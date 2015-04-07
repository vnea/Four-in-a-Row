package orsay.lpper.game;

import javax.json.JsonObjectBuilder;
import javax.json.spi.JsonProvider;

import orsay.lpper.commons.Constants;
import orsay.lpper.commons.enums.Color;

public class Grid 
{
	private int _numberOfRows;
	private int _numberOfCols;
	private Square[][] _gridSquare;
	private int _lastPosX = -1;
	private int _lastPosY = -1;
	private boolean _lastMoveOk = false;
	private boolean _won = false;
	
	public Grid(int aNumberOfRows, int aNumberOfCols)
	{
		_numberOfRows = aNumberOfRows;
		_numberOfCols = aNumberOfCols;
		
		_gridSquare = new Square[_numberOfRows][_numberOfCols];

		// Initialisation
		for (int y = 0; y < _numberOfRows; ++y)
		{
			for (int x = 0; x < _numberOfCols; ++x)
			{
				_gridSquare[y][x] = new Square();
			}
		}
	}
	
	public void endOfGame()
	{
		
	}
	
	private boolean checkWinRows() {
        // Check rows and see if there are 4 disks of the same color
        for (int y = 0; y < _numberOfRows; ++y) {
            int count = 0;
            for (int x = 1; x < _numberOfCols; ++x) {
                if (!_gridSquare[y][x].isEmpty() && _gridSquare[y][x].getPieceColor() == _gridSquare[y][x - 1].getPieceColor()) {
                    ++count;
                }
                else {
                    count = 1;
                }

                if (count >= 4) {
                    return true;
                }
            }
        }
        return false;
    }
	
	 private boolean checkWinColumns() {
        for (int x = 0; x < _numberOfCols; ++x) {
            int count = 0;
            // We will compare current element with the previous
            for (int y = 1; y < _numberOfRows; ++y) {
                if (!_gridSquare[y][x].isEmpty() && _gridSquare[y][x].getPieceColor() == _gridSquare[y - 1][x].getPieceColor()) {
                    ++count;
                }
                else {
                    count = 1;
                }

                if (count >= 4) {
                    return true;
                }
            }
        }
        return false;
	 }

	
	public boolean addPiece(boolean aPlayerOneTurn, int aPosX)
	{
		_lastPosX = aPosX;
		_lastPosY = Constants.C_NB_ROWS - 1;
		while (_lastPosY >= 0 && !_gridSquare[_lastPosY][_lastPosX].isEmpty())
		{
			--_lastPosY;
		}
		
		_lastMoveOk = _lastPosY != -1;
		if (_lastMoveOk)
		{
			_gridSquare[_lastPosY][_lastPosX].addPiece(new Piece(aPlayerOneTurn ? Color.red : Color.yellow));
			//_won = checkWinRows() || checkWinColumns();
		}
		
		return _lastMoveOk;
	}
	
	public JsonObjectBuilder getStateGrid()
	{
		JsonObjectBuilder job = JsonProvider.provider().createObjectBuilder();
		job.add("action", "updateGame");
		for (int y = 0; y < _numberOfRows; ++y)
		{
			for (int x = 0; x < _numberOfCols; ++x)
			{
				job.add(Integer.toString(y + x * _numberOfCols), _gridSquare[y][x].isEmpty() ? "empty" : _gridSquare[y][x].getPieceColor().name());
			}
		}
		
		job.add("lastPosX", Integer.toString(_lastPosX));
		job.add("lastPosY", Integer.toString(_lastPosY));
		job.add("lastMoveOk", _lastMoveOk);
		job.add("won", _won);

		return job;
	}
}

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
	
	public void addPiece(boolean aPlayerOneTurn, int aPosX)
	{
		_lastPosX = aPosX;
		_lastPosY = Constants.C_NB_ROWS - 1;
		while (!_gridSquare[_lastPosY][_lastPosX].isEmpty())
		{
			--_lastPosY;
		}
		
		_gridSquare[_lastPosY][_lastPosX].addPiece(new Piece(aPlayerOneTurn ? Color.red : Color.yellow));
	}
	
	public JsonObjectBuilder getStateGrid()
	{
		JsonObjectBuilder job = JsonProvider.provider().createObjectBuilder();
		job.add("action", "update");
		for (int y = 0; y < _numberOfRows; ++y)
		{
			for (int x = 0; x < _numberOfCols; ++x)
			{
				job.add(Integer.toString(y + x * _numberOfCols), _gridSquare[y][x].isEmpty() ? "empty" : _gridSquare[y][x].getPieceColor().name());
			}
		}
		
		job.add("lastPosX", Integer.toString(_lastPosX));
		job.add("lastPosY", Integer.toString(_lastPosY));

		return job;
	}
}

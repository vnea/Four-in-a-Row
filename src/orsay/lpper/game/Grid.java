package orsay.lpper.game;

public class Grid 
{	
	private Square[][] _gridSquare;
	
	public Grid(int aNumberOfRows, int aNumberOfCols)
	{
		_gridSquare = new Square[aNumberOfRows][aNumberOfCols];

		// Initialisation
		for(int i=0; i<aNumberOfRows; i++)
		{
			for(int j=0; j<aNumberOfCols; j++)
			{
				_gridSquare[i][j] = new Square();
			}
		}
	}
	
	public boolean addPieceInSquare(int aX, int aY, Piece aPiece)
	{
		return _gridSquare[aX][aY].addPiece(aPiece);
	}
	
}

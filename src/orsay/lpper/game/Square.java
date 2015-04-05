package orsay.lpper.game;

public class Square
{
	private Piece _piece;
	
	public Square()
	{
		_piece = null;
	}
	
	public Square(Piece aPiece)
	{
		_piece = aPiece;
	}
	
	public boolean addPiece(Piece aPiece)
	{
		if(_piece == null)
		{
			_piece = aPiece;
			return true;
		}
		return false;
	}
}

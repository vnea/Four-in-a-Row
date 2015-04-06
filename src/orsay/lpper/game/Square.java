package orsay.lpper.game;

import orsay.lpper.commons.enums.Color;

public class Square
{
	private Piece _piece = null;
	
	public Square()
	{
		
	}
	
	public void addPiece(Piece aPiece)
	{
		_piece = aPiece;
	}
	
	public boolean isEmpty()
	{
		return _piece == null;
	}
	
	public Color getPieceColor()
	{
		return _piece.getColor();
	}
}

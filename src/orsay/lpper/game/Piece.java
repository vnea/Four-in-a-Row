package orsay.lpper.game;

import orsay.lpper.commons.enums.Color;

public class Piece
{
	private Color _color;
	
	public Piece(Color aColor)
	{
		_color = aColor;
	}
	
	public Color getColor()
	{
		return _color;
	}
}

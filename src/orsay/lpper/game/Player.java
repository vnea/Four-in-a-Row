package orsay.lpper.game;

import orsay.lpper.commons.enums.Color;

public class Player
{
	private String _id;
	private Color _color;
	
	public Player(String aId, Color color)
	{
		_id = aId;
		_color = color;
	}
	
	public String getId()
	{
		return _id;
	}
	
	public Color getColor()
	{
		return _color;
	}
}

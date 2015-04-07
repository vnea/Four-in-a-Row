package orsay.lpper.game;
import javax.json.JsonObject;

import orsay.lpper.commons.Constants;
import orsay.lpper.commons.enums.Color;

public class Game 
{
	private String _id;
	private Grid _gridGame;
	private boolean _playerOneTurn = true;
	private Player _p1;
	private Player _p2;

	public Game(String id, String p1, String p2)
	{
		_id = id;
		_gridGame = new Grid(Constants.C_NB_ROWS, Constants.C_NB_COLS);
		_p1 = new Player(p1, Color.red);
		_p2 = new Player(p2, Color.yellow);
	}
	
	public void play(int aPosX)
	{
		if (_gridGame.addPiece(_playerOneTurn, aPosX))
		{
			_playerOneTurn = !_playerOneTurn;
		}
	}
	
	public JsonObject getStateGame()
	{
		return _gridGame.getStateGrid().add("playerOneTurn", _playerOneTurn)
									   .add("p", _playerOneTurn ? _p1.getId() : _p2.getId())
									   .add("idGame", _id)
									   .build();
	}
	
	public String getId()
	{
		return _id;
	}
	
	public void setId(String id)
	{
		_id = id;
	}
}

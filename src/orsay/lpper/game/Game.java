package orsay.lpper.game;
import javax.json.JsonObject;

import orsay.lpper.commons.Constants;

public class Game 
{
	private int _id;
	private Grid _gridGame;
	private boolean _playerOneTurn = true;
	
	public Game()
	{
		_gridGame = new Grid(Constants.C_NB_ROWS, Constants.C_NB_COLS);
	}

	public int getId() {
		return _id;
	}

	public void setId(int id) {
		_id = id;
	}
	
	public void play(int aPosX)
	{
		_gridGame.addPiece(_playerOneTurn, aPosX);
		_playerOneTurn = !_playerOneTurn;
	}
	
	public JsonObject getStateGame()
	{
		return _gridGame.getStateGrid().add("playerOneTurn", _playerOneTurn).build();
	}
}

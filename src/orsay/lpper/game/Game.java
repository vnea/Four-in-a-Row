package orsay.lpper.game;
import orsay.lpper.commons.Constants;
import orsay.lpper.commons.enums.Color;
import orsay.lpper.commons.enums.Player;

public class Game 
{
	private Grid _gridGame;
	private Color _colorP1;
	private Color _colorP2;
	
	public Game(Color aColorP1, Color aColorP2)
	{
		_gridGame = new Grid(Constants.C_NB_ROWS, Constants.C_NB_COLS);
		_colorP1 = aColorP1;
		_colorP2 = aColorP2;
	}
	
	public void play(int aX, int aY, Player aPlayer)
	{
		_gridGame.addPieceInSquare(aX, aY, aPlayer == Player.P1 ? new Piece(_colorP1) : new Piece(_colorP2));
	}
	
	//>> TODO : V�rification joueur a gagn� 
}

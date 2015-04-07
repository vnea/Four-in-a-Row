package orsay.lpper.model;

public class Room {
    private String id;
    private int nbPlayers;
    
    private String p1;
    private String p2;
    
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getNbPlayers() {
		return nbPlayers;
	}
	public void setNbPlayers(int nbPlayers) {
		this.nbPlayers = nbPlayers;
	}
	public String getP1() {
		return p1;
	}
	public void setP1(String p1) {
		this.p1 = p1;
	}
	public String getP2() {
		return p2;
	}
	public void setP2(String p2) {
		this.p2 = p2;
	}
}

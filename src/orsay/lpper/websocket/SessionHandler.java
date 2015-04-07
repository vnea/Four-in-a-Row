package orsay.lpper.websocket;

import java.io.IOException;
import java.util.HashSet;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.enterprise.context.ApplicationScoped;
import javax.json.JsonObject;
import javax.json.spi.JsonProvider;
import javax.websocket.Session;

import orsay.lpper.game.Game;
import orsay.lpper.model.Room;

@ApplicationScoped
public class SessionHandler
{
	private final Set<Session> sessions = new HashSet<Session>();
	private final Set<Game> games = new HashSet<Game>();
	private final Set<Room> rooms = new HashSet<Room>();
    
    public void addSession(Session session)
    {
    	sessions.add(session);
    }
    
    public void removeSession(Session session)
    {
        sessions.remove(session);
    }
    
    public void getRooms(Session session)
    {
    	for (Room room : rooms)
    	{
    		sendToSession(session, createAddMessage(room));
    	}
    }
    
    public void createRoom(String idRoom, String p1)
    {
    	Room room = new Room();
    	room.setId(idRoom);
    	room.setNbPlayers(1);
    	room.setP1(p1);
    	rooms.add(room);
    	sendToAllConnectedSessions(createAddMessage(room));
    }
    
    private JsonObject createAddMessage(Room room)
    {
        JsonProvider provider = JsonProvider.provider();
        JsonObject addMessage = provider.createObjectBuilder()
                .add("action", "initRooms")
                .add("idRoom", room.getId())
                .add("nbPlayers", room.getNbPlayers())
                .build();
        
        return addMessage;
    }
    
    public void createGame(String idGame, String p1, String p2)
    {
    	Game game = new Game(idGame, p1, p2);
    	games.add(game);
    	sendToAllConnectedSessions(game.getStateGame());
    }
    
    public void getGame(String idGame)
    {
    	Game game = getGameById(idGame);
    	if (game != null)
    	{
    		sendToAllConnectedSessions(game.getStateGame());
    	}
    	else
    	{
    		JsonObject message = JsonProvider.provider().createObjectBuilder()
    										 .add("action", "noGame")
    										 .add("idGame", idGame)
    										 .build();
    		
    		sendToAllConnectedSessions(message);
    	}
    }
    
    public void updateRoom(String idRoom, String p2)
    {
    	Room room = getRoomById(idRoom);
    	if (room != null)
    	{
    		room.setP2(p2);
    		room.setNbPlayers(2);
    		JsonObject message = JsonProvider.provider().createObjectBuilder()
    					 		.add("action", "updateRoom")
    					 		.add("idRoom", idRoom)
    					 		.add("p1", room.getP1())
    					 		.add("p2", p2)
    					 		.add("nbPlayers", room.getNbPlayers())
    					 		.build();
    		
    		sendToAllConnectedSessions(message);
    	}
    }
    
    public void refreshRoomGame(String id)
    {
    	Room room = getRoomById(id);
    	if (room != null)
    	{
    		JsonObject message = JsonProvider.provider().createObjectBuilder()
    					 		.add("action", "refreshRoomGame")
    					 		.add("idGame", id)
    					 		.add("p1", room.getP1())
    					 		.add("p2", room.getP2())
    					 		.add("nbPlayers", room.getNbPlayers())
    					 		.build();
    		
    		sendToAllConnectedSessions(message);
    	}
    }
    
    public void updateGame(String idGame, int aPosX)
    {
    	Game game = getGameById(idGame);
    	if (game != null)
		{
			game.play(aPosX);
			sendToAllConnectedSessions(game.getStateGame());
		}
    }
    
    private Game getGameById(String idGame)
    {
        for (Game game : games)
        {
            if (game.getId().equals(idGame))
            {
                return game;
            }
        }
        return null;
    }
    
    private Room getRoomById(String idRoom)
    {
        for (Room room : rooms)
        {
            if (room.getId().equals(idRoom))
            {
                return room;
            }
        }
        return null;
    }
    
    private void sendToAllConnectedSessions(JsonObject message)
    {
        for (Session session : sessions)
        {
            sendToSession(session, message);
        }
    }
    
    private void sendToSession(Session session, JsonObject message)
    {
        try
        {
            session.getBasicRemote().sendText(message.toString());
        }
        catch (IOException ex)
        {
            sessions.remove(session);
            Logger.getLogger(SessionHandler.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}

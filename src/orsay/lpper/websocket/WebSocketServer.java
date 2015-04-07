package orsay.lpper.websocket;

import java.io.StringReader;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.json.Json;
import javax.json.JsonObject;
import javax.json.JsonReader;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ApplicationScoped
@ServerEndpoint("/actions")
public class WebSocketServer
{
	@Inject
	private SessionHandler sessionHandler;
	
	@OnOpen
	public void open(Session session)
	{
        sessionHandler.addSession(session);
	}
	
	@OnClose
	public void close(Session session)
	{
		sessionHandler.removeSession(session);
	}
	
	@OnError
	public void onError(Throwable error)
	{
        Logger.getLogger(WebSocketServer.class.getName()).log(Level.SEVERE, null, error);
	}
	
	@OnMessage
	public void handleMessage(String message, Session session)
	{
		try (JsonReader reader = Json.createReader(new StringReader(message)))
		{
            JsonObject jsonMessage = reader.readObject();

            String action = jsonMessage.getString("action");
            switch (action)
            {
            	case "createGame":
            	{
            		sessionHandler.createGame(jsonMessage.getString("idGame"), jsonMessage.getString("p1"),
            																   jsonMessage.getString("p2"));
            	}
            	break;
            	
            	case "playGame":
            	{
            		sessionHandler.updateGame(jsonMessage.getString("idGame"), jsonMessage.getInt("posX"));
            	}
            	break;
            	
            	case "initGame":
            	{
            		sessionHandler.getGame(jsonMessage.getString("idGame"));
            	}
            	break;
            	
            	case "createRoom":
            	{
            		sessionHandler.createRoom(jsonMessage.getString("idRoom"), jsonMessage.getString("p1"));
            	}
            	break;
            	
            	case "initRooms":
            	{
            		sessionHandler.getRooms(session);
            	}
            	break;
            	
            	case "updateRoom":
            	{
            		sessionHandler.updateRoom(jsonMessage.getString("idRoom"), jsonMessage.getString("p2"));
            	}
            	break;
            	
            	case "refreshRoomGame":
            	{
            		sessionHandler.refreshRoomGame(jsonMessage.getString("idGame"));
            	}
            	break;
            	
            	default:
            }
        }
	}
}

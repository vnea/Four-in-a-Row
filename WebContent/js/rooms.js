var ROOMS = {
	env : {
		ctx: null,
		socket: new WebSocket("ws://localhost:8080/FourInARow/actions")
	},
	
	init: function () {
		ROOMS.env.socket.onmessage = ROOMS.onMessage;
		
		$(document).on("click", "#createRoom", function (event) {
			event.preventDefault();
		    var roomAction = {
		            action: "createRoom",
		            idRoom: ROOMS.getIdRoom(),
		            p1: "Jean"
		    };
		    
		    ROOMS.env.socket.send(JSON.stringify(roomAction));
		    
		    $("form>input[name='idGame']").val(ROOMS.getIdRoom());
		    $("form>input[name='p1']").val("Jean");
		    $("form").submit();
		});
		
		setTimeout(function () {
		    var roomAction = {
		            action: "initRooms"
		    };
		    
		    ROOMS.env.socket.send(JSON.stringify(roomAction));
		}, 200);
	},
	
	onMessage: function (event) {
		var room = JSON.parse(event.data);
		if (room.action === "initRooms") {
			ROOMS.addRoom(room);
		}
		else if (room.action === "updateRoom") {
			$("#" + room.idRoom).addClass("disabled");
			$("#" + room.idRoom).parent().prev().prev().text(room.nbPlayers + "/2")
		}
	},
	
	addRoom: function (room) {
		var $elem = $("<tr></tr>");
		$elem.append("<td>" + room.idRoom + "</td>");
		$elem.append("<td>" + room.nbPlayers + "/2</td>");
        $elem.append('<td><a id="spec' + room.idRoom + '" href="#" class="btn btn-primary">Regarder</a></td>');
		var status = room.nbPlayers == 1 ? "" : " disabled";
		$elem.append('<td><a id="' + room.idRoom + '" href="#" class="btn btn-success' + status + '">Rejoindre</a></td>');
		
		$("tbody").append($elem);
		
		$(document).on("click", "#" + room.idRoom, function () {
		    $("form>input[name='idGame']").val(room.idRoom);
		    $("form>input[name='p2']").val("Luc");
		    $("form").submit();
		    
		    var roomAction = {
		            action: "updateRoom",
		            idRoom: room.idRoom,
		            p2: "Luc"
		    };
		    
			ROOMS.env.socket.send(JSON.stringify(roomAction));
		});
		
		$(document).on("click", "#spec" + room.idRoom, function () {
		    $("form>input[name='idGame']").val(room.idRoom);
		    $("form").submit();
		});
	},
	
	getIdRoom: function () {
		return $("#room").val();
	}
}

window.onload = ROOMS.init;

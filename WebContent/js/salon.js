var ROOM = {
	env : {
		ctx: null,
		socket: new WebSocket("ws://localhost:8080/FourInARow/actions"),
		nbRows: 6,
		nbCols: 7,
		circleSize: 105,
		canvasWidth: 752,
		speedInMs: 100
	},
	
	init: function () {
		var canvas = document.getElementById("mainCanvas");
		ROOM.env.ctx = canvas.getContext("2d");
		ROOM.drawImage("background_grid", 0, 0);
		
		ROOM.env.socket.onmessage = ROOM.onMessage;
		
		canvas.addEventListener("click", function (event) {
			var x = event.pageX - $(canvas).offset().left;
			var posCursorX = Math.floor(x / (ROOM.env.canvasWidth / ROOM.env.nbCols));
		    var gameAction = {
		            action: "play",
		            posX: posCursorX
		    };
		    
		    ROOM.env.socket.send(JSON.stringify(gameAction));
		});
		
		setTimeout(function () {
		    var gameAction = {
		            action: "init"
		    };
		    
		    ROOM.env.socket.send(JSON.stringify(gameAction));
		}, 1000);
	},
	
	onMessage: function (event) {
		var game = JSON.parse(event.data);
		if (game.action === "update" || game.action === "init") {
			for (var i = 0; i < ROOM.env.nbRows; ++i) {
				for (var j = 0; j < ROOM.env.nbCols; ++j) {
					var index = i + j * ROOM.env.nbCols;
					if (game[index] === "empty") {
						ROOM.drawCircle(j * ROOM.env.circleSize + 60, i * ROOM.env.circleSize + 110); 
					}
					else {
						if (game.lastPosX != j || game.lastPosY != i) {
							ROOM.drawImage(game[index], j * ROOM.env.circleSize + 10, i * ROOM.env.circleSize + 60);
						}
					}
				}
			}
			
			if (game.lastMoveOk && (game.lastPosX != -1 || game.lastPosY != -1)) {
				if (game.lastMoveOk) {
					game.lastPosX = parseInt(game.lastPosX);
					game.lastPosY = parseInt(game.lastPosY);
					var index = game.lastPosY + parseInt(game.lastPosX) * ROOM.env.nbCols;
					ROOM.drawDescendingPiece(game[index], game.lastPosX, game.lastPosY);
				}
				else {
					alert("Invalid move.");
				}
			}
		}
	},
	
	drawCircle: function (posX, posY) {
		ROOM.env.ctx.beginPath();
		ROOM.env.ctx.arc(posX, posY, 50, 0, 2 * Math.PI);
		ROOM.env.ctx.fillStyle = "white";
		ROOM.env.ctx.fill();
		ROOM.env.ctx.stroke();
		ROOM.env.ctx.closePath();
	},
	
	drawImage: function (pieceName, posX, posY) {
		var piece = new Image();
		piece.src = "img/" + pieceName + ".png"
		piece.onload = function () {
			ROOM.env.ctx.drawImage(this, posX, posY);
		}
	},
	
	drawAndClearPiece: function (pieceName, posX, posY, posXC, posYC, i) {
		setTimeout(function () {
			ROOM.drawImage(pieceName, posX, posY);
			ROOM.drawCircle(posXC, posYC);
		}, (i + 1) * ROOM.env.speedInMs);
	},
	
	drawDescendingPiece: function (pieceName, lastPosX, lastPosY) {
		ROOM.drawImage(pieceName, lastPosX * ROOM.env.circleSize + 10, 60);
		for (var i = 0; i < lastPosY; ++i) {
			var x = lastPosX * ROOM.env.circleSize;
			var y = i * ROOM.env.circleSize;
			ROOM.drawAndClearPiece(pieceName, x + 10, y + 165, x + 60, y + 110, i);
		}
	}
}

window.onload = ROOM.init;

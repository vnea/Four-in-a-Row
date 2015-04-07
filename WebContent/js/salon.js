var GAME = {
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
		GAME.env.ctx = canvas.getContext("2d");
		GAME.drawImage("background_grid", 0, 0);
		
		GAME.env.socket.onmessage = GAME.onMessage;
		
		canvas.addEventListener("click", function (event) {
			var x = event.pageX - $(canvas).offset().left;
			var posCursorX = Math.floor(x / (GAME.env.canvasWidth / GAME.env.nbCols));
		    var gameAction = {
		            action: "playGame",
		            posX: posCursorX,
		            idGame: GAME.getIdGame()
		    };
		    
		    GAME.env.socket.send(JSON.stringify(gameAction));
		});
		
		$(document).on("click", "#launchGame", function (event) {
			event.preventDefault();
			$(this).remove();
		    var gameAction = {
		            action: "createGame",
		            idGame: GAME.getIdGame(),
		            p1: $("#p1").text(),
		            p2: $("#p2").text()
		    };
		    
		    GAME.env.socket.send(JSON.stringify(gameAction));
		});
		
		setTimeout(function () {
		    var gameAction = {
		            action: "initGame",
		            idGame: GAME.getIdGame()
		    };
		    
		    GAME.env.socket.send(JSON.stringify(gameAction));
		}, 1000);
		
		if ($("#p1").text() === "") {
			setTimeout(function () {
				    var gameAction = {
				            action: "refreshRoomGame",
				            idGame: GAME.getIdGame()
				    };
				    
				    GAME.env.socket.send(JSON.stringify(gameAction));
			}, 2000);
		}
	},
	
	onMessage: function (event) {
		var game = JSON.parse(event.data);
		if (game.idGame === GAME.getIdGame()) {
			if (game.action === "updateGame" || game.action === "initGame") {
				//GAME.drawImage("background_grid", 0, 0);
				for (var i = 0; i < GAME.env.nbRows; ++i) {
					for (var j = 0; j < GAME.env.nbCols; ++j) {
						var index = i + j * GAME.env.nbCols;
						if (game[index] === "empty") {
							GAME.drawCircle(j * GAME.env.circleSize + 60, i * GAME.env.circleSize + 110); 
						}
						else {
							if (game.lastPosX != j || game.lastPosY != i) {
								GAME.drawImage(game[index], j * GAME.env.circleSize + 10, i * GAME.env.circleSize + 60);
							}
						}
					}
				}
				
				if (game.lastMoveOk && (game.lastPosX != -1 || game.lastPosY != -1)) {
					if (game.lastMoveOk) {
						game.lastPosX = parseInt(game.lastPosX);
						game.lastPosY = parseInt(game.lastPosY);
						var index = game.lastPosY + parseInt(game.lastPosX) * GAME.env.nbCols;
						GAME.drawDescendingPiece(game[index], game.lastPosX, game.lastPosY);
					}
					else {
						alert("Invalid move.");
					}
				}
			}
			else if (game.action === "noGame") {
				//alert("No game found");
			}
			
			if (game.action === "refreshRoomGame") {
				$("#p1").text(game.p1);
				$("#p2").text(game.p2);
				$("#p2Div").removeClass("hidden");
				$("#launchGame").removeClass("disabled");
			}
		}
	},
	
	drawCircle: function (posX, posY) {
		GAME.env.ctx.beginPath();
		GAME.env.ctx.arc(posX, posY, 50, 0, 2 * Math.PI);
		GAME.env.ctx.fillStyle = "white";
		GAME.env.ctx.fill();
		GAME.env.ctx.stroke();
		GAME.env.ctx.closePath();
	},
	
	drawImage: function (pieceName, posX, posY) {
		var piece = new Image();
		piece.src = "img/" + pieceName + ".png"
		piece.onload = function () {
			GAME.env.ctx.drawImage(this, posX, posY);
		}
	},
	
	drawAndClearPiece: function (pieceName, posX, posY, posXC, posYC, i) {
		setTimeout(function () {
			GAME.drawImage(pieceName, posX, posY);
			GAME.drawCircle(posXC, posYC);
		}, (i + 1) * GAME.env.speedInMs);
	},
	
	drawDescendingPiece: function (pieceName, lastPosX, lastPosY) {
		GAME.drawImage(pieceName, lastPosX * GAME.env.circleSize + 10, 60);
		for (var i = 0; i < lastPosY; ++i) {
			var x = lastPosX * GAME.env.circleSize;
			var y = i * GAME.env.circleSize;
			GAME.drawAndClearPiece(pieceName, x + 10, y + 165, x + 60, y + 110, i);
		}
	},
	
	getIdGame: function () {
		return $("title").text().replace(/.*- (.*)/, "$1");
	}
}

window.onload = GAME.init;

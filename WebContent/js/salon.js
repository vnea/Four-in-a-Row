var GAME = {
	env : {
		ctx: null,
		socket: new WebSocket("ws://localhost:8080/FourInARow/actions"),
		nbRows: 6,
		nbCols: 7,
		circleSize: 105,
		canvasWidth: 752,
		speedInMs: 100,
		player: null,
		currentPlayer: null,
		currentPosCursorX: -1,
		oldPosCursorX: -1,
		redPiece: new Image(),
		yellowPiece: new Image(),
		isPlayerOneTurn: true,
		isGameRunning: false
	},
	
	init: function () {
		var canvas = document.getElementById("mainCanvas");
		GAME.env.ctx = canvas.getContext("2d");
		GAME.drawImage("background_grid", 0, 0);
		
		GAME.env.socket.onmessage = GAME.onMessage;
		GAME.env.redPiece.src = "img/red.png";
		GAME.env.yellowPiece.src = "img/yellow.png";

		if ($("#p1").text() !== "" || $("#p2").text() !== "") {
			canvas.addEventListener("mousemove", function (event) {
				if (GAME.env.player == GAME.env.currentPlayer) {
					var x = event.pageX - $(canvas).offset().left;
					var posCursorX = Math.floor(x / (GAME.env.canvasWidth / GAME.env.nbCols));
					GAME.env.currentPosCursorX = posCursorX;
					if (GAME.env.ol1dPosCursorX === -1) {
						GAME.env.oldPosCursorX = posCursorX;
					}
					if (GAME.env.oldPosCursorX !== posCursorX) {
						GAME.clearImage(GAME.env.oldPosCursorX * GAME.env.circleSize + 60, 88);
						GAME.env.oldPosCursorX = posCursorX;
					}
						
					GAME.drawLoadedImage(GAME.env.isPlayerOneTurn ? GAME.env.redPiece : GAME.env.yellowPiece,
										 posCursorX * GAME.env.circleSize + 10, 40);
				}
			});
			
			canvas.addEventListener("click", function (event) {
				if (GAME.env.player == GAME.env.currentPlayer) {
					var x = event.pageX - $(canvas).offset().left;
					var posCursorX = Math.floor(x / (GAME.env.canvasWidth / GAME.env.nbCols));
				    var gameAction = {
				            action: "playGame",
				            posX: posCursorX,
				            idGame: GAME.getIdGame()
				    };
				    
				    GAME.env.socket.send(JSON.stringify(gameAction));
				}
				else {
					if (GAME.env.isGameRunning) {
						alert("Ce n'est pas votre tour !");
					}
				}
			});
		}
		else {
			canvas.addEventListener("click", function (event) {
				alert("Mode spectateur !");
			});
		}

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
		}, 200);
		
		if ($("#p1").text() === "") {
			GAME.env.player = $("#p2").text();
			setTimeout(function () {
				    var gameAction = {
				            action: "refreshRoomGame",
				            idGame: GAME.getIdGame()
				    };
				    
				    GAME.env.socket.send(JSON.stringify(gameAction));
			}, 200);
		}
		else {
			GAME.env.player = $("#p1").text();
			$("#p1Div").removeClass("vHidden");
		}
	},
	
	onMessage: function (event) {
		var game = JSON.parse(event.data);
		if (game.idGame === GAME.getIdGame()) {
			if (game.action === "updateGame" || game.action === "initGame") {
				GAME.env.isGameRunning = true;
				GAME.env.currentPlayer = game.p;
				GAME.env.isPlayerOneTurn = game.playerOneTurn;
				//GAME.drawImage("background_grid", 0, 0);
				for (var i = 0; i < GAME.env.nbRows; ++i) {
					for (var j = 0; j < GAME.env.nbCols; ++j) {
						var index = i + j * GAME.env.nbCols;
						if (game[index] === "empty") {
							GAME.drawCircle(j * GAME.env.circleSize + 60, i * GAME.env.circleSize + 210); 
						}
						else {
							if (game.lastPosX != j || game.lastPosY != i) {
								GAME.drawImage(game[index], j * GAME.env.circleSize + 10, i * GAME.env.circleSize + 160);
							}
						}
					}
				}
				
				if (game.lastPosX != -1 || game.lastPosY != -1) {
					if (game.lastMoveOk) {
						game.lastPosX = parseInt(game.lastPosX);
						game.lastPosY = parseInt(game.lastPosY);
						var index = game.lastPosY + parseInt(game.lastPosX) * GAME.env.nbCols;
						GAME.drawDescendingPiece(game[index], game.lastPosX, game.lastPosY);
					}
					else {
						if (GAME.env.player == GAME.env.currentPlayer) {
							alert("Coup invalide !");
						}
					}
				}
			}
			else if (game.action === "noGame") {
				//alert("No game found");
			}
			
			if (game.action === "refreshRoomGame") {
				$("#p1").text(game.p1);
				$("#p2").text(game.p2);
				$("#p1Div").removeClass("vHidden");
				$("#p2Div").removeClass("vHidden");
				$("#launchGame").removeClass("disabled");
			}
		}
	},
	
	clearImage: function (posX, posY) {
		GAME.env.ctx.beginPath();
		GAME.env.ctx.arc(posX, posY, 50, 0, 2 * Math.PI);
		GAME.env.ctx.lineWidth = 5;
		GAME.env.ctx.strokeStyle = "white";
		GAME.env.ctx.fillStyle = "white";
		GAME.env.ctx.fill();
		GAME.env.ctx.stroke();
		GAME.env.ctx.closePath();
	},
	
	drawCircle: function (posX, posY) {
		GAME.env.ctx.beginPath();
		GAME.env.ctx.arc(posX, posY, 50, 0, 2 * Math.PI);
		GAME.env.ctx.lineWidth = 1;
		GAME.env.ctx.strokeStyle = "black";
		GAME.env.ctx.fillStyle = "white";
		GAME.env.ctx.fill();
		GAME.env.ctx.stroke();
		GAME.env.ctx.closePath();
	},
	
	drawLoadedImage: function (img, posX, posY) {
		GAME.env.ctx.drawImage(img, posX, posY);
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
		GAME.clearImage(GAME.env.currentPosCursorX * GAME.env.circleSize + 60, 88);
		GAME.drawImage(pieceName, lastPosX * GAME.env.circleSize + 10, 160);
		for (var i = 0; i < lastPosY; ++i) {
			var x = lastPosX * GAME.env.circleSize;
			var y = i * GAME.env.circleSize;
			GAME.drawAndClearPiece(pieceName, x + 10, y + 265, x + 60, y + 210, i);
		}
	},
	
	getIdGame: function () {
		return $("title").text().replace(/.*- (.*)/, "$1");
	}
}

window.onload = GAME.init;

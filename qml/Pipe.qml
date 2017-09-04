import QtQuick 2.4


Item {

	id:pipe
	width: 100
	height: 250
	x:500


	BorderImage {
		id: pipe_bottom
		source: "qrc:/images/qml/img/pipe.png"
		width: parent.width
		border.top: 100

	}

	BorderImage{
		id: pipe_top
		source: "qrc:/images/qml/img/pipe.png"
		width: parent.width
		border.top:100
		rotation: 180
	}




	onXChanged: {
		if(!(x >= bird.x + bird.width - width -50  && x<=bird.x + width -50 )) return
		if(bird.y >= pipe_top.height && bird.y +bird.height+5 <=pipe_bottom.y){
		}else{
			pipesCreator.stop();
			backg_animation.stop();
			pipe_moves.stop();
			stopKeys = true;
			death = true;
			gameoverDialog.open();


		}
	}

	function creatingPipes(){

		var random = Math.floor(Math.random()*300)+50;
		pipe_bottom.height = random;
		pipe_bottom.y = 600-random;
		pipe_top.height = 450-random;
	}

	PropertyAnimation {

	      id: pipe_moves
	      running: true
	      target: pipe
	      properties: "x"
	      from: 500
	      to: -width
	      duration: 3000

	  }



}


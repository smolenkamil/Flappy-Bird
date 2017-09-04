
import QtQuick 2.0
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2
import QtQuick 2.5

Window {
	visible: true
	id: win
	width: 500
	height: 600

	property bool stopKeys: false
	property bool death: false

	function jumpH(x){

		jumpAnimation.from = bird.y
		jumpAnimation.to = bird.y-x
		jumpAnimation.start()
	}




	Dialog{
		id:gameoverDialog
		title: "Game Over"

		contentItem: Rectangle {
			color: "black"
			implicitWidth: 250
			implicitHeight: 125
			Label{
				id: labelgo
				text: "GAME OVER"
				font.pointSize: 30
				color: "white"
				anchors.centerIn: parent
			}
			Label{
				id: quitlab
				text: "Click to quit"
				color: "white"
				anchors.horizontalCenter: parent.horizontalCenter
				anchors.top: labelgo.bottom
			}
			MouseArea{
				id:mouseClose
				anchors.fill: parent
				onClicked: {
					Qt.quit()

				}

			}
		}


	}

	Item{
		id:keyboard
		focus: true

		Keys.onPressed: {
			if(stopKeys==false){
				if (event.key == Qt.Key_Space) {
					jumpH(60);
				}
			}
		}
	}

	Timer{
		id: pipesCreator
		repeat: true
		running	: true
		interval: 2000
		onTriggered: {
			var component = Qt.createComponent("Pipe.qml");
			var pipe = component.createObject(win);
			pipe.creatingPipes()
		}
	}



	Image{
		id: backgroud
		height: 625
		source: "qrc:/images/qml/img/background.png"
		fillMode: Image.TileHorizontally

		Timer{
			id:backg_animation
			repeat: true
			running: true
			interval: 50
			onTriggered: {
				backgroud.x -= 5
				backgroud.width += 5
			}
		}
	}


	Image{
		id:bird
		x:parent.width/2-width/2
		y:238
		z:1
		source: "qrc:/images/qml/img/bird.png"


		Timer{
			id:bird_fall
			repeat: true
			running:true
			interval: 50
			onTriggered: {
				bird.y+=9
				if(bird.y>600-bird.height){
					stop()
					stopKeys = true;
				}
				if(death==true){
					bird.y+=25
					if(bird.y>575-bird.height){
						bird_fall.stop()

					}
				}
			}

		}

		Behavior on y {
			NumberAnimation { duration: 30 }
		}
		SequentialAnimation{
			running:mouseClicker.pressed

			RotationAnimation{
				target:bird;
				direction: RotationAnimation.Counterclockwise;
				properties: "rotation"
				to: -50;
				duration: 50
			}
			RotationAnimation{
				target:bird;
				direction: RotationAnimation.Clockwise;
				properties: "rotation";
				to:150;
				duration: 500
			}
		}

	}




	MouseArea {
		id:mouseClicker
		anchors.fill: parent
		onClicked: {
			if(stopKeys==false)
				jumpH(60);
		}
	}


	PropertyAnimation {

		id: jumpAnimation
		easing.type: Easing.OutQuad
		target: bird
		properties: "y"
		duration: 50

	}

}


import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.12

Item {
    id: root
    width: 1920
    height: 480

    ScrollImage{
        id: scrollor
        width: parent.width * 0.9
        height: parent.height * 0.5
        anchors.centerIn: parent
    }

    Button{
        id: btn1
        anchors.left: parent.left
        anchors.leftMargin: 100
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 60
        width: 100
        height: 25
        text: "添加"
        onClicked: {
            scrollor.addImage()

        }
    }
    Button{
        id: btn2
        anchors.left: btn1.right
        anchors.leftMargin: 100
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 60
        width: 100
        height: 25
        text: "加速"
        onClicked: {
            scrollor.setDestVelocity(scrollor.real_velocity + 300)
        }
    }
    Button{
        id: btn3
        anchors.left: btn2.right
        anchors.leftMargin: 100
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 60
        width: 100
        height: 25
        text: "减速"
        onClicked: {
            scrollor.setDestVelocity(scrollor.real_velocity - 300)
        }
    }

    Button{
        id: btn4
        anchors.left: btn3.right
        anchors.leftMargin: 100
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 60
        width: 100
        height: 25
        text: "Smooth pause"
        onClicked: {
            scrollor.setDestVelocity(0)
        }
    }

    Button{
        id: btn5
        anchors.left: btn4.right
        anchors.leftMargin: 100
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 60
        width: 100
        height: 25
        text: scrollor.animationPaused ? "启动" : "暂停"
        onClicked: {
            if(scrollor.animationPaused)
                scrollor.resumeAnimation()
            else
                scrollor.pauseAnimation()
        }
    }
    Text {
        id: infomation
        anchors.left: scrollor.left
        anchors.bottom: scrollor.top
        anchors.bottomMargin: 10
        color: "#804d4d"
        text: ""
        lineHeightMode: Text.FixedHeight
        lineHeight: 18
        font.family: "Micosoft YaHei"
        font.pixelSize: 12
    }
    Timer
    {
        interval: 200
        repeat: true
        running: true
        triggeredOnStart: true
        onTriggered: {
            infomation.text = "fps: " + fpsCounter.fps + "\n速度： " + scrollor.velocity + " px/s\n" + "加速度: " +scrollor.a + "\n" + "动画时间： " + scrollor.t + " s\n"  + "状态： " + (scrollor.animationPaused?"暂停中":"运行中")
        }
    }
}

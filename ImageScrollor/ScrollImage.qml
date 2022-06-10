import QtQuick 2.14

Rectangle{
    id: rect
    objectName: "image container"
    clip: true
    color: "#124580"
    property real velocity: 100
    property real t: 0
    property real a: 0
    property int status: 0
    property real last_stage_t: 0
    property real last_stage_s: 0
    property real dest_velocity: 100
    property real accelerate_time: 500
    property real s: 0
    property real real_velocity: 100

    onTChanged: {
        real_velocity = velocity + a * (t - last_stage_t)
        var state_t = t - last_stage_t
        s = last_stage_s + state_t * velocity + state_t * state_t * a * 0.5;
    }

    onReal_velocityChanged: {
        if(a > 0 && real_velocity - dest_velocity > 0 ||
                a < 0 && real_velocity - dest_velocity < 0)
        {
            real_velocity = dest_velocity
            a = 0
            if(real_velocity == 0)
                scrollAnimation.pause()
        }
    }

    onAChanged: {
        velocity = real_velocity
        last_stage_t = t
        last_stage_s = s
        console.log(last_stage_s)
        if((a !== 0 || real_velocity !== 0) && animationPaused)
            scrollAnimation.resume()
    }

    function addImage(){
        var item = imageComponent.createObject(rect)
    }
    function setDestVelocity(value)
    {
        a = (value - real_velocity)/(accelerate_time * 0.001)
        dest_velocity = value
    }
    function pauseAnimation()
    {
        scrollAnimation.pause()
    }
    function resumeAnimation()
    {
        if(a !== 0 || real_velocity !== 0)
            scrollAnimation.resume()
    }
    property alias animationPaused: scrollAnimation.paused
    Component.onCompleted: {
        a = 0
        real_velocity = dest_velocity = velocity = 100
        last_stage_t = t = 0
        last_stage_s = s = 0
    }
    Component{
        id: imageComponent
        Image{
            id: image
            source: "qrc:/images/1.jfif"
            height: parent.height
            width: parent.height * sourceSize.width / sourceSize.height
            anchors.verticalCenter: parent.verticalCenter
            x: 0
            onXChanged: {
                if(x > parent.width - 200)
                    destroy()
            }
            property real create_s: 0
            Component.onCompleted: {
                create_s = s
                image.x = Qt.binding(function(){
                    return s - create_s
                })
            }
        }
    }

    NumberAnimation{
        id: scrollAnimation
        target: rect
        property: "t"
        from: 0
        to: 10
        duration: 10000
        onFinished:{
            from = rect.t
            to = rect.t + 10
            duration = 10000
            start()
        }
        running: true
    }
}


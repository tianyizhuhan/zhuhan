#include "fpscounter.h"


FPSCounter::FPSCounter(){
    LARGE_INTEGER li;
    QueryPerformanceFrequency(&li);
    performaceFrequency = li.QuadPart;
    qDebug()<<li.QuadPart;
    QueryPerformanceCounter(&lastFramePerformanceCount);

}

void FPSCounter::setRenderWindow(QQuickWindow *window)
{
    if(window){
        connect(window, &QQuickWindow::afterRendering, this, &FPSCounter::onAfterRendering, Qt::DirectConnection);
    }
}

void FPSCounter::Test(){
    LARGE_INTEGER libegin, liend;
    QueryPerformanceCounter(&libegin);
    QThread::msleep(1020);
    QueryPerformanceCounter(&liend);
    qDebug()<<"PerformanceCount = "<<liend.QuadPart - libegin.QuadPart;
    qDebug()<<"PerformanceTime = "<<(double)(liend.QuadPart - libegin.QuadPart)/performaceFrequency;
}

uint32_t FPSCounter::getFPS(){
    return lastFps;
}

void FPSCounter::onAfterRendering()
{
    ++frameCount;
    LARGE_INTEGER li;
    QueryPerformanceCounter(&li);
    double timeStamp = (double)(li.QuadPart - lastFramePerformanceCount.QuadPart)/performaceFrequency;
    if(timeStamp > 1.0){
        lastFps = frameCount;
        lastFramePerformanceCount = li;
        frameCount = 0;
        QMetaObject::invokeMethod(this, "setFPS", Q_ARG(int, lastFps));
    }
}

int FPSCounter::fps() const
{
    return m_fps;
}

void FPSCounter::setFPS(int fps)
{
    if (m_fps == fps)
        return;

    m_fps = fps;
    emit fpsChanged(m_fps);
}

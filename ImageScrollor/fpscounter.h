#ifndef FPSCOUNTER_H
#define FPSCOUNTER_H

#include <QObject>

#include <Windows.h>
#include <QDebug>
#include <QThread>
#include <QQuickWindow>

class FPSCounter : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int fps READ fps WRITE setFPS NOTIFY fpsChanged)


public:
    FPSCounter();
    void setRenderWindow(QQuickWindow* window);
    void Test();
    uint32_t getFPS();
    void onAfterRendering();
    int fps() const;

public slots:
    void setFPS(int fps);

signals:
    void fpsChanged(int fps);

protected:
    UINT32 frameCount = 0;
    LARGE_INTEGER lastFramePerformanceCount;
    LONGLONG performaceFrequency = 0;
    uint32_t lastFps = 0;
    int m_fps;

};

#endif // FPSCOUNTER_H

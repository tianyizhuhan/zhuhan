#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include <QQmlContext>
#include "fpscounter.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    FPSCounter fpsCounter;
    QQuickView view;
    view.rootContext()->setContextProperty("fpsCounter", &fpsCounter);
    view.setResizeMode(QQuickView::SizeRootObjectToView);
    view.setSource(QUrl(QStringLiteral("qrc:/main.qml")));
    view.show();
    fpsCounter.setRenderWindow(&view);

    return app.exec();
}

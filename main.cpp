#include "widget.h"

#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    QQuickWindow::setGraphicsApi(QSGRendererInterface::OpenGLRhi);
    Widget w;
    w.show();
    return a.exec();
}

#include "widget.h"
#include "contactlistprovider.h"
#include "ui_widget.h"

#include <QQmlApplicationEngine>
#include <QQmlEngine>
#include <QQmlContext>

Widget::Widget(QWidget *parent)
    : QWidget(parent)
    , ui(new Ui::Widget)
{
    ui->setupUi(this);

    auto context = ui->quickWidget->rootContext();
    auto contactListProvider = new ContactListProvider(this);
    context->setContextProperty("contactListProvider", contactListProvider);

    ui->quickWidget->setSource(QUrl("qrc:/main.qml"));

}

Widget::~Widget()
{
    delete ui;
}


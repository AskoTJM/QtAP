#include "myjniobject.h"
#include <QDebug>

MyJNIObject::MyJNIObject(QObject *parent) : QObject(parent)
{
    // perform custom initiliazation steps here.
}

void MyJNIObject::dialNumber(const QString &text) {
    qDebug() << "MyJNIObject dialNumber called with" << text;
}

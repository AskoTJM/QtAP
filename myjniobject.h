#ifndef MYJNIOBJECT_H
#define MYJNIOBJECT_H

#include <QObject>

class MyJNIObject : public QObject
{
    Q_OBJECT
public:
    explicit MyJNIObject(QObject *parent = nullptr);

public slots:
    void dialNumber(const QString &text);

signals:


};

#endif // MYJNIOBJECT_H

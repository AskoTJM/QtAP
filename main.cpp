#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>


#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonParseError>
#include <QJsonValue>
#include <QString>
#include <QDebug>
#include <QFile>
#include <QDateTime>
#include <QDir>


#if defined (Q_OS_ANDROID)
#include <QtAndroidExtras/QtAndroid>
#include <QNetworkAccessManager>

bool requestAndroidPermissions(){
    //Request requiered permissions at runtime

//    const QVector<QString> permissions({"android.permission.ACCESS_COARSE_LOCATION",
//                                        "android.permission.BLUETOOTH",
//                                        "android.permission.BLUETOOTH_ADMIN",
//                                        "android.permission.INTERNET",
//                                        "android.permission.WRITE_EXTERNAL_STORAGE",
//                                        "android.permission.READ_EXTERNAL_STORAGE"});
    const QVector<QString> permissions({"android.permission.INTERNET",
                                        "android.permission.WRITE_INTERNAL_STORAGE",
                                        "android.permission.READ_INTERNAL_STORAGE"});

    for(const QString &permission : permissions){
        auto result = QtAndroid::checkPermission(permission);
        if(result == QtAndroid::PermissionResult::Denied){
            auto resultHash = QtAndroid::requestPermissionsSync(QStringList({permission}));
            if(resultHash[permission] == QtAndroid::PermissionResult::Denied)
                return false;
        }
    }

    return true;
}

// From https://bugreports.qt.io/browse/QTBUG-50759
bool checkPermission() {
    QtAndroid::PermissionResult r = QtAndroid::checkPermission("android.permission.WRITE_EXTERNAL_STORAGE");
    if(r == QtAndroid::PermissionResult::Denied) {
        QtAndroid::requestPermissionsSync( QStringList() << "android.permission.WRITE_EXTERNAL_STORAGE" );
        r = QtAndroid::checkPermission("android.permission.WRITE_EXTERNAL_STORAGE");
        if(r == QtAndroid::PermissionResult::Denied) {
             return false;
        }
   }
   return true;
}
#endif


int main(int argc, char *argv[])
{

//        requestAndroidPermissions();
//        Added for permission request
//        #if defined (Q_OS_ANDROID)
//           if(!requestAndroidPermissions())
//              return -1;
//      #endif


#if defined (Q_OS_ANDROID)
    if(!checkPermission())
        return -1;
#endif


    QQuickStyle::setStyle("Material");
    //QQuickStyle::setStyle("Default");
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();

}


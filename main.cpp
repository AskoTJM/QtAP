#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>

#if defined (Q_OS_ANDROID)
#include <QtAndroidExtras/QtAndroid>

bool requestAndroidPermissions(){
    //Request requiered permissions at runtime

    const QVector<QString> permissions({"android.permission.ACCESS_COARSE_LOCATION",
                                        "android.permission.BLUETOOTH",
                                        "android.permission.BLUETOOTH_ADMIN",
                                        "android.permission.INTERNET",
                                        "android.permission.WRITE_EXTERNAL_STORAGE",
                                        "android.permission.READ_EXTERNAL_STORAGE"});

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
#endif

int main(int argc, char *argv[])
{

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
// Added for permission request
    #if defined (Q_OS_ANDROID)
        if(!requestAndroidPermissions())
            return -1;
    #endif
}


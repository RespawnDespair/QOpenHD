#ifndef OPENHDSETTINGS_H
#define OPENHDSETTINGS_H

#include <map>
#include <string>

#include <QObject>
#include <QMap>
#include <QVariant>
#include <QtQuick>
#include <QQmlPropertyMap>

class QUdpSocket;

typedef QMap<QString, QVariant> VMap;

Q_DECLARE_METATYPE(VMap);

class OpenHDSettings : public QObject {
    Q_OBJECT
public:
    explicit OpenHDSettings(QObject *parent = nullptr);
    void initSettings();

    Q_PROPERTY(VMap allSettings MEMBER m_allSettings NOTIFY allSettingsChanged)

    Q_PROPERTY(bool loading MEMBER m_loading WRITE set_loading NOTIFY loadingChanged)
    void set_loading(bool loading);

    Q_PROPERTY(bool saving MEMBER m_saving WRITE set_saving NOTIFY savingChanged)
    void set_saving(bool saving);

    Q_PROPERTY(bool saved MEMBER m_saved WRITE set_saved NOTIFY savedChanged)
    void set_saved(bool saved);

    Q_INVOKABLE void fetchSettings();
    Q_INVOKABLE VMap getAllSettings();

    Q_INVOKABLE void saveSettings(VMap remoteSettings);

    Q_INVOKABLE void reboot();

signals:
    void allSettingsChanged(VMap allSettings);
    void loadingChanged(bool loading);
    void savingChanged(bool saving);
    void savedChanged(bool saved);

    void savingSettingsStart();
    void savingSettingsFinish();

public slots:
    void processDatagrams();


private slots:
    void _savingSettingsStart();
    void _savingSettingsFinish();

private:
    void init();
    void _saveSettings(VMap remoteSettings);

    void saveCheck();
    QUdpSocket *settingSocket = nullptr;

    VMap m_allSettings;
    qint64 start = 0;
    QTimer timer;

    QTimer savedTimer;

    void check();

    // used to keep track of how many settings need to be saved so we can compare it to
    // the number of save confirmations we get back from the ground side
    int settingsCount = 0;

    bool m_loading = false;
    bool m_saving = false;

    bool m_saved = false;

    QHostAddress groundAddress;
};



#endif // OPENHDSETTINGS_H

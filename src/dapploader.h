/*
 * Copyright (C) 2020 ~ 2022 UnionTech Technology Co., Ltd.
 *
 * Author:     Chen Bin <chenbin@uniontech.com>
 *
 * Maintainer: Chen Bin <chenbin@uniontech.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */
#ifndef DAPPLOADER_H
#define DAPPLOADER_H

#include <DObject>

#include <dtkdeclarative_global.h>
#include <QQmlComponent>

QT_BEGIN_NAMESPACE
class QString;
class QQmlEngine;
class QQuickWindow;
class QGuiApplication;
QT_END_NAMESPACE

DQUICK_BEGIN_NAMESPACE

class DAppLoaderPrivate;
class DAppLoader : public QObject, public DTK_CORE_NAMESPACE::DObject
{
    Q_OBJECT
    D_DECLARE_PRIVATE(DAppLoader)
    D_PRIVATE_SLOT(void _q_onMainComponentStatusChanged(QQmlComponent::Status))
    D_PRIVATE_SLOT(void _q_onPreloadCreated(QObject *, const QUrl &))
    D_PRIVATE_SLOT(void _q_onComponentProgressChanged())

public:
    DAppLoader() = delete ;
    DAppLoader(const QString &appName, const QString &appPath = QString(), QObject *parent = nullptr);
    ~DAppLoader();

    int exec(int &argc, char **argv);
    static DAppLoader *instance() { return self; }

Q_SIGNALS:
    void loadFinished();
private:
    static DAppLoader *self;
};

DQUICK_END_NAMESPACE

#endif // DAPPLOADER_H

/*
 * Copyright (C) 2022 UnionTech Technology Co., Ltd.
 *
 * Author:     yeshanshan <yeshanshan@uniontech.com>
 *
 * Maintainer: yeshanshan <yeshanshan@uniontech.com>
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

#pragma once

#include <dtkdeclarative_global.h>

#include <QtQml>

#include "dqmlglobalobject_p.h"

QT_BEGIN_NAMESPACE
class QQuickWindow;
class QQuickItem;
QT_END_NAMESPACE

DQUICK_BEGIN_NAMESPACE

class DPopupWindowHandleImpl;
class Q_DECL_EXPORT DPopupWindowHandle : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QQmlComponent *delegate READ delegate WRITE setDelegate)
    Q_PROPERTY(QQuickWindow *window READ window NOTIFY windowChanged)
    Q_PROPERTY(bool forceWindowMode READ forceWindowMode WRITE setForceWindowMode)

public:
    explicit DPopupWindowHandle(QObject *parent = nullptr);
    ~DPopupWindowHandle() override;

    static DPopupWindowHandle *qmlAttachedProperties(QObject *object);

    static void setPopupMode(const DQMLGlobalObject::PopupMode mode);

    QQuickWindow *window() const;
    QQmlComponent *delegate() const;
    void setDelegate(QQmlComponent *delegate);
    bool forceWindowMode() const;
    void setForceWindowMode(bool forceWindowMode);

Q_SIGNALS:
    void windowChanged();

private Q_SLOTS:
    void createHandle();

private:
    QObject *popup() const;
    bool needCreateHandle() const;

private:
    bool m_forceWindowMode = false;
    bool m_isWindowMode = false;
    QQmlComponent *m_delegate = nullptr;
    QScopedPointer<DPopupWindowHandleImpl> m_handle;
    static DQMLGlobalObject::PopupMode m_popupMode;
};

class DPopupWindowHandleImpl : public QObject
{
    Q_OBJECT
public:
    explicit DPopupWindowHandleImpl(QQuickWindow *window, QObject *parent);
    ~DPopupWindowHandleImpl() override;

    QQuickWindow *window() const;
    QObject *popup() const;
    QQuickItem *popupItem() const;
    void updatePosition();
    bool isPositioning() const;
    void setPositioning(bool positioning);

private Q_SLOTS:
    void reposition();
    void close();
private:
    QQuickWindow *m_window = nullptr;
    QObject *m_popup = nullptr;
    bool m_positioning = false;
};

DQUICK_END_NAMESPACE

QML_DECLARE_TYPEINFO(DTK_QUICK_NAMESPACE::DPopupWindowHandle, QML_HAS_ATTACHED_PROPERTIES)

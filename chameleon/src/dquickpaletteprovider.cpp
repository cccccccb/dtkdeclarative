/*
 * Copyright (C) 2020 Uniontech Technology Co., Ltd.
 *
 * Author:     zccrs <zccrs@live.com>
 *
 * Maintainer: zccrs <zhangjide@uniontech.com>
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
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include "dquickpaletteprovider_p.h"
#include "dquickpalette_p.h"

#include <DPalette>

#include <private/qqmlvaluetype_p.h>

DGUI_USE_NAMESPACE
DQUICK_BEGIN_NAMESPACE

static QQmlValueTypeProvider *instance()
{
    static DQuickPaletteProvider provider;
    return &provider;
}

void DQuickPaletteProvider::init()
{
    QQml_addValueTypeProvider(instance());
}

void DQuickPaletteProvider::cleanup()
{
    QQml_removeValueTypeProvider(instance());
}

#if defined(QT_NO_DEBUG) && !defined(QT_FORCE_ASSERTS)
    #define ASSERT_VALID_SIZE(size, min) Q_UNUSED(size)
#else
    #define ASSERT_VALID_SIZE(size, min) Q_ASSERT(size >= min)
#endif

const QMetaObject *DQuickPaletteProvider::getMetaObjectForMetaType(int type)
{
    switch (type) {
    case QMetaType::QPalette:
        return &DQuickPalette::staticMetaObject;
    default:
        break;
    }

    return nullptr;
}

bool DQuickPaletteProvider::init(int type, QVariant& dst)
{
    switch (type) {
    case QMetaType::QPalette:
        dst.setValue<QPalette>(QPalette());
        return true;
    default: break;
    }

    return false;
}

template<typename T>
bool typedEqual(const void *lhs, const QVariant& rhs)
{
    return (*(reinterpret_cast<const T *>(lhs)) == rhs.value<T>());
}

bool DQuickPaletteProvider::equal(int type, const void *lhs, const QVariant &rhs)
{
    switch (type) {
    case QMetaType::QPalette:
        return typedEqual<QPalette>(lhs, rhs);
    default: break;
    }

    return false;
}

template<typename T>
bool typedStore(const void *src, void *dst, size_t dstSize)
{
    ASSERT_VALID_SIZE(dstSize, sizeof(T));
    const T *srcT = reinterpret_cast<const T *>(src);
    T *dstT = reinterpret_cast<T *>(dst);
    new (dstT) T(*srcT);
    return true;
}

bool DQuickPaletteProvider::store(int type, const void *src, void *dst, size_t dstSize)
{
    switch (type) {
    case QMetaType::QPalette:
        return typedStore<QPalette>(src, dst, dstSize);
    default: break;
    }

    return false;
}

template<typename T>
bool typedRead(const QVariant& src, int dstType, void *dst)
{
    T *dstT = reinterpret_cast<T *>(dst);
    if (src.type() == static_cast<uint>(dstType)) {
        *dstT = src.value<T>();
    } else {
        *dstT = T();
    }
    return true;
}

bool DQuickPaletteProvider::read(const QVariant &src, void *dst, int dstType)
{
    switch (dstType) {
    case QMetaType::QPalette:
        return typedRead<QPalette>(src, dstType, dst);
    default: break;
    }

    return false;
}

template<typename T>
bool typedWrite(const void *src, QVariant& dst)
{
    const T *srcT = reinterpret_cast<const T *>(src);
    if (dst.value<T>() != *srcT) {
        dst = *srcT;
        return true;
    }
    return false;
}

bool DQuickPaletteProvider::write(int type, const void *src, QVariant& dst)
{
    switch (type) {
    case QMetaType::QPalette:
        return typedWrite<QPalette>(src, dst);
    default: break;
    }

    return false;
}

#undef ASSERT_VALID_SIZE

DQUICK_END_NAMESPACE

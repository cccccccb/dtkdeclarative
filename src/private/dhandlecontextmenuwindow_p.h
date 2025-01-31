#ifndef DHANDLECONTEXTMENUWINDOW_P_H
#define DHANDLECONTEXTMENUWINDOW_P_H

#include <QQuickWindow>

class DHandleContextMenuWindow : public QQuickWindow
{
public:
    DHandleContextMenuWindow(QWindow *parent = nullptr);

protected:
    bool event(QEvent *) override;
    void handleMouseEvent(QMouseEvent *);
};

#endif // DHANDLECONTEXTMENUWINDOW_P_H

#ifndef CONTACTLISTPROVIDER_H
#define CONTACTLISTPROVIDER_H

#include <QObject>
#include <QVariantList>

class ContactListProvider : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVariantList contactData READ contactData WRITE setContactData NOTIFY contactDataChanged)
public:
    explicit ContactListProvider(QObject *parent = nullptr);
    QVariantList contactData() const
    {
        return m_contactData;
    }

public slots:
    void setContactData(QVariantList contactData)
    {
        if (m_contactData == contactData)
            return;

        m_contactData = contactData;

        emit contactDataChanged(m_contactData);
    }
    void setContactFavorite(int index, bool favorite);
    QVariantList getDataChunk(int startIndex, int size);
    QVariantList getOnlyFavorites();
    QVariantList getAvailableLetters();
    QVariantList getFilteredData(QString filter);

private:
    QVariantList m_contactData;
    QString alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ#";

signals:

    void contactDataChanged(QVariantList contactData);
};

#endif // CONTACTLISTPROVIDER_H

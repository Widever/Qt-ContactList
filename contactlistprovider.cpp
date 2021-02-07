#include "contactlistprovider.h"

ContactListProvider::ContactListProvider(QObject *parent) : QObject(parent)
{
    QVariantList contactData_;
    for(int i =0; i<100; i++){
        QVariantMap contactItem;
        contactItem["contactName"] = QString("AUser %0").arg(i);
        contactItem["favorite"] = false;
        contactItem["index_"] = i;
        contactData_.append(contactItem);
    }
    for(int i =100; i<200; i++){
        QVariantMap contactItem;
        contactItem["contactName"] = QString("BUser %0").arg(i);
        contactItem["favorite"] = false;
        contactItem["index_"] = i;
        contactData_.append(contactItem);
    }
    for(int i =200; i<300; i++){
        QVariantMap contactItem;
        contactItem["contactName"] = QString("CUser %0").arg(i);
        contactItem["favorite"] = false;
        contactItem["index_"] = i;
        contactData_.append(contactItem);
    }
    setContactData(contactData_);
}

void ContactListProvider::setContactFavorite(int index, bool favorite)
{
    QVariantList contactData_ = m_contactData;
    QVariantMap contactItem = m_contactData.at(index).toMap();
    contactItem["favorite"] = favorite;
    contactData_[index] = contactItem;
    setContactData(contactData_);
}

QVariantList ContactListProvider::getDataChunk(int startIndex, int size)
{
    QVariantList chunk = m_contactData.mid(startIndex, size);
    return chunk;
}

QVariantList ContactListProvider::getOnlyFavorites()
{
    QVariantList onlyFavorites;
    for(auto contact: m_contactData){
        if(contact.toMap()["favorite"].toBool()){
            onlyFavorites.append(contact);
        }
    }
    return onlyFavorites;
}

QVariantList ContactListProvider::getAvailableLetters()
{
   // std::sort(m_contactData.begin(), m_contactData.end());
    QMap<QChar, QVariantMap> availableLettersProto;
    for(auto letterChar: alphabet){
        QVariantMap letter;
        letter["symbol"] = letterChar;
        letter["firstContactIndex"] = -1;
        letter["available"] = false;
        availableLettersProto[letterChar] = letter;
    }
    QChar currentLetter = '.';
    for(int i =0; i<m_contactData.size();++i){
        QChar firstLetter = m_contactData.at(i).toMap()["contactName"].toString()[0].toUpper();
        if(firstLetter == currentLetter) continue;
        if(!availableLettersProto.contains(firstLetter)){
            firstLetter = '#';
        }
        QVariantMap& letter = availableLettersProto[firstLetter];
        letter["firstContactIndex"] = m_contactData.at(i).toMap()["index_"];
        letter["available"] = true;
        currentLetter = firstLetter;
    }
    QVariantList availableLetters;
    for(auto item: availableLettersProto){
        availableLetters.append(item);
    }
    return availableLetters;
}

QVariantList ContactListProvider::getFilteredData(QString filter)
{
    QVariantList filteredData = {};
    for(auto contact: m_contactData){
        if(contact.toMap()["contactName"].toString().indexOf(filter)!=-1){
            filteredData.append(contact);
        }
    }
    return filteredData;
}

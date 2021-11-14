//
//  ContactsHelper.swift
//  EmployeesList
//
//  Created by Anton Stremovskiy on 14.11.2021.
//

import Foundation
import Contacts
import ContactsUI

typealias Contacts = [CNContact]

class ContactsHelper {
    
    static func fetchPhoneContacts() -> Contacts {
        
        var contacts = [CNContact]()
        
        let keys: [Any] = [
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
            CNContactEmailAddressesKey,
            CNContactPhoneNumbersKey,
            CNContactJobTitleKey,
            CNContactViewController.descriptorForRequiredKeys()
        ]
        
        let request = CNContactFetchRequest(keysToFetch: keys as! [CNKeyDescriptor])
        let contactStore = CNContactStore()
        
        try? contactStore.enumerateContacts(with: request, usingBlock: { contact, _ in
            contacts.append(contact)
        })
        return contacts
    }
}

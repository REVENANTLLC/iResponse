#!/usr/bin/swift

import Cocoa
import Foundation
import Collaboration

do {
    
    let defaultAuthority = CSGetLocalIdentityAuthority().takeUnretainedValue()
    let identityClass = kCSIdentityClassUser

    let query   = CSIdentityQueryCreate(nil, identityClass, defaultAuthority).takeRetainedValue()

    var error : Unmanaged<CFError>? = nil

    CSIdentityQueryExecute(query, 0, &error)

    let results = CSIdentityQueryCopyResults(query).takeRetainedValue()

    let resultsCount = CFArrayGetCount(results)

    var allUsersArray = [CBIdentity]()

    for idx in 0...resultsCount-1 {

        let identity    = unsafeBitCast(CFArrayGetValueAtIndex(results,idx),to: CSIdentity.self)
        let uuidString  = CFUUIDCreateString(nil, CSIdentityGetUUID(identity).takeUnretainedValue())

        if let uuidNS = NSUUID(uuidString: uuidString! as String), let identityObject =  CBIdentity(uniqueIdentifier: uuidNS as UUID, authority: CBIdentityAuthority.default()){
            allUsersArray.append(identityObject)
        }
    }
    
    for users in allUsersArray{
        print("\(users)")
    }
        
} catch {
    print("Cant find Users")
}
 

//
//  UserServicesProtocol.swift
//  AIChat
//
//  Created by sinduke on 8/14/25.
//


protocol UserServicesProtocol {
    var remote: RemoteUserServiceProtocol { get }
    var local: LocalUserPersistanceProtocol { get }
}

struct MockUserServices: UserServicesProtocol {
    let remote: RemoteUserServiceProtocol
    let local: LocalUserPersistanceProtocol
    
    init(user: UserModel? = nil) {
        self.remote = MockUserService(user: user)
        self.local = MockUserPersistance(user: user)
    }
}

struct ProductionUserServices: UserServicesProtocol {
    let remote: RemoteUserServiceProtocol = FirebaseUserService()
    let local: LocalUserPersistanceProtocol = FileManagerUserPersistance()
}

//
//  RemoteUserServiceProtocol.swift
//  AIChat
//
//  Created by sinduke on 8/14/25.
//


protocol RemoteUserServiceProtocol {
    func saveUser(user: UserModel) async throws
    func streamUser(userId: String) -> AsyncThrowingStream<UserModel, Error>
    func deleteUser(userId: String) async throws
    func markOnboardingCompleted(userId: String, profileColorHex: String) async throws
}

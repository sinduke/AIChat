//
//  AuthServiceProtocol.swift
//  AIChat
//
//  Created by sinduke on 8/1/25.
//

import SwiftUI


// iOS26似乎不需要让这个协议符合 Sendable 这个在Dev网站上没有写 不知道是否正确是否会推到正式
// iOS26之前的写法 protocol AuthServiceProtocol: Sendable {
/**
 注销这里的协议和Struct的方式进行的环境注入 该用Manager(Class)
 .environment(<#T##object: (Observable & AnyObject)?##(Observable & AnyObject)?#>)
 .environment(<#T##keyPath: WritableKeyPath<EnvironmentValues, V>##WritableKeyPath<EnvironmentValues, V>#>, <#T##value: V##V#>)
 extension EnvironmentValues {
     @Entry var authService: AuthServiceProtocol = MockAuthService()
 }
 */
protocol AuthServiceProtocol {
    // 添加监听
    func addAuthenticatedUserListener(onListenerAttached: (any NSObjectProtocol) -> Void) -> AsyncStream<UserAuthInfo?>
    // 查询是否已经登录 User是Firebase中的定义 需要解耦
    func getAuthenticatedUser() -> UserAuthInfo?
    // 匿名登录 signInAnonymously的返回值是AuthDataResult 来自Firebase 需要解耦
    func signInAnonymously() async throws -> (user: UserAuthInfo, isNewUser: Bool)
    // 使用Apple进行第三方登录
    func signInApple() async throws -> (user: UserAuthInfo, isNewUser: Bool)
    // 退出登录
    func signOut() throws
    // 删除账号
    func deleteAccount() async throws
}

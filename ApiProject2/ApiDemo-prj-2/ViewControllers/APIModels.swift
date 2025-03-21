//
//  APIModels.swift
//  StudentCoreDataApp
//
//  Created by iPHTech 35 on 20/03/25.
//

import Foundation

struct LoginRes: Codable {
    let message: String
    let isSuccess: Bool
    let data: LoginData?
}

struct LoginData: Codable {
    let id: Int?
    let username: String
    let email: String
}

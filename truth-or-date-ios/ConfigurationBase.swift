//
//  ConfigurationBase.swift
//  ios-training
//
//  Created by Quang Nguyễn Như on 17/05/2023.
//

import Foundation

enum HTTPMethod: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case delete = "DELETE"
}

struct ServiceError: Error {
    let issueCode: IssueCode
    var message: String {
        return issueCode.message
    }
    static var urlError: ServiceError {
        return ServiceError(issueCode: IssueCode.CUSTOM_MES(message: "URL is wrong"))
    }
    static var notFoundData: ServiceError {
        return ServiceError(issueCode: IssueCode.CUSTOM_MES(message: "Not found Data"))
    }
    
    static var parseError: ServiceError {
        return ServiceError(issueCode: IssueCode.CUSTOM_MES(message: "Parse Model Error"))
    }
    
    static var jsonError: ServiceError {
        return ServiceError(issueCode: IssueCode.CUSTOM_MES(message: "Response is not JSON"))
    }
    
    static var somethinkWrong: ServiceError {
        return ServiceError(issueCode: IssueCode.CUSTOM_MES(message: "error_message_something_went_wrong"))
    }
}

enum IssueCode {
    case CUSTOM_MES(message: String)
    
    static func initValue(value: String) -> IssueCode {
        if value.isEmpty {
            return .CUSTOM_MES(message: "error_message_something_went_wrong")
        }
        return .CUSTOM_MES(message: value)
    }
    
    var message: String {
        switch self {
        case .CUSTOM_MES(let message):
            return message
        }
    }
}

extension IssueCode {
    private static func issueCode(fromCode code: String) -> IssueCode {
        return initValue(value: code.uppercased())
    }
}

// MARK: - Issue
final class Issue: Codable {
    let error: String?
    let errorCode: String?
}

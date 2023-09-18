//
//  Extension+NSError.swift
//  TheWeather
//
//  Created by Иван Луганцов on 25.05.2023.
//

import Foundation

extension NSError {
    static func error(_ message: String, code: Int = 0) -> NSError {
        NSError(domain: Bundle.main.bundleIdentifier!,
                code: code,
                userInfo: [NSLocalizedDescriptionKey: message])
    }

    static func error(
        title: String,
        message: String,
        code: Int = 0,
        payload: [String: Any]? = nil) -> NSError {
        var mutableUserInfo: [String : Any] = [
            NSLocalizedDescriptionKey: message,
            NSLocalizedFailureReasonErrorKey: title
        ]

        if let p = payload {
            p.keys.forEach({
                mutableUserInfo[$0] = p[$0]
            })
        }

        return NSError(domain: Bundle.main.bundleIdentifier!,
                code: code,
                userInfo: mutableUserInfo)
    }

    static func unknownError() -> NSError {
        error("Sorry, try again later.")
    }
}

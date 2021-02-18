//
//  Logger.swift
//  LocalizedNumberField
//
//  Created by 배지영 on 2021/02/09.
//

import Foundation

public class Logger : NSObject {
    
    enum LogLevel {
        case DEBUG
        case INFO
        case WARN
        case ERROR
        
        var headerMessage: String {
            switch self {
            case .DEBUG:
                return "🛠 [DEBUG]"
            case .INFO:
                return "ℹ️ [INFO]"
            case .WARN:
                return "⚠️ [WARN]"
            case .ERROR:
                return "🆘 [ERROR]"
            }
        }
    }
    
    private let _logPlace: String
    
    public init(logPlace: AnyClass) {
        _logPlace = "\(logPlace)"
    }
    
    public func debug(function: String = #function, line: Int = #line, message: Any) {
        #if DEBUG
        let log = format(logLevel: LogLevel.DEBUG, function: function, line: line, message: message)
            print(log)
        #elseif RELEASE
            //TODO log server에 전송
        #endif
    }
    
    public func info(function: String = #function, line: Int = #line, message: Any) {
        #if DEBUG
        let log = format(logLevel: LogLevel.INFO, function: function, line: line, message: message)
        print(log)
        #endif
    }
    
    public func warn(function: String = #function, line: Int = #line, message: Any) {
        #if DEBUG
        let log = format(logLevel: LogLevel.WARN, function: function, line: line, message: message)
        print(log)
        #endif
    }
    
    public func error(function: String = #function, line: Int = #line, message: Any) {
        #if DEBUG
        let log = format(logLevel: LogLevel.ERROR, function: function, line: line, message: message)
        print(log)
        #endif
    }
    
    private func format(logLevel: LogLevel, function: String, line: Int, message: Any) -> String {
        return
            """

            \(logLevel.headerMessage)
            - log place : \(_logPlace)
            - function : \(function)
            - message
            \(message)
            
            """
    }
}

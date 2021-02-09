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
    
    public func debug(message: Any) {
        // 조건부 컴파일 블록
        #if DEBUG
            let log = format(logLevel: LogLevel.DEBUG, message: message)
            print(log)
        #elseif RELEASE
            //TODO log server에 전송
        #endif
    }
    
    public func info(message: Any) {
        let log = format(logLevel: LogLevel.INFO, message: message)
        print(log)
    }
    
    public func warn(message: Any) {
        let log = format(logLevel: LogLevel.WARN, message: message)
        print(log)
    }
    
    public func error(message: Any) {
        let log = format(logLevel: LogLevel.ERROR, message: message)
        print(log)
    }
    
    private func format(logLevel: LogLevel, message: Any) -> String {
        return
            """
            \(logLevel.headerMessage) - log place : \(_logPlace)
            \(message)
            """
    }
}

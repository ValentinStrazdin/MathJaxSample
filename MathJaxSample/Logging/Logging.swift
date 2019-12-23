//
//  Logging.swift
//  smartAuthenticator
//
//  Created by Valentin Strazdin on 8/21/18.
//  Copyright © 2018 Sokolov, Alexander. All rights reserved.
//

import Foundation
//import Crashlytics

extension Date {
    
    /// Here we get Current Time string
    public var longTimeString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss.SSS"
        return dateFormatter.string(from: self)
    }
}

class Logging {
    
    /// In Debug mode we print message to output, in Release - do nothing
    ///
    /// - Parameter message: message to be printed
    static func logMessage(_ message: String) {
//        #if DEBUG
        print("\(Date().longTimeString) \(message)")
//        #endif
    }
    
    /// In Debug mode we print message to output, in Release - send error to Fabric
    ///
    /// - Parameters:
    ///   - errorMessage: message to be printed (or sent to Fabric)
    ///   - code: corresponding Error Code
//    static func logError(_ errorMessage: String, code: Int) {
//        #if RELEASE
//        let userInfo = [NSLocalizedDescriptionKey: errorMessage]
//        Crashlytics.sharedInstance().recordError(NSError(domain:NSMachErrorDomain, code:code, userInfo:userInfo))
//        #else
//        print(errorMessage)
//        #endif
//    }
}

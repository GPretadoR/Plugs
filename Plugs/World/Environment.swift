//
//  Environment.swift
//  MVVM-C-Networking
//
//  Created by Garnik Ghazaryan on 1/22/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import Foundation

protocol Environment {
    var baseURL: URL { get }
    var socketBaseURL: URL { get }
    var persistentStoreName: String { get }
//    var gifStorageBaseURL: URL { get }
//    var isDebug: Bool { get }
//    var isProduction: Bool { get }
//    var sharesheetURL: URL { get }
//    var changeLanguageURL: URL { get }
//    var exportListsURL: URL { get }
//    var faqURL: URL { get }
//    var sharingFromIBooksURL: URL { get }
//    var privacyPolicyURLString: String { get }
//    var termsAndConditionsURLString: String { get }
//    var surveyURL: URL { get }
//    var appStoreLink: String { get }
//    var appGroup: String { get }
//    var appURLScheme: String { get }
 
//    var googleMapConfig: GoogleConfig { get }
//    var googleSignInClientIdConfig: GoogleConfig { get }
}

enum AppEnvironment: Environment {
    
    case develop
    case production
    case qa
    
    enum Versions: String {
        case v1
        case v2
    }

    #if DEBUG
    static let current: AppEnvironment = .develop
    #else
    static let current: AppEnvironment = .production
    #endif
    
    private var version: Versions {
        .v2
    }
    
    var baseURL: URL {
        let baseURLString: String = {
            switch self {
            case .develop: return "https://apidev2.yerevanride.am/api" + "/\(version)"
            case .production: return "https://api2.yerevanride.am/api" + "/\(version)"
            case .qa: return "http://f2a10ad8.ngrok.io/api" + "/\(version)"
            }
        }()
        return URL(string: baseURLString)!
    }
    
    var socketBaseURL: URL {
        let baseURLString: String = {
            switch self {
            case .develop: return "https://apidev2.yerevanride.am"
            case .production: return "https://api.yerevanride.am"
            case .qa: return "http://f2a10ad8.ngrok.io"
            }
        }()
        return URL(string: baseURLString)!
    }
    
    var persistentStoreName: String {
        "Plugs"
    }
    
    public var appGroup: String {
        return "group.com.plug.common"
    }
}

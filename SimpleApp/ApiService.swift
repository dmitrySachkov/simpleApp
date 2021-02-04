//
//  ApiService.swift
//  SimpleApp
//
//  Created by Dmitry Sachkov on 30.01.2021.
//

import Foundation
import Moya

enum Api {
    case read
}

 extension Api: TargetType {
    var baseURL: URL {
        return URL(string: "https://pryaniky.com")!
    }
    
    var path: String {
        switch self {
        case .read:
            return "/static/json/sample.json"
        default:
            break
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return .none
    }

}

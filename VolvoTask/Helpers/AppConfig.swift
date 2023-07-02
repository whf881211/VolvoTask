//
//  AppConfig.swift
//  VolvoTask
//
//  Created by 王浩沣 on 2023/7/1.
//

import Foundation

/*
 配置项
 */


enum QueryCtiy: String {
    case Beijing
    case Shanghai
    case Guangzhou
    case Shenzhen
    case Suzhou
    case Shengyang
    func adCode() -> String {
        switch self {
        case .Beijing:
            return "110000"
            
        case .Shanghai:
            return "310000"
            
        case .Guangzhou:
            return "440100"
            
        case .Shenzhen:
            return "440300"
            
        case .Suzhou:
            return "320500"
            
        case .Shengyang:
            return "210100"

        }
    }
}


struct AppConfig {
    ///展示天气预报的城市
    static func cityToDisplayForecast() -> [QueryCtiy] {
        return [.Beijing, .Shanghai, .Guangzhou, .Shenzhen, .Suzhou, .Shengyang]
    }
}


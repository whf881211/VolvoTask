//
//  CityWeatherForecastsInfo.swift
//  VolvoTask
//
//  Created by 王浩沣 on 2023/7/1.
//

import Foundation

/*
 请求返回数据
 */

struct WeatherForeastsResponse: Codable {
    var status: String
    var count: String
    var info: String
    var forecasts: [CityWeatherForeastsDataModel]
    
}

struct CityWeatherForeastsDataModel: Codable {
    var adcode: String
    var city: String
    var casts: [WeatherForeastsDataModel]
    var province: String
}


struct WeatherForeastsDataModel: Codable {
    ///日期
    var date: String
    var daytemp: String
    var nighttemp: String
    var dayweather: String
    var nightweather: String
    var daywind: String
    var nightwind: String
    
}

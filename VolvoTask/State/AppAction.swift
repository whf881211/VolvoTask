//
//  AppAction.swift
//  VolvoTask
//
//  Created by 王浩沣 on 2023/7/1.
//

import Foundation

enum AppAction {
    ///加载首页数据
    case startRefreshData
    ///已加载部分数据
    case loadPartialData(result: Result<CityWeatherForecastViewModel, Error> )
}

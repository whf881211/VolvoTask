//
//  WeatherForecastViewModel.swift
//  VolvoTask
//
//  Created by 王浩沣 on 2023/7/1.
//


import Foundation

/*
 页面展示ViewModel
 */

class CityWeatherForecastViewModel: Hashable, Identifiable, ObservableObject {
    
    var city: String
    var adcode: String
    var forecastDetail: ForecastDetailViewModel?
    @Published var isLoading: Bool
    
    
    init(with city: QueryCtiy) {
        self.city = city.rawValue
        self.adcode = city.adCode()
        self.forecastDetail = nil
        self.isLoading = true
    }
    
    init(with dataModel: CityWeatherForeastsDataModel) {
        self.city = dataModel.city
        self.adcode = dataModel.adcode

        self.forecastDetail = dataModel.casts.compactMap{ ForecastDetailViewModel.init(with: $0)}[1]
        self.isLoading = false
    }
    
    func update(with viewModel: CityWeatherForecastViewModel) {
        self.city = viewModel.city
        self.adcode = viewModel.adcode
        self.forecastDetail = viewModel.forecastDetail
        self.isLoading = false
    }
    
    /*
     Hashable
     */
    var id: String {
        get {
            return self.adcode
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.adcode)
    }
    static func == (lhs: CityWeatherForecastViewModel, rhs: CityWeatherForecastViewModel) -> Bool {
        lhs.adcode == rhs.adcode
    }
}


/*
 城市详细天气预报ViewModel
 */
struct ForecastDetailViewModel {
    init(with dataModel: WeatherForeastsDataModel) {
        self.date = dataModel.date
        self.dayTemp = dataModel.daytemp
        self.nightTmp = dataModel.nighttemp
        self.dayWeahter = dataModel.dayweather
        self.nightWeahter = dataModel.nightweather
        self.dayWind = dataModel.daywind
        self.nightWind = dataModel.nightwind
    }
    var date: String
    var dayTemp: String
    var nightTmp: String
    var dayWeahter: String
    var nightWeahter: String
    var dayWind: String
    var nightWind: String
    
}

//
//  Store.swift
//  VolvoTask
//
//  Created by 王浩沣 on 2023/7/1.
//

import Foundation
import Combine


///loading状态
enum AppDataLoadingState {
    case initial
    case loadingData
    case loadingFinish
}

///App当前展示的数据
class AppState: ObservableObject {

    var forecastViewModels: [CityWeatherForecastViewModel] = AppConfig.cityToDisplayForecast().map{.init(with: $0) }
    var appDataLoadingState: AppDataLoadingState = .initial
    ///错误提示
    @Published var displayAlert: Bool = false
    var error: Error? = nil
    var loadedCount = 0
}

///存储App状态
class Store: ObservableObject {
    @Published var appState = AppState()
    
    var disposeBag = Set<AnyCancellable>()
        
    /// appState转换方法
    /// - Parameters:
    ///   - state: 当前的appState
    ///   - action: 当前动作
    /// - Returns: - state: 新的appState; - appCommand:
    static func reduce(state: AppState, action: AppAction) -> (AppState, AppCommand?) {
        let curState = state
        var command: AppCommand? = nil
        curState.error = nil
        curState.displayAlert = false
        switch action {
            ///首页数据加载
        case .startRefreshData:
            command = QueryCityWeather()
            curState.appDataLoadingState = .loadingData
            break
            
            
        case .loadPartialData(result: let result):
            switch result {
            case .success(let viewModel):
                curState.loadedCount += 1
                if let index = curState.forecastViewModels.firstIndex(where: { $0.adcode == viewModel.adcode }) {
                    curState.forecastViewModels[index].update(with: viewModel)
                    curState.forecastViewModels[index].isLoading = false
                }
                curState.appDataLoadingState = .loadingData
                if curState.loadedCount == AppConfig.cityToDisplayForecast().count {
                    curState.appDataLoadingState = .loadingFinish
                }
                break
                
            case .failure(let error):
                curState.error = error
                curState.displayAlert = true
                break
            }
            break

        }
        return (curState, command)
    }
    
    
    func dispatch(_ action: AppAction) {
        let result = Store.reduce(state: appState, action: action)
        appState = result.0
        if let command = result.1 {
            command.execute(in: self)
        }
    }
}


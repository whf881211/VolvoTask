//
//  AppCommand.swift
//  VolvoTask
//
//  Created by 王浩沣 on 2023/7/1.
//

import Foundation

protocol AppCommand {
    func execute(in store: Store)
}

struct QueryCityWeather: AppCommand{
    var publisherProvider: DataTaskPublisher = UrlSessionDataTaskPublisher()
    func execute(in store: Store) {
        AppConfig.cityToDisplayForecast().forEach { city in
            FetchDataRequest(city: city).publisher
                .sink { complete in
                    if case .failure(let error) = complete {
                        store.dispatch(.loadPartialData(result: .failure(error)))
                    }
                } receiveValue: { dataModel in
                    guard let dataModel = dataModel else {
                        return
                    }
                    let viewModel =  CityWeatherForecastViewModel.init(with: dataModel)
                    store.dispatch(.loadPartialData(result: .success(viewModel)))
                }.store(in: &store.disposeBag)

        }

        
    }
}

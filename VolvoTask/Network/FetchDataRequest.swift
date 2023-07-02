//
//  FetchDataRequest.swift
//  VolvoTask
//
//  Created by 王浩沣 on 2023/7/1.
//

import Foundation
import Combine


/*
 数据获取协议
 */
protocol DataTaskPublisher {
    func dataTaskPublisher(for url: URL) -> AnyPublisher<URLSession.DataTaskPublisher.Output , URLError>
}

/*
 默认采用UrlSession进行数据获取
 */
struct UrlSessionDataTaskPublisher : DataTaskPublisher {
    func dataTaskPublisher(for url: URL) -> AnyPublisher<URLSession.DataTaskPublisher.Output , URLError>{
        return URLSession.shared.dataTaskPublisher(for: url).eraseToAnyPublisher()
    }
}

/*
 拉取信息
 */

struct FetchDataRequest {
    let modelUrl = "https://restapi.amap.com/v3/weather/weatherInfo?key=4394203aee54aa1ffbd7e8268d6cc379&extensions=all"
    let city: QueryCtiy
    var publisherProvider: DataTaskPublisher = UrlSessionDataTaskPublisher()
    ///默认使用URLSession
    var publisher : AnyPublisher<CityWeatherForeastsDataModel?, Error> {
        let queryUrl = buildQueryUrl(with: city)
        return publisherProvider.dataTaskPublisher(for: queryUrl)
            .map {$0.data}
            .decode(type: WeatherForeastsResponse.self, decoder: JSONDecoder())
            .compactMap {$0.forecasts.first}
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    
    
    private func buildQueryUrl(with city : QueryCtiy) -> URL {
        guard let url = URL(string: modelUrl) else {
            assertionFailure("[RefreshDataRequest] Wrong URL!")
            return URL(fileURLWithPath: "")
        }
        var usingUrl = url
        usingUrl.append(queryItems: [URLQueryItem(name: "city", value: city.adCode())])
        
        return usingUrl
    }
   
}

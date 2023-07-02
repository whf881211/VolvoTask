//
//  DetailForecastView.swift
//  VolvoTask
//
//  Created by 王浩沣 on 2023/7/2.
//

import Foundation
import SwiftUI

/*
 天气详情
 */

struct DetailForecastView: View {
    let viewModel: CityWeatherForecastViewModel
    var body: some View {
        NavigationView {
            List {
                Text("\(viewModel.city)")
                Text("日期：\(viewModel.forecastDetail?.date ?? "")")
                Text("白天温度:\(viewModel.forecastDetail?.dayTemp ?? "")")
                Text("白天气候:\(viewModel.forecastDetail?.dayWeahter ?? "")")
                Text("白天风向:\(viewModel.forecastDetail?.dayWind ?? "")")

                Text("夜间温度:\(viewModel.forecastDetail?.nightTmp ?? "")")
                Text("夜间气候:\(viewModel.forecastDetail?.nightWeahter ?? "")")
                Text("夜间风向:\(viewModel.forecastDetail?.nightWind ?? "")")

                
            }.navigationTitle("天气详情")
        }
     }
}

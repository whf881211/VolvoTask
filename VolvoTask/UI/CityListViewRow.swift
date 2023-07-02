//
//  ContentCellView.swift
//  VolvoTask
//
//  Created by 王浩沣 on 2023/7/2.
//

import Foundation
import SwiftUI

/*
 每一行的天气信息UI
 */

struct CityListViewRow: View {
   let store: Store
    @ObservedObject var viewModel: CityWeatherForecastViewModel
    
    var body: some View {
        HStack {
            Text(viewModel.city)
        
            if viewModel.isLoading {
                ProgressView()
                .progressViewStyle(.circular)
            } else {
                Text("\(viewModel.forecastDetail?.dayWeahter ?? "")   \(viewModel.forecastDetail?.dayTemp ?? "")°")
            }
        }
    }

    
}

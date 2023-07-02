//
//  ContentView.swift
//  VolvoTask
//
//  Created by 王浩沣 on 2023/7/1.
//

import SwiftUI

/*
 主界面UI
 */
struct CityListView: View {
    let store = Store()
    @ObservedObject var appState: AppState

    var body: some View {
        NavigationView {
            List() {
                ForEach(store.appState.forecastViewModels, id: \.id) { viewModel in
                    NavigationLink(
                        destination: DetailForecastView.init(viewModel: viewModel),
                        label: {
                            CityListViewRow.init(store: store, viewModel: viewModel)
                        })
                }
            }.alert(isPresented: $appState.displayAlert) {
                let wording = store.appState.error?.localizedDescription ?? ""
                return Alert(title: Text("Ooops! Sth went wrong(\(wording)"))
            }.onAppear {
                store.dispatch(.startRefreshData)
            }.navigationTitle("明日天气")
        }
    }
}



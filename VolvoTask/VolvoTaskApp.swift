//
//  VolvoTaskApp.swift
//  VolvoTask
//
//  Created by 王浩沣 on 2023/7/1.
//

import SwiftUI

@main
struct VolvoTaskApp: App {
    
    let store = Store()
    var body: some Scene {
        WindowGroup {
            CityListView.init(appState: store.appState)
        }
    }
}

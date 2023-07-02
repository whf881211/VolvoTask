//
//  StoreUnitTest.swift
//  VolvoTaskTests
//
//  Created by 王浩沣 on 2023/7/2.
//

import XCTest
@testable import VolvoTask

final class StoreUnitTest: XCTestCase {

    let store: Store = Store()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    ///测试store的dispatch方法
    func testStore_dispacth() throws {
        ///调用
        store.dispatch(.startRefreshData)
        ///检查是否符合预期
        XCTAssertEqual(store.appState.appDataLoadingState, .loadingData)
    }
    
    ///测试refreshData的AppAction成功时，appState的状态变化
    func testStoreReduce_loadPartialDataAction_success() throws {
        ///准备测试数据
        let testViewModel = CityWeatherForecastViewModel.init(with: .Beijing)
        testViewModel.isLoading = false
        ///调用
        let result = Store.reduce(state: store.appState, action: .loadPartialData(result: .success(testViewModel)))
        ///检查是否符合预期
        let viewModel = try XCTUnwrap(store.appState.forecastViewModels.first {$0.adcode == testViewModel.adcode})
        XCTAssertEqual(viewModel.isLoading, false)
        XCTAssertEqual(testViewModel, viewModel)
    }
    
    ///测试refreshData的AppAction成功时，appState的状态变化
    func testStoreReduce_loadPartialDataAction_fail() throws {
        ///准备测试数据
        let testViewModel = CityWeatherForecastViewModel.init(with: .Beijing)
        testViewModel.isLoading = false

        ///调用
        let result = Store.reduce(state: store.appState, action: .loadPartialData(result: .failure(NSError())))
        ///检查是否符合预期
        let viewModel = try XCTUnwrap(store.appState.forecastViewModels.first {$0.adcode == testViewModel.adcode})
        XCTAssertEqual(viewModel.isLoading, true)
    }

}

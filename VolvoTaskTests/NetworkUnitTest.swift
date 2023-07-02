//
//  NetworkUnitTest.swift
//  VolvoTaskTests
//
//  Created by 王浩沣 on 2023/7/2.
//

import XCTest
@testable import VolvoTask
import Combine

final class NetworkUnitTest: XCTestCase {

    var disposeBag = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    ///测试网络层返回错误的情况
    func testNetwork_responseFailure() throws {
        ///准备数据
        let mockResponse = URLResponse()
        let publisherProvider = MockErrorTaskPublisher(error: URLError(.badServerResponse))
        let expecation = expectation(description: "testPublisher")
        ///调用
        FetchDataRequest.init(city: .Beijing, publisherProvider: publisherProvider)
            .publisher
            .sink { complete in
                if case .failure(let error) = complete {
                    if let err = error as? URLError {
                        XCTAssertEqual(err, URLError(.badServerResponse))
                    } else {
                        XCTAssertTrue(false)
                    }
                }
                expecation.fulfill()
                
            } receiveValue: { dataModel in
            }.store(in: &self.disposeBag)
        self.wait(for: [expecation], timeout: 1)
    }
    
    ///测试网络层返回空数据的情况
    func testNetwork_responseEmptyData() throws {
        ///准备数据
        let mockResponse = URLResponse()
        let publisherProvider = MockDataTaskPublisher(mockData: Data(), mockResponse: mockResponse)
        let expecation = expectation(description: "testPublisher")
        ///调用
        FetchDataRequest.init(city: .Beijing, publisherProvider: publisherProvider)
            .publisher
            .sink { complete in
                if case .failure(let error) = complete {
                    if let err = error as? NSError {
                        ///json转换失败错误  -4864
                        XCTAssertEqual(err.code, 4864)
                    } else {
                        XCTAssertTrue(false)
                    }
                }
                expecation.fulfill()
                
            } receiveValue: { dataModel in
            }.store(in: &self.disposeBag)
        self.wait(for: [expecation], timeout: 1)
    }
    
    ///测试网络层返回正确数据的情况
    func testNetwork_responseData() throws {
        ///准备数据
        let mockResponse = URLResponse()
        let publisherProvider = MockDataTaskPublisher(mockData: self.mockWeatherData(), mockResponse: mockResponse)
        let expecation = expectation(description: "testPublisher")
        ///调用
        FetchDataRequest.init(city: .Beijing, publisherProvider: publisherProvider)
            .publisher
            .sink { complete in
                if case .failure(_) = complete {
                    XCTAssertTrue(false)
                }
                expecation.fulfill()
                
            } receiveValue: { dataModel in
                XCTAssertEqual(dataModel?.city, "北京市")
            }.store(in: &self.disposeBag)
        self.wait(for: [expecation], timeout: 1)
    }
    
    ///mock的json数据
    func mockWeatherData() -> Data {
        let jsonStr = "{\"status\":\"1\",\"count\":\"1\",\"info\":\"OK\",\"infocode\":\"10000\",\"forecasts\":[{\"city\":\"北京市\",\"adcode\":\"110000\",\"province\":\"北京\",\"reporttime\":\"2023-07-02 22:10:37\",\"casts\":[{\"date\":\"2023-07-02\",\"week\":\"7\",\"dayweather\":\"多云\",\"nightweather\":\"多云\",\"daytemp\":\"36\",\"nighttemp\":\"24\",\"daywind\":\"南\",\"nightwind\":\"南\",\"daypower\":\"≤3\",\"nightpower\":\"≤3\",\"daytemp_float\":\"36.0\",\"nighttemp_float\":\"24.0\"},{\"date\":\"2023-07-03\",\"week\":\"1\",\"dayweather\":\"阴\",\"nightweather\":\"小雨\",\"daytemp\":\"34\",\"nighttemp\":\"24\",\"daywind\":\"南\",\"nightwind\":\"南\",\"daypower\":\"≤3\",\"nightpower\":\"≤3\",\"daytemp_float\":\"34.0\",\"nighttemp_float\":\"24.0\"},{\"date\":\"2023-07-04\",\"week\":\"2\",\"dayweather\":\"多云\",\"nightweather\":\"多云\",\"daytemp\":\"37\",\"nighttemp\":\"23\",\"daywind\":\"西\",\"nightwind\":\"西\",\"daypower\":\"≤3\",\"nightpower\":\"≤3\",\"daytemp_float\":\"37.0\",\"nighttemp_float\":\"23.0\"},{\"date\":\"2023-07-05\",\"week\":\"3\",\"dayweather\":\"晴\",\"nightweather\":\"晴\",\"daytemp\":\"38\",\"nighttemp\":\"23\",\"daywind\":\"西北\",\"nightwind\":\"西北\",\"daypower\":\"≤3\",\"nightpower\":\"≤3\",\"daytemp_float\":\"38.0\",\"nighttemp_float\":\"23.0\"}]}]}"
        return jsonStr.data(using: .utf8) ?? Data()

    }
}

//
//  TestForecastPresenter.swift
//  TestForecastPresenter
//
//  Created by Иван Луганцов on 16.08.2023.
//

import XCTest
@testable import TheWeather

final class TestForecastPresenter: XCTestCase {

    var sut: ApplicationPresenter!

    override func setUpWithError() throws {
        sut = ApplicationPresenter.shared
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
        // Put teardown code here.
        // This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete.
        // Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
//            Это блок кода, который будет измеряться на производительность.
//            Все, что находится внутри этого блока, будет выполнено несколько раз,
//            и фреймворк XCTest замерит среднее время выполнения.
//            В этом блоке вы можете поместить код, который вы хотите протестировать на производительность.
        }
    }

    func testTrue() throws {

        // GIVEN
        let didReceiveResponce = expectation(description: #function)
        var result: [WeatherForecast]?

        // WHEN
        DataStorage.shared.fetchAllData {

            XCTAssertNil(result, "Expected no errors loading a file.")
            let resultData = DataStorage.shared.forecastData
            result = resultData

            XCTAssertNotNil(resultData, "Expected to load a file.")
            didReceiveResponce.fulfill()
        }

        wait(for: [didReceiveResponce], timeout: 8)

        // THEN
        switch result {
        case _ where result?.isEmpty == true:
            XCTFail("Test failed result.isEmpty")
        case _ where result?.isEmpty == false:
            XCTAssertNotNil(result)
        default:
            XCTFail("Test failed new case")
        }
    }
}

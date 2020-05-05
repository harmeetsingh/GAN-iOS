//
//  NetworkSessionTests.swift
//  GANTests
//
//  Created by Harmeet Singh on 03/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import XCTest
@testable import GAN

/// FYI - Tests in Given, When, Then format
class NetworkSessionTests: XCTestCase {

    // MARK: - Properties

    let networkRequest = MockNetworkRequest(endpoint: "/something/cool",
                                            query: "?A=1",
                                            method: .get,
                                            headers: nil,
                                            parameters: nil)

    let networkImageRequest = MockNetworkImageRequest()

    let responseDecoder = MockNetworkResponseDecoder()

    static var mockSession = SuperSession.shared
    var networkSession = NetworkSession(session: mockSession, domain: "domain")

    // MARK: - Init tests

    func testInit_DomainCorrectValue() {
        XCTAssertEqual(networkSession.domain, "domain")
    }

    // MARK: - Load failure scenario tests

    func testLoad_InvalidRequest_ReturnsNilURLError() {

        let networkRequest = MockNetworkRequest(endpoint: "",
                                                query: "",
                                                method: .get,
                                                headers: nil,
                                                parameters: nil)

        let mockSession = SuperSession.shared
        networkSession = NetworkSession(session: mockSession, domain: "")

        networkSession.load(request: networkRequest, decoder: responseDecoder) { result in

            switch result {

            case .failure(let error):

                let networkRequestError = error as? NetworkRequestError
                XCTAssertEqual(networkRequestError, NetworkRequestError.nilURL)

            default:
                XCTFail()
            }
        }
    }

    func testLoad_ErrorReturned_ReturnsCorrectError() {

        let expectation = self.expectation(description: "testLoad_ErrorReturned_ReturnsCorrectError")

        let networkRequest = MockNetworkRequest(endpoint: "something/cool",
                                                query: nil,
                                                method: .get,
                                                headers: nil,
                                                parameters: nil)

        NetworkSessionTests.mockSession.stubDataTask(withError: MockError.randomError)

        networkSession.load(request: networkRequest, decoder: responseDecoder) { result in

            switch result {

            case .failure(let error):

                let mockError = error as? MockError
                XCTAssertEqual(mockError, MockError.randomError)
                expectation.fulfill()

            default:
                XCTFail()
            }
        }

        wait(for: [expectation], timeout: 0.1)
    }

    func testLoad_RequestFailed_ReturnsCorrectError() {

        let expectation = self.expectation(description: "testLoad_RequestFailed_ReturnsCorrectError")

        let mockResponse = HTTPURLResponse(url: URL(string: "url")!,
                                           statusCode: 401,
                                           httpVersion: "1.1",
                                           headerFields: nil)

        NetworkSessionTests.mockSession.stubDataTask(withResponse: mockResponse)

        networkSession.load(request: networkRequest, decoder: responseDecoder) { result in

            switch result {

            case .failure(let error):

                let networkSessionError = error as? NetworkSessionError
                XCTAssertEqual(networkSessionError, NetworkSessionError.unsuccessfulRequest(mockResponse))
                expectation.fulfill()

            default:
                XCTFail()
            }
        }

        wait(for: [expectation], timeout: 0.1)
    }

    func testLoad_NilResponseData_ReturnsCorrectError() {

        let expectation = self.expectation(description: "testLoad_NilResponseData_ReturnsCorrectError")

        let mockResponse = HTTPURLResponse(url: URL(string: "url")!,
                                           statusCode: 200,
                                           httpVersion: "1.1",
                                           headerFields: nil)

        NetworkSessionTests.mockSession.stubDataTask(with: nil, response: mockResponse, error: nil)

        networkSession.load(request: networkRequest, decoder: responseDecoder) { result in

            switch result {

            case .failure(let error):

                let networkSessionError = error as? NetworkSessionError
                XCTAssertEqual(networkSessionError, NetworkSessionError.nilResponseData)
                expectation.fulfill()

            default:
                XCTFail()
            }
        }

        wait(for: [expectation], timeout: 0.1)
    }

    // MARK: - Load success scenario tests

    func testLoad_ResponseDataUnexpectedFormat_ReturnsCorrectError() {

        let expectation = self.expectation(description: "testLoad_ResponseDataUnexpectedFormat_ReturnsCorrectError")

        let mockResponse = HTTPURLResponse(url: URL(string: "url")!,
                                           statusCode: 200,
                                           httpVersion: "1.1",
                                           headerFields: nil)

        let mockData = "something".data(using: .utf8)

        NetworkSessionTests.mockSession.stubDataTask(with: mockData, response: mockResponse, error: nil)

        networkSession.load(request: networkRequest, decoder: responseDecoder) { result in

            switch result {

            case .success(let decodedData):
                XCTAssertEqual(decodedData as? String, "a string was decoded")
                expectation.fulfill()
            default:
                XCTFail()
            }
        }

        wait(for: [expectation], timeout: 0.1)
    }

    // MARK: - Load image failure scenario tests

    func testLoadImage_ErrorReturned_ReturnsCorrectError() {

        let expectation = self.expectation(description: "testLoadImage_ErrorReturned_ReturnsCorrectError")

        NetworkSessionTests.mockSession.stubDataTask(withError: MockError.randomError)

        networkSession.loadImage(request: networkImageRequest) { result in

            switch result {

            case .failure(let error):

                let mockError = error as? MockError
                XCTAssertEqual(mockError, MockError.randomError)
                expectation.fulfill()

            default:
                XCTFail()
            }
        }

        wait(for: [expectation], timeout: 0.1)
    }

    func testLoadImage_RequestFailed_ReturnsCorrectError() {

        let expectation = self.expectation(description: "testLoadImage_RequestFailed_ReturnsCorrectError")

        let mockResponse = HTTPURLResponse(url: URL(string: "url")!,
                                           statusCode: 401,
                                           httpVersion: "1.1",
                                           headerFields: nil)

        NetworkSessionTests.mockSession.stubDataTask(withResponse: mockResponse)

        networkSession.loadImage(request: networkImageRequest) { result in

            switch result {

            case .failure(let error):

                let networkSessionError = error as? NetworkSessionError
                XCTAssertEqual(networkSessionError, NetworkSessionError.unsuccessfulRequest(mockResponse))
                expectation.fulfill()

            default:
                XCTFail()
            }
        }

        wait(for: [expectation], timeout: 0.1)
    }

    func testLoadImage_NilResponseData_ReturnsCorrectError() {

        let expectation = self.expectation(description: "testLoadImage_NilResponseData_ReturnsCorrectError")

        let mockResponse = HTTPURLResponse(url: URL(string: "url")!,
                                           statusCode: 200,
                                           httpVersion: "1.1",
                                           headerFields: nil)

        NetworkSessionTests.mockSession.stubDataTask(with: nil, response: mockResponse, error: nil)

        networkSession.loadImage(request: networkImageRequest) { result in

            switch result {

            case .failure(let error):

                let networkSessionError = error as? NetworkSessionError
                XCTAssertEqual(networkSessionError, NetworkSessionError.nilResponseData)
                expectation.fulfill()

            default:
                XCTFail()
            }
        }

        wait(for: [expectation], timeout: 0.1)
    }

    // MARK: - Load success scenario tests

    func testLoadImage_ResponseDataUnexpectedFormat_ReturnsCorrectError() {

        let expectation = self.expectation(description: "testLoadImage_ResponseDataUnexpectedFormat_ReturnsCorrectError")

        let mockResponse = HTTPURLResponse(url: URL(string: "url")!,
                                           statusCode: 200,
                                           httpVersion: "1.1",
                                           headerFields: nil)


        let mockData = Data.contentsOfImageFileName(fileName: "tick", forClass: NetworkSessionTests.self)

        NetworkSessionTests.mockSession.stubDataTask(with: mockData, response: mockResponse, error: nil)

        networkSession.loadImage(request: networkImageRequest) { result in

            switch result {

            case .success(let responseImage):

                let localImage = UIImage(data: mockData!)
                XCTAssertEqual(responseImage.pngData(), localImage?.pngData())
                expectation.fulfill()
            default:
                XCTFail()
            }
        }

        wait(for: [expectation], timeout: 0.1)
    }
}


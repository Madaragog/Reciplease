//
//  MockURLProtocol.swift
//  RecipleaseTests
//
//  Created by Cedric on 19/06/2020.
//  Copyright © 2020 Cedric. All rights reserved.
//

import Foundation

class MockURLProtocol: URLProtocol {
    enum ResponseType {
        case error(Error)
        case success(HTTPURLResponse)
    }

    let url = "http://openClassrooms.com"
    static var responseType: ResponseType!

    private(set) var activeTask: URLSessionTask?

    private lazy var session: URLSession = {
        let configuration: URLSessionConfiguration = URLSessionConfiguration.ephemeral
        return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }()

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
// swiftlint:disable identifier_name
    override class func requestIsCacheEquivalent(_ a: URLRequest, to b: URLRequest) -> Bool {
        return false
    }

    override func startLoading() {
        activeTask = session.dataTask(with: request.urlRequest!)
        activeTask?.cancel()
    }

    override func stopLoading() {
        activeTask?.cancel()
    }
}

// MARK: - URLSessionDataDelegate

extension MockURLProtocol: URLSessionDataDelegate {
    static var recipesResponseCorrectData: Data {
        let bundle = Bundle(for: MockURLProtocol.self)
        let url = bundle.url(forResource: "Recipes", withExtension: "json")
        let data = try? Data(contentsOf: url!)
        return data!
    }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        client?.urlProtocol(self, didLoad: MockURLProtocol.recipesResponseCorrectData)
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        switch MockURLProtocol.responseType {
        case .error(let error)?:
            client?.urlProtocol(self, didFailWithError: error)
        case .success(let response)?:
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        default:
            break
        }

        client?.urlProtocolDidFinishLoading(self)
    }
}

extension MockURLProtocol {
    enum MockError: Error {
        case none
    }

    static func responseWithFailure() {
        MockURLProtocol.responseType = MockURLProtocol.ResponseType.error(MockError.none)
    }

    static func responseWithStatusCode(code: Int) {
        MockURLProtocol.responseType = MockURLProtocol.ResponseType.success(HTTPURLResponse(url:
            URL(string: "http://openClassrooms.com")!, statusCode: code, httpVersion: nil, headerFields: nil)!)
    }
}

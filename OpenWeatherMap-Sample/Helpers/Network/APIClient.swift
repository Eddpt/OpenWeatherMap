//
//  APIClient.swift
//  OpenWeatherMap-Sample
//
//  Created by Eddpt on 14/08/2016.
//  Copyright © 2016 test. All rights reserved.
//

import Foundation

public typealias JSONDictionary = [String : AnyObject]

enum APIError: ErrorType {
    case genericError(error: NSError)
    case invalidResponseError
    case badResponseError(response: NSURLResponse)
    case invalidDataError
}

enum Result<T, Error: ErrorType> {
    case success(T)
    case failure(Error)
}

class APIClient {

    //MARK: Private properties

    private let urlSession = NSURLSession.sharedSession()

    //MARK: APIClient Public methods

    /**
     Method responsible for retrieving data from a given URL, which will callback the given closure
     when the operation has finished.

     - parameter url:        URL used in order to make the request
     - parameter completion: Closure to be called at the end of the request, with either an error or some data.

     - returns: An optional and cancelable URL Session Data Task
     */
    func getData(fromURL url: NSURL, completion: (Result<JSONDictionary, APIError>) -> Void) -> NSURLSessionDataTask? {
        let task = urlSession.dataTaskWithURL(url) { (responseData, response, responseError) in
            if let error = responseError {
                completion(.failure(APIError.genericError(error: error)))
                return
            }

            guard let httpResponse = response as? NSHTTPURLResponse else {
                completion(.failure(APIError.invalidResponseError))
                return
            }

            guard (200...299 ~= httpResponse.statusCode) else {
                completion(.failure(APIError.badResponseError(response: httpResponse)))
                return
            }

            guard let data = responseData else {
                completion(.failure(APIError.invalidDataError))
                return
            }

            do {
                let result = try JSONDataParser.parse(withData: data)

                completion(.success(result))
            } catch {
                completion(.failure(APIError.invalidDataError))
            }
        }
        
        task.resume()
        
        return task
    }
}
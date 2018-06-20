//
//  AppExtensions.swift
//  kevin
//
//  Created by kevin.cheng on 6/20/18.
//  Copyright © 2018 Nazca Triangle. All rights reserved.
//

import UIKit
import RxSwift
func delay(_ seconds: Double, complete: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
        complete()
    }
}

var deviceId: String {
    return UIDevice.current.identifierForVendor!.uuidString
}

extension Date {
    
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    var startOfHour: Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day, .hour], from: Date()))!
    }
    
    var endOfDay: Date {
        var dateComponents = DateComponents()
        dateComponents.second = -1
        return Calendar.current.date(byAdding: dateComponents, to: self.startOfDay.addDay(1))!
    }
    
    func addDay(_ day: Double) -> Date {
        return self.addingTimeInterval(60 * 60 * 24 * day)
    }
    
    func addMinute(_ minute: Double) -> Date {
        return self.addingTimeInterval(60 * minute)
    }
    
}

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}

extension UIColor {
    var inverted: UIColor {
        var red: CGFloat = 0.0, green: CGFloat = 0.0, blue: CGFloat = 0.0, alpha: CGFloat = 0.0
        UIColor.red.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return UIColor(red: (1 - red), green: (1 - green), blue: (1 - blue), alpha: alpha)
    }
}

enum APIError: Error {
    case invalidToken
    case dataNotExisted(message: String)
    case invalidFormat(type: Any.Type, value: Any)
    case unauthorized
    case badRequest
    case duplicateRequest
    case serverError
    case invalidUrl
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "Delete"
}

extension Data {
    
    static func request(url: String, data: Data?, method: HttpMethod = .post, headers: [String: String] = [:],
                        queryStrings: [String: String] = [:]) -> Observable<(Data, URLResponse)> {
        
        return Observable<(Data, URLResponse)>.create { observable in
            guard var urlComponents = URLComponents(string: url) else {
                observable.onError(APIError.invalidUrl)
                return Disposables.create()
            }
            if method == .get {
                urlComponents.queryItems =
                    queryStrings.map {
                        URLQueryItem(name: $0.key, value: $0.value)
                }
            }
            guard let url = urlComponents.url else {
                observable.onError(APIError.invalidUrl)
                return Disposables.create()
            }
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            request.cachePolicy = .reloadIgnoringLocalCacheData
            for header in headers {
                request.addValue(header.value, forHTTPHeaderField: header.key)
            }
            if let data = data {
                #if DEBUG
                print("posting body: \(String(data: data, encoding: .utf8) ?? "")")
                #endif
                request.httpBody = data
            }
            let urlSession = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if let error = error {
                    observable.onError(error)
                    return
                } else if let data = data, let response = response {
                    observable.onNext((data, response))
                    observable.onCompleted()
                }
            })
            urlSession.resume()
            return Disposables.create()
            }
            .map(errorCheck)
    }
    
    static func errorCheck(_ httpResult: (Data, URLResponse)) throws ->  (Data, URLResponse) {
        if let urlResponse = httpResult.1 as? HTTPURLResponse {
            if urlResponse.statusCode >= 400 {
                print("error on: \(httpResult.1.url?.absoluteString ?? "")")
                print("error code: \(urlResponse.statusCode)")
                print(String(data: httpResult.0, encoding: .utf8) ?? "")
            }
            switch urlResponse.statusCode {
            case 401:
                throw APIError.unauthorized
            case 400:
                throw APIError.badRequest
            case 409:
                throw APIError.duplicateRequest
            case 500:
                throw APIError.serverError
            default:
                break
            }
        }
        return httpResult
    }
}

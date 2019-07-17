//
//  Model.swift
//  Ланчи Гаэтано
//
//  Created by Денис Обухов on 07/07/2019.
//  Copyright © 2019 Oggetto. All rights reserved.
//

import Foundation




var todayMenu: [String] {
    get {
        if let array = UserDefaults.standard.array(forKey: getCacheKey())
            as? [String] {
            return array
        } else {
            let result = getServerData()
            UserDefaults.standard.set(result, forKey: getCacheKey())
            UserDefaults.standard.synchronize()
            return result
        }
    }
    set {
        UserDefaults.standard.set(newValue, forKey: getCacheKey())
        UserDefaults.standard.synchronize()
    }
}

func getCacheKey() -> String {
    let now = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "hhddMMyyyy"
    return dateFormatter.string(from: now)
}


extension URLSession {
    func synchronousDataTask(with url: URL) -> Data? {
        var data: Data?
        var response: URLResponse?
        var error: Error?
        
        let semaphore = DispatchSemaphore(value: 0)
        
        let dataTask = self.dataTask(with: url) {
            data = $0
            response = $1
            error = $2
            
            semaphore.signal()
        }
        dataTask.resume()
        
        _ = semaphore.wait(timeout: .distantFuture)
        
        return data
    }
}

func getServerData() -> [String] {
    
    var result: [String] = []
    
    let url = URL(string: "http://obukhow.ru/oggetto/gaetano-api.php")!
    
    var data :Data? = URLSession.shared.synchronousDataTask(with: url)
    
    do {
        if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: []) as? [String] {
            result = jsonResult
        }
    } catch let error as NSError {
        print(error.localizedDescription)
    }
    
    return result
}

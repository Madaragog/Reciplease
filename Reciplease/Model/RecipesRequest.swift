//
//  RecipesRequest.swift
//  Reciplease
//
//  Created by Cedric on 08/06/2020.
//  Copyright © 2020 Cedric. All rights reserved.
//

import Foundation
import Alamofire

class RequestService {
    func request() {
        AF.request("").response { response in
            print(response)
        }
    }
}

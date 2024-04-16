//
//  ImageDecodeTest.swift
//  ImageTableAssignment
//
//  Created by Suprabha Dhavan on 15/04/24.
//

import UIKit
import Foundation
//class ImageDecodeTest: NSObject {
//
//}
struct imageDetail: Codable {
    let urls: imgURL
}
struct imgURL: Codable {
    let urlStr: String
    var urlFmStr: URL { return URL(string: urlStr)!
    }
}

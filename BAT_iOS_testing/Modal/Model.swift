//
//  Model.swift
//  BAT_iOS_testing
//
//  Created by Dawei Hao on 2024/9/9.
//

import UIKit

struct Youbike: Codable {
    var sna: String     // YouBike中文站名
    var snaen: String   // YouBike英文站名
    var tot: Int        // 場站總車格
    var sbi: Int       // 場站目前車輛數，現在作為可選字段
    var bemp: Int      // 目前空位數量，現在作為可選字段
    var lat: Double     // 緯度
    var lng: Double     // 經度
    var sarea: String   // 市區名
    var ar: String      // 路名
    var sareaen: String // 英文市區名
    var aren: String    // 英文路名
    var srcUpdateTime: String
    var updateTime: String
    
    enum CodingKeys: String, CodingKey {
        case sna, snaen, sarea, ar, sareaen, aren, srcUpdateTime, updateTime
        case tot = "total"
        case sbi = "available_rent_bikes"
        case bemp = "available_return_bikes"
        case lat = "latitude"
        case lng = "longitude"
    }
}

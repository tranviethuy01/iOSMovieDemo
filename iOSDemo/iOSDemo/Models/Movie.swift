//
//  Movie.swift
//  iOSDemo
//
//  Created by Viet Huy on 4/26/23.
//  Copyright © 2023 Tran Viet Huy. All rights reserved.

import Foundation
import ObjectMapper

class Movie: Mappable {
    var id: Int = 0
    var title: String?
    var description: String?
    var rating: Double?
    var duration: String?
    var genre: String?
    var releasedDate: Date?
    var trailerLink: String?
    var image: String?
    var isOnMyWatchList: Bool?
    convenience required init?(map: Map) {
        self.init()
        id <- map["id"]
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        title <- map["title"]
        description <- map["description"]
        rating <- map["rating"]
        duration <- map["duration"]
        genre <- map["genre"]
        releasedDate <- (map["releasedDate"], MappingService.transformStringDate)
        trailerLink <- map["trailerLink"]
        image <- map["image"]
        isOnMyWatchList <- map["isOnMyWatchList"]
    }
}

//
//  MappingService.swift
//  iOSDemo
//
//  Created by Viet Huy on 4/26/23.
//

import Foundation
import ObjectMapper
class MappingService {
    static let transformStringDate = TransformOf<Date, String>(fromJSON: { (value: String?) -> Date? in
        // transform value from String? to Date?
        if let value = value {
            return value.dateFromISO8601
        }
        return nil
    }, toJSON: { (value: Date?) -> String? in
        // transform value from Date? to String?
        if let value = value {
            return value.ldiso8601
        }
        return nil
    })
    static let transformIntBool = TransformOf<Bool, Int>(fromJSON: { (value: Int?) -> Bool in
        // transform value from String? to Date?
        if let value = value {
            if value == 1 {
                return true
            }
            else {
                return false
            }
        }
        return false
    }, toJSON: { (value: Bool?) -> Int in
        // transform value from Date? to String?
        if let value = value {
            return value ? 1:0
        }
        return 0
    })
    static let transformDoubleDate = TransformOf<Date, Int64>(fromJSON: { (value: Int64?) -> Date? in
        if let value = value {
            return Date(milliseconds: value)
        }
        return nil
    }) { (value: Date?) -> Int64? in
        if let value = value {
            return value.millisecondsSince1970
        }
        return nil
    }
    
}

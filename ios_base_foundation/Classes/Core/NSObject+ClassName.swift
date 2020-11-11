//
//  NSObject+ClassName.swift
//  SwiftyBase
//
//  Created by walker on 2020/10/20.
//

import Foundation

public extension NSObject {
    
    class var className: String {
        let typeName = "\(type(of: Self.self))"
        let nameArray = typeName.components(separatedBy: ".")
        return nameArray.first ?? typeName
    }
    
    var className: String {
        let typeName = "\(type(of: self))"
        let nameArray = typeName.components(separatedBy: ".")
        return nameArray.first ?? typeName
    }
    
}

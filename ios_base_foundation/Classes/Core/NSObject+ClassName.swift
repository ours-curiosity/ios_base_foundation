//
//  NSObject+ClassName.swift
//  SwiftyBase
//
//  Created by walker on 2020/10/20.
//

import Foundation

public extension NSObject {
    
    public class var className: String {
        let typeName = "\(type(of: Self.self))"
        let nameArray = typeName.components(separatedBy: ".")
        return nameArray.first ?? typeName
    }
    
    public var className: String {
        let typeName = "\(type(of: self))"
        let nameArray = typeName.components(separatedBy: ".")
        return nameArray.first ?? typeName
    }
    
}

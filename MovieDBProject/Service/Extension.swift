//
//  Extension.swift
//  LearnRXSwift
//
//  Created by MacBook on 05/06/21.
//

import Foundation

protocol HasApply { }

extension HasApply {
    func apply(closure:(Self) -> ()) -> Self {
        closure(self)
        return self
    }
}

extension NSObject: HasApply { }

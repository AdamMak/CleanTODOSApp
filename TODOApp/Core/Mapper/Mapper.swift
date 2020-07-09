//
//  Mapper.swift
//  TODOApp
//
//  Created by Adam Makhfoudi on 09/07/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

protocol Mapper {
    associatedtype Input: APIResponse
    associatedtype Output
    func mapping(input: Input) -> Output
}


//
//  ChatLoader.swift
//  Rapptr iOS Test
//
//  Created by Deniz Tutuncu on 5/16/22.
//

import Foundation

public protocol ChatLoader {
    typealias Result = Swift.Result<[Message], Error>
    func load(completion: @escaping (Result) -> Void)
}

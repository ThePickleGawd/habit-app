//
//  DataAccess.swift
//  Habit
//
//  Created by Dylan Lu on 1/28/24.
//

import Foundation

protocol DataAccess<Request, Response> {
    associatedtype Request
    associatedtype Response
    
    func fetch(request: Request) async throws -> Response
}

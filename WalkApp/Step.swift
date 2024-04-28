//
//  Step.swift
//  WalkApp
//
//  Created by Andy Lam on 4/27/24.
//

import Foundation

struct Step: Identifiable {
    let id = UUID()
    let count: Int
    let date: Date
}

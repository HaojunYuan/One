//
//  Workout.swift
//  One
//
//  Created by Brian Yuan on 2/19/24.
//

import Foundation

// Enum for target muscles
enum WorkoutType: String, Codable, CaseIterable, Hashable {
    case chest
    case back
    case legs
    case arms
    case shoulders
    case core
    case cardio
    case functional
}

enum Unit: String, Codable, CaseIterable {
    case lb
    case kg
    case min
}

struct Workout: Codable, Hashable {
    var id = UUID()
    var name: String
    var workoutType: WorkoutType
    var sets: [WorkoutSet] = []
    var unit: Unit
}

struct WorkoutSet: Codable, Hashable {
    var id = UUID()
    var weight: Int?
    var repetitions: Int?
}

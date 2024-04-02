//
//  HealthManager.swift
//  TrainX
//
//  Created by Brian Yuan on 3/31/24.
//

import Foundation
import HealthKit


class HealthViewModel: ObservableObject {
    
    let healthStore = HKHealthStore()
    @Published var activities: [String: Activity] = [:]
    
    init() {
        let steps = HKQuantityType(.stepCount)
        let calories = HKQuantityType(.activeEnergyBurned)
        let workouts = HKObjectType.workoutType()
        let healthTypes: Set = [steps, calories, workouts]
        
        Task {
            do {
                try await healthStore.requestAuthorization(toShare: [], read: healthTypes)
                fetchTodayCalories()
                fetchTodaySteps()
                fetchTodayWorkouts()
            } catch {
                print("Error fetching health data")
            }
        }
    }
    
    func fetchTodayCalories() {
        let calories = HKQuantityType(.activeEnergyBurned)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        let query = HKStatisticsQuery(quantityType: calories, quantitySamplePredicate: predicate) {_, result, error in
            guard let quantity = result?.sumQuantity(), error == nil else {
                print("Error fetching today's calory data")
                return
            }
            let caloriesBurned = quantity.doubleValue(for: .kilocalorie())
            let activity = Activity(id: UUID(), title: "Active calories", subtitle: "Goal 500", image: "flame", amount: caloriesBurned.formattedString())
            DispatchQueue.main.async {
                self.activities["todayCalories"] = activity
            }
        }
        healthStore.execute(query)
    }
    
    func fetchTodaySteps() {
        let steps = HKQuantityType(.stepCount)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate) {_, result, error in
            guard let quantity = result?.sumQuantity(), error == nil else {
                print("Error fetching today's step data")
                return
            }
            let stepCount = quantity.doubleValue(for: .count())
            let activity = Activity(id: UUID(), title: "Steps", subtitle: "Goal 5000", image: "figure.walk", amount: stepCount.formattedString())
            DispatchQueue.main.async {
                self.activities["todaySteps"] = activity
            }
        }
        healthStore.execute(query)
    }
    
    func fetchTodayWorkouts() {
        let workout = HKObjectType.workoutType()
        let timePredicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        let query = HKSampleQuery(sampleType: workout, predicate: timePredicate, limit: 20, sortDescriptors: nil) {_, sample, error in
            guard let workouts = sample as? [HKWorkout], error == nil else {
                print("Error fetching today's workout data")
                return
            }
            
            var workoutCounts: [String: Int] = [:]
            
            for workout in workouts {
                let duration = Int(workout.duration) / 60
                let activityType = workout.workoutActivityType.name
                
                if let count = workoutCounts[activityType] {
                    workoutCounts[activityType] = count + duration
                } else {
                    workoutCounts[activityType] = duration
                }
            }
            
            var activities: [Activity] = []
            for (activityType, duration) in workoutCounts {
                if let symbolName = self.symbolName(for: activityType) {
                    let activity = Activity(id: UUID(), title: activityType, subtitle: "", image: symbolName, amount: "\(duration) minutes")
                    activities.append(activity)
                }
            }
            
            DispatchQueue.main.async {
                for activity in activities {
                    self.activities["today\(activity.title)"] = activity
                }
            }
        }
        
        healthStore.execute(query)
    }
    
    private func symbolName(for activityType: String) -> String? {
        switch activityType {
        case "Running":
            return "figure.run"
        case "Traditional Strength Training":
            return "dumbbell"
        case "Soccer":
            return "figure.soccer"
        case "Cycling":
            return "bicycle"
        case "Swimming":
            return "figure.pool.swim"
            // Add more cases as needed
        default:
            return nil
        }
    }
}

//
//  HealthManager.swift
//  TrainX
//
//  Created by Brian Yuan on 3/31/24.
//

import Foundation
import HealthKit

extension Date {
    static var startOfDay: Date {
        Calendar.current.startOfDay(for: Date())
    }
}

extension Double {
    func formattedString() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        
        if let formattedString = formatter.string(from: NSNumber(value: self)) {
            return formattedString
        } else {
            return "\(self)"
        }
    }
}

class HealthViewModel: ObservableObject {
    
    let healthStore = HKHealthStore()
    @Published var activities: [String: Activity] = [:]
    
    init() {
        let steps = HKQuantityType(.stepCount)
        let calories = HKQuantityType(.activeEnergyBurned)
        let healthTypes: Set = [steps, calories]
        
        Task {
            do {
                try await healthStore.requestAuthorization(toShare: [], read: healthTypes)
                fetchTodaySteps()
                fetchTodayCalories()
            } catch {
                print("Error fetching health data")
            }
        }
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
            let activity = Activity(id: 0, title: "Today's Steps", subtitle: "Goal 5000", image: "figure.walk", amount: stepCount.formattedString())
            DispatchQueue.main.async {
                self.activities["todaySteps"] = activity
            }
        }
        healthStore.execute(query)
    }
    
    func fetchTodayCalories() {
        let steps = HKQuantityType(.activeEnergyBurned)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate) {_, result, error in
            guard let quantity = result?.sumQuantity(), error == nil else {
                print("Error fetching today's step data")
                return
            }
            let caloriesBurned = quantity.doubleValue(for: .kilocalorie())
            let activity = Activity(id: 1, title: "Today's calories", subtitle: "Goal 500", image: "flame", amount: caloriesBurned.formattedString())
            DispatchQueue.main.async {
                self.activities["todayCalories"] = activity
            }
        }
        healthStore.execute(query)
    }
}

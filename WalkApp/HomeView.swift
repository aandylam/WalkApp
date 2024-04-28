//
//  HomeView.swift
//  WalkApp
//
//  Created by Andy Lam on 4/27/24.
//


import SwiftUI
import HealthKit

struct HomeView: View {
    
    private var healthStore: HealthStore?
    @State private var steps: [Step] = [Step]()
    
    init() {
        healthStore = HealthStore()
    }
    
    private func updateUIFromStatitics(_ statisticsCollection: HKStatisticsCollection) {
        let calendar = Calendar.current
        let startDate = calendar.startOfDay(for: Date())
        let endDate = Date()
        statisticsCollection.enumerateStatistics(from: startDate, to: endDate) { (statistics, _) in
            let count = statistics.sumQuantity()?.doubleValue(for: .count())
            let step = Step(count: Int(count ?? 0), date: statistics.startDate)
            steps.append(step)
        }
    }
    
    var body: some View {
        List(steps, id: \.id) { step in
            VStack {
                Text("\(step.count)")
                Text(step.date, style: .date)
                    .opacity(0.5)
            }
            
            
        }
            .onAppear {
                if let healthStore = healthStore {
                    healthStore.requestAuthorization { success in
                        if success {
                            healthStore.calculateSteps {
                                statisticsCollection in
                                if let statisticsCollection = statisticsCollection {
                                    updateUIFromStatitics(statisticsCollection)
                                }
                            }
                        }
                    }
                }
            }
    }
}

#Preview {
    HomeView()
}

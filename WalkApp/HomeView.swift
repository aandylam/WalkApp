//
//  HomeView.swift
//  WalkApp
//
//  Created by Andy Lam on 4/27/24.
//


import SwiftUI
import HealthKit

struct HomeView: View {
    @State private var steps: [Step] = []
    @State private var progress: Double = 0.0
    
    private var healthStore: HealthStore?
    
    init() {
        healthStore = HealthStore()
    }
    
    private func updateUIFromStatistics(_ statisticsCollection: HKStatisticsCollection) {
        let calendar = Calendar.current
        let startDate = calendar.startOfDay(for: Date())
        let endDate = Date()
        
        // Clear the existing steps array before appending new steps
        steps.removeAll()
        
        statisticsCollection.enumerateStatistics(from: startDate, to: endDate) { (statistics, _) in
            let count = statistics.sumQuantity()?.doubleValue(for: .count())
            let step = Step(count: Int(count ?? 0), date: statistics.startDate)
            steps.append(step)
            
            // Calculate progress
            let totalCount = steps.reduce(0) { $0 + $1.count }
            progress = min(Double(totalCount) / 10000.0, 1.0) // Ensure progress doesn't exceed 100%
        }
    }
    
    var body: some View {
        VStack {
            ProgressBar(value: progress)
            Text("Steps: \(steps.reduce(0) { $0 + $1.count })")
            Text("Progress: \(Int(progress * 100))%")
        }
        .onAppear {
            if let healthStore = healthStore {
                healthStore.requestAuthorization { success in
                    if success {
                        healthStore.calculateSteps { statisticsCollection in
                            if let statisticsCollection = statisticsCollection {
                                updateUIFromStatistics(statisticsCollection)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct ProgressBar: View {
    var value: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.2), style: StrokeStyle(lineWidth: 10.0))
                .frame(width: 120, height: 120)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.value, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 10.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(.blue)
                .rotationEffect(Angle(degrees: -90.0))
                .frame(width: 120, height: 120)
                
        }
    }
}

#Preview {
    HomeView()
}

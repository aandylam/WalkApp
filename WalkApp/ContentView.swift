//
//  ContentView.swift
//  WalkApp
//
//  Created by Andy Lam on 4/27/24.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem() {
                    Image(systemName: "house")
                    Text("Home")
                }
            FriendsView()
                .tabItem() {
                    Image(systemName: "person.2")
                    Text("Friends")
                }
            SettingsView()
                .tabItem() {
                    Image(systemName: "line.3.horizontal")
                    Text("Settings")
                }
        }
    }
    

}

#Preview {
    ContentView()
}

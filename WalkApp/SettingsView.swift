//
//  SettingsView.swift
//  WalkApp
//
//  Created by Andy Lam on 4/27/24.
//

import SwiftUI

struct SettingsView: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var goal: String = "10000"
    
    var body: some View {
        NavigationView{
            Form {
                
                Section(header: Text("Personal Information")) {
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                }
                
                Section(header: Text("Daily Steps Goal")) {
                    TextField("Goal", text: $goal)
                        .keyboardType(.numberPad)
                }
            }
            .navigationTitle("Account")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("Save", action: saveUser)
                }
            }
        }
        .accentColor(.red)
    }
    
    func saveUser() {
        print("User saved")
    }
}

#Preview {
    SettingsView()
}

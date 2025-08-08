//
//  ContentView.swift
//  BirthdayApp
//
//  Created by Scholar on 8/8/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query private var friends: [Friend]
    @Environment(\.modelContext) private var context
    
    //=[Friend(name: "Shamim Dulal", birthday: .now), Friend(name: "Eloise Love", birthday: Date(timeIntervalSince1970: 0))]
    @State private var newName = ""
    @State private var newBirthday = Date.now
    var body: some View {
        NavigationStack {
            List(friends) {friend in
                HStack {
                    Text(friend.name)
                    Spacer()
                    Text(friend.birthday, format: .dateTime.month(.wide).day().year())
                }//end hstack
            }//end List
            .navigationTitle("Birthdays")
            .safeAreaInset(edge: .bottom,){
                VStack(alignment:.center, spacing: 20){
                    Text("New Birthday")
                        .font(.headline)
                    
                    DatePicker(selection: $newBirthday, in: Date.distantPast...Date.now, displayedComponents: .date){
                        TextField("Name", text: $newName)
                        .textFieldStyle(.roundedBorder)
                    }//ends DatePicker
                    
                    Button("Save") {
                        let newFriend = Friend(name: newName, birthday: newBirthday)
                        context.insert(newFriend)
                        newName = ""
                        newBirthday = .now
                    }//end Button
                    .bold()
                }//end VStack
                .padding()
                .background(.bar)
            }//end SafeAreaInsert
        }//end Navigation Stack
        
    }//end body
}//end struct

#Preview {
    ContentView()
        .modelContainer(for: Friend.self, inMemory: true)
}

//
//  ContentView.swift
//  BirthdayApp
//
//  Created by Scholar on 8/8/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query(sort: \Friend.name)private var friends: [Friend]
    @Environment(\.modelContext) private var context
    
    //=[Friend(name: "Elton Lin", birthday: .now), Friend(name: "Jenny Court", birthday: Date(timeIntervalSince1970: 0))]
    @State private var newName = ""
    @State private var newBirthday = Date.now
    @State private var selectedFriend: Friend?
    
    var body: some View {
        NavigationStack {
            List {
                ForEach (friends) {friend in
                    HStack {
                        Text(friend.name)
                        Spacer()
                        Text(friend.birthday, format: .dateTime.month(.wide).day().year())
                    }//end hstack
                    .onTapGesture{
                        selectedFriend = friend
                    }//end onTapGesture
                }//end ForEach loop
                .onDelete(perform: deleteFriend)
            }//end List
            .navigationTitle("Birthdays")
            .sheet(item: $selectedFriend){
                friend in NavigationStack {
                    EditFriendView(friend: friend)
                }
                
            }//ends sheet
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
    
    func deleteFriend(at offset: IndexSet){
        for index in offset {
            let friendToDelete = friends[index]
            context.delete(friendToDelete)
        }//ends for loop
    }//ends deleteFriend function
    
}//end struct

#Preview {
    ContentView()
        .modelContainer(for: Friend.self, inMemory: true)
}

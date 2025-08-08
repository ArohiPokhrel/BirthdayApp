//
//  EditFriendView.swift
//  BirthdayApp
//
//  Created by Scholar on 8/8/25.
//

import SwiftUI

struct EditFriendView: View {
    var friend: Friend
    @State private var newName: String
    @State private var newBirthday : Date
    @Environment(\.dismiss) private var dismiss
    
    init(friend: Friend) {
        self.friend = friend
        _newName = State(initialValue: friend.name)
        _newBirthday = State(initialValue: friend.birthday)
        
    }//end init
    var body: some View {
        Form{
            TextField("Name", text: $newName)
            DatePicker("Birthday", selection: $newBirthday, displayedComponents: .date)
        }//end form"
        .navigationTitle("Edit Friend")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }//end button
            }//ends toolBarItem
            
            ToolbarItem(placement: .confirmationAction) {
                Button("Save"){
                    friend.name = newName
                    friend.birthday = newBirthday
                    dismiss()
                }//end button
            }//ends toolbaritem 
            
        }//end toolbar
    }//end body
}//end struct

#Preview {
    NavigationStack {
        EditFriendView(friend: Friend(name: "Test", birthday: Date.now))
    }//ends navStack
}//ends Preview

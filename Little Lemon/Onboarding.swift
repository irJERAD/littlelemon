//
//  Onboarding.swift
//  Little Lemon
//
//  Created by Jerad Acosta on 3/4/23.
//

import SwiftUI

// declare keys for UserDefaults
let kFirstName = "first name key"
let kLastName = "last name key"
let kEmail = "email key"

struct Onboarding: View {
//    Declare form user input variables
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
//    Logged in state variable
    @State var isLoggedIn = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: Home(), isActive: $isLoggedIn) {
                    EmptyView()
                }
                TextField("First Name", text: $firstName)
                TextField("Last Name" , text: $lastName)
                TextField("Email", text: $email)
                Button {
                    if !firstName.isEmpty &&
                        !lastName.isEmpty &&
                        !email.isEmpty {
                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                        UserDefaults.standard.set(lastName, forKey: kLastName)
                        UserDefaults.standard.set(email, forKey: kEmail)
                        
                        // If not empty navigate to home page
                        isLoggedIn = true
                    }
                } label: {
                    Text("Register")
                }
            }
        }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}

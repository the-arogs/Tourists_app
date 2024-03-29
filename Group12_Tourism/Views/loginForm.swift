//
//  loginForm.swift
//  IOSProject
//
//  Created by Arjune on 2024-02-14.
//
import SwiftUI

struct loginForm: View {
    @State private var userName: String = ""
    @State private var pass: String = ""
    @State private var showAlert = false
    @State private var validationAlert = false
    @State private var isLoggedIn = false
    @State private var rememberMe = false //  state for Remember Me checkbox
    
    let users: [User] = [
        User(email: "user1", password: "123"),
        User(email: "user2", password: "321")
    ]

    var body: some View {
        
        NavigationView {
            ZStack{
                Color.blue
                    .ignoresSafeArea()
                Circle()
                    .scale (1.7)
                    .foregroundColor(.white.opacity(0.15))
                Circle()
                    .scale (1.35)
                    .foregroundColor(.white)
               
            VStack {
                Text("Vacay Ventures")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .padding(.bottom, 50)
                    .frame(minWidth: 0, maxWidth: .infinity)
                
                Text("User Name")
                    .font(.headline).foregroundStyle(.loginText)
                
                TextField("Username", text: $userName)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .foregroundStyle(.loginText)

                Text("Password")
                    .font(.headline).foregroundStyle(.loginText)
                    
                TextField("Password", text: $pass)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .keyboardType(.default)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .foregroundStyle(.loginText)
                                           
                // Remember Me checkbox
                Toggle("Remember Me", isOn: $rememberMe)
                    .padding(.horizontal, 50).foregroundStyle(.loginText)

                Button("Login") {
                    UserDefaults.standard.removeObject(forKey: "savedUsername")
                    UserDefaults.standard.removeObject(forKey: "savedPassword")

                    // Synchronize UserDefaults to ensure changes are saved
                    UserDefaults.standard.synchronize()
                    login()
                    
                }
//                .alert(isPresented: $showAlert) {
//                    if validationAlert {
//                        Alert(title: Text("Welcome"), message: nil, dismissButton: .default(Text("Continue")) )
//                    } else {
//                        Alert(title: Text("Invalid credentials"))
//                    }
//                }
                .foregroundColor(.white)
                                    .frame(width: 300, height: 50)
                                    .background(Color.blue)
                                    .cornerRadius(10)

                NavigationLink(destination: ActivitiesScreen()
                    .navigationBarBackButtonHidden(true), isActive: $isLoggedIn) {
                    EmptyView()
                } .navigationTitle("")
                .navigationBarHidden(true)
            }
            // Automatically login if Remember Me is checked and credentials are stored
            .onAppear {
                    if let savedUsername = UserDefaults.standard.string(forKey: "savedUsername"),
                       let savedPassword = UserDefaults.standard.string(forKey: "savedPassword"),
                       let user = users.first(where: { $0.email == savedUsername && $0.password == savedPassword }) {
                        isLoggedIn = true
                    } else{
                        userName = ""
                        pass = ""
                    }
                }
            }
        }
    }
    
    func login() {
        // Perform validation
        if let user = users.first(where: { $0.email == userName && $0.password == pass }) {
            
            
            
            // Save credentials if Remember Me is checked
            if rememberMe {
                // Remove a value for a specific key
                UserDefaults.standard.removeObject(forKey: "savedUsername")
                UserDefaults.standard.removeObject(forKey: "savedPassword")

                // Synchronize UserDefaults to ensure changes are saved
                UserDefaults.standard.synchronize()
                UserDefaults.standard.set(userName, forKey: "savedUsername")
                UserDefaults.standard.set(pass, forKey: "savedPassword")
                saveFavouritesListToUD(favouritesList: user.favorites)

            }
            // Login successful
//            validationAlert = true
//            showAlert = true
            print("Login successful for user: \(user.email)")
            isLoggedIn = true
            
            
            
            
        } else {
            showAlert = true
            validationAlert = false
            print("Login failed")
        }
    }
}


struct LoginForm_Previews: PreviewProvider {
    static var previews: some View {
        loginForm()
    }
}

#Preview {
    loginForm()
}

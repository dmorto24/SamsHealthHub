import SwiftUI
import Firebase
import FirebaseCore

struct SignUpView: View {
    @State private var email = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var password = ""
    @State private var phoneNumber = ""
    @ObservedObject var uservm = UserViewModel()
    @State private var isAlertShown = false
    @State private var navigateLogin = false
    
    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("First Name", text: $firstName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Last Name", text: $lastName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Phone Number", text: $phoneNumber)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                uservm.signup(email: email, fname: firstName, lname: lastName, password: password, phone: phoneNumber)
                isAlertShown = true
            }) {
                Text("Sign Up")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
        }
        .padding()
        .alert(isPresented: $isAlertShown) {
            Alert(title: Text("Sign Up Successful"),
                  message: Text("Welcome to Sam's Health Hub"),
                  dismissButton: .default(Text("Get Started")) {
                      navigateLogin = true
                  })
        }
        .fullScreenCover(isPresented: $navigateLogin) {
            IndexView()
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

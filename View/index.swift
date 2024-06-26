import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct IndexView: View {
    @StateObject var viewModel = UserViewModel()
    @State private var email = ""
    @State private var password = ""
    @State private var isLoggedIn = false
    @State private var errorMessage: String?
    
    var body: some View {
        NavigationView{
        
        VStack {
            TextField("Email", text: $email)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            SecureField("Password", text: $password)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Login") {
                viewModel.login(email: email, password: password) { success in
                    if success {
                        isLoggedIn = true
                    } else {
                        errorMessage = "Failed to log in"
                    }
                }
            }
            .padding()
            NavigationLink(destination: SignUpView()){
                Text("Sign Up")
            }
        }
        .padding()
        .fullScreenCover(isPresented: $isLoggedIn) {
            HomeView(currentUser: viewModel.currentUser)
        }
        if let errorMessage = errorMessage {
            Text(errorMessage)
                .foregroundColor(.red)
        }

            
    }
}
struct IndexView_Previews: PreviewProvider {
        static var previews: some View {
            IndexView()
        }
    }
}

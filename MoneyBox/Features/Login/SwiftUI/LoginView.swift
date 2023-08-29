//
//  LoginView.swift
//  MoneyBox
//
//  Created by George Woodham on 25/08/23.
//

import SwiftUI

@available(iOS 16.0, *)
struct LoginView: View {
    
    @StateObject var viewModel: LoginViewModel
    
    var body: some View {
        ZStack {
            Color("GreyColor")
                .ignoresSafeArea()
            VStack {
                TextField(
                    "Email",
                    text: $viewModel.email
                )
                SecureField(
                    "Password",
                    text: $viewModel.password
                )
                Button {
                    viewModel.login()
                } label: {
                    Text("Login")
                        .bold()
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                Button {
                    autoFillLogin()
                } label: {
                    Text("Auto fill")
                        .bold()
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                
            }
            
            .textFieldStyle(.roundedBorder)
            .padding([.leading, .trailing])
        }
        .navigationTitle(viewModel.title)
        .navigationBarTitleDisplayMode(.large)
    }
}

@available(iOS 16.0, *)
extension LoginView {
    func autoFillLogin() {
        viewModel.email = "test+ios2@moneyboxapp.com"
        viewModel.password = "P455word12"
    }
    
}

@available(iOS 16.0, *)
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginView(viewModel: .init(dataProvider: PreviewDataProvider()))
        }
    }
}

//
//  ContentView.swift
//  appFirebase
//
//  Created by jimbo on 15/12/24.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var userIsLoggedIn = false
    
    
    var body: some View {
        
        if userIsLoggedIn {
            ListView()
        } else {
            content
        }
      
    }
    
    
    
    var content : some View {
        
        ZStack {
            Color.cyan
            
            
          /*  RoundedRectangle(cornerRadius: 30, style: .continuous)
                .foregroundStyle(.linearGradient(colors: [.pink,.red], startPoint: UnitPoint.topLeading, endPoint: .bottomTrailing))
                .frame(width: 1000, height: 400)
                .rotationEffect(.degrees(135))
                .offset(y: -350)
            
            */
            
            Circle()
                .foregroundStyle(.linearGradient(colors: [.white,.blue], startPoint: UnitPoint.bottomLeading, endPoint: UnitPoint.topTrailing))
                .frame(width: 300, height: 400)
            
            Circle()
                .foregroundStyle(.linearGradient(colors: [.white,.blue], startPoint: UnitPoint.bottomLeading, endPoint: UnitPoint.topTrailing))
                .frame(width: 300, height: 400)
                .offset(x:100,y: -100)
            
            VStack(spacing: 20) {
                Text ("Bienvenido")
                    .foregroundColor(.gray)
                    .font(.system(size: 40,weight: .bold, design: .rounded))
                    .offset(x: -9, y:-100)
                
                
                TextField("Email", text: $email)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .placeholder(when: email.isEmpty){
                        Text("")
                            .foregroundColor(.white)
                            .bold()
                    }
                
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.white)
                
                SecureField("Contraseña", text: $password)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .placeholder(when: password.isEmpty) {
                        Text("")
                            .foregroundColor(.white)
                            .bold()
                    }
                
                    Rectangle()
                    .frame(width: 350,height: 1)
                    .foregroundColor(.white)
                
                Button{
                    register()
                } label: {
                    Text("Inscribirse")
                        .bold()
                        .frame(width: 200, height: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.linearGradient(colors: [.pink, .red], startPoint: UnitPoint.top, endPoint: UnitPoint.bottomTrailing))
                        
                        )
                        .foregroundColor(.white)
                }
                .padding(.top)
                .offset(y: 100)
                
                Button{
                    login()
                } label: {
                    Text("¿Ya tienes una cuenta? Ingresa")
                        .bold()
                        .foregroundColor(.indigo)
                }
                .padding(.top)
                .offset(y: 110)
            }
            .frame(width:350)
            .onAppear {
                Auth.auth().addStateDidChangeListener{ auth, user in
                    if user != nil {
                        userIsLoggedIn.toggle()
                    }
                    
                }
            }
        }
        .ignoresSafeArea()
        
        
        
        
        
    }
    func login(){
        Auth.auth().signIn(withEmail: email, password: password){ result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
            
        }
    }
    func register(){
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
            
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View{
    func placeholder<Content: View>(
        when shouldShow: Bool,
        aligment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
        
            
            ZStack(alignment: aligment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
    }
}

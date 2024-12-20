//
//  NuevaVistaPerro.swift
//  appFirebase
//
//  Created by jimbo on 15/12/24.
//

import SwiftUI

struct NuevaVistaPerro: View {
    
    @EnvironmentObject var dataManger: DataManager
    @State private var newDog = ""
    var body: some View {
        VStack{
        TextField("Perros", text: $newDog)
            
            Button{
             //   dataManger.addDog(dogBreed: newDog)
            } label: {
                Text("Guardar")
            }
            
        }
        
        .padding()
    }
}

struct NuevaVistaPerro_Previews: PreviewProvider {
    static var previews: some View {
        NuevaVistaPerro()
    }
}

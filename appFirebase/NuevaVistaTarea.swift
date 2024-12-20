//
//  NuevaVistaTarea.swift
//  appFirebase
//
//  Created by jimbo on 16/12/24.
//
import SwiftUI

struct NuevaVistaTarea: View {
    
    @EnvironmentObject var dataManager: DataManager
    @Environment(\.dismiss) var dismiss // Para cerrar la vista
    @State private var titulo: String = ""
    @State private var descripcion: String = ""
    @State private var estado: Bool = false
    
    var body: some View {
        VStack {
            TextField("Título de la tarea", text: $titulo)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Descripción", text: $descripcion)  // Campo de descripción
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Toggle(isOn: $estado) {
                Text("Tarea completada")
            }
            .padding()
            
            Button {
                // Crear una nueva tarea
                let nuevaTarea = Tarea(
                    id: UUID().uuidString,
                    titulo: titulo,
                    descripcion: descripcion,
                    fecha_de_creacion: Date(),
                    estado: estado
                )
                
                // Agregar la tarea al dataManager
                dataManager.addTarea(tarea: nuevaTarea)
                
                dismiss() // Cierra la vista
                limpiarCampos() // Limpia los campos
            } label: {
                Text("Guardar Tarea")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
        }
        .padding()
    }
    
    // Función para limpiar los campos después de guardar
    private func limpiarCampos() {
        titulo = ""
        descripcion = ""
        estado = false
    }
}

struct NuevaVistaTarea_Previews: PreviewProvider {
    static var previews: some View {
        NuevaVistaTarea()
            .environmentObject(DataManager())
    }
}

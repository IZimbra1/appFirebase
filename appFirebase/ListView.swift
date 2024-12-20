//
//  ListView.swift
//  appFirebase
//
//  Created by jimbo on 15/12/24.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var dataManager: DataManager
    
    @State private var showPopup = false
    @State private var tareaSeleccionada: Tarea? // Tarea seleccionada para editar
    
    var body: some View {
        NavigationView {
            List(dataManager.tareas, id: \.id) { tarea in
                VStack(alignment: .leading) {
                    HStack {
                        // Mostrar un checkmark si la tarea está completada
                        Image(systemName: tarea.estado ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(tarea.estado ? .green : .gray)
                            .onTapGesture {
                                // Cambiar el estado de la tarea (completa/no completa)
                                var tareaToUpdate = tarea
                                tareaToUpdate.estado.toggle()
                                dataManager.editTarea(tarea: tareaToUpdate)
                            }
                        
                        VStack(alignment: .leading) {
                            Text(tarea.titulo)
                                .font(.headline)
                                .strikethrough(tarea.estado, color: .gray) // Tachamos si está completada
                                .foregroundColor(tarea.estado ? .gray : .black)
                            
                            Text(tarea.descripcion)
                                .font(.subheadline)
                                .foregroundColor(tarea.estado ? .gray : .gray)
                        }
                    }
                    
                    HStack {
                        
                        // Botón de eliminar
                        Button(action: {
                            dataManager.deleteTarea(tarea: tarea)
                        }) {
                            Text("Eliminar")
                                .foregroundColor(.red)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Tareas")
            .navigationBarItems(trailing: Button(action: {
                showPopup.toggle()
            }, label: {
                Image(systemName: "plus")
            }))
            .sheet(isPresented: $showPopup) {
               NuevaVistaTarea()
               
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
            .environmentObject(DataManager())
    }
}

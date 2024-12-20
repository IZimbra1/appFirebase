//
//  DataManger.swift
//  appFirebase
//
//  Created by jimbo on 15/12/24.
//

import SwiftUI
import Firebase


class DataManager: ObservableObject {
    //@Published var perros: [Perro] = []
    @Published var tareas: [Tarea] = []
    init(){
        //fetchPerros()
        fetchTareas()
    }
    
    
    func fetchTareas(){
        tareas.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("Tareas")
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    
                    let id = data["id"] as? String ?? ""
                    let titulo = data["titulo"] as? String ?? ""
                    let descripcion = data["descripcion"] as? String ?? ""
                    let fecha_de_creacion = data["fecha_de_creacion"] as? Date ?? Date()
                    let estado = data["estado"] as? Bool ?? false
                    
                    let tarea = Tarea(id: id, titulo: titulo, descripcion: descripcion, fecha_de_creacion: fecha_de_creacion, estado: estado)
                    self.tareas.append(tarea)
                }
            }
            
        }
    }
    
    /*  func fetchPerros(){
     perros.removeAll()
     let db = Firestore.firestore()
     let ref = db.collection("Perros")
     ref.getDocuments { snapshot, error in
     guard error == nil else {
     print(error!.localizedDescription)
     return
     }
     
     if let snapshot = snapshot {
     for document in snapshot.documents {
     let data = document.data()
     
     
     let id = data["id"] as? String ?? ""
     let breed = data["breed"] as? String ?? ""
     
     
     let perro = Perro(id: id, breed: breed)
     self.perros.append(perro)
     }
     }
     }
     }  */
    
    
    func addTarea(tarea: Tarea) {
        // Guardar la tarea en Firestore
        let db = Firestore.firestore()
        let ref = db.collection("Tareas").document(tarea.id)
        
        ref.setData([
            "id": tarea.id,
            "titulo": tarea.titulo,
            "descripcion": tarea.descripcion,
            "fecha_de_creacion": tarea.fecha_de_creacion,
            "estado": tarea.estado
        ]) { error in
            if let error = error {
                print("Error al guardar tarea: \(error.localizedDescription)")
            } else {
                // Si no hay error, agregar la tarea a la lista local
                DispatchQueue.main.async {
                    self.tareas.append(tarea)
                }
            }
        }
    }
    
    func deleteTarea(tarea: Tarea) {
        let db = Firestore.firestore()
        let ref = db.collection("Tareas").document(tarea.id)
        
        ref.delete { error in
            if let error = error {
                print("Error al eliminar tarea: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    
                    self.tareas.removeAll { $0.id == tarea.id }
                }
            }
        }
    }
    
    func editTarea(tarea: Tarea) {
        let db = Firestore.firestore()
        let ref = db.collection("Tareas").document(tarea.id)
        
        // Actualiza solo los campos que cambiaron
        ref.updateData([
            "titulo": tarea.titulo,
            "descripcion": tarea.descripcion,
            "estado": tarea.estado
        ]) { error in
            if let error = error {
                print("Error al editar tarea: \(error.localizedDescription)")
            } else {
                // Si la edición es exitosa, actualiza la lista de tareas localmente
                DispatchQueue.main.async {
                    if let index = self.tareas.firstIndex(where: { $0.id == tarea.id }) {
                        // Actualiza la tarea en la lista local
                        self.tareas[index] = tarea
                    }
                }
            }
        }
        /* func addDog(dogBreed :String){
         let db = Firestore.firestore()
         let ref = db.collection("Dogs").document(dogBreed)
         ref.setData(["raza": dogBreed, "id":10]) { error in
         if let error = error {
         print(error.localizedDescription)
         }
         }
         } */
        
        
        
    }
}


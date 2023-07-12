//
//  ContentView.swift
//  create-v1
//
//  Created by Gabriele Lopes Rocha on 10/07/23.
//

import SwiftUI

struct Task: Identifiable{
    let id = UUID()
    var title: String
    var isCompleted: Bool = false
}

class TaskListViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    
    func addTask(title: String) {
        let task = Task(title: title)
        tasks.append(task)
    }
    
    func toggleTaskCompletion(task: Task) {
        if let index = tasks.firstIndex(where: {$0.id == task.id }) {
            tasks[index].isCompleted.toggle()
        }
            
    }
    
}
struct ContentView: View {
    @StateObject private var viewModel = TaskListViewModel()
    @State private var newTaskTitle=""
    
    var body: some View {
        NavigationView {
            VStack{
                List(viewModel.tasks) { task in
                    Button(action: {
                        viewModel.toggleTaskCompletion(task: task)
                    }) {
                        HStack {
                            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(task.isCompleted ? .green : .primary)
                            Text(task.title)
                                .strikethrough(task.isCompleted)
                        }
                    }
                    
                }
                HStack{
                    TextField("Nova tarefa", text: $newTaskTitle)
                         .textFieldStyle(RoundedBorderTextFieldStyle())
                     Button(action: {
                         viewModel.addTask(title: newTaskTitle)
                         newTaskTitle = ""
                     }) {
                         Image(systemName: "plus.circle.fill")
                             .font(.title)
                             .foregroundColor(.blue)
                     }
                }
                .padding()
            }
            .navigationBarTitle("To-do-List")
        
        }


    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

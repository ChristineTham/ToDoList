//
//  ToDo.swift
//  ToDoList
//
//  Created by Chris Tham on 18/11/18.
//  Copyright © 2018 Hello Tham. All rights reserved.
//

import Foundation

struct ToDo : Codable {
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?
    
    static let DocumentsDirectory =
        FileManager.default.urls(for: .documentDirectory,
                                 in: .userDomainMask).first!
    static let ArchiveURL =
        DocumentsDirectory.appendingPathComponent("todos")
            .appendingPathExtension("plist")
    
//    init(title: String, isComplete: Bool, dueDate: Date, notes: String?) {
//        self.title = title
//        self.isComplete = isComplete
//        self.dueDate = dueDate
//        self.notes = notes
//    }
    
    static func loadToDos() -> [ToDo]?  {
        guard let codedToDos = try? Data(contentsOf: ArchiveURL)
            else {return nil}
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<ToDo>.self, from: codedToDos)
    }
    
    static func loadSampleToDos() -> [ToDo] {
        let todo1 = ToDo(title: "ToDo One", isComplete: false,
                         dueDate: Date(), notes: "Notes 1")
        let todo2 = ToDo(title: "ToDo Two", isComplete: false,
                         dueDate: Date(), notes: "Notes 2")
        let todo3 = ToDo(title: "ToDo Three", isComplete: false,
                         dueDate: Date(), notes: "Notes 3")
        
        return [todo1, todo2, todo3]
    }
    
    static func saveToDos(_ todos: [ToDo]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedToDos = try? propertyListEncoder.encode(todos)
        try? codedToDos?.write(to: ArchiveURL,
                               options: .noFileProtection)
        
    }
    
    //Inside ToDo type definition
    static let dueDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
        }()
}

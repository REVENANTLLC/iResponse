#!/usr/bin/swift

import Cocoa
import Foundation

extension String {
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
}


print("Creating file zsh_history.txt")
let fileName = "zsh_history"
let documentDirectoryUrl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
let fileUrl = documentDirectoryUrl.appendingPathComponent(fileName).appendingPathExtension("txt")
// prints the file path
print("File path \(fileUrl.path)")
    
print("Collecting ZSH History ...")
let homeDirURL = FileManager.default.homeDirectoryForCurrentUser
let home: String = homeDirURL.absoluteString
let newhome = home.deletingPrefix("file:")
let fileURL = URL(fileURLWithPath: "\(newhome).zsh_history", isDirectory: true)
  
do {
    // Get the saved data
    let savedData = try Data(contentsOf: fileURL)
    // Write data to file
    try savedData.write(to: fileUrl)
    print("Writing ZSH History to zsh_history.txt")
     
} catch {
    // Catch any errors
    print("Unable to read")
}




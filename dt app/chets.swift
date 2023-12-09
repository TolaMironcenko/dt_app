//
//  chets.swift
//  dt
//
//  Created by Анатолий Миронченко on 29.01.2023.
//

import Foundation

// function for get url for all chets
func getAllChets() -> [URL] {
    var all_chets: [URL]

    let dataDirectory: URL = URL(string: getDataDirectory() + "data/")!

    all_chets = try! FileManager.default.contentsOfDirectory(
        at: dataDirectory,
        includingPropertiesForKeys: nil
    )
    
    all_chets = all_chets.filter { $0.absoluteString.split(separator: "/")[$0.absoluteString.split(separator: "/").count-1] != ".DS_Store" }

    return all_chets
}

// function for create a new chet
func createChet(chetName: String) {
    createDirectory(dirName: chetName)
    if (readFromFile(fileName: getDataDirectory() + "data/" + chetName + "/balance") == "" && readFromFile(fileName: getDataDirectory() + "data/" + chetName + "/transactions") == "") {
        writeInFile(fileName: getDataDirectory() + "data/" + chetName + "/balance", str: "0")
        writeInFile(fileName: getDataDirectory() + "data/" + chetName + "/transactions", str: "")
    } else {
        print("Chet already exists")
    }
}

// function for delete a chet
func deleteChet(chetName: String) {
    if (chetName == "main" || chetName == "MAIN") {
        print("You can't delete main chet!")
    } else {
        removeDirectory(dirName: chetName)
    }
}

// function for get info about all chets or one chet
func getInfo() {
    let all_chets: [URL] = getAllChets()

    if (CommandLine.argc < 3) {
        for chet: URL in all_chets {
            var chetarr: [String.SubSequence] = chet.absoluteString.split(separator: "/")
            chetarr.removeFirst()
            let transactions = readFromFile(fileName: "/" + chetarr.joined(separator: "/") + "/transactions").split(separator: "\n")

            print(chetarr[chetarr.count - 1] + " balance: " + readFromFile(fileName: "/" + chetarr.joined(separator: "/") + "/balance"))

            if (transactions.count == 0) {
                print("\nNo transactions.\n")
            } else {
                print("|\tsum\t|\tdate time\t|\tcategory\t|")
                print("|\t---\t|\t---------\t|\t--------\t|")
                for transaction in transactions {
                    print("|\t" + transaction + "\t\t|")
                }
                print("\n")
            }
        }
    } else {
        let transactions = readFromFile(fileName: getDataDirectory() + "data/" + CommandLine.arguments[2] + "/transactions").split(separator: "\n")
        
        let balance: String = readFromFile(fileName: getDataDirectory() + "data/" + CommandLine.arguments[2] + "/balance")

        if (balance != "") {
            print(CommandLine.arguments[2] + " balance: " + balance)
            
            if (transactions.count == 0) {
                print("\nNo transactions.\n")
            } else {
                print("|\tsum\t|\tdate time\t|\tcategory\t|")
                print("|\t---\t|\t---------\t|\t--------\t|")
                for transaction in transactions {
                    print("|\t" + transaction + "\t\t|")
                }
            }
        } else {
            print("Can`t find this chet. Maybe you don`t have this chet.")
        }
    }
}

// function for get sum for all chets or one chet
func getSum() {
    if (CommandLine.argc < 3) {
        let all_chets: [URL] = getAllChets()

        for chet: URL in all_chets {
            var chetarr: [String.SubSequence] = chet.absoluteString.split(separator: "/")
            chetarr.removeFirst()
            print(chetarr[chetarr.count - 1] + " balance: " + readFromFile(fileName: "/" + chetarr.joined(separator: "/") + "/balance"))
        }
    } else {
        print(CommandLine.arguments[2] + " balance: " + readFromFile(fileName: getDataDirectory() + "data/" + CommandLine.arguments[2] + "/balance"))
    }
}

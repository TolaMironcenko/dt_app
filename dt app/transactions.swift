//
//  transactions.swift
//  dt
//
//  Created by Анатолий Миронченко on 29.01.2023.
//

import Foundation

struct Transaction: Identifiable {
    let category: String
    let datetime: String
    let sum: String
    var id: String = UUID().uuidString
}

// function for create a transaction
func createTransaction(transaction: Transaction, chetName: String) {
    if (chetName != "main") {
        appendInFile(fileName: getDataDirectory() + "data/" + "main" + "/transactions", str: String(transaction.sum) + "\t|\t" + String(transaction.datetime) + "\t|\t" + String(transaction.category) + "\n")
        
        var newBalance: Float = (readFromFile(fileName: getDataDirectory() + "data/" + "main" + "/balance") as NSString).floatValue
        newBalance += (transaction.sum as NSString).floatValue
        writeInFile(fileName: getDataDirectory() + "data/" + "main" + "/balance", str: String(format: "%.2f", newBalance))
    }
    appendInFile(fileName: getDataDirectory() + "data/" + chetName + "/transactions", str: String(transaction.sum) + "\t|\t" + String(transaction.datetime) + "\t|\t" + String(transaction.category) + "\n")
    var newBalance: Float = (readFromFile(fileName: getDataDirectory() + "data/" + chetName + "/balance") as NSString).floatValue
    newBalance += (transaction.sum as NSString).floatValue
    writeInFile(fileName: getDataDirectory() + "data/" + chetName + "/balance", str: String(format: "%.2f", newBalance))
}

// function for get transactions all chets or one chet
func getTransactions() -> [Transaction] {
    var transactions: [Transaction] = []
    let transactionsarr: [String.SubSequence] = readFromFile(fileName: "/" + getDataDirectory() + "data/" + "main" + "/transactions").split(separator: "\n")
    for transact in transactionsarr {
        transactions.append(Transaction(category: String(String(transact).components(separatedBy: ["|"])[2]), datetime: String(String(transact).components(separatedBy: ["|"])[1]), sum: String(String(transact).components(separatedBy: ["|"])[0])))
    }
    //    print(transactions)
    return transactions.reversed()
}

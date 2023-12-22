//
//  allChetsData.swift
//  dt app
//
//  Created by Анатолий Миронченко on 25.11.2023.
//

import Foundation

struct Сhet: Identifiable {
    let name: String
    let balance: String
    var id: String { name }
}

func getAllChetsData() -> [Сhet] {
    createDataDirectory()
    let all_chets: [URL] = getAllChets()
    var chetsarr: [Сhet] = []
    
    for chet: URL in all_chets {
        var chetarr: [String.SubSequence] = chet.absoluteString.split(separator: "/")
        chetarr.removeFirst()
        if (String(chetarr[chetarr.count - 1]) != "main") {
            chetsarr.append(Сhet(name: String(chetarr[chetarr.count - 1]), balance: readFromFile(fileName: "/" + chetarr.joined(separator: "/") + "/balance")))
        }
    }
    return chetsarr
}

func getMainChetData() -> Сhet {
    let mainChet: Сhet = Сhet(name: "main", balance: readFromFile(fileName: getDataDirectory() + "data/main/balance"))
    return mainChet
}

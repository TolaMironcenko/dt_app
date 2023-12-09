//
//  TransactionView.swift
//  dt app
//
//  Created by Анатолий Миронченко on 27.11.2023.
//

import Foundation
import SwiftUI

struct TransactionView: View {
    var transaction: Transaction
    
    var body: some View {
        Text("\(transaction.sum) | \(transaction.datetime) | \(transaction.category)")
            .padding()
            .background(RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.gray)
                .shadow(radius: 10, x: 5, y: 5))
    }
}

#Preview {
    TransactionView(transaction: Transaction(category: "hello", datetime: "19.06.2002", sum: "50"))
}

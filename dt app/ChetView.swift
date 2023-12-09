//
//  ChetView.swift
//  dt app
//
//  Created by Анатолий Миронченко on 27.11.2023.
//

import Foundation
import SwiftUI

struct ChetView: View {
    var chet: Сhet
    var body: some View {
        VStack {
            Text("\(chet.name): \(chet.balance)")
                .padding()
            Button("Delete", action: {
                deleteChet(chetName: chet.name)
            })
            .padding()
        }
        .background(RoundedRectangle(cornerRadius: 10)
            .foregroundColor(.gray)
            .shadow(radius: 10, x: 5, y: 5))
    }
}

#Preview {
    ChetView(chet: Сhet(name: "tola", balance: "10"))
}

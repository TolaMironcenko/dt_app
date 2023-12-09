//
//  ContentView.swift
//  dt app
//
//  Created by Анатолий Миронченко on 25.11.2023.
//

import SwiftUI

struct ContentView: View {
    @State public var all_chets: [Сhet] = getAllChetsData()
    @State var all_transactions: [Transaction] = getTransactions()
    @State var isPresent: Bool = false
    @State var isPresentTransaction: Bool = false
    @State var category: String = "No category"
    @State var sum: String = ""
    @State var newChetName: String = ""
    @State var tChetName: String = "main"
    
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack (alignment: .center, spacing: 30) {
                        ForEach(all_chets) { chet in
                            VStack {
                                Text("\(chet.name): \(chet.balance)")
                                    .padding()
                                Button("Delete", action: {
                                    withAnimation(.linear(duration: 0.2)) {
                                        deleteChet(chetName: chet.name)
                                        all_chets = getAllChetsData()
                                    }
                                })
                                .padding()
                            }
                            .background(RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.gray)
                                .shadow(radius: 10, x: 5, y: 5))
                        }
                        Button(action: {
                            print("hello world")
                            isPresent = true
                        }) {
                            Label("Create chet", systemImage: "plus")
                                .padding()
                        }
                        .cornerRadius(10)
                        .alert("New chet", isPresented: $isPresent, actions: {
                            TextField("Chet name", text: $newChetName)
                                .cornerRadius(10)
                                .padding()
                            Button("Add", action: {
                                withAnimation(.linear(duration: 0.2)) {
                                    createChet(chetName: newChetName)
                                    all_chets = getAllChetsData()
                                }
                            })
                            Button("Cancel", action: {
                                isPresent = false
                            })
                        }, message: {
                            Text("Please enter a chet name.")
                        })
                    }
                    .padding()
                }
                
                Button(action: {
                    isPresentTransaction = true
                }) {
                    Label("Create transaction", systemImage: "plus")
                        .padding()
                }
                .cornerRadius(10)
                .alert("New transaction", isPresented: $isPresentTransaction, actions: {
                    TextField("chet", text: $tChetName)
                        .cornerRadius(10)
                        .padding()
                    TextField("sum", text: $sum)
                        .cornerRadius(10)
                        .padding()
                    TextField("category", text: $category)
                        .cornerRadius(10)
                        .padding()
                    Button("Add", action: {
                        withAnimation(.linear(duration: 0.2)) {
                            createTransaction(transaction: Transaction(category: category, datetime: getDateTimeNow(), sum: sum), chetName: tChetName)
                            all_chets = getAllChetsData()
                            all_transactions = getTransactions()
                        }
                    })
                    Button("Cancel", action: {
                        isPresentTransaction = false
                    })
                }, message: {
                    Text("Please enter transaction data.")
                })
                
                ScrollView (.vertical, showsIndicators: false) {
                    if (all_transactions.isEmpty) {
                        Text("No transactions")
                    }
                    VStack (alignment: .center, spacing: 10) {
                        ForEach(all_transactions) { transaction in
                            TransactionView(transaction: transaction)
                        }
                        
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}

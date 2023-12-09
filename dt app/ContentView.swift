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
                            isPresent = true
                        }) {
                            Label("Create chet", systemImage: "plus")
                                .padding()
                        }
                        .cornerRadius(10)
                        .sheet(isPresented: $isPresent, content: {
                            VStack {
                                HStack {
                                    Spacer()
                                    Text("Create new chet")
                                    Spacer()
                                    Button(action: {
                                        isPresent = false
                                    }) {
                                        Image(systemName: "xmark")
                                    }
                                    .buttonBorderShape(.circle)
                                    
                                }
                                VStack(alignment: .leading) {
                                    Text("Chet name")
                                        .font(.headline)
                                    TextField(text: $newChetName) {
                                        Text("Chet name")
                                    }
                                    .textFieldStyle(.roundedBorder)
                                    .disableAutocorrection(true)
                                }
                                Button(action: {
                                    withAnimation(.linear(duration: 0.2)) {
                                        if (newChetName != "") {
                                            createChet(chetName: newChetName)
                                            all_chets = getAllChetsData()
                                            newChetName = ""
                                        }
                                        isPresent = false
                                    }
                                }) {
                                    (Text(Image(systemName: "plus.circle")) + Text(" Add"))
                                        .font(.headline)
                                        .padding(5)
                                        .frame(maxWidth: .infinity)
                                }
                                .buttonStyle(.borderedProminent)
                            }
                            .frame(minWidth: 200)
                            .padding()
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
                .sheet(isPresented: $isPresentTransaction, content: {
                    VStack {
                        HStack {
                            Spacer()
                            Text("Create new transaction")
                            Spacer()
                            Button(action: {
                                isPresentTransaction = false
                            }) {
                                Image(systemName: "xmark")
                            }
                            .buttonBorderShape(.circle)
                            
                        }
                        VStack (alignment: .leading) {
                            Text("Chet name")
                                .font(.headline)
                            TextField("chet", text: $tChetName)
                                .textFieldStyle(.roundedBorder)
                                .disableAutocorrection(true)
                        }
                        VStack (alignment: .leading) {
                            Text("Sum")
                                .font(.headline)
                            TextField("sum", text: $sum)
                                .textFieldStyle(.roundedBorder)
                                .disableAutocorrection(true)
                        }
                        VStack (alignment: .leading) {
                            Text("Category")
                                .font(.headline)
                            TextField("category", text: $category)
                                .textFieldStyle(.roundedBorder)
                                .disableAutocorrection(true)
                        }
                        Button(action: {
                            withAnimation(.linear(duration: 0.2)) {
                                createTransaction(transaction: Transaction(category: category, datetime: getDateTimeNow(), sum: sum), chetName: tChetName)
                                all_chets = getAllChetsData()
                                all_transactions = getTransactions()
                            }
                        }) {
                            (Text(Image(systemName: "plus.circle")) + Text(" Add"))
                                .font(.headline)
                                .padding(5)
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .frame(minWidth: 200)
                    .padding()
                })
                //                .alert("New transaction", isPresented: $isPresentTransaction, actions: {
                //                    TextField("chet", text: $tChetName)
                //                        .cornerRadius(10)
                //                        .padding()
                //                    TextField("sum", text: $sum)
                //                        .cornerRadius(10)
                //                        .padding()
                //                    TextField("category", text: $category)
                //                        .cornerRadius(10)
                //                        .padding()
                //                    Button("Add", action: {
                //                        withAnimation(.linear(duration: 0.2)) {
                //                            createTransaction(transaction: Transaction(category: category, datetime: getDateTimeNow(), sum: sum), chetName: tChetName)
                //                            all_chets = getAllChetsData()
                //                            all_transactions = getTransactions()
                //                        }
                //                    })
                //                    Button("Cancel", action: {
                //                        isPresentTransaction = false
                //                    })
                //                }, message: {
                //                    Text("Please enter transaction data.")
                //                })
                
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

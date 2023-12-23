//
//  ContentView.swift
//  dt app
//
//  Created by Анатолий Миронченко on 25.11.2023.
//

import SwiftUI
import Charts

struct ContentView: View {
    @State public var all_chets: [Сhet] = getAllChetsData()
    @State var all_transactions: [Transaction] = getTransactions()
    @State var isPresent: Bool = false
    @State var isPresentTransaction: Bool = false
    @State var category: String = "No category"
    @State var sum: String = ""
    @State var newChetName: String = ""
    @State var tChetName: String = "main"
    @State var mainChet: Сhet = getMainChetData()
    
    var body: some View {
        HStack (alignment: .center) {
            VStack (alignment: .leading) {
                Text("Balance")
                    .font(.caption)
                (Text("\(mainChet.balance)") + Text(Image(systemName: "rublesign")))
                    .font(.title3)
                    .fontWeight(.heavy)
            }
            Spacer()
            Button(action: {
                isPresentTransaction = true
            }) {
                Image(systemName: "plus")
                    .font(.title)
            }
            .background(.blue)
            .clipShape(Circle())
            
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
        }
        .padding(10)
        .background(.gray)
        VStack {
            VStack(spacing: 0) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack (alignment: .center, spacing: 30) {
                        ForEach(all_chets) { chet in
                            VStack {
                                (Text("\(chet.name): \(chet.balance)") + Text(Image(systemName: "rublesign")))
                                    .padding()
                                Button("Delete", action: {
                                    withAnimation(.linear(duration: 0.2)) {
                                        deleteChet(chetName: chet.name)
                                        all_chets = getAllChetsData()
                                        mainChet = getMainChetData()
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
                                            mainChet = getMainChetData()
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
                //                Chart {
                //                    BarMark(x: .value("animals", "dog"), y: .value("number", 1))
                //                        .cornerRadius(10)
                //                    BarMark(x: .value("animals", "cat"), y: .value("number", 228))
                //                        .cornerRadius(10)
                //                }
                //                .background(.gray)
                //                .cornerRadius(10)
                //                .padding()
                Text("All transactions")
                    .font(.headline)
                ScrollView (.vertical, showsIndicators: false) {
                    if (all_transactions.isEmpty) {
                        Text("No transactions")
                    }
                    VStack (alignment: .center) {
                        ForEach(all_transactions) { transaction in
                            TransactionView(transaction: transaction)
                        }
                        
                    }
                }
                .padding()
            }
            .frame(minWidth: 400, minHeight: 400)
        }
    }
}

#Preview {
    ContentView()
}

//
//  ProductListView.swift
//  MoneyBox
//
//  Created by George Woodham on 25/08/23.
//

import SwiftUI

@available(iOS 16.0, *)
struct ProductListView: View {
    
    @StateObject var viewModel: ProductListViewModel
    
    var body: some View {
        ZStack {
            Color("GreyColor")
                .ignoresSafeArea()
            switch viewModel.state {
            case .error(let message):
                VStack {
                    Text("Uh oh!")
                        .bold()
                    Text(message)
                }
                .foregroundColor(Color("PrimaryText"))
            case .loading:
                ProgressView()
            case .loaded(let products):
                List {
                    ForEach(products, id: \.self) { product in
                        NavigationLink {
                            Text(product.name ?? "")
                        } label: {
                            VStack(alignment: .leading) {
                                Text(product.name ?? "")
                                Text(product.formattedPlanValue ?? "")
                                Text(product.formattedMoneybox ?? "")
                            }
                            .foregroundColor(Color("PrimaryText"))
                            .bold()
                        }
                    }
                }
                .scrollContentBackground(.hidden)
            }
        }
        .navigationTitle("Products")
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            viewModel.fetchProducts()
        }
    }
}

@available(iOS 16.0, *)
struct AccountListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProductListView(viewModel: .init(dataProvider: PreviewDataProvider()))
        }
    }
}

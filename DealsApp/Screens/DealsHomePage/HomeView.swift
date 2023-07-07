//
//  ContentView.swift
//  DealsApp
//
//  Created by renupunjabi on 7/3/23.
//

import SwiftUI

struct HomeView: View {
    
    @State var searchText: String = "";
    @StateObject var viewModel: HomeViewModel = HomeViewModel();
    var body: some View {
        
        NavigationStack() {
            ScrollView {
                
                ForEach(searchResults) { deal in
                    
                    NavigationLink(destination: {
                        ItemDetailsView(dealData: deal)
                    }, label: {
                        DealCard(deal: deal)
                    })
                }
            }
            .navigationTitle("Local Deals")
            .toolbarBackground(Color("DarkAccent"), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            /// https://sarunw.com/posts/swiftui-navigation-bar-color/
        }
        .searchable(text: $searchText)
    }
    
    var searchResults: [DealData] {
        if searchText.isEmpty {
            return viewModel.deals
        } else {
            return viewModel.deals.filter { deal in
                return deal.rawData.description.lowercased().contains(searchText.lowercased()) ||
                deal.rawData.title.lowercased().contains(searchText.lowercased()) ||
                deal.rawData.product.description.lowercased().contains(searchText.lowercased())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

//
//  ContentView.swift
//  DealsApp
//
//  Created by renupunjabi on 7/3/23.
//

import SwiftUI

struct HomeView: View {
    
    @State var searchText: String = "";
    @State var path: NavigationPath = NavigationPath()
    @StateObject var viewModel: HomeViewModel = HomeViewModel();
    var body: some View {
        
        NavigationStack(path: $path) {
            ScrollView {
                
                ForEach(searchResults) { deal in
                    
                    NavigationLink(value: searchResults[0].self) {
                        DealCard(deal: deal)
                    }
                }
            }
            .navigationTitle("Local Deals")
            .toolbarBackground(Color("DarkAccent"), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            /// https://sarunw.com/posts/swiftui-navigation-bar-color/
            .navigationDestination(for: DealData.self) { deal in
                ItemDetailsView(dealData: deal, path: $path)
            }
        }
        .searchable(text: $searchText)
    }
    
    // TODO: Refactor this into a mockDB search rather than filtering here.
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

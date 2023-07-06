//
//  ContentView.swift
//  DealsApp
//
//  Created by renupunjabi on 7/3/23.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel: HomeViewModel = HomeViewModel();
    var body: some View {
        
        NavigationStack() {
            ScrollView {
                
                ForEach(viewModel.deals) { deal in
                    
                    NavigationLink(destination: {
                        
                    }, label: {
                        DealCard(deal: deal)
                            .foregroundColor(.black)
                    })
                }
            }
            .navigationTitle("Home")
        }
    }
}

struct DealCard: View {
    
    let deal: DealData;
    var body: some View {
        
        VStack(alignment: .leading) {
            
            /// https://swiftwithmajid.com/2021/07/07/mastering-asyncimage-in-swiftui/
            AsyncImage(url: deal.product.imageUrl) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(minHeight: 200, maxHeight: 300)
            } placeholder: {
                ProgressView()
                    .frame(maxWidth: .infinity, minHeight: 100)
                    .padding()
            }
            .cornerRadius(15)
            .padding()
            
            Text("\(deal.rawData.title)")
                .font(.body.weight(.bold))
                .padding(.horizontal)
                .multilineTextAlignment(.leading)
            
            HStack {
                Text(deal.priceString)
                    .font(.footnote)
                    .padding(.horizontal)
                Spacer()
            }
            
            Divider()
                .padding(.horizontal)
            
            Text(deal.rawData.description)
                .font(.caption)
                .padding(.horizontal)
                .padding(.vertical)
                .multilineTextAlignment(.leading)
            
            HStack {
                Image(systemName: "hand.thumbsup.fill")
                Text("\(deal.rawData.likes.count)")
                
                Divider()
                
                Image(systemName: "hand.thumbsdown.fill")
                Text("\(deal.rawData.dislikes.count)")
                
                Spacer()
                 
                Text(deal.lastUpdate)
                    .font(.caption)
                    .fontWeight(.light)
            }
            .frame(maxHeight: 1)
            .padding(.horizontal)
            .padding(.bottom)
        }
        .background(.white)
        .cornerRadius(15)
        .padding()
        .shadow(radius: 4, x: 3, y: 3)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

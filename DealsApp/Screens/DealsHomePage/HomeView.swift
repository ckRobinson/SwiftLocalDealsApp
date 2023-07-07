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
                    .cornerRadius(15)
                    .frame(maxWidth: .infinity, minHeight: 200, maxHeight: 300)
            } placeholder: {
                ProgressView()
                    .frame(maxWidth: .infinity, minHeight: 100)
                    .padding()
            }
            .cornerRadius(15)
            .padding()
            
            VStack {
                Text("\(deal.rawData.title)")
                    .font(.body.bold())
                    .padding(.horizontal)
                    .padding(.top)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                
                HStack {
                    Text(deal.priceString)
                        .font(.body)
                        .fontWeight(.heavy)
                        .foregroundColor(Color("LightAccent"))
                        .padding(.horizontal)
                    Spacer()
                }
                
                
                Divider()
                    .padding(.horizontal)
                    .background(.white)
                
                Text(deal.rawData.description)
                    .font(.footnote)
                    .lineSpacing(4)
                    .padding(.vertical)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
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
            .background(Color("DarkAccent"))
            .foregroundColor(.white)
            .padding(.top)
        }
        .background(.white)
        .foregroundColor(Color("DarkAccent"))
        .cornerRadius(15)
        .shadow(radius: 4, x: 3, y: 3)
        .overlay(content: {
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color("DarkAccent"), lineWidth: 5)
        })
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

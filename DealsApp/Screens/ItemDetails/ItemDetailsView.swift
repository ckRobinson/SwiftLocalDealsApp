//
//  ItemDetailsView.swift
//  DealsApp
//
//  Created by Cameron Robinson on 7/4/23.
//

import SwiftUI

struct ItemDetailsView: View {
    
    let dealData: DealData
    var body: some View {
        ZStack {
            CoreContent
            BuyButtonBar
        }
        .navigationBarTitle("", displayMode: .inline)
        .toolbarBackground(Color("DarkAccent"), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        /// https://swiftuirecipes.com/blog/swiftui-toolbar-placement-cheatsheet
    }
        
    var CoreContent: some View {
        ScrollView {

            ProductImage
                .padding(.vertical)
            
            Text(dealData.rawData.title)
                .font(.headline.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            Text(dealData.priceString)
                .font(.body)
                .fontWeight(.heavy)
                .foregroundColor(Color("LightAccent"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                        
            UserRatings
                .padding(.horizontal)
                .shadow(radius: 4, x: 3, y: 3)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ProductDescription
                .padding()
            
            ItemCommentsView(comments: dealData.rawData.comments)
                .padding(.horizontal)
            
            RelatedItemsView(parentDeal: dealData)
                .padding(.horizontal)
            
            Spacer(minLength: 50)
        }
    }
    
    var UserRatings: some View {
        
        VStack {
            Text("Deal Rating:")
                .font(.footnote)
            HStack {
                
                Image(systemName: "hand.thumbsup.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 13)
                Text("\(dealData.rawData.likes.count)")
                    .font(.footnote)
                
                Divider()
                    .background(.white)
                
                Image(systemName: "hand.thumbsdown.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 13)
                Text("\(dealData.rawData.dislikes.count)")
                    .font(.footnote)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 2)
        .background(Color("DarkAccent"))
        .foregroundColor(.white)
        .cornerRadius(15)
    }
    
    var ProductImage: some View {

        AsyncImage(url: dealData.product.imageUrl) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        } placeholder: {
            ProgressView()
                .frame(maxWidth: .infinity, minHeight: 100)
        }
        .frame(width: 250)
        .padding(.vertical)
        .cornerRadius(15)
        .padding()
        .overlay() {
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color("DarkAccent"), lineWidth: 7)
        }
    }
        
    var ProductDescription: some View {
        
        VStack {
            Text("Product Desription:")
                .font(.callout)
                .fontWeight(.medium)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
            
            Text(dealData.rawData.product.description)
                .font(.footnote)
                .lineSpacing(4)
        }
        .padding()
        .background(Color("DarkAccent"))
        .foregroundColor(.white)
        .cornerRadius(15)
        .shadow(radius: 4, x: 3, y: 3)
    }
    
    var BuyButtonBar: some View {
        
        VStack {
            
            Spacer()
            
            ZStack {
                Rectangle()
                    .border(.gray.opacity(0.5))
                    .frame(maxWidth: .infinity, maxHeight: 75)
                    .foregroundColor(.white)
                
                VStack {
                    Button(action: {
                        if let url = dealData.itemURL {
                            print("Opening URL.")
                            UIApplication.shared.open(url)
                        }
                    }) {
                        BuyButtonView
                    }
                }
            }
        }
        .ignoresSafeArea(.all)
    }
    
    var BuyButtonView: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color("LightAccent"))
                .frame(maxWidth: .infinity, maxHeight: 30)
                .cornerRadius(15)
                .padding(.horizontal)
                
            Text("Buy Now")
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
        }
        .padding(.bottom)
        .shadow(radius: 4, x: 3, y: 3)
    }
}

struct ItemDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetail_PreviewWrapper()
    }
}

private struct ItemDetail_PreviewWrapper: View {
    
    let dealData: DealData
    init() {
        let viewModel: HomeViewModel = HomeViewModel();
        self.dealData = viewModel.deals[1];
    }
    
    var body: some View {
        ItemDetailsView(dealData: dealData);
    }
}

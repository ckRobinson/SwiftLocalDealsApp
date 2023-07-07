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
            buyButtonBar
        }
    }
    
    var buyButtonBar: some View {
        
        VStack {
            
            Spacer()
            
            ZStack {
                Rectangle()
                    .border(.gray.opacity(0.5))
                    .frame(maxWidth: .infinity, maxHeight: 75)
                    .foregroundColor(.white)
                
                VStack {
                    Button(action: {}) {
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
                    }
                    .padding(.bottom)
                    .shadow(radius: 4, x: 3, y: 3)
                }
            }
        }
        .ignoresSafeArea(.all)
    }
    
    var CoreContent: some View {
        ScrollView {

            ProductImage
                .padding(.bottom)
            
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
                        
            ProductDescription
                .padding()
            
//            ProductActivity
//                .padding(.horizontal)
//                .shadow(radius: 4, x: 3, y: 3)
            
            ItemCommentsView(comments: dealData.rawData.comments)
                .padding(.horizontal)
            
            Spacer(minLength: 50)
        }
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

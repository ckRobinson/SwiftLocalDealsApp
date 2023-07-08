//
//  RelatedItemsView.swift
//  DealsApp
//
//  Created by Cameron on 7/7/23.
//

import SwiftUI

struct RelatedItemsView: View {
    
    @ObservedObject var viewModel: RelatedItemsViewModel = RelatedItemsViewModel()
    @Binding var path: NavigationPath;
    
    init(parentDeal: DealData, path: Binding<NavigationPath>) {
        self._path = path;
        self.viewModel.getRelatedItemsFromParent(parentDeal);
    }
    
    var body: some View {
        if self.viewModel.relatedItems.count > 0 {
            VStack {
                Text("Users who liked this item also liked:")
                    .font(.body.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top)
                    .foregroundColor(Color("DarkAccent"))
                
                ScrollView(.horizontal) {
                    
                    HStack {
                        ForEach(viewModel.relatedItems) { deal in
                            
                            NavigationLink(destination: {
                                ItemDetailsView(dealData: deal, path: $path)
                            }, label: {
                                RelatedItemCard(deal: deal)
                            })
                        }
                    }
                }
            }
            .overlay() {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(.gray.opacity(0.5))
            }
        }
        else {
            EmptyView()
        }
    }
}

private struct RelatedItemCard: View {
    
    let deal: DealData
    var body: some View {
        VStack {
            
            RelatedDealImage
            
            RelatedDealText
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
    
    var RelatedDealImage: some View {
        AsyncImage(url: deal.product.imageUrl) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(15)
                .frame(maxWidth: .infinity, minHeight: 100, maxHeight: 100)
        } placeholder: {
            ProgressView()
                .frame(maxWidth: .infinity, minHeight: 100)
                .padding()
        }
        .cornerRadius(15)
        .padding(.vertical)
    }
    
    var RelatedDealText: some View {
        VStack {
            Text(deal.rawData.title)
                .font(.caption.bold())
                .lineLimit(4, reservesSpace: true)
                .multilineTextAlignment(.leading)
                .frame(width: 150, alignment: .leading)
                .padding(.bottom, 1)
            
            Text(deal.priceString)
                .font(.body)
                .fontWeight(.heavy)
                .foregroundColor(Color("LightAccent"))
                .frame(width: 150, alignment: .leading)
        }
        .padding()
        .background(Color("DarkAccent"))
        .foregroundColor(.white)
    }
}

struct RelatedItemsView_Previews: PreviewProvider {
    static var previews: some View {
        RelatedItemsView_PreviewWrapper()
    }
}

private struct RelatedItemsView_PreviewWrapper: View {
    
    let dealData: DealData
    @State var path: NavigationPath = NavigationPath();

    init() {
        let viewModel: HomeViewModel = HomeViewModel();
        self.dealData = viewModel.deals[0]
    }
    
    var body: some View {
        RelatedItemsView(parentDeal: dealData, path: $path);
    }
}

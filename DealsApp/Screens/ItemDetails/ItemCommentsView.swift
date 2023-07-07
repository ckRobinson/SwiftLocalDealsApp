//
//  ItemCommentsView.swift
//  DealsApp
//
//  Created by Cameron on 7/6/23.
//

import SwiftUI

struct ItemCommentsView: View {
    
    let comments: [Comment]
    var body: some View {
        
        ZStack {
            
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(15)
                .shadow(radius: 4, x: 3, y: 3)
            
            VStack {
                
                Text("User Reviews")
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ForEach(Array(self.comments.enumerated()), id: \.element.id) { index, comment in
                    
                    CommentView(commentData: comment)
                        .padding(.bottom)
                    
                    if(index < comments.count - 1) {
                        Divider()
                            .padding(.bottom)
                    }
                }
            }
            .padding()
            .cornerRadius(15)
        }
        .overlay() {
            RoundedRectangle(cornerRadius: 15)
                .stroke(.gray.opacity(0.5))
        }
    }
}

private struct CommentView: View {
    
    let commentData: Comment
    var body: some View {
        VStack {
            
            HStack {
                Image(systemName: "person.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20)
                    .padding(.all, 5)
                    .background(Color("DarkAccent"))
                    .foregroundColor(.white)
                    .clipShape(Circle())
                
                Text(commentData.user.name)
                    .font(.footnote.bold())
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(commentData.text)
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
        }
    }
}

struct ItemCommentsView_Previews: PreviewProvider {
    static var previews: some View {
        ItemCommentsView_PreviewWrapper()
    }
}

private struct ItemCommentsView_PreviewWrapper: View {
    
    let dealData: DealData
    init() {
        let viewModel: HomeViewModel = HomeViewModel();
        self.dealData = viewModel.deals[0];
    }
    
    var body: some View {
        ItemCommentsView(comments: dealData.rawData.comments);
    }
}

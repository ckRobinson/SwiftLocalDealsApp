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
        
        ScrollView {
            ForEach(self.comments, id: \.self.id) { comment in
                
                CommentView(commentData: comment)
                    .padding(.bottom)
                
                Divider()
                    .padding(.horizontal)
                    .padding(.bottom)
            }
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
                    .background(.gray)
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
        .padding(.horizontal)
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

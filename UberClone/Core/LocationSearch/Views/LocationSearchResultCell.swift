//
//  LocationSearchResultCell.swift
//  UberClone
//
//  Created by Arman  Urstem on 07.06.2024.
//

import SwiftUI

struct LocationSearchResultCell: View {
    var body: some View {
        HStack {
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .accentColor(.white)
                .foregroundColor(.blue)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Starbucks Coffee")
                    .font(.body)
                
                Text("123 Main St, Cuppetino CA")
                    .font(.system(size: 15))
                    .foregroundStyle(.gray)
                
                Divider()
            }
            .padding(.leading, 8)
            .padding(.horizontal, 8)
        }
        .padding(.leading)
    }
}

#Preview {
    LocationSearchResultCell()
}

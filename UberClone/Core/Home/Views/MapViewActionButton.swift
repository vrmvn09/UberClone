//
//  MapViewActionButton.swift
//  UberClone
//
//  Created by Arman  Urstem on 07.06.2024.
//

import SwiftUI

struct MapViewActionButton: View {
    var body: some View {
        Button {
            <#code#>
        } label: {
            Image(systemName: "line.3.horizontal")
                .font(.title2)
                .foregroundColor(.black)
                .padding()
                .background(.white)
                .clipShape(Circle())
                .shadow(color: .black, radius: 6)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    MapViewActionButton()
}

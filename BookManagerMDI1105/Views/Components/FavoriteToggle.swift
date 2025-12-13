//
//  FavoriteToggle.swift
//  BookManagerMDI1105
//
//  Created by Alex Arthur on 12/11/25.
//

import SwiftUI

struct FavoriteToggle: View {
    //this binding toggle updates book object in main list
    @Binding var isFavorite: Bool
    
    //animation states
    @State private var scale: CGFloat = 1
    @State private var opacity: CGFloat = 0
    @State private var offsetY: CGFloat = 0
    
    var body: some View {
        ZStack {
            //floating heart animation
            Image(systemName: "heart.fill")
                .foregroundColor(.red)
                .font(.largeTitle)
                .opacity(opacity)
                .scaleEffect(scale)
                .offset(y: offsetY)
            
            //clickable button
            Toggle(isOn: $isFavorite){
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .foregroundColor(isFavorite ? .red : .secondary)
                    .font(.title2)
            }
            .toggleStyle(.button)
            .buttonStyle(.plain)
            .animation(.bouncy, value: isFavorite)
            .accessibilityLabel(isFavorite ? "Remove from Favorites" : "Add to Favorites")
            .onChange(of: isFavorite) { oldValue, newValue in
                //run animation if adding to favorites
                guard newValue == true else { return }
                
                //instant reset states
                scale = 1
                opacity = 1
                offsetY = 0
                
                //float up and fade out animation
                withAnimation(.easeOut(duration: 1.0)) {
                    offsetY = -80
                    opacity = 0
                    scale = 1.5
                }
            }
        }
    }
}

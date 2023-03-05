//
//  Home.swift
//  Little Lemon
//
//  Created by Jerad Acosta on 3/4/23.
//

import SwiftUI

struct Home: View {
    var body: some View {
        TabView {
            Menu()
                .tabItem({
                    Label("Menu", systemImage: "list.dash")
                })
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

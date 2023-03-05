//
//  Menu.swift
//  Little Lemon
//
//  Created by Jerad Acosta on 3/4/23.
//

import SwiftUI

struct Menu: View {
    var body: some View {
        VStack {
            Text("Little Lemon")
            Text("San Diego")
            Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
            List {
            }
        }
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}

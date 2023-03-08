//
//  Header.swift
//  Little Lemon
//
//  Created by Jerad Acosta on 3/8/23.
//

import SwiftUI

struct Header: View {
    var body: some View {
        HStack (alignment: .center) {
            Spacer()
            Spacer()
            Image("Logo")
                .frame(alignment: .center)
            Spacer()
            Image("profile-image-placeholder")
                .resizable()
                .frame(width: 50, height: 50, alignment: .trailing)
        }
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header()
    }
}

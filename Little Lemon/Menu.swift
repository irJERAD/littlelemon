//
//  Menu.swift
//  Little Lemon
//
//  Created by Jerad Acosta on 3/4/23.
//

import SwiftUI

struct Menu: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        VStack {
            Text("Little Lemon")
            Text("San Diego")
            Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
//            List {
//            }
            FetchedObjects() { (dishes: [Dish]) in
                List {
                    ForEach(dishes) { dish in
                        Text((dish.title ?? "") + "$" + (dish.price ?? ""))
                    }
                }
            }
            .onAppear{
                getMenuData()
            }
        }
    }
    
    func getMenuData() {
//        first clear database each time before saving the menu list again
        PersistenceController.shared.clear()
        
        let menuAddress = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let menuURL = URL(string: menuAddress)!
        let request = URLRequest(url: menuURL)
        let task = URLSession.shared.dataTask(with: request)
        { data, response, error in
            if let data = data,
               let responseString = String(data: data, encoding: .utf8) {
                let decoder = JSONDecoder()
                
                let menu = try? decoder.decode(MenuList.self, from: data)
                
                menu?.menu.forEach({
                    let newDish = Dish(context: viewContext)
                    newDish.title = $0.title
                    newDish.image = $0.image
                    newDish.price = $0.price
                })
//                Save data in database after loop ends
                try? viewContext.save()
            }
        }
        
        task.resume()
        
//        menu.forEach {
//            let newDish = Dish(context: viewContext)
//            newDish.title = $0.title
//            newDish.image = $0.image
//            newDish.price = $0.price
//        }
//        save data into the database
    }
    
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}

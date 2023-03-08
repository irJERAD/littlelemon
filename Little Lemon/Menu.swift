//
//  Menu.swift
//  Little Lemon
//
//  Created by Jerad Acosta on 3/4/23.
//

import SwiftUI

struct Menu: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
//    Build sort descriptor for FetchObjects to sort by title
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title",
                                 ascending: true,
                                 selector: #selector(NSString.localizedStandardCompare))]
    }
    
//    Create search variable for filtering FetchObjects
    @State var searchText = ""
    
//    Create predicate to filder FetchObjects with searchText variable
    func buildPredicate() -> NSPredicate {
//        empy searchText filters all dishes so return value: true if empty
        if searchText.isEmpty {
            return NSPredicate(value: true)
        } else {
            return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
    }
    
    
    var body: some View {
        VStack {
            Text("Little Lemon")
            Text("San Diego")
            Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
//            List {
//            }
            TextField("Search menu", text: $searchText)
            FetchedObjects(predicate: buildPredicate(),
                           sortDescriptors: buildSortDescriptors(),
                           content: { (dishes: [Dish]) in
                List {
                    ForEach(dishes) { dish in
//                        TODO: pass dish.info to ItemInfo() view for text display
//                        NavigationLink(destination: ItemInfo()) {
                            VStack(alignment: .leading) {
                                //                        TODO: Add Navigation to go to new desciption / info page
                                Text((dish.title ?? ""))
                                Text("$" + (dish.price ?? ""))
                                let imageURL = dish.image ?? ""
                                AsyncImage(url: URL(string: imageURL)!){ image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                } placeholder: {
                                    Image(systemName: "photo.fill")
                                }.frame(width: 250, height: 250)
                                
                            }
//                        }
                        }
                }
            })
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
                    newDish.info = $0.description
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

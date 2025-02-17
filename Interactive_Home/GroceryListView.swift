import SwiftUI

// MARK: - Models
struct GroceryItem: Identifiable, Codable {
    var id: UUID
    let name: String
    var isChecked: Bool = false
    var category: Category = .none
    
    init(id: UUID = UUID(), name: String, category: Category = .none, isChecked: Bool = false) {
        self.id = id
        self.name = name
        self.category = category
        self.isChecked = isChecked
    }
    
    enum Category: String, Codable, CaseIterable {
        case produce = "Produce"
        case dairy = "Dairy"
        case pantry = "Pantry"
        case meat = "Meat"
        case none = "Other"
    }
}

// MARK: Main View
struct GroceryListView: View {
    @State private var groceryItems: [GroceryItem] = []
    @State private var newItem: String = ""
    @State private var selectedCategory: GroceryItem.Category = .none
    @State private var showAlert = false
    @State private var showingAllItems = false
    @AppStorage("groceryItems") private var savedItemsData: Data = Data()
    
    private let itemLimit = 100
    
    var body: some View {
        VStack(spacing: 16) {
            headerSection
            if !showingAllItems {
                categoryPicker
            }
            listSection
            addItemSection
        }
        .background(Color.white) // Add white background to ensure contrast
        .alert("Maximum Items Reached", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Please remove some items before adding more.")
        }
        .onAppear(perform: loadItems)
    }
    
    // MARK: View Components
    private var headerSection: some View {
        VStack {
            Text("⭒ Grocery List ⭒ ")
                .font(.custom("Palatino", size: 40))
                .padding(.top)
            
            Button(action: { showingAllItems.toggle() }) {
                Text(showingAllItems ? "Filter by Category" : "See All Items")
                    .font(.custom("Palatino", size: 12))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.green.opacity(0.2))
                    .foregroundColor(.black)
                    .cornerRadius(8)
                    .shadow(radius: 3)
            }
        }
    }
    
    private var categoryPicker: some View {
        Picker("Category", selection: $selectedCategory) {
            ForEach(GroceryItem.Category.allCases, id: \.self) { category in
                Text(category.rawValue).tag(category)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(.horizontal)
        .background(Color.blue.opacity(0.3))
    }
    
    private var listSection: some View {
        List {
            ForEach(sortedItems) { item in
                GroceryItemRow(item: item, toggleAction: { toggleItem(item) })
            }
            .onDelete(perform: deleteItems)
            .listRowBackground(Color.green.opacity(0.15))
        }
        .background(Color.green.opacity(0.15))
        .scrollContentBackground(.hidden)
    }
    
    private var addItemSection: some View {
        HStack {
            TextField("Add item", text: $newItem)
                .font(.custom("Chalkduster", size: 20))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .submitLabel(.done)
                .onSubmit(addItem)
            
            Button(action: addItem) {
                Text("Add")
                    .font(.headline)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.blue.opacity(0.3))
                    .foregroundColor(.black)
                    .cornerRadius(8)
                    .shadow(radius: 5)
            }
        }
        .padding()
        .background(Color.white) // Keep add item section with white background
    }
    
    // MARK: Helper Views
    struct GroceryItemRow: View {
        let item: GroceryItem
        let toggleAction: () -> Void
        
        var body: some View {
            HStack {
                Button(action: toggleAction) {
                    Image(systemName: item.isChecked ? "checkmark.square" : "square")
                        .foregroundColor(item.isChecked ? .green : .black)
                }
                
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.custom("Palatino", size: 20))
                        .strikethrough(item.isChecked, color: .red)
                        .foregroundColor(item.isChecked ? .gray : .black)
                    
                    Text(item.category.rawValue)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
        }
    }
    
    // MARK: Computed Properties
    private var sortedItems: [GroceryItem] {
        let items = showingAllItems ? groceryItems : groceryItems.filter { groceryItem in
            groceryItem.category == selectedCategory
        }
        
        return items.sorted { (item1, item2) in
            if item1.isChecked != item2.isChecked {
                return !item1.isChecked // Unchecked items come first
            }
            // If checked status is the same, sort by category
            return item1.category.rawValue < item2.category.rawValue
        }
    }
    
    // MARK: Methods
    private func toggleItem(_ item: GroceryItem) {
        if let index = groceryItems.firstIndex(where: { $0.id == item.id }) {
            groceryItems[index].isChecked.toggle()
            saveItems()
        }
    }
    
    private func addItem() {
        guard !newItem.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        guard groceryItems.count < itemLimit else {
            showAlert = true
            return
        }
        
        let item = GroceryItem(
            name: newItem.trimmingCharacters(in: .whitespaces),
            category: selectedCategory
        )
        groceryItems.append(item)
        newItem = ""
        saveItems()
    }
    
    private func deleteItems(at offsets: IndexSet) {
        groceryItems.remove(atOffsets: offsets)
        saveItems()
    }
    
    // MARK: Persistence
    private func saveItems() {
        if let encoded = try? JSONEncoder().encode(groceryItems) {
            savedItemsData = encoded
        }
    }
    
    private func loadItems() {
        if let decoded = try? JSONDecoder().decode([GroceryItem].self, from: savedItemsData) {
            groceryItems = decoded
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationView {
        GroceryListView()
    }
}

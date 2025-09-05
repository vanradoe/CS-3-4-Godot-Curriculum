# Lesson 13: Complete Inventory System - Integrating Arrays

## Learning Objectives
By the end of this lesson, you will:
- Integrate array fundamentals, display, and manipulation into one complete system
- Create a professional inventory interface that players can actually use
- Connect inventory to existing game systems (Player, Pickup objects)
- Handle real-time inventory updates from gameplay events
- Build a foundation for save/load functionality (next lesson)
- Experience how individual concepts combine into complete game features

## Getting Started

### Bringing It All Together
**You've learned the pieces**:
- **Lesson 8**: Array basics (creating, accessing, looping)
- **Lesson 9**: Arrays for game data (NPC dialogue)
- **Lesson 10**: Arrays of objects (Enemy, Pickup management)
- **Lesson 11**: Displaying arrays (UI presentation)
- **Lesson 12**: Array manipulation (adding, removing, searching, sorting)

**Today we combine them** into a complete, working inventory system that:
- ✅ **Stores items** using arrays of Pickup objects
- ✅ **Displays items** in professional UI
- ✅ **Updates in real-time** when players collect/use items
- ✅ **Integrates with gameplay** (picking up items, using potions, etc.)
- ✅ **Provides player control** (sorting, organizing, item details)

### What Makes This Different
**Previous lessons**: Practiced concepts in isolation
**Today**: Everything works together as a real game feature

**Before** (separate pieces):
```gdscript
# Lesson 8: Basic arrays
var items = ["Sword", "Potion"]

# Lesson 11: Display
show_array_contents(items)

# Lesson 12: Manipulation
items.append("New Item")
```

**Now** (integrated system):
```gdscript
# Complete inventory that:
# - Holds actual Pickup objects
# - Updates UI automatically
# - Responds to game events
# - Lets players interact with items
```

## Part 1: Inventory System Architecture

### Step 1: Create the Complete Inventory Script
**Create** a new script: `scripts/complete_inventory.gd`

```gdscript
extends Control
class_name CompleteInventory

# Core inventory data - array of actual Pickup objects
var inventory_items: Array[Pickup] = []

# UI elements for display
@onready var inventory_grid: GridContainer = $InventoryPanel/ScrollContainer/InventoryGrid
@onready var item_details_panel: Panel = $ItemDetailsPanel
@onready var item_name_label: Label = $ItemDetailsPanel/VBox/ItemNameLabel
@onready var item_description_label: Label = $ItemDetailsPanel/VBox/ItemDescriptionLabel
@onready var use_item_button: Button = $ItemDetailsPanel/VBox/UseItemButton
@onready var sort_options: OptionButton = $InventoryPanel/ControlBar/SortOptions

# Inventory configuration
@export var max_inventory_slots: int = 20
@export var items_per_row: int = 5

# Current state
var selected_item: Pickup = null
var selected_slot_index: int = -1
var current_sort_mode: String = "default"

# References to game systems
var player_reference: Player = null

func _ready():
    print("=== COMPLETE INVENTORY SYSTEM ===")
    
    setup_ui_components()
    setup_sorting_options()
    connect_signals()
    initialize_inventory_grid()
    
    # Find player reference for integration
    find_player_reference()
    
    print("Inventory system ready!")
    print("Max slots: " + str(max_inventory_slots))

func setup_ui_components():
    # Configure inventory grid
    if inventory_grid:
        inventory_grid.columns = items_per_row
    
    # Hide item details initially
    if item_details_panel:
        item_details_panel.visible = false
    
    print("UI components configured")

func setup_sorting_options():
    if not sort_options:
        return
    
    sort_options.clear()
    sort_options.add_item("Default Order")
    sort_options.add_item("Alphabetical")
    sort_options.add_item("By Type")
    sort_options.add_item("By Rarity")
    
    print("Sorting options configured")

func connect_signals():
    if sort_options:
        sort_options.item_selected.connect(_on_sort_option_selected)
    
    if use_item_button:
        use_item_button.pressed.connect(_on_use_item_pressed)
    
    print("Signals connected")
```

### Step 2: Create Inventory Slot UI Component
**Create** a script for individual inventory slots: `scripts/inventory_slot.gd`

```gdscript
extends Panel
class_name InventorySlot

# UI elements
@onready var item_icon: TextureRect = $ItemIcon
@onready var item_label: Label = $ItemLabel
@onready var quantity_label: Label = $QuantityLabel
@onready var rarity_indicator: ColorRect = $RarityIndicator

# Slot data
var slot_index: int = -1
var contained_item: Pickup = null
var is_selected: bool = false

# Visual configuration
var empty_color: Color = Color(0.2, 0.2, 0.2, 0.5)
var filled_color: Color = Color(0.4, 0.4, 0.4, 0.8)
var selected_color: Color = Color(0.6, 0.8, 1.0, 0.9)

# Rarity colors
var rarity_colors = {
    "common": Color.WHITE,
    "uncommon": Color.GREEN,
    "rare": Color.BLUE,
    "epic": Color.PURPLE,
    "legendary": Color.GOLD
}

signal slot_clicked(slot_index: int)

func _ready():
    # Connect click signal
    gui_input.connect(_on_gui_input)
    setup_empty_slot()

func _on_gui_input(event):
    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
            slot_clicked.emit(slot_index)

func setup_empty_slot():
    contained_item = null
    is_selected = false
    
    # Visual setup for empty slot
    color = empty_color
    
    if item_label:
        item_label.text = "[Empty]"
        item_label.modulate = Color.GRAY
    
    if quantity_label:
        quantity_label.visible = false
    
    if rarity_indicator:
        rarity_indicator.visible = false
    
    if item_icon:
        item_icon.texture = null

func set_item(item: Pickup):
    contained_item = item
    
    if item == null:
        setup_empty_slot()
        return
    
    # Visual setup for filled slot
    color = filled_color
    
    if item_label:
        item_label.text = item.get_pickup_name()
        item_label.modulate = Color.WHITE
    
    # Show rarity indicator
    if rarity_indicator:
        var rarity = get_item_rarity(item)
        rarity_indicator.color = rarity_colors.get(rarity, Color.WHITE)
        rarity_indicator.visible = true
    
    # TODO: Set item icon when we have item graphics
    
    update_quantity_display()

func get_item_rarity(item: Pickup) -> String:
    # This would be expanded based on your item system
    if item is HealthPotion:
        return "common"
    elif item is Coin:
        return "common" 
    elif item is ExperienceGem:
        return "uncommon"
    else:
        return "common"

func update_quantity_display():
    # For stackable items, show quantity
    if quantity_label:
        # This would be expanded based on your item stacking system
        quantity_label.visible = false  # For now, no stacking

func set_selected(selected: bool):
    is_selected = selected
    
    if selected:
        color = selected_color
    else:
        color = filled_color if contained_item != null else empty_color
```

## Part 2: Inventory Management Functions

### Step 3: Add Core Inventory Functions
**Add these functions** to your `complete_inventory.gd` script:

```gdscript
func initialize_inventory_grid():
    if not inventory_grid:
        print("Warning: Inventory grid not found")
        return
    
    # Clear existing slots
    for child in inventory_grid.get_children():
        child.queue_free()
    
    # Create inventory slots
    for i in range(max_inventory_slots):
        var slot = create_inventory_slot(i)
        inventory_grid.add_child(slot)
    
    print("Created " + str(max_inventory_slots) + " inventory slots")

func create_inventory_slot(index: int) -> InventorySlot:
    var slot = InventorySlot.new()
    slot.slot_index = index
    slot.custom_minimum_size = Vector2(64, 64)
    
    # Connect slot click signal
    slot.slot_clicked.connect(_on_slot_clicked)
    
    return slot

func _on_slot_clicked(slot_index: int):
    print("Slot " + str(slot_index) + " clicked")
    select_slot(slot_index)

func select_slot(slot_index: int):
    # Deselect previous slot
    if selected_slot_index >= 0:
        var old_slot = get_inventory_slot(selected_slot_index)
        if old_slot:
            old_slot.set_selected(false)
    
    # Select new slot
    selected_slot_index = slot_index
    var new_slot = get_inventory_slot(slot_index)
    
    if new_slot:
        new_slot.set_selected(true)
        selected_item = new_slot.contained_item
        update_item_details()
    
    print("Selected slot " + str(slot_index))

func get_inventory_slot(index: int) -> InventorySlot:
    if not inventory_grid or index < 0 or index >= inventory_grid.get_child_count():
        return null
    
    return inventory_grid.get_child(index) as InventorySlot

func update_item_details():
    if not item_details_panel:
        return
    
    if selected_item == null:
        item_details_panel.visible = false
        return
    
    # Show item details
    item_details_panel.visible = true
    
    if item_name_label:
        item_name_label.text = selected_item.get_pickup_name()
    
    if item_description_label:
        item_description_label.text = get_item_description(selected_item)
    
    if use_item_button:
        use_item_button.text = get_use_button_text(selected_item)
        use_item_button.disabled = not can_use_item(selected_item)

func get_item_description(item: Pickup) -> String:
    if item is HealthPotion:
        var health_potion = item as HealthPotion
        return "Restores " + str(health_potion.heal_amount) + " health points."
    elif item is Coin:
        var coin = item as Coin
        return "Worth " + str(coin.coin_value) + " gold pieces."
    elif item is ExperienceGem:
        var exp_gem = item as ExperienceGem
        return "Grants " + str(exp_gem.exp_value) + " experience points."
    else:
        return "A mysterious item."

func get_use_button_text(item: Pickup) -> String:
    if item is HealthPotion:
        return "Drink Potion"
    elif item is Coin:
        return "Count Gold"
    elif item is ExperienceGem:
        return "Use Gem"
    else:
        return "Use Item"

func can_use_item(item: Pickup) -> bool:
    if not player_reference:
        return false
    
    if item is HealthPotion:
        # Can use if player is not at full health
        return player_reference.current_health < player_reference.max_health
    elif item is Coin:
        # Coins can always be "used" (counted)
        return true
    elif item is ExperienceGem:
        # Experience gems can always be used
        return true
    
    return true
```

### Step 4: Add Item Management Functions
**Add these functions** for adding/removing items:

```gdscript
func add_item(item: Pickup) -> bool:
    # Find first empty slot
    var empty_slot_index = find_empty_slot()
    
    if empty_slot_index < 0:
        print("❌ Inventory full! Cannot add " + item.get_pickup_name())
        return false
    
    # Add item to inventory data
    inventory_items.append(item)
    
    # Update UI slot
    var slot = get_inventory_slot(empty_slot_index)
    if slot:
        slot.set_item(item)
    
    print("✅ Added " + item.get_pickup_name() + " to slot " + str(empty_slot_index))
    return true

func remove_item(item: Pickup) -> bool:
    var item_index = inventory_items.find(item)
    if item_index < 0:
        print("❌ Item not found in inventory")
        return false
    
    # Remove from inventory data
    inventory_items.remove_at(item_index)
    
    # Find and clear the UI slot
    var slot_index = find_item_slot(item)
    if slot_index >= 0:
        var slot = get_inventory_slot(slot_index)
        if slot:
            slot.set_item(null)
    
    # Clear selection if this was the selected item
    if selected_item == item:
        selected_item = null
        selected_slot_index = -1
        update_item_details()
    
    print("🗑️ Removed " + item.get_pickup_name())
    refresh_inventory_display()
    return true

func remove_item_at_slot(slot_index: int) -> bool:
    var slot = get_inventory_slot(slot_index)
    if not slot or not slot.contained_item:
        return false
    
    var item = slot.contained_item
    return remove_item(item)

func find_empty_slot() -> int:
    for i in range(max_inventory_slots):
        var slot = get_inventory_slot(i)
        if slot and slot.contained_item == null:
            return i
    return -1

func find_item_slot(item: Pickup) -> int:
    for i in range(max_inventory_slots):
        var slot = get_inventory_slot(i)
        if slot and slot.contained_item == item:
            return i
    return -1

func get_inventory_count() -> int:
    return inventory_items.size()

func get_empty_slots_count() -> int:
    return max_inventory_slots - inventory_items.size()

func is_inventory_full() -> bool:
    return inventory_items.size() >= max_inventory_slots
```

## Part 3: Integration with Game Systems

### Step 5: Connect to Player and Game World
**Add these integration functions**:

```gdscript
func find_player_reference():
    # Try to find Player in the scene tree
    var player = get_tree().get_first_node_in_group("players")
    if player and player is Player:
        player_reference = player
        print("✅ Found player reference")
        
        # Connect to player events if possible
        if player_reference.has_signal("item_collected"):
            player_reference.item_collected.connect(_on_player_collected_item)
        
    else:
        print("⚠️ Player reference not found")

func _on_player_collected_item(item: Pickup):
    print("Player collected: " + item.get_pickup_name())
    add_item(item)

func _on_use_item_pressed():
    if not selected_item or not player_reference:
        return
    
    print("Using item: " + selected_item.get_pickup_name())
    use_selected_item()

func use_selected_item():
    if not selected_item or not player_reference:
        return
    
    var item_used = false
    
    if selected_item is HealthPotion:
        var health_potion = selected_item as HealthPotion
        if player_reference.current_health < player_reference.max_health:
            player_reference.heal(health_potion.heal_amount)
            item_used = true
    
    elif selected_item is Coin:
        var coin = selected_item as Coin
        if player_reference.has_method("add_currency"):
            player_reference.add_currency(coin.coin_value)
            item_used = true
    
    elif selected_item is ExperienceGem:
        var exp_gem = selected_item as ExperienceGem
        if player_reference.has_method("gain_experience"):
            player_reference.gain_experience(exp_gem.exp_value)
            item_used = true
    
    # Remove item from inventory if it was consumed
    if item_used:
        remove_item(selected_item)
        print("Item consumed!")

# Connect this to pickup objects in the game world
func collect_pickup(pickup: Pickup):
    # This would be called when player touches a pickup
    if add_item(pickup):
        # Successfully added to inventory
        if pickup.has_method("queue_free"):
            pickup.queue_free()  # Remove from world
        return true
    else:
        # Inventory full
        return false
```

### Step 6: Add Sorting and Organization
**Add these sorting functions** using your array manipulation skills:

```gdscript
func _on_sort_option_selected(index: int):
    match index:
        0: sort_default()
        1: sort_alphabetical()
        2: sort_by_type()
        3: sort_by_rarity()

func sort_default():
    current_sort_mode = "default"
    # Keep items in the order they were added
    refresh_inventory_display()
    print("Sorted by default order")

func sort_alphabetical():
    current_sort_mode = "alphabetical"
    
    # Sort inventory items alphabetically
    inventory_items.sort_custom(func(a, b): 
        return a.get_pickup_name() < b.get_pickup_name()
    )
    
    refresh_inventory_display()
    print("Sorted alphabetically")

func sort_by_type():
    current_sort_mode = "type"
    
    # Define type priority
    var type_priority = {
        "HealthPotion": 1,
        "ExperienceGem": 2,
        "Coin": 3
    }
    
    inventory_items.sort_custom(func(a, b):
        var type_a = a.get_script().get_global_name()
        var type_b = b.get_script().get_global_name()
        
        var priority_a = type_priority.get(type_a, 999)
        var priority_b = type_priority.get(type_b, 999)
        
        if priority_a != priority_b:
            return priority_a < priority_b
        
        # Same type, sort alphabetically
        return a.get_pickup_name() < b.get_pickup_name()
    )
    
    refresh_inventory_display()
    print("Sorted by type")

func sort_by_rarity():
    current_sort_mode = "rarity"
    
    var rarity_priority = {
        "legendary": 1,
        "epic": 2,
        "rare": 3,
        "uncommon": 4,
        "common": 5
    }
    
    inventory_items.sort_custom(func(a, b):
        var rarity_a = get_item_rarity(a)
        var rarity_b = get_item_rarity(b)
        
        var priority_a = rarity_priority.get(rarity_a, 6)
        var priority_b = rarity_priority.get(rarity_b, 6)
        
        return priority_a < priority_b
    )
    
    refresh_inventory_display()
    print("Sorted by rarity")

func refresh_inventory_display():
    # Clear all slots first
    for i in range(max_inventory_slots):
        var slot = get_inventory_slot(i)
        if slot:
            slot.set_item(null)
    
    # Place items in order
    for i in range(inventory_items.size()):
        if i < max_inventory_slots:
            var slot = get_inventory_slot(i)
            if slot:
                slot.set_item(inventory_items[i])
    
    print("Inventory display refreshed")
```

## Part 4: Testing and Debugging

### Step 7: Add Debug and Testing Functions
**Add these debugging tools** to test your inventory system:

```gdscript
func _input(event):
    # Debug controls for testing
    if event.is_action_pressed("ui_page_up"):
        debug_add_random_item()
    elif event.is_action_pressed("ui_page_down"):
        debug_remove_random_item()
    elif event.is_action_pressed("ui_home"):
        debug_fill_inventory()
    elif event.is_action_pressed("ui_end"):
        debug_clear_inventory()

func debug_add_random_item():
    var random_items = [
        create_test_health_potion(),
        create_test_coin(),
        create_test_experience_gem()
    ]
    
    var random_item = random_items[randi() % random_items.size()]
    if add_item(random_item):
        print("🎲 Added random item: " + random_item.get_pickup_name())
    else:
        print("🎲 Failed to add random item - inventory full")

func debug_remove_random_item():
    if inventory_items.size() == 0:
        print("🎲 No items to remove")
        return
    
    var random_index = randi() % inventory_items.size()
    var item = inventory_items[random_index]
    remove_item(item)
    print("🎲 Removed random item: " + item.get_pickup_name())

func debug_fill_inventory():
    print("🎲 Filling inventory with test items...")
    
    while not is_inventory_full():
        debug_add_random_item()
    
    print("Inventory filled! (" + str(get_inventory_count()) + "/" + str(max_inventory_slots) + ")")

func debug_clear_inventory():
    print("🎲 Clearing inventory...")
    
    inventory_items.clear()
    refresh_inventory_display()
    
    selected_item = null
    selected_slot_index = -1
    update_item_details()
    
    print("Inventory cleared!")

func create_test_health_potion() -> HealthPotion:
    var potion = HealthPotion.new()
    potion.heal_amount = 25 + (randi() % 25)  # 25-50 healing
    return potion

func create_test_coin() -> Coin:
    var coin = Coin.new()
    coin.coin_value = 5 + (randi() % 15)  # 5-20 gold
    return coin

func create_test_experience_gem() -> ExperienceGem:
    var gem = ExperienceGem.new()
    gem.exp_value = 50 + (randi() % 100)  # 50-150 exp
    return gem

func get_inventory_status() -> String:
    var status = "=== INVENTORY STATUS ===\n"
    status += "Items: " + str(get_inventory_count()) + "/" + str(max_inventory_slots) + "\n"
    status += "Empty slots: " + str(get_empty_slots_count()) + "\n"
    status += "Sort mode: " + current_sort_mode + "\n"
    status += "Selected item: " + (selected_item.get_pickup_name() if selected_item else "None") + "\n"
    
    status += "\nItems by type:\n"
    var type_counts = {}
    for item in inventory_items:
        var type_name = item.get_script().get_global_name()
        if type_name in type_counts:
            type_counts[type_name] += 1
        else:
            type_counts[type_name] = 1
    
    for type_name in type_counts:
        status += "  " + type_name + ": " + str(type_counts[type_name]) + "\n"
    
    return status

func print_inventory_status():
    print(get_inventory_status())
```

## Part 5: Scene Setup and Integration

### Step 8: Create the Complete Inventory Scene
1. **Create** a new scene (`scenes/complete_inventory_test.tscn`)

2. **Scene structure**:
   ```
   CompleteInventoryTest (Control)
   ├── InventoryPanel (Panel)
   │   ├── ControlBar (HBoxContainer)
   │   │   ├── TitleLabel (Label) - "Inventory"
   │   │   └── SortOptions (OptionButton)
   │   └── ScrollContainer (ScrollContainer)
   │       └── InventoryGrid (GridContainer)
   ├── ItemDetailsPanel (Panel)
   │   └── VBox (VBoxContainer)
   │       ├── ItemNameLabel (Label)
   │       ├── ItemDescriptionLabel (Label)
   │       └── UseItemButton (Button)
   └── DebugPanel (Panel)
       └── VBox (VBoxContainer)
           ├── DebugLabel (Label) - "Debug Controls:"
           ├── HBox1 (HBoxContainer)
           │   ├── AddItemButton (Button) - "Add Random"
           │   └── RemoveItemButton (Button) - "Remove Random"
           └── HBox2 (HBoxContainer)
               ├── FillButton (Button) - "Fill Inventory"
               └── ClearButton (Button) - "Clear All"
   ```

3. **Configure layout**:
   - **InventoryPanel**: Position (50, 50), Size (400, 300)
   - **ItemDetailsPanel**: Position (500, 50), Size (250, 300)
   - **DebugPanel**: Position (50, 400), Size (400, 150)

4. **Attach** your `complete_inventory.gd` script to the root Control node

### Step 9: Connect Debug Buttons
**Add these signal connections** to your inventory script:

```gdscript
func connect_debug_signals():
    # Find debug buttons and connect them
    var add_button = find_child("AddItemButton")
    var remove_button = find_child("RemoveItemButton")
    var fill_button = find_child("FillButton")
    var clear_button = find_child("ClearButton")
    
    if add_button:
        add_button.pressed.connect(debug_add_random_item)
    if remove_button:
        remove_button.pressed.connect(debug_remove_random_item)
    if fill_button:
        fill_button.pressed.connect(debug_fill_inventory)
    if clear_button:
        clear_button.pressed.connect(debug_clear_inventory)

# Call this in your _ready() function
func _ready():
    print("=== COMPLETE INVENTORY SYSTEM ===")
    
    setup_ui_components()
    setup_sorting_options()
    connect_signals()
    connect_debug_signals()  # Add this line
    initialize_inventory_grid()
    find_player_reference()
    
    print("Inventory system ready!")
    print("Debug controls:")
    print("  Page Up/Down: Add/Remove random item")
    print("  Home/End: Fill/Clear inventory")
```

### Step 10: Integration with Main Game
**To integrate** with your existing game, add this to your Player class:

```gdscript
# Add to Player class
signal item_collected(item: Pickup)

# Modify your player's collision detection for pickups
func _on_area_entered(area):
    if area is Pickup:
        # Try to collect the item
        item_collected.emit(area)
        
        # The inventory system will handle adding the item
        # and removing it from the world if successful

# Add method to show/hide inventory
func toggle_inventory():
    var inventory = get_tree().get_first_node_in_group("inventory_ui")
    if inventory:
        inventory.visible = not inventory.visible
```

**Add inventory controls** to your main game input:

```gdscript
# In your main game input handling
func _input(event):
    if event.is_action_pressed("inventory_toggle"):  # Define this in Input Map
        var player = get_tree().get_first_node_in_group("players")
        if player and player.has_method("toggle_inventory"):
            player.toggle_inventory()
```

## Part 6: Advanced Features

### Step 11: Add Search and Filter Functions
**Add these advanced features**:

```gdscript
# Add UI elements for search/filter
@onready var search_field: LineEdit = $InventoryPanel/ControlBar/SearchField
@onready var filter_options: OptionButton = $InventoryPanel/ControlBar/FilterOptions

var current_search_term: String = ""
var current_filter_type: String = "all"

func setup_search_and_filter():
    if search_field:
        search_field.text_changed.connect(_on_search_text_changed)
        search_field.placeholder_text = "Search items..."
    
    if filter_options:
        filter_options.clear()
        filter_options.add_item("All Items")
        filter_options.add_item("Potions")
        filter_options.add_item("Coins")
        filter_options.add_item("Experience")
        filter_options.item_selected.connect(_on_filter_selected)

func _on_search_text_changed(new_text: String):
    current_search_term = new_text.to_lower()
    filter_and_display_items()

func _on_filter_selected(index: int):
    match index:
        0: current_filter_type = "all"
        1: current_filter_type = "HealthPotion"
        2: current_filter_type = "Coin"
        3: current_filter_type = "ExperienceGem"
    
    filter_and_display_items()

func filter_and_display_items():
    var filtered_items: Array[Pickup] = []
    
    for item in inventory_items:
        # Apply type filter
        if current_filter_type != "all":
            var item_type = item.get_script().get_global_name()
            if item_type != current_filter_type:
                continue
        
        # Apply search filter
        if current_search_term != "":
            var item_name = item.get_pickup_name().to_lower()
            if not current_search_term in item_name:
                continue
        
        filtered_items.append(item)
    
    display_filtered_items(filtered_items)

func display_filtered_items(filtered_items: Array[Pickup]):
    # Clear all slots
    for i in range(max_inventory_slots):
        var slot = get_inventory_slot(i)
        if slot:
            slot.set_item(null)
    
    # Display filtered items
    for i in range(filtered_items.size()):
        if i < max_inventory_slots:
            var slot = get_inventory_slot(i)
            if slot:
                slot.set_item(filtered_items[i])
    
    print("Displaying " + str(filtered_items.size()) + " filtered items")
```

## Deliverables
By the end of this lesson, you should have:
- [ ] Complete inventory system with visual UI and object storage
- [ ] Integration with Player class and pickup objects
- [ ] Working item usage system (potions heal, coins add currency, etc.)
- [ ] Sorting options (alphabetical, by type, by rarity)
- [ ] Debug tools for testing inventory functionality
- [ ] Search and filter capabilities for large inventories
- [ ] Professional inventory interface that players can actually use
- [ ] Foundation ready for save/load functionality

## Next Lesson Preview - Dictionary Data Structures!
**In Lesson 14**, we'll learn about Dictionaries and how they improve upon arrays for certain use cases:
- **Key-value storage**: Player settings, game configuration
- **Fast lookups**: O(1) performance vs O(n) array searching
- **Structured data**: Complex game data organization
- **Comparison**: When to use Arrays vs Dictionaries

**This will enhance** your data management toolkit even further!

## Troubleshooting

**"Inventory slots don't display items"**
- Check that InventorySlot script is properly attached to slot nodes
- Verify that `set_item()` is being called correctly
- Make sure UI node references (@onready) are properly connected

**"Items aren't being removed when used"**
- Check that `remove_item()` is being called after successful item use
- Verify that player methods (heal, add_currency) exist and work
- Debug by adding print statements in the use item function

**"Sorting doesn't work"**
- Ensure `refresh_inventory_display()` is called after sorting
- Check that comparison functions return boolean values
- Verify that inventory_items array is being sorted, not just displayed

**"Integration with game systems fails"**
- Make sure Player is in the "players" group
- Check that signal connections are properly established
- Verify that pickup objects inherit from the Pickup base class

## Reflection Questions
Write down or discuss:

1. **Integration**: How does combining multiple concepts create more value than individual pieces?
2. **User Experience**: What makes an inventory system feel professional vs amateur?
3. **System Design**: How do you balance functionality with simplicity?
4. **Performance**: What happens to UI responsiveness with very large inventories?
5. **Extensibility**: How would you add new features like item stacking or trading?

**You've built a complete, professional inventory system using everything you've learned about arrays!** 🎮

---

*This inventory system demonstrates how individual programming concepts combine into complete game features. The same integration approach applies to quest systems, skill trees, dialogue systems, and other complex game features.*

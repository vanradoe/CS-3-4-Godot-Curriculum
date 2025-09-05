extends Control
class_name ArrayDisplayUI

# UI elements for showing array contents
@onready var inventory_label: Label = $InventoryPanel/InventoryLabel
@onready var enemy_status_label: Label = $EnemyPanel/EnemyStatusLabel

# Sample data arrays (these would come from your game systems)
var player_inventory: Array[String] = []
var active_enemies: Array[String] = []

# Interactive navigation
var current_inventory_page: int = 0
var items_per_page: int = 4
var selected_item_index: int = 0

# Item classification for display
var rare_items: Array[String] = ["Dragon Scale", "Phoenix Feather", "Magic Ring"]
var common_items: Array[String] = ["Iron Sword", "Health Potion"]

# Change tracking
var inventory_change_log: Array[String] = []

func _ready():
    print("=== ARRAY DISPLAY UI PRACTICE ===")
    
    # Set up sample data
    setup_sample_data()
    
    # Practice different display methods
    practice_basic_display()
    practice_formatted_display()
    practice_interactive_display()
    
    # Advanced features
    create_sorted_displays()
    test_interactive_features()
    
    print("=================================")
    print("Use arrow keys to navigate!")
    print("Press Enter to select items!")

func setup_sample_data():
    print("Setting up sample data...")
    
    # Sample inventory items
    player_inventory.append("Iron Sword")
    player_inventory.append("Health Potion")
    player_inventory.append("Magic Ring")
    player_inventory.append("Gold Key")
    
    # Sample enemy status
    active_enemies.append("Goblin (50/50 HP)")
    active_enemies.append("Orc (35/80 HP)")
    active_enemies.append("Troll (120/120 HP)")
    
    print("Sample data ready!")

func practice_basic_display():
    print("\n--- Basic Array Display ---")
    
    # Simple list display
    var inventory_text = "PLAYER INVENTORY:\n"
    for i in range(player_inventory.size()):
        inventory_text += str(i + 1) + ". " + player_inventory[i] + "\n"
    
    print("Basic inventory display:")
    print(inventory_text)
    
    # Show on UI if available
    if inventory_label:
        inventory_label.text = inventory_text

func practice_formatted_display():
    print("\n--- Formatted Array Display ---")
    
    # Professional inventory formatting
    var formatted_inventory = create_formatted_inventory()
    print("Formatted inventory:")
    print(formatted_inventory)
    
    # Professional enemy status formatting
    var formatted_enemies = create_formatted_enemy_list()
    print("Formatted enemy status:")
    print(formatted_enemies)
    
    # Update UI labels
    if inventory_label:
        inventory_label.text = formatted_inventory
    if enemy_status_label:
        enemy_status_label.text = formatted_enemies

func create_formatted_inventory() -> String:
    var output = "╔══════════════════╗\n"
    output += "║    INVENTORY     ║\n"
    output += "╠══════════════════╣\n"
    
    # Show each inventory item with nice formatting
    for i in range(player_inventory.size()):
        var item_number = str(i + 1).pad_zeros(2)  # "01", "02", etc.
        var item_name = player_inventory[i]
        output += "║ " + item_number + ". " + item_name.pad_right(13) + "║\n"
    
    # Fill empty slots if inventory isn't full
    var max_slots = 8
    for i in range(player_inventory.size(), max_slots):
        var slot_number = str(i + 1).pad_zeros(2)
        output += "║ " + slot_number + ". " + "[Empty]".pad_right(13) + "║\n"
    
    output += "╚══════════════════╝"
    return output

func create_formatted_enemy_list() -> String:
    var output = "╔══════════════════╗\n"
    output += "║   ENEMY STATUS   ║\n"
    output += "╠══════════════════╣\n"
    
    if active_enemies.size() == 0:
        output += "║   No enemies     ║\n"
        output += "║   detected!      ║\n"
    else:
        for enemy in active_enemies:
            # Truncate long enemy names to fit
            var enemy_display = enemy
            if enemy_display.length() > 16:
                enemy_display = enemy_display.substr(0, 13) + "..."
            output += "║ " + enemy_display.pad_right(16) + "║\n"
    
    output += "╚══════════════════╝"
    return output

func practice_interactive_display():
    print("\n--- Interactive Array Display ---")
    
    # Simulate adding/removing items
    simulate_inventory_changes()
    
    # Simulate enemy changes
    simulate_enemy_changes()

func simulate_inventory_changes():
    print("Simulating inventory changes...")
    
    # Add item
    player_inventory.append("Mysterious Scroll")
    print("Added Mysterious Scroll")
    update_display()
    
    # Remove item
    if player_inventory.size() > 0:
        var removed_item = player_inventory.pop_back()
        print("Removed: " + removed_item)
        update_display()
    
    # Add multiple items
    player_inventory.append("Dragon Scale")
    player_inventory.append("Phoenix Feather")
    print("Added Dragon Scale and Phoenix Feather")
    update_display()

func simulate_enemy_changes():
    print("Simulating enemy status changes...")
    
    # Remove defeated enemy
    if active_enemies.size() > 0:
        var defeated_enemy = active_enemies.pop_front()
        print("Enemy defeated: " + defeated_enemy)
        update_display()
    
    # Add new enemy
    active_enemies.append("Shadow Beast (60/60 HP)")
    print("New enemy appeared!")
    update_display()

func update_display():
    # Refresh all UI displays
    var formatted_inventory = create_formatted_inventory()
    var formatted_enemies = create_formatted_enemy_list()
    
    if inventory_label:
        inventory_label.text = formatted_inventory
    if enemy_status_label:
        enemy_status_label.text = formatted_enemies
    
    print("Display updated!")

func create_color_coded_inventory() -> String:
    var output = "╔══════════════════╗\n"
    output += "║    INVENTORY     ║\n"
    output += "║  (R)are (C)ommon ║\n"
    output += "╠══════════════════╣\n"
    
    for i in range(player_inventory.size()):
        var item_number = str(i + 1).pad_zeros(2)
        var item_name = player_inventory[i]
        
        # Add rarity indicator
        var rarity_symbol = "?"
        if item_name in rare_items:
            rarity_symbol = "R"
        elif item_name in common_items:
            rarity_symbol = "C"
        
        # Format: "01. (R) Dragon Scale"
        var display_name = "(" + rarity_symbol + ") " + item_name
        if display_name.length() > 13:
            display_name = display_name.substr(0, 10) + "..."
        
        output += "║ " + item_number + ". " + display_name.pad_right(13) + "║\n"
    
    # Fill empty slots
    var max_slots = 6  # Smaller for this example
    for i in range(player_inventory.size(), max_slots):
        var slot_number = str(i + 1).pad_zeros(2)
        output += "║ " + slot_number + ". " + "[Empty]".pad_right(13) + "║\n"
    
    output += "╚══════════════════╝"
    return output

func create_sorted_displays():
    print("\n--- Sorted Array Displays ---")
    
    # Sort inventory alphabetically
    var sorted_inventory = player_inventory.duplicate()
    sorted_inventory.sort()
    
    print("Alphabetical inventory:")
    var alpha_display = "ALPHABETICAL ORDER:\n"
    for i in range(sorted_inventory.size()):
        alpha_display += "  " + str(i + 1) + ". " + sorted_inventory[i] + "\n"
    print(alpha_display)
    
    # Sort by rarity (rare items first)
    var rarity_sorted = sort_by_rarity()
    print("Rarity-sorted inventory:")
    var rarity_display = "BY RARITY:\n"
    for i in range(rarity_sorted.size()):
        var item = rarity_sorted[i]
        var rarity = get_item_rarity(item)
        rarity_display += "  " + str(i + 1) + ". " + item + " (" + rarity + ")\n"
    print(rarity_display)

func sort_by_rarity() -> Array[String]:
    var sorted_items: Array[String] = []
    
    # Add rare items first
    for item in player_inventory:
        if item in rare_items:
            sorted_items.append(item)
    
    # Then add common items
    for item in player_inventory:
        if item in common_items:
            sorted_items.append(item)
    
    # Finally add unknown items
    for item in player_inventory:
        if not item in rare_items and not item in common_items:
            sorted_items.append(item)
    
    return sorted_items

func get_item_rarity(item_name: String) -> String:
    if item_name in rare_items:
        return "Rare"
    elif item_name in common_items:
        return "Common"
    else:
        return "Unknown"

func _input(event):
    if event.is_action_pressed("ui_up"):
        scroll_inventory_up()
    elif event.is_action_pressed("ui_down"):
        scroll_inventory_down()
    elif event.is_action_pressed("ui_left"):
        previous_inventory_page()
    elif event.is_action_pressed("ui_right"):
        next_inventory_page()
    elif event.is_action_pressed("ui_accept"):
        select_current_item()

func scroll_inventory_up():
    if player_inventory.size() > 0:
        selected_item_index -= 1
        if selected_item_index < 0:
            selected_item_index = player_inventory.size() - 1
        update_interactive_display()

func scroll_inventory_down():
    if player_inventory.size() > 0:
        selected_item_index += 1
        if selected_item_index >= player_inventory.size():
            selected_item_index = 0
        update_interactive_display()

func previous_inventory_page():
    # Placeholder for page navigation
    print("Previous page (not implemented in this demo)")

func next_inventory_page():
    # Placeholder for page navigation
    print("Next page (not implemented in this demo)")

func select_current_item():
    if player_inventory.size() > 0 and selected_item_index < player_inventory.size():
        var selected_item = player_inventory[selected_item_index]
        print("Selected item: " + selected_item)
        show_item_details(selected_item)

func show_item_details(item_name: String):
    var details = "╔══════════════════╗\n"
    details += "║   ITEM DETAILS   ║\n"
    details += "╠══════════════════╣\n"
    details += "║ " + item_name.pad_right(16) + "║\n"
    details += "║                  ║\n"
    
    # Show item-specific information
    if item_name in rare_items:
        details += "║ Rarity: Rare     ║\n"
        details += "║ Value: High      ║\n"
    elif item_name in common_items:
        details += "║ Rarity: Common   ║\n"
        details += "║ Value: Normal    ║\n"
    else:
        details += "║ Rarity: Unknown  ║\n"
        details += "║ Value: ???       ║\n"
    
    details += "║                  ║\n"
    details += "║ [Enter] to use   ║\n"
    details += "╚══════════════════╝"
    
    print(details)

func update_interactive_display():
    var display = create_interactive_inventory()
    if inventory_label:
        inventory_label.text = display

func create_interactive_inventory() -> String:
    var output = "╔══════════════════╗\n"
    output += "║    INVENTORY     ║\n"
    output += "║ ↑↓ Navigate      ║\n"
    output += "╠══════════════════╣\n"
    
    for i in range(player_inventory.size()):
        var item_name = player_inventory[i]
        var display_name = item_name
        if display_name.length() > 14:
            display_name = display_name.substr(0, 11) + "..."
        
        # Highlight selected item
        if i == selected_item_index:
            output += "║► " + display_name.pad_right(15) + "║\n"
        else:
            output += "║  " + display_name.pad_right(15) + "║\n"
    
    # Show controls
    output += "║                  ║\n"
    output += "║ [Enter] Select   ║\n"
    output += "╚══════════════════╝"
    return output

func add_item_to_inventory(item_name: String):
    player_inventory.append(item_name)
    var change_message = "Added: " + item_name
    inventory_change_log.append(change_message)
    print(change_message)
    update_display()
    show_change_notification(change_message)

func remove_item_from_inventory(item_name: String):
    var index = player_inventory.find(item_name)
    if index >= 0:
        player_inventory.remove_at(index)
        var change_message = "Removed: " + item_name
        inventory_change_log.append(change_message)
        print(change_message)
        
        # Adjust selected index if needed
        if selected_item_index >= player_inventory.size():
            selected_item_index = max(0, player_inventory.size() - 1)
        
        update_display()
        show_change_notification(change_message)

func show_change_notification(message: String):
    # This would show a temporary notification in a real game
    print("📢 " + message)

func create_change_log_display() -> String:
    var output = "╔══════════════════╗\n"
    output += "║   CHANGE LOG     ║\n"
    output += "╠══════════════════╣\n"
    
    # Show last 5 changes
    var recent_changes = inventory_change_log.slice(-5)  # Get last 5 items
    
    for change in recent_changes:
        var display_change = change
        if display_change.length() > 16:
            display_change = display_change.substr(0, 13) + "..."
        output += "║ " + display_change.pad_right(16) + "║\n"
    
    # Fill empty lines
    for i in range(recent_changes.size(), 5):
        output += "║                  ║\n"
    
    output += "╚══════════════════╝"
    return output

func test_interactive_features():
    print("\n--- Testing Interactive Features ---")
    
    # Test adding items
    add_item_to_inventory("Enchanted Bow")
    add_item_to_inventory("Healing Crystal")
    
    # Test removing items
    remove_item_from_inventory("Health Potion")
    
    # Show change log
    var log_display = create_change_log_display()
    print("Recent changes:")
    print(log_display)
    
    # Initialize interactive mode
    update_interactive_display()

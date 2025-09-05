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

# Search and filter elements
@onready var search_field: LineEdit = $InventoryPanel/ControlBar/SearchField
@onready var filter_options: OptionButton = $InventoryPanel/ControlBar/FilterOptions

# Inventory configuration
@export var max_inventory_slots: int = 20
@export var items_per_row: int = 5

# Current state
var selected_item: Pickup = null
var selected_slot_index: int = -1
var current_sort_mode: String = "default"
var current_search_term: String = ""
var current_filter_type: String = "all"

# References to game systems
var player_reference: Player = null

func _ready():
    print("=== COMPLETE INVENTORY SYSTEM ===")
    
    setup_ui_components()
    setup_sorting_options()
    setup_search_and_filter()
    connect_signals()
    connect_debug_signals()
    initialize_inventory_grid()
    find_player_reference()
    
    print("Inventory system ready!")
    print("Max slots: " + str(max_inventory_slots))
    print("Debug controls:")
    print("  Page Up/Down: Add/Remove random item")
    print("  Home/End: Fill/Clear inventory")

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

func connect_signals():
    if sort_options:
        sort_options.item_selected.connect(_on_sort_option_selected)
    
    if use_item_button:
        use_item_button.pressed.connect(_on_use_item_pressed)
    
    print("Signals connected")

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

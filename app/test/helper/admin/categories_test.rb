# category_parent_selection

test "category_parent_selection returns a sorted list of categories and their IDs" do
    # Create a few categories with nested ancestors
    cat1 = create(:category, name: "Category 1")
    cat2 = create(:category, name: "Category 2", parent: cat1)
    cat3 = create(:category, name: "Category 3", parent: cat2)
    cat4 = create(:category, name: "Category 4")
    
    # Define the expected output of the function
    expected = [
      ["Category 1/Category 2/Category 3", cat3.id],
      ["Category 1/Category 2", cat2.id],
      ["Category 1", cat1.id],
      ["Category 4", cat4.id]
    ]
    
    # Assert that the function returns the expected output
    assert_equal expected, category_parent_selection
end
  
  
# render_partner_categories

test "render_partner_categories renders a sortable list of categories" do
    # Create a couple of categories
    cat1 = create(:category, name: "Category 1")
    cat2 = create(:category, name: "Category 2")
    
    # Pass the categories to the function
    categories = [cat1, cat2]
    output = render_partner_categories(categories)
    
    # Check that the output includes a sortable list element with the correct reordering URL
    assert_select output, 'ol.sortable.category-list[data-url=?]', reorder_admin_partner_categories_path
    
    # Check that the output includes two list items (one for each category)
    assert_select output, 'ol.sortable.category-list li', count: 2
end
  
  
# render_categories

test "render_categories renders a sortable list of categories" do
    # Create a couple of categories
    cat1 = create(:category, name: "Category 1")
    cat2 = create(:category, name: "Category 2")
    
    # Pass the categories to the function
    categories = [cat1, cat2]
    output = render_categories(categories)
    
    # Check that the output includes a sortable list element with the correct reordering URL
    assert_select output, 'ol.sortable.category-list[data-url=?]', reorder_admin_categories_path
    
    # Check that the output includes two list items (one for each category)
    assert_select output, 'ol.sortable.category-list li', count: 2
end


# render_sortable

# This test checks that the 'render_sortable' function renders a sortable list of items
# with the correct URL for reordering
test "render_sortable renders a sortable list of items" do
    # Create a collection of items
    collection = [1, 2, 3]
    
    # Specify the reordering URL
    url = "/test"
    
    # Render the collection using the `render_sortable` function,
    # passing a block to specify how to render each item in the collection
    output = render_sortable(collection, url) do
      collection.each do |item|
        concat content_tag(:li, item)
      end
    end
    
    # Check that the output includes a sortable list element with the correct reordering URL
    assert_select output, 'ol.sortable[data-url=?]', url
    
    # Check that the output includes three list items (one for each item in the collection)
    assert_select output, 'ol.sortable li', count: 3
  end
  
  


  
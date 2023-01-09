# question helper

# This test checks that the `category_selection` function returns a sorted list of categories and their IDs,
# excluding root categories
test "category_selection returns a sorted list of categories and their IDs, excluding root categories" do
    # Create some categories with nested ancestors
    cat1 = create(:category, name: "Category 1")
    cat2 = create(:category, name: "Category 2", parent: cat1)
    cat3 = create(:category, name: "Category 3", parent: cat2)
    cat4 = create(:category, name: "Category 4")
    
    # Define the expected output of the function
    expected = [
      ["Category 1/Category 2/Category 3", cat3.id],
      ["Category 1/Category 2", cat2.id],
      ["Category 1", cat1.id]
    ]
    
    # Assert that the function returns the expected output
    assert_equal expected, category_selection
end
  
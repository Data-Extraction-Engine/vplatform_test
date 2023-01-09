# layout helper


# This test checks that the `navbar_breadcrumbs` function generates the correct breadcrumb HTML
# using the options specified in the function
test "navbar_breadcrumbs generates correct breadcrumb HTML" do
    # Set up some breadcrumbs using the `add_breadcrumb` method
    add_breadcrumb "Home", root_path
    add_breadcrumb "Admin", admin_path
    add_breadcrumb "Users", admin_users_path
    
    # Render the breadcrumbs using the `navbar_breadcrumbs` function
    output = navbar_breadcrumbs
    
    # Check that the output is an unordered list element
    assert_select output, 'ul'
    
    # Check that the output includes three list items, with the correct link texts and classes
    assert_select output, 'ul li:nth-child(1) a[href=?]', root_path, text: "Home"
    assert_select output, 'ul li:nth-child(2) a[href=?]', admin_path, text: "Admin"
    assert_select output, 'ul li:nth-child(3) a.is-active[href=?]', admin_users_path, text: "Users"
end
  


# import status

# This test checks that the `import_status` function returns the correct icon and text
# for each possible value of the `status` attribute on a data import object
test "import_status returns the correct icon and text for each status" do
    # Create a data import object with each possible value of the `status` attribute
    new_import = build(:data_import, status: "new")
    running_import = build(:data_import, status: "running")
    finished_import = build(:data_import, status: "finished")
    failed_import = build(:data_import, status: "failed")
    
    # Assert that the `import_status` function returns the correct output for each data import object
    assert_equal '<i class="fa fa-fw clock-o" aria-hidden="true"></i> Queued', import_status(new_import)
    assert_equal '<i class="fa fa-fw cog spin" aria-hidden="true"></i> Running', import_status(running_import)
    assert_equal '<i class="fa fa-fw check" aria-hidden="true"></i> Finished', import_status(finished_import)
    assert_equal '<i class="fa fa-fw exclamation-triangle" aria-hidden="true"></i> Failed', import_status(failed_import)
  end
  
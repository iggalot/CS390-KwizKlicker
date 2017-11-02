describe "Navigation Requests Spec" do

  describe "Navigation should be available" do
    it "should show the navigation on the home page" do
      visit root_path
      page.should have_link('Home')
      page.should have_link('Create Room')
      page.should have_link('Join Room')
    end
  end
end
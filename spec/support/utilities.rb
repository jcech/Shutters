def show_photo

    click_link 'New Photo'
    page.attach_file("photo_image", '/Users/epicodus/Documents/raccoon-tuxedo.jpg')
    click_button 'Create Photo'
    find("#photo").click
end

def login_user
  create(:user, :username => 'Oswaldo', :password => 'oswaldo', :password_confirmation => 'oswaldo')
    visit '/'
    fill_in 'Username', :with => 'Oswaldo'
    fill_in 'Password', :with => 'oswaldo'
    click_button 'Log In'
end

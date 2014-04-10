require 'spec_helper'

feature "the signup process" do
  it "signs Oswaldo up" do
    visit '/'
    click_link 'Sign Up'
    fill_in 'Username', :with => 'Oswaldo'
    fill_in 'Password', :with => 'oswaldo'
    fill_in 'Password Confirmation', :with => 'oswaldo'
    click_button 'Create User'
    expect(page).to have_content 'Photos'
  end
end


feature "the signin process" do
  before :each do
    create(:user, :username => 'Oswaldo', :password => 'oswaldo', :password_confirmation => 'oswaldo')
  end

  it "signs Oswaldo in" do
    visit '/'
    fill_in 'Username', :with => 'Oswaldo'
    fill_in 'Password', :with => 'oswaldo'
    click_button 'Log In'
    expect(page).to have_content 'Logged in!'
  end

  it "signs Oswaldo out" do
    visit '/'
    fill_in 'Username', :with => 'Oswaldo'
    fill_in 'Password', :with => 'oswaldo'
    click_button 'Log In'
    click_link 'Log Out'
    expect(page).to have_content 'Log In'
  end
end

feature 'Photo adding' do
  before :each do
    login_user
  end
  it 'adds a photo' do
    click_link 'New Photo'
    page.attach_file("photo_image", '/Users/epicodus/Documents/raccoon-tuxedo.jpg')
    click_button 'Create Photo'
    expect(page).to have_content "Photos"
  end
  it 'Deletes a photo' do
    click_link 'New Photo'
    page.attach_file("photo_image", '/Users/epicodus/Documents/raccoon-tuxedo.jpg')
    click_button 'Create Photo'
    find("#photo").click
    click_link 'Delete Photo'
    expect(page).to have_content 'Photo deleted!'
  end
end

feature 'tagging a photo' do
  before :each do
    login_user
    show_photo
  end
  it 'tags a photo' do
    find('#tag_user_id').find(:xpath, 'option[2]').select_option
    click_button 'Tag a user to the photo'
    expect(page).to have_content 'Users in this photo: Oswaldo'
  end
end

feature '(un)favoriting a photo' do
  before :each do
    login_user
    show_photo
  end
  it 'favorites a photo' do
    click_link 'Favorite'
    expect(page).to have_content 'Unfavorite'
  end
  it 'unfavorites a photo' do
    click_link 'Favorite'
    click_link 'Unfavorite'
    expect(page).to have_content 'Favorite'
  end
end

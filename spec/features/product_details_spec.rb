require 'rails_helper'

RSpec.feature "Visitor navigates to product page", type: :feature, js: true do

#SETUP
before :each do
  @category = Category.create! name: 'Apparel'

  10.times do |n|
    @category.products.create!(
      name:  Faker::Hipster.sentence(3),
      description: Faker::Hipster.paragraph(4),
      image: open_asset('apparel1.jpg'),
      quantity: 10,
      price: 64.99
    )
  end
end
scenario "They can visit the product page from the home page" do

  #ACT
  visit root_path

  #DEBUG
  save_screenshot('test1.png')

  #CLICK 
  click_link("Details »", match: :first)

  #VERIFY
  expect(page).to have_text(/Quantity/i)

  #DEBUG
  save_screenshot('test2.png')
end


end 
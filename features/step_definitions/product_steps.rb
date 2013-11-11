Given(/^I am on the homepage$/) do
  visit root_path
end

When(/^I enter valid product details$/) do
  fill_in 'Title', with: 'My awesome product!'
  fill_in 'Details', with: 'These are details of my awesome product!'
end

When(/^submit the form$/) do
  click_button 'Voeg product toe!'
end

Then(/^I should see the product title$/) do
  unless page.has_content? 'My awesome product!'
    raise 'Tekst staat niet op het scherm!'
  end
end

Then(/^show me the page$/) do
  save_and_open_page
end

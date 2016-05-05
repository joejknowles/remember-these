require 'rails_helper'

feature 'recommends' do
  scenario 'I enter my username' do
    visit '/'
    fill_in 'username', with: 'joeknowlesy'
    click_button ''
    expect(page).to have_content 'remember'
    expect(page).to have_content '?'
  end
end
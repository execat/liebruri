require 'rails_helper'

describe "the homepage", type: :feature do
  it "should show homepage" do
    visit '/'
    expect(page).to have_content "Cugzi"
  end
end

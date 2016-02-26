require 'rails_helper'

describe "the sanity" do
  it "should pass for true assertions" do
    expect(1 + 1).to be 2
    expect(true).to be true
  end

  it "should fail for false assertions" do
    expect(1 + 1).to_not be true
    expect(false).to_not equal true
  end
end

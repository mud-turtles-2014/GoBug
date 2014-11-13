require 'rails_helper'

describe User do

  it "is valid with a first name, last name, username, password, and email" do
    user = User.new(first_name: "Boba", last_name: "Fett", password: "test", password_confirmation: "test", username: "bobafett", email: "bobafett@jabba.com")
    expect(user).to be_valid
  end

  it "has an expense in a wishlist" do
  end

  it
end
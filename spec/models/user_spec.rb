require 'rails_helper'

RSpec.describe User, :type => :model do
  subject {
         described_class.new(email: "jane@doe.com",
                             role_names: nil,
                             admin:false,
                             broker:true,
                             buyer:true,
                             password: "some_password")
  }

  describe "Validations" do
    #describe what is a valid user --> must have valid attributes
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is invalid without an email" do
      subject.email = " "
      expect(subject).to_not be_valid
    end

    it "is invalid without a password" do
      subject.password = " "
      expect(subject).to_not be_valid
    end

    it "is invalid with invalid email formats" do
      invalid_addresses = %w[ user@example,com, user_at_foo.org user.name@example. foo@bar+baz.com]
      invalid_addresses.each do |invalid_address|
        subject.email = invalid_address
        expect(subject).to_not be_valid, "#{invalid_address.inspect} is invalid."
      end
    end

    it "is invalid with short password" do
      subject.password = "a" * 5
      expect(subject).to_not be_valid
    end

    it "is invalid with long password" do
      subject.password = "a" * 255
      expect(subject).to_not be_valid
    end

    it "is invalid with false values for broker && buyer" do
      subject.broker = false
      subject.buyer = false
      expect(subject).to_not be_valid
    end
  end
end

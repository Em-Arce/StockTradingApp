require 'rails_helper'

RSpec.describe User, :type => :model do
  subject {
         described_class.new(password: "some_password",
                             email: "jane@doe.com",
                             role_id: 2)
  }

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is invalid without a password" do
      subject.password = nil
      expect(subject).to_not be_valid
    end

    it "is invalid without an email" do
      subject.email = nil
      expect(subject).to_not be_valid
    end

    it "is invalid without a role" do
      subject.role_id = nil
      expect(subject).to_not be_valid
    end
  end
end

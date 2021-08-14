require 'rails_helper'

RSpec.describe User, :type => :model do
  subject {
         described_class.new(password: "some_password",
                             email: "jane@doe.com")
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

    it "is invalid invalid email format" do
      subject.email = "test@example,com"
      expect(subject).to_not be_valid, "#{subject.email.inspect} is invalid."
    end

    it "is invalid with short password" do
      subject.password = "t" * 5
      expect(subject).to_not be_valid
    end
  end
end

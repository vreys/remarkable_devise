require 'spec_helper'

describe Remarkable::Devise::Matchers::BeAValidatableMatcher do
  context "validate inclusion of Devise::Models::Validatable" do
    it "should validate that model has Devise::Models::Validatable module included" do
      subject.matches?(User).should be_true
    end

    it "should validate that model has no Devise::Models::Validatable module included" do
      subject.matches?(FooUser).should be_false
    end
  end

  context "options matching" do
    describe :password_length do
      it "should validate that model is configured with proper :password_length option" do
        subject.class.new(:password_length => 8..20).matches?(User).should be_true
      end

      it "should validate that model isn't configured with proper :password_length option" do
        subject.class.new(:password_length => 4..10).matches?(User).should be_false
      end
    end

    describe :email_regexp do
      it "should validate that model is configured with proper :email_regexp option" do
        subject.class.new(:email_regexp => /^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/i).matches?(User).should be_true
      end

      it "should validate that model isn't configured with proper :email_regexp option" do
        subject.class.new(:email_regexp => /^(.+)@(.+)$/).matches?(User).should be_false
      end
    end
  end

  context "description" do
    context "when matching without options" do
      specify { subject.description.should eql('be a validatable') }
    end

    context "when matching with :password_length option" do
      before do
        @matcher = subject.class.new(:password_length => 8..20)
        @matcher.matches?(User)
      end

      specify { @matcher.description.should eql("be a validatable with password length 8..20") }
    end

    context "when matching with :email_regexp option" do
      before do
        @matcher = subject.class.new(:email_regexp => /^(.+)@(.+)$/i)
        @matcher.matches?(User)
      end

      specify { @matcher.description.should eql("be a validatable with email regexp /^(.+)@(.+)$/i") }
    end
  end

  describe "expectation message" do
    context "when Devise::Models::Validatable is not included" do
      before do
        subject.matches?(FooUser)
      end

      specify { subject.failure_message_for_should.should match('Foo user to include Devise :validatable model')}
    end

    context "when options doesn't match" do
      before do
        @matcher = subject.class.new(:password_length => 4..18)
        @matcher.matches?(User)
      end

      specify { @matcher.failure_message_for_should.should match('User to be a validatable with options (.+), got (.+)') }
    end
  end
end

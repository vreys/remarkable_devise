require 'spec_helper'

describe Remarkable::Devise::Matchers::BeATokenAuthenticatableMatcher do
  before do
    @valid_columns = ['authentication_token']

    User.stubs(:column_names).returns(@valid_columns)
  end

  context "validate inclusion of Devise::Models::TokenAuthenticatable" do
    it "should validate that model has Devise::Models::TokenAuthenticatable module included" do
      subject.matches?(User).should be_true
    end

    it "should validate that model has not Devise::Models::TokenAuthenticatable module included" do
      subject.matches?(FooUser).should be_false
    end
  end

  describe "options validation" do
    describe :token_authentication_key do
      it "should validate that model is configured with proper :token_authentication_key option" do
        subject.class.new(:token_authentication_key => :auth_token).matches?(User).should be_true
      end

      it "should validate that model isn't configured with proper :token_authentication_key option" do
        subject.class.new(:token_authentication_key => :authen_foo_key).matches?(User).should be_false
      end
    end
  end

  context "columns validation" do
    before do
      subject.stubs(:included?).returns(true)
    end

    context "authentication_token column" do
      it "should validate that model has authentication_column column" do
        subject.matches?(User).should be_true
      end

      it "should validate that model has no authentication_column column" do
        User.stubs(:column_names).returns(@valid_columns - ['authentication_token'])
        
        subject.matches?(User).should be_false
      end
    end
  end

  describe "description" do
    context "when matching without options" do
      specify { subject.description.should eql('be a token authenticatable') }
    end

    context "when matching with :token_authentication_key option" do
      before do
        @matcher = subject.class.new(:token_authentication_key => :auth_token)
        @matcher.matches?(User)
      end

      specify { @matcher.description.should eql("be a token authenticatable with :auth_token as token authentication key") }
    end
  end

  describe "expectation message" do
    context "when Devise::Models::TokenAuthenticatable is not included" do
      before do
        subject.matches?(FooUser)
      end

      specify { subject.failure_message_for_should.should match("to include Devise :token_authenticatable model") }
    end

    context "when model has no authentication_token column" do
      before do
        subject.stubs(:has_authentication_token_column?).returns(false)
        subject.matches?(User)
      end

      specify { subject.failure_message_for_should.should match("to have authentication_token column") }
    end

    context "when options doesn't match" do
      before do
        @matcher = subject.class.new(:token_authentication_key => :auth_foo_key)
        @matcher.matches?(User)
      end

      specify { @matcher.failure_message_for_should.should match("User to be a token authenticatable with options (.+), got (.+)") }
    end
  end
end

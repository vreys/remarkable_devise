require 'spec_helper'

describe Remarkable::Devise::Matchers::BeARecoverableMatcher do
  before do
    @valid_columns = ['reset_password_token']

    User.stubs(:column_names).returns(@valid_columns)
  end

  context "inclusion of Devise::Models::Recoverable" do
    it "should validate that model has Devise::Models::Recoverable included" do
      subject.matches?(User).should be_true
    end

    it "should validate that model has no Devise::Models::Recoverable included" do
      subject.matches?(FooUser).should be_false
    end
  end

  context "columns validation" do
    before do
      subject.stubs(:included?).returns(true)
    end

    it "should validate that model has reset_password_token column" do
      subject.matches?(User).should be_true
    end

    it "should validate that model has no reset_password_token column" do
      User.stubs(:column_names).returns(@valid_columns - ['reset_password_token'])
      
      subject.matches?(User).should be_false
    end
  end

  describe "description" do
    specify { subject.description.should eql('be a recoverable') }
  end

  
  describe "expectation message" do
    context "when Devise::Models::Recoverable is not included" do
      before do
        subject.stubs(:included?).returns(false)
        subject.matches?(User)
      end

      specify { subject.failure_message_for_should.should match('to include Devise :recoverable model') }
    end

    context "when has no reset_password_token column" do
      before do
        subject.stubs(:has_reset_password_token_column?).returns(false)
        subject.matches?(User)
      end
      specify { subject.failure_message_for_should.should match('to have reset_password_token column') }
    end
  end
end

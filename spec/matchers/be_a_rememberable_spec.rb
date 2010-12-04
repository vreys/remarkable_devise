require 'spec_helper'

describe Remarkable::Devise::Matchers::BeARememberableMatcher do
  before do
    @valid_columns = ['remember_token', 'remember_created_at']

    User.stubs(:column_names).returns(@valid_columns)
  end

  context "validate inclusion of Devise::Models::Rememberable" do
    it "should validate that model has Devise::Models::Rememberable module included" do
      subject.matches?(User).should be_true
    end

    it "should validate that model has no Devise::Models::Rememberable module included" do
      subject.matches?(FooUser).should be_false
    end
  end

  context "columns validation" do
    before do
      subject.stubs(:included?).returns(true)
    end

    context "remember_token column" do
      it "should validate that model has remember_token column" do
        subject.matches?(User).should be_true
      end

      it "should validate that model has no remember_token column" do
        User.stubs(:column_names).returns(@valid_columns - ['remember_token'])

        subject.matches?(User).should be_false
      end
    end

    context "remember_created_at" do
      before do
        subject.stubs(:has_remember_token_column?).returns(true)
      end

      it "should validate that model has remember_create_at column" do
        subject.matches?(User).should be_true
      end

      it "should validate that model has no remember_create_at column" do
        User.stubs(:column_names).returns(@valid_columns - ['remember_created_at'])

        subject.matches?(User).should be_false
      end
    end
  end

  describe "description" do
    specify { subject.description.should eql('be a rememberable') }
  end

  describe "expectation message" do
    context "when module Devise::Models::Remeberable is not included" do
      before do
        subject.stubs(:included?).returns(false)
        subject.matches?(User)
      end

      specify { subject.failure_message_for_should.should match('to include Devise :rememberable model') }
    end
    
    context "when model has no remember_token column" do
      before do
        subject.stubs(:has_remember_token_column?).returns(false)
        subject.matches?(User)
      end

      specify { subject.failure_message_for_should.should match('to have remember_token column') }
    end

    context "when model has no remember_created_at column" do
      before do
        subject.stubs(:has_remember_created_at_column?).returns(false)
        subject.matches?(User)
      end

      specify { subject.failure_message_for_should.should match('to have remember_created_at column') }
    end

  end
end

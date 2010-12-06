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

  context "options validation" do
    describe :remember_for do
      it "should validate that a model has proper :remember_for option" do
        subject.class.new(:remember_for => 2.weeks).matches?(User).should be_true
      end

      it "should validate that a model hasn't proper :remember_for option" do
        subject.class.new(:remember_for => 1.month).matches?(User).should be_false
      end
    end

    describe :extend_remember_period do
      it "should validate that a model is configured with proper :remember_across_browsers option" do
        subject.class.new(:extend_remember_period => true).matches?(User).should be_true
      end

      it "should validate that a model isn't configured with proper :remember_across_browsers option" do
        subject.class.new(:extend_remember_period => false).matches?(User).should be_false
      end
    end

    describe :cookie_domain do
      it "should validate that a model is configured with proper :cookie_domain option" do
        subject.class.new(:cookie_domain => 'foo').matches?(User).should be_true
      end

      it "should validate that a model isn't configured with proper :cookie_domain option" do
        subject.class.new(:cookie_domain => 'bar').matches?(User).should be_false
      end
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
    context "when matching without options" do
      specify { subject.description.should eql('be a rememberable') }
    end

    context "when matching with :remember_for option" do
      before do
        @matcher = subject.class.new(:remember_for => 2.weeks)
        @matcher.matches?(User)
      end

      specify { @matcher.description.should eql('be a rememberable with 14 days remember period') }
    end

    context "when matching with :extend_remember_period" do
      context "positive" do
        before do
          @matcher = subject.class.new(:extend_remember_period => true)
          @matcher.matches?(User)
        end

        specify { @matcher.description.should eql('be a rememberable with extendable remember period') }
      end

      context "negative" do
        before do
          @matcher = subject.class.new(:extend_remember_period => false)
          @matcher.matches?(User)
        end

        specify { @matcher.description.should eql('be a rememberable without extandable remember period') }
      end
    end

    context "when matching with :cookie_domain option" do
      before do
        @matcher = subject.class.new(:cookie_domain => 'foo')
        @matcher.matches?(User)
      end

      specify { @matcher.description.should eql('be a rememberable with "foo" cookie domain') }
    end
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

    context "when a model doesn't match given options" do
      before do
        @matcher = subject.class.new(:remember_for => 2.weeks, :cookie_domain => 'bar')
        @matcher.matches?(User)
      end

      specify { @matcher.failure_message_for_should.should match('User to be rememberable with options (.+), got (.+)') }
    end
  end
end

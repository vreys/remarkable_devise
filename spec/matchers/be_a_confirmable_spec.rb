require 'spec_helper'

describe Remarkable::Devise::Matchers::BeAConfirmableMatcher do
  before do
    @valid_columns = ['confirmation_token', 'confirmed_at', 'confirmation_sent_at']

    User.stubs(:column_names).returns(@valid_columns)
  end

  context "inclusion of Devise::Models::Confirmable" do
    it "should validate that model has :confirmable Devise model included" do
      subject.matches?(User).should be_true
    end

    it "should valodate that model has not :confirmable Devise model included" do
      subject.matches?(FooUser).should be_false
    end
  end

  context "columns validation" do
    context "confirmation_token column" do
      before do
        subject.stubs(:has_confirmed_at_column?).returns(true)
        subject.stubs(:has_confirmation_sent_at_column?).returns(true)
      end
      
      it "should validate that model has confirmation_token column" do
        subject.matches?(User).should be_true
      end

      it "should validate that model has no confirmaion_token column" do
        User.stubs(:column_names).returns(@valid_columns - ['confirmation_token'])

        subject.matches?(User).should be_false
      end
    end

    context "confirmed_at column" do
      before do
        subject.stubs(:has_confirmation_token_column?).returns(true)
        subject.stubs(:has_confirmation_sent_at_column?).returns(true)
      end

      it "should validate that model has confirmed_at column" do
        subject.matches?(User).should be_true
      end

      it "should validate that model has no confirmed_at column" do
        User.stubs(:column_names).returns(@valid_columns - ['confirmed_at'])
        
        subject.matches?(User).should be_false
      end
    end

    context "confirmation_sent_at" do
      before do
        subject.stubs(:has_confirmation_token_column?).returns(true)
        subject.stubs(:has_confirmed_at_column?).returns(true)
      end

      it "should validate that model has confirmation_sent_at column" do
        subject.matches?(User).should be_true
      end

      it "should validate that model has no confirmation_sent_at column" do
        User.stubs(:column_names).returns(@valid_columns - ['confirmation_sent_at'])
        
        subject.matches?(User).should be_false
      end
    end
  end

  describe "description" do
    before do
      @msg = subject.description
    end
    
    specify { @msg.should eql('be a confirmable') }
  end

  context "expectation message" do
    context "when Devise::Models::Confirmable not included" do
      before do
        subject.matches?(FooUser)
        
        @msg = subject.failure_message_for_should
      end
      
      specify { @msg.should match('to include Devise :confirmable model') }
    end

    context "when model has no confirmation_token column" do
      before do
        subject.stubs(:has_confirmation_token_column?).returns(false)
        subject.matches?(User)

        @msg = subject.failure_message_for_should
      end

      specify { @msg.should match('to have confirmation_token column') }
    end

    context "when model has no confirmed_at column" do
      before do
        subject.stubs(:has_confirmed_at_column?).returns(false)
        subject.matches?(User)

        @msg = subject.failure_message_for_should
      end

      specify { @msg.should match('to have confirmed_at column') }
    end

    context "when model has no confirmation_sent_at column" do
      before do
        subject.stubs(:has_confirmation_sent_at_column?).returns(false)
        subject.matches?(User)

        @msg = subject.failure_message_for_should
      end

      specify { @msg.should match('to have confirmation_sent_at column') }
    end
  end
end

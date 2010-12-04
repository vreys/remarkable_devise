require 'spec_helper'

describe Remarkable::Devise::Matchers::BeATrackableMatcher do
  before do
    @valid_columns = ['sign_in_count', 'current_sign_in_at', 'last_sign_in_at', 'current_sign_in_ip', 'last_sign_in_ip']
    User.stubs(:column_names).returns(@valid_columns)
  end

  context "requirement of Devise::Models::Trackable module inclusion" do
    it "should validate that model has Devise::Models::Trackable included" do
      subject.matches?(User).should be_true
    end

    it "should validate that model has no Devise::Models::Trackable included" do
      subject.matches?(FooUser).should be_false
    end

  end

  context "columns validation" do
    before do
      subject.stubs(:included?).returns(true)
    end

    describe "sign_in_count column" do
      before do
        subject.stubs(:has_current_sign_in_at_column?).returns(true)
        subject.stubs(:has_last_sign_in_at_column?).returns(true)
        subject.stubs(:has_current_sign_in_ip_column?).returns(true)
        subject.stubs(:has_last_sign_in_ip_column?).returns(true)
      end

      it "should validate that model has sign_in_count column" do
        subject.matches?(User).should be_true
      end

      it "should validate that model has no sign_in_count column" do
        User.stubs(:column_names).returns(@valid_columns - ['sign_in_count'])

        subject.matches?(User).should be_false
      end
    end

    describe "current_sign_in_at column" do
      before do
        subject.stubs(:has_sign_in_count_column?).returns(true)
        subject.stubs(:has_last_sign_in_at_column?).returns(true)
        subject.stubs(:has_current_sign_in_ip_column?).returns(true)
        subject.stubs(:has_last_sign_in_ip_column?).returns(true)
      end

      it "should validate that model has current_sign_in_at column" do
        subject.matches?(User).should be_true
      end

      it "should validate that model has no current_sign_in_at column" do
        User.stubs(:column_names).returns(@valid_columns - ['current_sign_in_at'])

        subject.matches?(User).should be_false
      end
    end

    describe "last_sign_in_at column" do
      before do
        subject.stubs(:has_sign_in_count_column?).returns(true)
        subject.stubs(:has_current_sign_in_at_column?).returns(true)
        subject.stubs(:has_current_sign_in_ip_column?).returns(true)
        subject.stubs(:has_last_sign_in_ip_column?).returns(true)
      end

      it "should validate that model has last_sign_in_at column" do
        subject.matches?(User).should be_true
      end

      it "should validate that model has no last_sign_in_at column" do
        User.stubs(:column_names).returns(@valid_columns - ['last_sign_in_at'])
        
        subject.matches?(User).should be_false
      end
    end

    describe "current_sign_in_ip column" do
      before do
        subject.stubs(:has_sign_in_count_column?).returns(true)
        subject.stubs(:has_current_sign_in_at_column?).returns(true)
        subject.stubs(:has_last_sign_in_at_column?).returns(true)
        subject.stubs(:has_last_sign_in_ip_column?).returns(true)
      end

      it "should validate that model has current_sign_in_ip column" do
        subject.matches?(User).should be_true
      end

      it "should validate that model has no current_sign_in_ip column" do
        User.stubs(:column_names).returns(@valid_columns - ['current_sign_in_ip'])

        subject.matches?(User).should be_false
      end
    end

    describe "last_sign_in_ip column" do
      before do
        subject.stubs(:has_sign_in_count_column?).returns(true)
        subject.stubs(:has_current_sign_in_at_column?).returns(true)
        subject.stubs(:has_last_sign_in_at_column?).returns(true)
        subject.stubs(:has_current_sign_in_ip_column?).returns(true)
      end

      it "should validate that model has last_sign_in_ip column" do
        subject.matches?(User).should be_true
      end

      it "should validate that model has no last_sign_in_ip column" do
        User.stubs(:column_names).returns(@valid_columns - ['last_sign_in_ip'])

        subject.matches?(User).should be_false
      end

    end
  end

  describe "description" do
    specify { subject.description.should eql('be a trackable') }
  end

  describe "expectation message" do
    context "when module Devise::Models::Trackable is not included" do
      before do
        subject.matches?(FooUser)
      end

      specify { subject.failure_message_for_should.should match('to include Devise :trackable model') }
    end

    context "when model has no sign_in_count column" do
      before do
        User.stubs(:column_names).returns(@valid_columns - ['sign_in_count'])

        subject.matches?(User)
      end

      specify { subject.failure_message_for_should.should match('to have sign_in_count column') }
    end

    context "when model has no current_sign_in_at column" do
      before do
        User.stubs(:column_names).returns(@valid_columns - ['current_sign_in_at'])

        subject.matches?(User)
      end

      specify { subject.failure_message_for_should.should match('to have current_sign_in_at column') }
    end

    context "when model has no last_sign_in_at column" do
      before do
        User.stubs(:column_names).returns(@valid_columns - ['last_sign_in_at'])

        subject.matches?(User)
      end

      specify { subject.failure_message_for_should.should match('to have last_sign_in_at column') }
    end

    context "when model has no current_sign_in_ip column" do
      before do
        User.stubs(:column_names).returns(@valid_columns - ['current_sign_in_ip'])

        subject.matches?(User)
      end

      specify { subject.failure_message_for_should.should match('to have current_sign_in_ip column') }
    end

    context "when model has no last_sign_in_ip column" do
      before do
        User.stubs(:column_names).returns(@valid_columns - ['last_sign_in_ip'])

        subject.matches?(User)
      end

      specify { subject.failure_message_for_should.should match('to have last_sign_in_ip column')}
    end
  end
end

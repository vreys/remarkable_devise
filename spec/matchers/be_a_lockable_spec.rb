require 'spec_helper'

describe Remarkable::Devise::Matchers::BeALockableMatcher do
  before do
    @valid_columns = %w{failed_attempts unlock_token locked_at}

    User.stubs(:column_names).returns(@valid_columns)
  end

  describe "validation of Devise::Models::Lockable module inclusion" do
    before do
      User.stubs(:lock_strategy).returns(:none)
      User.stubs(:unlock_strategy).returns(:none)
      User.stubs(:has_column?).returns(true)
    end

    it "should validate that a model has Devise::Models::Lockable module included" do
      subject.matches?(User).should be_true
    end

    it "should validate that a model hasn't Devise::Models::Lockable module included" do
      subject.matches?(FooUser).should be_false
    end
  end

  describe "columns validation" do
    before do
      subject.stubs(:included?).returns(true)
    end

    context "when :lock_strategy is :failed_attempts" do
      before do
        User.stubs(:lock_strategy).returns(:failed_attempts)
      end

      it "should validate that a model has :failed_attempts column" do
        subject.matches?(User).should be_true
      end

      it "should validate that a model hasn't :faild_attempts column" do
        User.stubs(:column_names).returns(@valid_columns - ['failed_attempts'])
        
        subject.matches?(User).should be_false
      end
    end

    context "when :lock_strategy is :none" do
      before do
        User.stubs(:lock_strategy).returns(:none)
      end

      context "when a model has :failed_attempts column" do
        it "should match" do
          subject.matches?(User).should be_true
        end
      end

      context "when a model hasn't :failed_attempts column" do
        before do
          User.stubs(:column_names).returns(@valid_columns - ['failed_attempts'])
        end

        it "should match" do
          subject.matches?(User).should be_true
        end
      end
    end

    context "when :unlock_strategy is :time" do
      before do
         User.stubs(:unlock_strategy).returns(:time)
      end

      it_should_behave_like "lockable matcher for unlock_strategy without unlock_token column needed"
    end

    context "when :unlock_strategy is :email" do
      before do
        User.stubs(:unlock_strategy).returns(:email)
      end

      it_should_behave_like "lockable matcher for unlock_strategy with unlock_token column needed"
    end

    context "when :unlock_strategy is :both" do
      before do
        User.stubs(:unlock_strategy).returns(:both)
      end

      it_should_behave_like "lockable matcher for unlock_strategy with unlock_token column needed"
    end

    context "when :unlock_strategy is :none" do
      before do
        User.stubs(:unlock_strategy).returns(:none)
      end

      it_should_behave_like "lockable matcher for unlock_strategy without unlock_token column needed"
    end

    describe :locked_at do
      context "when a model has locked_at column" do
        it "should match" do
          subject.matches?(User).should be_true
        end
      end

      context "when a model has no locked_at column" do
        before do
          User.stubs(:column_names).returns(@valid_columns - ['locked_at'])
        end

        it "should not match" do
          subject.matches?(User).should be_false
        end
      end
    end
  end

  describe "matching with options" do
    describe :maximum_attempts do
      context "when a model has expected :maximum_attepmts value" do
        it "should match" do
          subject.class.new(:maximum_attempts => 10).matches?(User).should be_true
        end
      end

      context "when a model hasn't expected :maximum_attempts value" do
        it "should not match" do
          subject.class.new(:maximum_attempts => 25).matches?(User).should be_false
        end
      end
    end

    describe :lock_strategy do
      context "when a model has expected :lock_strategy value" do
        it "should match" do
          subject.class.new(:lock_strategy => :none).matches?(User).should be_true
        end
      end

      context "when a model hasn't expected :lock_strategy value" do
        it "should not match" do
          subject.class.new(:lock_strategy => :failed_attempts).matches?(User).should be_false
        end
      end
    end

    describe :unlock_strategy do
      context "when a model has expected :unlock_strategy value" do
        it "should match" do
          subject.class.new(:unlock_strategy => :time).matches?(User).should be_true
        end
      end

      context "when a model hasn't expected :unlock_strategy value" do
        it "should not match" do
          subject.class.new(:unlock_strategy => :both).matches?(User).should be_false
        end
      end
    end

    describe :unlock_in do
      context "when a model has expected :unlock_in value" do
        it "should match" do
          subject.class.new(:unlock_in => 5.hours).matches?(User).should be_true
        end

      end

      context "when a model hasn't expected :unlock_in value" do
        it "should not match" do
          subject.class.new(:unlock_in => 1.hour).matches?(User).should be_false
        end
      end
    end
  end

  describe "description" do
    context "when matching without options" do
      specify { subject.description.should eql('be a lockable') }
    end

    context "when matching with :maximum_attempts option" do
      before do
        @matcher = subject.class.new(:maximum_attempts => 10)
        @matcher.matches?(User)
      end

      specify { @matcher.description.should eql("be a lockable with 10 maximum attempts") }
    end

    context "when matching with :lock_strategy option" do
      before do
        @matcher = subject.class.new(:lock_strategy => :time)
        @matcher.matches?(User)
      end

      specify { @matcher.description.should eql("be a lockable with :time lock strategy") }
    end

    context "when matching with :unlock_strategy option" do
      before do
        @matcher = subject.class.new(:unlock_strategy => :both)
        @matcher.matches?(User)
      end

      specify { @matcher.description.should eql("be a lockable with :both unlock strategy") }
    end

    context "when matching with :unlock_in option" do
      before do
        @matcher = subject.class.new(:unlock_in => 5.minutes)
        @matcher.matches?(User)
      end

      specify { @matcher.description.should eql("be a lockable with unlock in 300 seconds") }
    end
  end

  describe "failure message" do
    before do
      User.lock_strategy = :failed_attempts
      User.unlock_strategy = :both
    end

    context "when module Devise::Models::Lockable is not included" do
      before do
        subject.matches?(FooUser)
      end

      specify { subject.failure_message_for_should.should match("Foo user to have Devise :lockable model") }
    end

    context "when model doesn't have :failed_attempts column" do
      before do
        User.stubs(:column_names).returns(@valid_columns - ['failed_attempts'])

        subject.matches?(User)
      end

      specify { subject.failure_message_for_should.should match("User to have failed_attempts column") }
    end

    context "when model doesn't have :unlock_token column" do
      before do
        User.stubs(:column_names).returns(@valid_columns - ['unlock_token'])

        subject.matches?(User)
      end

      specify { subject.failure_message_for_should.should match("User to have unlock_token column") }
    end

    context "when model doesn't have :locked_at column" do
      before do
        User.stubs(:column_names).returns(@valid_columns - ['locked_at'])

        subject.matches?(User)
      end

      specify { subject.failure_message_for_should.should match("User to have locked_at column") }
    end
  end
end

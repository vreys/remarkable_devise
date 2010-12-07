require 'spec_helper'

describe Remarkable::Devise::Matchers::BeATimeoutableMatcher do
  describe "validate inclusion of Devise::Models::Timeoutable" do
    it "should validate that model is include Devise::Models::Timeoutable module" do
      subject.matches?(User).should be_true
    end

    it "should validate that model isn't include Devise::Models::Timeoutable module" do
      subject.matches?(FooUser).should be_false
    end
  end

  describe "options validation" do
    describe :timeout_in do
      it "should validate that model is timeoutable with proper :timeout_in option" do
        subject.class.new(:timeout_in => 15.minutes).matches?(User).should be_true
      end

      it "should validate that model is timeoutable without proper :timeout_in option" do
        subject.class.new(:timeout_in => 5.minutes).matches?(User).should be_false
      end
    end
  end

  describe "description" do
    context "when matching without options" do
      specify { subject.description.should eql("be a timeoutable") }
    end

    context "when matching with :timeout_in option" do
      before do
        @matcher = subject.class.new(:timeout_in => 15.minutes)
        @matcher.matches?(User)
      end

      specify { @matcher.description.should eql("be a timeoutable within 900 seconds") }
    end
  end

  describe "expectation message" do
    context "when model hasn't Devise::Models::Timeoutable module included" do
      before do
        subject.matches?(FooUser)
      end

      specify { subject.failure_message_for_should.should match("Foo user to include Devise :timeoutable model") }
    end
    
    context "when model doesn't match options" do
      before do
        @matcher = subject.class.new(:timeout_in => 5.minutes)
        @matcher.matches?(User)
      end

      specify { @matcher.failure_message_for_should.should match("User to be a timeoutable with options (.+), got (.+)") }
    end
  end
end

require "spec_helper"

describe Remarkable::Devise::Matchers::BeARegisterableMatcher do
  describe "validate inclusion of Devise::Models::Registerable module" do
    it "should validate that a model has Devise::Models::Registerable included" do
      subject.matches?(User).should be_true
    end

    it "should validate that a model hasn't Devise::Models::Registerable included" do
      subject.matches?(FooUser).should be_false
    end
  end

  describe "description" do
    specify { subject.description.should eql("be a registerable") }
  end

  describe "failure message" do
    context "when a model hasn't Devise::Models::Registerable module included" do
      before do
        subject.matches?(FooUser)
      end

      specify { subject.failure_message_for_should.should match("Foo user to have Devise :registerable model") }
    end
  end
end

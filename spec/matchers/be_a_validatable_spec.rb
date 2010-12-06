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

  context "description" do
    specify { subject.description.should eql('be a validatable') }
  end

  context "expectation message" do
    before do
      subject.matches?(FooUser)
    end

    specify { subject.failure_message_for_should.should match('to include Devise :validatable model')}
  end
end

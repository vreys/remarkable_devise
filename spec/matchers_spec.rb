require 'spec_helper'

describe Remarkable::Devise::Matchers do
  describe "#be_a_database_authenticatable" do
    it "should return Remarkable::Devise::Matchers::BeADatabaseAuthenticatableMatcher" do
      be_a_database_authenticatable.should be_an_instance_of(Remarkable::Devise::Matchers::BeADatabaseAuthenticatableMatcher)
    end
  end

  describe "#be_a_confirmable" do
    it "should return Remarkable::Devise::Matchers::BeAConfirmableMatcher" do
      be_a_confirmable.should be_an_instance_of(Remarkable::Devise::Matchers::BeAConfirmableMatcher)
    end
  end

  describe "#be_a_recoverable" do
    it "should return Remarkable::Devise::Matchers::BeARecoverableMatcher" do
      be_a_recoverable.should be_an_instance_of(Remarkable::Devise::Matchers::BeARecoverableMatcher)
    end
  end
end

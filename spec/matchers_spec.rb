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
  
  describe "#be_a_rememberable" do
    it "should return Remarkable::Devise::Matchers::BeARememberableMatcher" do
      be_a_rememberable.should be_an_instance_of(Remarkable::Devise::Matchers::BeARememberableMatcher)
    end
  end

  describe "#be_a_trackable" do
    it "should return Remarkable::Devise::Matchers::BeATrackableMatcher" do
      be_a_trackable.should be_an_instance_of(Remarkable::Devise::Matchers::BeATrackableMatcher)
    end
  end
end
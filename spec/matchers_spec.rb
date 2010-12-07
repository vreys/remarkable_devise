require 'spec_helper'

describe Remarkable::Devise::Matchers do
  describe "#be_a_database_authenticatable" do
    it "should return Remarkable::Devise::Matchers::BeADatabaseAuthenticatableMatcher" do
      be_a_database_authenticatable(:stretches => 10).should be_an_instance_of(Remarkable::Devise::Matchers::BeADatabaseAuthenticatableMatcher)
    end
  end

  describe "#be_a_confirmable" do
    it "should return Remarkable::Devise::Matchers::BeAConfirmableMatcher" do
      be_a_confirmable(:confirm_within => 2.days).should be_an_instance_of(Remarkable::Devise::Matchers::BeAConfirmableMatcher)
    end
  end

  describe "#be_a_recoverable" do
    it "should return Remarkable::Devise::Matchers::BeARecoverableMatcher" do
      be_a_recoverable.should be_an_instance_of(Remarkable::Devise::Matchers::BeARecoverableMatcher)
    end
  end
  
  describe "#be_a_rememberable" do
    it "should return Remarkable::Devise::Matchers::BeARememberableMatcher" do
      be_a_rememberable(:remember_for => 2.weeks).should be_an_instance_of(Remarkable::Devise::Matchers::BeARememberableMatcher)
    end
  end

  describe "#be_a_trackable" do
    it "should return Remarkable::Devise::Matchers::BeATrackableMatcher" do
      be_a_trackable.should be_an_instance_of(Remarkable::Devise::Matchers::BeATrackableMatcher)
    end
  end

  describe "#be_a_validatable" do
    it "should return Remarkable::Devise::Matchers::BeAValidatableMatcher" do
      be_a_validatable(:password_length => 8..20).should be_an_instance_of(Remarkable::Devise::Matchers::BeAValidatableMatcher)
    end
  end

  describe "#be_a_token_authenticatable" do
    it "should return Remarkable::Devise::Matchers::BeATokenAuthenticatableMatcher" do
      be_a_token_authenticatable(:token_authentication_key => :auth_token).should be_an_instance_of(Remarkable::Devise::Matchers::BeATokenAuthenticatableMatcher)
    end
  end
end

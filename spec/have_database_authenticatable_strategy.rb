require 'spec_helper'

class User < ActiveRecord::Base
  devise :database_authenticatable
end

class Admin < ActiveRecord::Base

end

shared_examples_for "HaveDatabaseAuthenticatableModuleMatcher" do
  it "should validate that model has :database_authenticatable module" do
    subject.matches?(User).should be_true
  end

  it "should validate that model has no :database_authenticatable module" do
    subject.matches?(Admin).should be_false
  end
end

describe Remarkable::Devise do
  describe "#have_database_authenticatable_module" do
    subject { have_database_authenticatable_module }
    it_should_behave_like "HaveDatabaseAuthenticatableModuleMatcher"
  end

  describe "#be_a_database_authenticatable" do
    subject { be_a_database_authenticatable }
    it_should_behave_like "HaveDatabaseAuthenticatableModuleMatcher"
  end
end

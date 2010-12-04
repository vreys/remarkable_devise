require 'spec_helper'

class User < ActiveRecord::Base
  devise :database_authenticatable
end

class FooUser < ActiveRecord::Base
end

describe Remarkable::Devise::Matchers::BeADatabaseAuthenticatableMatcher do
  before do
    @matcher_class = Remarkable::Devise::Matchers::BeADatabaseAuthenticatableMatcher
    @valid_columns = ['email', 'encrypted_password', 'password_salt']

    User.stubs(:column_names).returns(@valid_columns)
  end

  subject { be_a_database_authenticatable }

  context "inclusion of Devise::Models::DatabaseAuthenticatable" do
    it "should validate that model has :database_authenticatable module" do
      subject.matches?(User).should be_true
    end

    it "should validate that model has no :database_authenticatable module" do
       subject.matches?(FooUser).should be_false
    end
  end
  
  context "columns validation" do
    context "email column" do
      before do
        @matcher_class.any_instance.stubs(:has_encrypted_password_column?).returns(true)
        @matcher_class.any_instance.stubs(:has_password_salt_column?).returns(true)
      end

      it "should validate that model has email column" do
        subject.matches?(User).should be_true
      end

      it "should validate that model has no email column" do
        User.stubs(:column_names).returns(@valid_columns - ['email'])
        
        subject.matches?(User).should be_false
      end
    end

    context "encrypted_password column" do
      before do
        @matcher_class.any_instance.stubs(:has_email_column?).returns(true)
        @matcher_class.any_instance.stubs(:has_password_salt_column?).returns(true)
      end

      it "should validate that model has encrypted_password column" do
        subject.matches?(User).should be_true
      end

      it "should validate that model has no encrypted_password column" do
        User.stubs(:column_names).returns(@valid_columns - ['encrypted_password'])
        
        subject.matches?(User).should be_false
      end
    end

    context "password_salt column" do
      before do
        @matcher_class.any_instance.stubs(:has_email_column?).returns(true)
        @matcher_class.any_instance.stubs(:has_encrypted_password_column?).returns(true)
      end

      it "should validate that model has password_salt column" do
        subject.matches?(User).should be_true
      end

      it "should validate that model has no password_salt column" do
        User.stubs(:column_names).returns(@valid_columns - ['password_salt'])
        
        subject.matches?(User).should be_false
      end
    end
  end

  describe "messages" do
    before do
      @yml = Remarkable.t('remarkable.devise.be_a_database_authenticatable')
    end

    subject { @yml }

    it { should include(:description) }

    context "expectations" do
      subject { @yml[:expectations] }

      it { should include(:has_email_column) }
      it { should include(:has_encrypted_password_column) }
      it { should include(:has_password_salt_column) }
    end
  end
end

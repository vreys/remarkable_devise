require 'spec_helper'

describe User do
  before do
    User.stubs(:column_names).returns(%w{email encrypted_password password_salt confirmation_token confirmed_at confirmation_sent_at remember_token remember_created_at locked_at authentication_token sign_in_count current_sign_in_at last_sign_in_at current_sign_in_ip last_sign_in_ip reset_password_token failed_attempts unlock_token})
  end
    
  it { should be_a_confirmable(:confirm_within => 2.days) }
  it { should be_a_rememberable(:remember_for => 2.weeks) }
  it { should be_a_validatable(:password_length => 8..20) }
  it { should be_a_timeoutable(:timeout_in => 15.minutes) }
  it { should be_a_lockable(:lock_strategy => :failed_attempts, :unlock_strategy => :both) }
  it { should be_a_token_authenticatable }
  it { should be_a_trackable }
  it { should be_a_registerable }
  it { should be_a_recoverable }
  
  should_be_a_database_authenticatable do |o|
    o.stretches = 15
    o.encryptor = :clearance_sha1
    o.params_authenticatable = false
    o.authentication_keys = [:email, :login]
  end
end

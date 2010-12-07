shared_examples_for "lockable matcher for unlock_strategy with unlock_token column needed" do
  context "when a model has :unlock_token column" do
    it "should match" do
      subject.matches?(User).should be_true
    end
  end

  context "when a model has no :unlock_token column" do
    before do
      User.stubs(:column_names).returns(@valid_columns - ['unlock_token'])
    end

    it "should not match" do
      subject.matches?(User).should be_false
    end
  end
end

shared_examples_for "lockable matcher for unlock_strategy without unlock_token column needed" do
  context "when a model has :unlock_token column" do
    it "should match" do
      subject.matches?(User).should be_true
    end
  end

  context "when a model has no :unlock_token column" do
    before do
      User.stubs(:column_names).returns(@valid_columns - ['unlock_token'])
    end

    it "should match" do
      subject.matches?(User).should be_true
    end
  end
end

shared_examples_for "any Devise authentication model" do
  describe "validation of Devise::Models::Authenticatable module inclusion" do
    context "when a model has module included" do
      it "should match" do
        subject.matches?(User).should be_true
      end
    end

    context "when a model hasn't module included" do
      it "should not match" do
        subject.matches?(FooUser).should be_false
      end
    end
  end

  describe "options validation" do
    describe :authentication_keys do
      context "when a model has expected :authentication_keys value" do
        it "should match" do
          subject.class.new(:authentication_keys => [:email, :login]).matches?(User).should be_true
        end
      end

      context "when a model hasn't expected :authentication_keys value" do
        it "should not match" do
          subject.class.new(:authentication_keys => [:login]).matches?(User).should be_false
        end
      end
    end

    describe :params_authenticatable do
      context "when a model has expected :params_authenticatable value" do
        it "should match" do
          subject.class.new(:params_authenticatable => false).matches?(User).should be_true
        end
      end

      context "when a model hasn't expected :params_authenticatable value" do
        it "should not match" do
          subject.class.new(:params_authenticatable => true).matches?(User).should be_false
        end
      end
    end
  end

  describe "description" do
    context "when matching with :authentication_keys option" do
      before do
        @matcher = subject.class.new(:authentication_keys => [:email, :login])
        @matcher.matches?(User)
      end

      specify { @matcher.description.should match(/with \[\:email, \:login\] as authentication keys/) }
    end

    context "when matching with :params_authenticatable option" do
      context "positive" do
        before do
          @matcher = subject.class.new(:params_authenticatable => true)
          @matcher.matches?(User)
        end

        specify { @matcher.description.should match(/with params authenticatable/) }
      end

      context "negative" do
        before do
          @matcher = subject.class.new(:params_authenticatable => false)
          @matcher.matches?(User)
        end

        specify { @matcher.description.should match(/without params authenticatable/) }
      end
    end
  end

  describe "failure message" do
    context "when Devise::Models::Authenticatable module isn't included" do
      before do
        subject.matches?(FooUser)
      end

      specify { subject.failure_message_for_should.should match("Foo user to have Devise :authenticatable model") }
    end
  end
end

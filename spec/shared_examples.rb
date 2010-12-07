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

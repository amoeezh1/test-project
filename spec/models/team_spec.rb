require 'rails_helper'

RSpec.describe Team, type: :model do
  it { should have_many(:members) }


  it "is checking if name is given then it is valid or not" do
    t= Team.new(name: "moeez")
    expect(t).to be_valid
  end
  it "is checking if name is not given then it is valid or not" do
    t= Team.new(name: nil)
    expect(t).to_not be_valid
  end
end

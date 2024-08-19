require 'rails_helper'

RSpec.describe Project, type: :model do
   it { should have_and_belong_to_many(:members).join_table('members_projects_joins') }
   it "is checking if wrong datatype is given" do
    m=Project.new(name: 1)
    expect(m).to_not be_valid
  end

end

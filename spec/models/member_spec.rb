# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Member, type: :model do
  it { should belong_to(:team) }
  it { should have_and_belong_to_many(:projects) }

  team = Team.new(name: 'team')
  it 'is checking if firstname and lastname given is valid or not' do
    m = Member.new(first_name: 'moeez', last_name: 'hassan', team: team)
    expect(m).to be_valid
  end
  it 'is checking if firstname and lastname not given is valid or not' do
    m = Member.new(first_name: nil, last_name: nil, team: team)
    expect(m).to_not be_valid
  end
  it 'is checking if firstname and lastname wrong datatype is given' do
    m = Member.new(first_name: 11, last_name: 22, state: 3, city: 4, country: 6, team: team)
    expect(m).to_not be_valid
  end
end

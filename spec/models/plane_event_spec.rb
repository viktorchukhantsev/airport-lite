# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PlaneEvent, type: :model do
  let(:plane) { FactoryBot.build(:plane) }

  it 'is valid with valid attributes' do
    expect(plane.events.build(state: plane.current_state)).to be_valid
  end

  it 'is not valid without a plane_id' do
    expect(PlaneEvent.new(state: 'takeoff')).to be_invalid
  end

  it 'is not valid without a state' do
    expect(PlaneEvent.new(plane_id: 1)).to be_invalid
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Plane, type: :model do
  it 'is valid with valid attributes' do
    plane = FactoryBot.create(:plane)
    expect(plane).to be_valid
  end

  it 'is not valid without a code' do
    expect(Plane.new).to be_invalid
  end

  it 'is change status from hangar to awaiting_takeoff' do
    plane = FactoryBot.create(:plane)
    plane.awaiting_takeoff
    expect(plane.current_state).to eq('awaiting_takeoff')
  end

  it 'is change status from awaiting_takeoff to takeoff' do
    plane = FactoryBot.create(:plane)
    plane.awaiting_takeoff
    plane.takeoff
    expect(plane.current_state).to eq('takeoff')
  end

  it 'is not change status from hangar to takeoff' do
    plane = FactoryBot.create(:plane)
    plane.takeoff
    expect(plane.current_state).not_to eq('takeoff')
  end

  it 'is change status from takeoff to flew_away' do
    plane = FactoryBot.create(:plane)
    plane.awaiting_takeoff
    plane.takeoff
    plane.flew_away
    expect(plane.current_state).to eq('flew_away')
  end

  it 'is change status from hangar to flew_away' do
    plane = FactoryBot.create(:plane)
    plane.flew_away
    expect(plane.current_state).not_to eq('flew_away')
  end
end

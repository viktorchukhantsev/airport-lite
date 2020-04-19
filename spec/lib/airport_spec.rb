# frozen_string_literal: true

require_relative '../../lib/airport'

RSpec.describe Airport do
  context 'check thread' do
    it 'init new runway' do
      mock_thread = OpenStruct.new(name: 'Useless Thread')
      expect(Thread).to receive(:new).and_return(mock_thread)
      Airport::Runway.start
    end
  end

  context 'check states' do
    let(:plane) { FactoryBot.create(:plane) }

    before(:all) { Airport.queue = Queue.new }

    it 'should pass plane through states' do
      thread = Airport::Runway.start.thread
      Airport.enqueue(plane)
      expect(plane.current_state).to eq('awaiting_takeoff')
      Airport::Runway.stop(thread)
    end

    it 'should flew away plane' do
      thread = Airport::Runway.start.thread
      Airport.enqueue(plane)
      sleep(30.seconds)
      expect(plane.current_state).to eq('flew_away')
      Airport::Runway.stop(thread)
    end
  end
end

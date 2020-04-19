# frozen_string_literal: true

require_relative '../../lib/airport'

Airport.queue = Queue.new
Airport::Runway.start

# frozen_string_literal: true

# Airport
module Airport
  def self.queue
    @queue
  end

  def self.queue=(queue)
    @queue = queue
  end

  def self.enqueue(plane)
    plane.awaiting_takeoff
    queue.push(plane)
  end

  # airport runway
  class Runway
    attr_accessor :thread

    def initialize(name)
      @thread = Thread.new { airplane_run }
      @thread.name = name
    end

    def airplane_run
      loop do
        plane = Airport.queue.pop
        plane.takeoff
        sleep(rand(10..16).seconds)
        plane.flew_away
      rescue ActiveRecord::Error => e
        Rails.logger.error(e)
      end
    end

    def self.start
      new('Runway')
    end

    def self.stop(thread)
      Thread.kill(thread)
    end
  end
end

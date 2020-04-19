# frozen_string_literal: true

# planes dashboard controller
class PlanesController < ApplicationController
  def index
    @planes = Plane.includes(:events).all
    @events = PlaneEvent.includes(:plane).order(created_at: :desc).all
  end

  def take_off
    plane = Plane.find(params[:id])
    Airport.enqueue(plane)
    redirect_to root_url, notice: "Plane #{plane.code} was enqueued to takeoff."
  rescue ActiveRecord::RecordNotFound
    Rails.logger.error('Somebody try to enqueue wrong plane.')
    redirect_to root_url
  end

  def enqueue
    Plane.where(id: params[:planes_ids]).find_in_batches(batch_size: 1) { |plane_batch| Airport.enqueue(plane_batch.first) }
    redirect_to root_url, notice: 'Planes was enqueued to takeoff.'
  rescue ActiveRecord::RecordNotFound
    Rails.logger.error('Somebody try to enqueue wrong planes.')
    redirect_to root_url
  end
end

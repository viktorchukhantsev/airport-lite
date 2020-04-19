# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/planes', type: :request do
  describe 'GET /index' do
    let(:plane) { FactoryBot.create(:plane) }

    it 'renders a successful response' do
      get planes_path
      expect(response).to be_successful
    end

    it 'should assign and render planes' do
      plane
      get planes_path
      expect(response.body).to include(plane.code)
    end

    it 'should assign and render events' do
      plane.awaiting_takeoff
      get planes_path
      expect(response.body).to include(plane.current_state.titleize)
    end

    it 'contains Planes and Journal' do
      get planes_path
      expect(response.body).to include('Planes')
      expect(response.body).to include('Journal')
    end
  end

  describe 'GET /take_off' do
    let(:plane) { FactoryBot.create(:plane) }

    context 'with valid parameters' do
      it 'redirects to the root' do
        get take_off_plane_path(plane)
        expect(response).to redirect_to(root_url)
      end
    end

    context 'with invalid parameters' do
      it 'redirects to the root' do
        get take_off_plane_path(id: 123123)
        expect(response).to redirect_to(root_url)
      end
    end
  end

  describe 'POST /enqueue' do
    let(:plane) { FactoryBot.create(:plane) }

    let(:valid_attributes) {
      {
        planes_ids: [plane.id]
      }
    }

    let(:invalid_attributes) {
      {
        some_attr: ''
      }
    }

    context 'with valid parameters' do
      it 'redirects to the root' do
        post enqueue_planes_path(valid_attributes)
        expect(response).to redirect_to(root_url)
      end
    end

    context 'with invalid parameters' do
      it 'redirects to the root' do
        post enqueue_planes_path(invalid_attributes)
        expect(response).to redirect_to(root_url)
      end
    end
  end
end

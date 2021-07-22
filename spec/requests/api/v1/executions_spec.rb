require 'rails_helper'

RSpec.describe 'Api::V1::Executions', type: :request do
  before { sign_in(user) }

  let(:user) { create(:user) }

  describe 'GET #show' do
    subject { get executions_api_v1_movie_path(movie) }

    let(:movie) { create(:movie) }
    let(:player) { create(:player, user: user, movie: movie, end_date: nil) }

    it 'returns http_status ok' do
      subject

      expect(response).to have_http_status(:ok)
    end

    it 'returns the player serialized' do
      player
      subject

      expect(json).to eq(serialize(player))
    end
  end

  describe 'PUT #update' do
    let!(:player) { create(:player, user: user, movie: movie) }
    let(:movie) { create(:movie) }

    context 'when successfully' do
      subject do
        put executions_api_v1_movie_path(movie), params: {
          execution: {
            elapsed_time: time1,
            end_date: time2
          }
        }
      end

      let(:time1) { Time.current + 5.minutes }
      let(:time2) { Time.current + 10.minutes }

      it 'has http_status ok' do
        subject

        expect(response).to have_http_status(:ok)
      end

      it 'updates the player' do
        subject
        player.reload

        expect(player.elapsed_time.strftime('%H:%M:%S')).to eq(time1.strftime('%H:%M:%S'))
        expect(time_formatter(player.end_date)).to eq(time_formatter(time2))
      end

      it 'renders the player serialized' do
        subject
        player.reload

        expect(json).to eq(serialize(player))
      end
    end

    # context 'when failed' do
    #   subject do
    #     put executions_api_v1_movie_path(movie), params: {
    #       execution: {
    #         elapsed_time: nil,
    #         end_date: nil
    #       }
    #     }
    #   end

    #   it 'has http_status unprocessable_entity' do
    #     subject

    #     expect(response).to have_http_status(:unprocessable_entity)
    #   end

    #   it 'doesn\'t update the player' do
    #     subject
    #     player.reload

    #     expect(player.elapsed_time).not_to be_nil
    #     expect(end_date).not_to be_nil
    #   end

    #   it 'renders the errors messages' do
    #     subject

    #     expect(json[:errors]).to include('ElapsedTime can\'t be nil')
    #   end
    # end
  end
end

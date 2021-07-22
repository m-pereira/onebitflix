require 'rails_helper'

RSpec.describe Player, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:movie) }
    it { is_expected.to belong_to(:user) }
  end

  describe 'callbacks' do
    describe 'set_start_date' do
      let(:player) { build(:player, start_date: nil) }

      it 'sets the start_date even if it was not setted' do
        player.save

        expect(I18n.l(player.start_date)).to eq(I18n.l(Time.current))
      end
    end
  end
end

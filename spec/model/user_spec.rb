# frozen_string_literal: true

RSpec.describe User, type: :model do
  let!(:user) { create :user }

  describe 'Creation' do
    let!(:user) { build :user }

    it 'Fabrics' do
      expect(user).to be_valid
    end
  end
end

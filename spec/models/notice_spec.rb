require 'rails_helper'

RSpec.describe Notice, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:category) }
    it { is_expected.to belong_to(:user) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:text) }
  end
end

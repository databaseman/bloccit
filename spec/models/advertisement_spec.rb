require 'rails_helper'

RSpec.describe Advertisement, type: :model do
  let(:my_advertisement) { Advertisement.create!(title: 'New Post Title', body: 'New Post Body', price: 0) }

  describe 'attributes' do
    it 'has title, body, and price attributes' do
      expect(my_advertisement).to have_attributes(title: 'New Post Title', body: 'New Post Body', price: 0)
    end
  end
end

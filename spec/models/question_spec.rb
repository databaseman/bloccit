require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:my_question) { Question.create!(title: 'New Post Title', body: 'New Post Body', resolved: false) }

  describe 'attributes' do
    it 'has title, body, and resolved attributes' do
      expect(my_question).to have_attributes(title: 'New Post Title', body: 'New Post Body', resolved: false)
    end
  end
end

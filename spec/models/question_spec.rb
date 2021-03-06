require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_length_of(:title).is_at_least(10).is_at_most(100) }
  it { should have_many(:answers).dependent(:destroy) }
end

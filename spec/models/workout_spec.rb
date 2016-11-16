require 'rails_helper'

RSpec.describe Workout do
  it { should belong_to :user }
  it { should have_many :exercises }
end
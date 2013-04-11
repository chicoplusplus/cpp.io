require 'test_helper'

describe ApplicationHelper do
  it 'should round up' do
    round(0.6).must_equal 1
  end

  it 'should round up to nearest 10' do
    round(6, 10).must_equal 10
  end
end


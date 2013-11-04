require 'spec_helper'

describe Task do
  it { should have_many(:notes).dependent(:destroy) }
end

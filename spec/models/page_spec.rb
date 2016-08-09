require 'rails_helper'

describe Page, type: :model do
  it { should serialize(:h1) }
  it { should serialize(:h2) }
  it { should serialize(:h3) }
  it { should serialize(:links) }
end

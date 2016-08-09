FactoryGirl.define do
  factory :page do
    url { FFaker::Internet.http_url }
    h1  { FFaker::HipsterIpsum.words } 
    h2  { FFaker::HipsterIpsum.words }
    h3  { FFaker::HipsterIpsum.words }
    links [FFaker::Internet.http_url, FFaker::Internet.http_url, FFaker::Internet.http_url]
  end
end
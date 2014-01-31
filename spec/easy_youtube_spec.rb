require 'spec_helper'

describe EasyYouTube do
  describe "the valid_id? method" do
  	it "should return false for a nil id" do
  		EasyYouTube.valid_id?(nil).should be_false
  	end
  	it "should return false with an invalid id" do
  		Net::HTTP.stub(:get).and_return("Invalid id")
  		EasyYouTube.valid_id?('L57s0Q2qgYg').should be_false
  		Net::HTTP.stub(:get).and_return("Video not found")
  		EasyYouTube.valid_id?('L57s0Q2qgYg').should be_false
  	end
  	it "should return true with a valid video" do
  		Net::HTTP.stub(:get).and_return("<?xml version='1.0' encoding='UTF-8'?><entry ... xmlns:media='http://search.yahoo.com/mrss/'")
  		EasyYouTube.valid_id?('L57s0Q2qgYg').should be_true
  	end
  end

  describe "the extract_video_id method" do
    it "should return nil if the url is not valid" do
      EasyYouTube.extract_video_id("not a valid url").should be_nil
      EasyYouTube.extract_video_id("github.com/?id=L57s0Q2qgYg").should be_nil
    end

  end
end
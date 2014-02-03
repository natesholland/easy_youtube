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
    it "should return the proper id from the basic url" do
      EasyYouTube.extract_video_id("http://www.youtube.com/watch?v=L57s0Q2qgYg").should == "L57s0Q2qgYg"
      EasyYouTube.extract_video_id("https://www.youtube.com/watch?v=L57s0Q2qgYg").should == "L57s0Q2qgYg"
      EasyYouTube.extract_video_id("www.youtube.com/watch?v=L57s0Q2qgYg").should == "L57s0Q2qgYg"
      EasyYouTube.extract_video_id("http://www.youtube.com/watch?feature=player_embedded&v=L57s0Q2qgYg").should == "L57s0Q2qgYg"
      EasyYouTube.extract_video_id("http://youtu.be/L57s0Q2qgYg").should == "L57s0Q2qgYg"

    end
  end

  describe "the youtube_embeded_url method" do
    it "should construct valid embeded urls" do
      EasyYouTube.youtube_embed_url("www.youtube.com/watch?v=L57s0Q2qgYg").should == 
      %(<iframe width="420" height="315" src="http://www.youtube.com/embed/L57s0Q2qgYg" frameborder="0" allowfullscreen></iframe>)

      EasyYouTube.youtube_embed_url("www.youtube.com/watch?v=L57s0Q2qgYg", 720, 420).should == 
      %(<iframe width="720" height="420" src="http://www.youtube.com/embed/L57s0Q2qgYg" frameborder="0" allowfullscreen></iframe>)
    end
  end

  describe "the youtube_regular_url method" do
    it "should construct valid urls" do
      EasyYouTube.youtube_regular_url("http://www.youtube.com/watch?v=L57s0Q2qgYg").should == "http://www.youtube.com/watch?v=L57s0Q2qgYg"
    end
  end

  describe "the youtube_shortened_url method" do
    it "should construct valid shortened url" do
      EasyYouTube.youtube_shortened_url("http://www.youtube.com/watch?v=L57s0Q2qgYg").should == "http://youtu.be/L57s0Q2qgYg"
    end
  end

  describe "the invalid_characters method" do
    it "should return false for all valid character" do
      EasyYouTube.has_invalid_chars?("ABCDEFGHIJKLMNOPQRSTUVWXYZ").should be_false
      EasyYouTube.has_invalid_chars?("abcdefghijklmnopqrstuvwxyz").should be_false
      EasyYouTube.has_invalid_chars?("0123456789").should be_false
      EasyYouTube.has_invalid_chars?("./?=").should be_false
    end

    it "should return true for invalid characters" do
      EasyYouTube.has_invalid_chars?("ABCDEFGHIJKLMNOPQRSTUVWXYZ#").should be_true
      EasyYouTube.has_invalid_chars?("abcd^").should be_true
    end
  end

  describe "the valid_youtube_url method" do 
    it "should return false for random addresses, invalid_characters, and nil calls" do
      Net::HTTP.stub(:get).and_return("This is valid")
      EasyYouTube.valid_youtube_url?("abc123").should be_false
      EasyYouTube.valid_youtube_url?("http://www.youtube.com/watch?v=L57s0#2qgYg").should be_false
      EasyYouTube.valid_youtube_url?("https://github.com/natesholland/easy_youtube").should be_false
      EasyYouTube.valid_youtube_url?("").should be_false
    end

    it "should return true for legitimate urls" do
      Net::HTTP.stub(:get).and_return("This is valid")
      EasyYouTube.valid_youtube_url?("http://www.youtube.com/watch?v=L57s02qgYg").should be_true
      EasyYouTube.valid_youtube_url?("http://www.youtube.com/watch?feature=player_embedded&v=L57s0Q2qgYg").should be_true
      EasyYouTube.valid_youtube_url?("http://youtu.be/L57s0Q2qgYgr").should be_true
    end
  end
end
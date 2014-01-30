require 'spec_helper'

describe EasyYouTube do
  describe "the valid_id? method" do
  	it "should return false for a nil id" do
  		EasyYouTube.valid_id?(nil).should be_false
  	end
  end
end
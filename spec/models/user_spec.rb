require 'spec_helper'

describe User do

  before do
    @auth = {
    'provider' => 'linked_in',
    'uid' => '123545',
    'user_info' => {'name' => "Ben Franklin"},
    'credentials' => {'token' => 'abc123', 'secret' => 'xyz987'}
    }
  end

  describe "Add LinkedIn Info" do
    before do
      stub_request(:get, "https://api.linkedin.com/v1/people/~:(id,certifications,educations,positions,picture-url,skills,summary)").
        to_return(:status => 200, :body => fixture("linked_in_profile.json"), :headers => {})
    end

    context "#add_linked_in_skills" do
      it "should add the linked in info to the user" do
        @client = User.new
        test = @client.add_linked_in_skills(@auth)
        test.should == "Ruby on Rails,ESRI,GIS"
      end
    end

    context "#add_linked_in_id" do
      it "should add the linked in id to the user" do
        @client = User.new
        user_id = @client.add_linked_in_id(@auth)
        user_id.should == "abc123"
      end
    end

  end

end

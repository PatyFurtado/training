require 'rails_helper'
require './app/controllers/api/v1/modulos_controller'

RSpec.describe Api::V1::ModulosController, type: :api do

  before do
    @user = User.create({:email => "paty@knap.com", :name => "Patricia", :birthday => "1989-09-22", :profile => User::PROFILE_STUDENT, :password => "password", :password_confirmation => "password"})
    post "auth_user", {:email => "paty@knap.com", :password => "password"}
    post_json = JSON.parse last_response.body
    header "Authorization", "Bearer #{post_json["auth_token"]}"
  end

  it "should return true if the student watched all videos" do
    course = FactoryGirl.create(:course, :available => true)
    modulo = FactoryGirl.create(:modulo, :course_id => course.id)
    video_1 = FactoryGirl.create(:video, :modulo_id => modulo.id)
    video_2 = FactoryGirl.create(:video, :modulo_id => modulo.id)
    FactoryGirl.create(:position, :video_id => video_1.id, :user_id => @user.id, :watched => true)
    FactoryGirl.create(:position, :video_id => video_2.id, :user_id => @user.id, :watched => true)
    get "api/v1/courses/#{course.id}/modulos.json"

    post_json = JSON.parse last_response.body
    expect(post_json["modulos"][0]["watched_videos"]).to be true
  end

  it "should return false if the student not watched all videos" do
    course = FactoryGirl.create(:course, :available => true)
    modulo = FactoryGirl.create(:modulo, :course_id => course.id)
    video_1 = FactoryGirl.create(:video, :modulo_id => modulo.id)
    video_2 = FactoryGirl.create(:video, :modulo_id => modulo.id)
    FactoryGirl.create(:position, :video_id => video_1.id, :user_id => @user.id, :watched => true)
    get "api/v1/courses/#{course.id}/modulos.json"

    post_json = JSON.parse last_response.body
    expect(post_json["modulos"][0]["watched_videos"]).to be false
  end
end

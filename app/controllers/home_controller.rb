class HomeController < ApplicationController
  def index
    if current_user.nil?

    else
      @accepted_friends = Friendship.where(status: 'accepted').where("user_id = :user_id OR friend_id = :user_id", user_id: current_user.id).map do |friendship|
        friendship.user_id == current_user.id ? friendship.friend : friendship.user
    end

    end
    # render
 
    @like = Like.new
    @post = Post.new
    @users = User.all

  end
end



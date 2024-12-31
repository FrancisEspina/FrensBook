class UsersController < ApplicationController


  def show

    @accepted_friends = Friendship.where(status: 'accepted').where("user_id = :user_id OR friend_id = :user_id", user_id: current_user.id).map do |friendship|
      friendship.user_id == current_user.id ? friendship.friend : friendship.user
    end
      
    @friendship = Friendship.new
    @post = Post.new
    @user = User.find(params[:id])
    @user_posts = Post.where(user: @user).order(created_at: :desc)
  end
end

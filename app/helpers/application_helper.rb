module ApplicationHelper

    def like_exist(post, current_user)
       like = Like.find_by(post_id: post.id, user_id: current_user.id)
    end
    

    def like_owner(like)
        like.user_id == current_user.id
    end

    def is_friend_with(user)
        current_user.friends.include?(user)
    end
end

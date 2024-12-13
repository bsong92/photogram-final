class UsersController < ApplicationController
#   skip_before_action(:authenticate_user!, {:only => [:index]})

# def index
#     @list_of_users = User.all.order(username: :asc)
#     render(template: "users_html/index")
#   end

#   def show
#     @username = params.fetch("username")
#     @the_user = User.where(username: @username).first

#     if @the_user == nil
#       redirect_to("/404")
#     else
#       render(template: "users_html/show")
#     end
#   end

#   def create
#     my_input_username = params.fetch("input_username")
#     new_user = User.new
#     new_user.username = my_input_username
#     new_user.save
#     redirect_to("/users/" + my_input_username)
#   end

#   def update
#     user_id = params.fetch("user_id")
#     my_input_username = params.fetch("input_username")
#     the_user = User.where(id: user_id).first
#     the_user.username = my_input_username
#     the_user.save
#     redirect_to("/users/" + my_input_username)
#   end
# end

  skip_before_action(:authenticate_user!, {:only => [:index]})
  #index
    def index
      render({:template => "users/index"})
    end 
    def profile
      @this_user = User.where(:username => params.fetch("username")).first
      
      if current_user_can_view_details?(@this_user)
        render({:template => "users/profile"})
      else
          redirect_to("/users", {:notice => "You are not authorized to do that!" })
        end
    end 
    
    def liked_photos
      @this_user = User.where(:username => params.fetch("username")).first
      render({:template => "users/liked_photos"})
    end 
    
    def feed
      @this_user = User.where(:username => params.fetch("username")).first
      @all_leaders = @this_user.follow_sent.where(:status => "accepted").pluck(:recipient_id)
      @all_leader_photos = Photo.where(owner_id: @all_leaders)
      render({:template => "users/feed"})
    end
    def discover
      @this_user = User.where(:username => params.fetch("username")).first
      @all_leaders = User.where(id: @this_user.follow_sent.where(:status => "accepted").pluck(:recipient_id))
      @all_leader_likes = Like.where(fan_id: @all_leaders.pluck(:id))
      @all_leader_liked_photos = Photo.where(id: @all_leader_likes.pluck(:photo_id))
      render({:template => "users/discover"})
    end 
    def current_user_can_view_details?(user)
      @this_user = User.where(:username => params.fetch("username")).first
      return true if current_user.id == @this_user.id
      return true if @this_user.private == false
      return true if @this_user.private == true && current_user.follow_sent.where(:status => "accepted", :recipient_id => @this_user.id).present?
    end
    def edit
      render({:template => "devise/registration/edit"})
    end
  end

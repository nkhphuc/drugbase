class PostsController < ApplicationController
    before_action :authenticate_user!, except: [:index]
    before_action :set_post, only: [ :show, :edit, :update, :destroy, :change_status]
    authorize_resource
    skip_authorize_resource only: :index
        
    def index
        @posts = Post.where(status: params[:status].presence || "open")
    end

    def show
    end

    def edit
    end

    def create
        @post = Post.new(post_params)
        @post.user_id = current_user.id
        if @post.save
            respond_to do |format|
                format.turbo_stream
            end
            Turbo::StreamsChannel.broadcast_prepend_to("posts_channel", target: "posts", partial: "posts/post", locals: { post: @post, user: current_user })
        else
            respond_to do |format|
                format.turbo_stream { render turbo_stream: turbo_stream.replace("#{helpers.dom_id(@post)}_form", partial: "posts/form", locals: { post: @post }) }
            end
        end
    end

    def update
        if @post.status == "open"
            if @post.update(post_params)
                Turbo::StreamsChannel.broadcast_replace_to("posts_channel", target: "#{helpers.dom_id(@post)}", partial: "posts/post", locals: { post: @post, user: current_user })
            else
                render turbo_stream: turbo_stream.replace("#{helpers.dom_id(@post)}_form", partial: "posts/form", locals: { post: @post })
            end
        else 
           @post.errors.add(:status, "is closed.")
           render turbo_stream: turbo_stream.replace("#{helpers.dom_id(@post)}_form", partial: "posts/form", locals: { post: @post })
        end
    end

    def destroy
        @post.destroy
        Turbo::StreamsChannel.broadcast_remove_to("posts_channel", target: "#{helpers.dom_id(@post)}" )
    end

    def change_status
        @post.update(status: post_params[:status])
        Turbo::StreamsChannel.broadcast_remove_to("posts_channel", target: "#{helpers.dom_id(@post)}" )
    end

    private

    def post_params
        params.require(:post).permit(:title, :content, :status, :user_id)
    end

    def set_post
        @post = Post.find(params[:id])
    end
          
end

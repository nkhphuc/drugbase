class PostsController < ApplicationController
    before_action :authenticate_user!, except: [:index]
    before_action :set_post, only: [ :show, :edit, :update, :destroy, :change_status]
    authorize_resource
        
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
                format.html { redirect_to post_path(@post) }
            end
            Turbo::StreamsChannel.broadcast_prepend_to("posts_channel", target: "posts", partial: "posts/post", locals: { post: @post })
        else
            respond_to do |format|
                format.turbo_stream { render turbo_stream: turbo_stream.replace("#{helpers.dom_id(@post)}_form", partial: "form", locals: { post: @post }) }
                format.html { render :new, status: :unprocessable_entity }
            end
        end
    end

    def update
        if @post.status == "open"
            if @post.update(post_params)
                respond_to do |format|
                    format.html { redirect_to post_path(@post) }
                    format.json { render :show, status: :ok, location: @post }
                end
                Turbo::StreamsChannel.broadcast_replace_to("posts_channel", target: "#{helpers.dom_id(@post)}", partial: "posts/post", locals: { post: @post })
            else
                respond_to do |format|
                    format.turbo_stream { render turbo_stream: turbo_stream.replace("#{helpers.dom_id(@post)}_form", partial: "form", locals: { post: @post }) }
                    format.html { render :edit, status: :unprocessable_entity }
                    format.json { render json: @post.errors, status: :unprocessable_entity }
                end
            end
        else 
           @post.errors.add(:status, "is closed.")
           render turbo_stream: turbo_stream.replace("#{helpers.dom_id(@post)}_form", partial: "form", locals: { post: @post })
        end
    end

    def destroy
        @post.destroy
        respond_to do |format|
            format.html { redirect_to posts_path }
            format.json { head :no_content }
        end
        Turbo::StreamsChannel.broadcast_remove_to("posts_channel", target: "#{helpers.dom_id(@post)}" )
    end

    def change_status
        @post.update(status: post_params[:status])
        respond_to do |format|
            format.html { redirect_to posts_path }
        end
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

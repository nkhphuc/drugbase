class PostsController < ApplicationController
    before_action :authenticate_user!, except: [:index]
    before_action :set_post, only: [ :edit, :update, :destroy, :change_status]
        
    def index
        @posts = Post.where(status: params[:status].presence || "open")
    end

    def edit
    end

    def create
        @post = Post.new(post_params)
        @post.user_id = current_user.id
      
        respond_to do |format|
            if @post.save
                format.turbo_stream do
                    flash.turbo[:notice] = "Post was successfully created."
                end
                format.html { redirect_to post_path(@post), notice: "Post was successfully created." }
            else
                format.turbo_stream { render turbo_stream: turbo_stream.replace("#{helpers.dom_id(@post)}_form", partial: "form", locals: { post: @post }) }
                format.html { render :new, status: :unprocessable_entity }
            end
        end
    end

    def update
        if @post.status == "open"
            respond_to do |format|
                if @post.update(post_params)
                    format.turbo_stream do
                        flash.turbo[:notice] = "Post was successfully updated."
                    end
                    format.html { redirect_to post_path(@post), notice: "Post was successfully updated." }
                    format.json { render :show, status: :ok, location: @post }
                else
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
            format.turbo_stream do
                flash.turbo[:alert] = "Post was successfully destroyed."
                render turbo_stream: turbo_stream.remove("#{helpers.dom_id(@post)}_container")
            end
            format.html { redirect_to posts_path, alert: "Post was successfully destroyed." }
            format.json { head :no_content }
        end
    end

    def change_status
        @post.update(status: post_params[:status])
        respond_to do |format|
            format.turbo_stream do
                flash.turbo[:notice] = "Updated post status."
                render turbo_stream: turbo_stream.remove("#{helpers.dom_id(@post)}_container")
            end
            format.html { redirect_to posts_path, notice: "Updated post status." }
        end
    end

    private

    def post_params
        params.require(:post).permit(:title, :content, :status, :user)
    end

    def set_post
        @post = Post.find(params[:id])
    end
          
end

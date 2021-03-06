class PostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.new
  end

  def index
    if params[:tag_name]
      @posts = Post.tagged_with("#{params[:tag_name]}").order(created_at: :desc).page(params[:page]).reverse_order
    else
      @posts = Post.page(params[:page]).reverse_order.order(created_at: :desc) # ページネーション記述位置注意。この記述で適応された。
    end # 1ページで決められた件数だけを、新しく取得する
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post.id), notice: "投稿が保存されました。"
    else
      flash.now[:alert] = "投稿の保存に失敗しました" # flashメッセージが引き継がれてしまうことを防ぐため、1回だけ表示させるflash.nowを使用
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to posts_path, notice: "投稿を削除しました。"
    else
      flash.now[:alert] = "投稿の削除に失敗しました。 再度実行してください。"
      render :show
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image, :tag_list)
  end
end

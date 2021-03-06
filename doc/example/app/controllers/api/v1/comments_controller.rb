class API::V1::CommentsController < APIController
  handles :all

  private
    def comment_params
      params.require(:comment).permit(:name, :content)
    end
end

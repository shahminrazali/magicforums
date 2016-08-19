class VotesController < ApplicationController
  respond_to :js
  before_action :authenticate!

  def upvote
    @vote = current_user.votes.find_or_create_by(comment_id: params[:comment_id])

    if @vote.update(value: 1)
      VoteBroadcastJob.perform_later(@vote.comment, @vote.comment.total_votes, @vote.comment.total_upvotes, @vote.comment.total_downvotes)
      flash.now[:success] = "NEW VOTE"
    else
      flash.now[:danger] = "no new vote"
    end
  end

  def downvote
    @vote = current_user.votes.find_or_create_by(comment_id: params[:comment_id])

    if @vote.update(value: -1)
      VoteBroadcastJob.perform_later(@vote.comment, @vote.comment.total_votes, @vote.comment.total_upvotes, @vote.comment.total_downvotes)
      flash.now[:success] = "NEW VOTE"
    else
      flash.now[:danger] = "no new vote"
    end
  end

end

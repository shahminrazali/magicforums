class VoteBroadcastJob < ApplicationJob
  queue_as :default

  def perform(comment, vote, up, down)
    ActionCable.server.broadcast 'votes_channel', comment: comment, vote: vote, upvote: up, downvote: down, partial: render_vote_partial(comment)
  end

  private

  def render_vote_partial(comment)
    CommentsController.render partial: "votes/votes", locals: { comment: comment, post: comment.post, topic: comment.post.topic, current_user: comment.user, extra_class: "hidden" }
  end
end

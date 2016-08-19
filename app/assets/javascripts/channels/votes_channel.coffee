votesChannelFunctions = () ->

  updateVote = (data) ->
    $(".vote[data-id=#{data.comment.id}]").html(data.vote)
    $(".upvote[data-id=#{data.comment.id}]").html(data.upvote)
    $(".downvote[data-id=#{data.comment.id}]").html(data.downvote)
    $(".votes[data-id=#{data.comment.id}]").html(data.partial)
    console.log("#{data.comment}.#{data.comment.id}.#{data.vote}.VOTE WORKING LA TUN")


  if $('.comments.index').length > 0
    App.votes_channel = App.cable.subscriptions.create {
      channel: "VotesChannel"
    },

    connected: () ->
      console.log("user logged vote")

    disconnected: () ->
      console.log("user logged out votes")

    received: (data) ->
      console.log("received data votes")
      updateVote(data)

$(document).on 'turbolinks:load', votesChannelFunctions

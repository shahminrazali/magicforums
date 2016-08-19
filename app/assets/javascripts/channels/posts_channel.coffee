postsChannelFunctions = () ->

  checkMe = (comment_id, username) ->
    console.log($("meta[name=admin]").length)
    console.log($("meta[user=#{username}]").length)
    if $('meta[name=admin]').length < 1
      if $("meta[user=#{username}]").length < 1
        $(".comment[data-id=#{comment_id}] .box").remove()

    $(".comment[data-id=#{comment_id}]").removeClass("hidden")

  createComment = (data) ->
    console.log("CREATE COMMENT")
    if $('.comments.index').data().id == data.post.id && $(".comment[data-id=#{data.comment.id}]").length < 1
      $('#comments').append(data.partial)
      checkMe(data.comment.id, data.username)

  updateComment = (data) ->
    $(".comment[data-id=#{data.comment.id}]").replaceWith(data.partial)
    checkMe(data.comment.id, data.username)

  destroyComment = (data) ->
    $(".comment[data-id=#{data.comment.id}]").remove()

  if $('.comments.index').length > 0
    App.posts_channel = App.cable.subscriptions.create {
      channel: "PostsChannel"
    },

    connected: () ->
      console.log("user logged in")

    disconnected: () ->
      console.log("user logged out")

    received: (data) ->
      switch data.type
        when "create" then createComment(data)
        when "update" then updateComment(data)
        when "destroy" then destroyComment(data)

      console.log("user logged out")

$(document).on 'turbolinks:load', postsChannelFunctions

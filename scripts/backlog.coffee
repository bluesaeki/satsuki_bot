backlogUrl = 'https://blue-inc.backlog.jp/'

module.exports = (robot) ->
  robot.router.post "/room/:room", (req, res) ->
    room = req.params.room
    body = req.body

    console.log 'body type = ' + body.type
    console.log 'room = ' + room

    try
      switch body.type
          when 1
              label = '課題が追加'
          when 2, 3
              label = '課題が更新'
          when 4
              label = '課題が削除'
          else
              return


      url = "#{backlogUrl}view/#{body.project.projectKey}-#{body.content.key_id}"

      if body.content.comment?.id?
          url += "#comment-#{body.content.comment.id}"
        
        # message = "ID: #{body.id}\n"
        # message += "noticeName: #{body.noticifications.user.name}\n"
        # message += "changed: #{body.content.changes[0].field}\n"
        # message += "changed: #{body.content.changes[0].new_value}\n"
        # message += "changed: #{body.content.changes[0].old_value}\n"
        # message += "changed: #{body.content.changes[0].type}\n"
      message = "[info][title]Backlogより[/title]"
      message += "#{body.createdUser.name}さんによって#{label}されました\n"
      message += "[#{body.project.projectKey}-#{body.content.key_id}]"
      message += "#{body.content.summary}\n"

      if body.content.comment?.content?
          message += "#{body.content.comment.content}\n"
      message += "#{url}[/info]"

      console.log 'message = ' + message

      if message?
          robot.messageRoom room, message
          res.end "OK"
      else
          robot.messageRoom room, "Backlog integration error."
          res.end "Error"
    catch error
      robot.send
      res.end "Error"
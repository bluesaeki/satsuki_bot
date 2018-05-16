backlogUrl = 'https://blue-inc.backlog.jp/'

module.exports = (robot) ->
  robot.router.post "/room/:room", (req, res) ->
    room = req.params.room
    body = req.body
    usagi = "lesson-front"
    postFlag = false

    for changeObj, index in body.content.changes
        if changeObj.field == "assigner"
            if changeObj.new_value == usagi
                postFlag = true

    if !postFlag
        robot.messageRoom room, "（・・・誰かが課題を更新したっぽい・・・）"
        res.end "OK"
        return false
    
    try
      url = "#{backlogUrl}view/#{body.project.projectKey}-#{body.content.key_id}"

      if body.content.comment?.id?
          url += "#comment-#{body.content.comment.id}"

      message = "[info][title]Backlogより[/title]"
      message += "#{body.createdUser.name}さんによって課題が更新されましたよ！\n"
      message += "[#{body.project.projectKey}-#{body.content.key_id}]"
      message += "#{body.content.summary}\n"

      if body.content.comment?.content?
          message += "#{body.content.comment.content}\n"
      message += "#{url}[/info]"
      
      if message?
          robot.messageRoom room, message
          res.end "OK"
      else
          robot.messageRoom room, "Backlog integration error."
          res.end "Error"
    catch error
      robot.send
      res.end "Error"
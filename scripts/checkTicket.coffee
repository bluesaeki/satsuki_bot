backlogUrl = 'https://blue-inc.backlog.jp/'
apiUrl = 'api/v2/issues'
apiKey = 'C6DOpbVItiqcOQLtl4PZyr7Qhp46M3ccwupWu4gsAqLGwLQvuCYW85JP3vqYlze0'
userId = '1074134945'

requestUrl = backlogUrl + apiUrl + "?apiKey=" + apiKey + "&assigneeId[]=" + userId
module.exports = (robot) ->
  robot.hear /課題チェック/, (msg) ->
    request = robot.http(requestUrl)
                   .get()
    request (err, res, body) ->
      json = JSON.parse body
      message = ""

      for thisTicket, index in json
        if thisTicket.status.id != 4
          message += "[info][title]Backlog[/title]"
          message += "#{thisTicket.updatedUser.name}さんによって課題が更新されました\n"
          message += "[#{thisTicket.issueKey}]"
          message += "#{thisTicket.summary}\n"
          message += "#{backlogUrl}/view/#{thisTicket.issueKey}"
          message += "[/info]"

      msg.send message
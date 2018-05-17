backlogUrl = 'https://blue-inc.backlog.jp/'
apiUrl = 'api/v2/issues'
apiKey = 'C6DOpbVItiqcOQLtl4PZyr7Qhp46M3ccwupWu4gsAqLGwLQvuCYW85JP3vqYlze0'
userId = '1074134945'
requestUrl = backlogUrl + apiUrl + "?apiKey=" + apiKey + "&assigneeId[]=" + userId
cronJob = require('cron').CronJob

module.exports = (robot) ->
  cronjob = new cronJob(
    cronTime: "0 17 * * * 1-5"
    start: true
    onTick: ->
      greet = "皆様おはようございます！\n"

      request = robot.http(requestUrl)
                    .get()
      request (err, res, body) ->
        json = JSON.parse body
        message = "今lesson-frontに来ているチケットは以下の通りです！\n\n"
        ticket = ""

        for thisTicket, index in json
          if thisTicket.status.id != 4
            ticket += "[info][title]Backlog[/title]"
            ticket += "#{thisTicket.updatedUser.name}さんによって課題が更新されました\n"
            ticket += "[#{thisTicket.issueKey}]"
            ticket += "#{thisTicket.summary}\n"
            ticket += "#{backlogUrl}view/#{thisTicket.issueKey}"
            ticket += "[/info]"
        
        if ticket == ""
          robot.send {room: "106987262"}, greet + "チケットはありませんでした！"
        else
          robot.send {room: "106987262"}, greet + message + ticket 
  )
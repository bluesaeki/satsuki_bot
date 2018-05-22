backlogUrl = 'https://blue-inc.backlog.jp/'
apiUrl = 'api/v2/issues'
apiKey = 'C6DOpbVItiqcOQLtl4PZyr7Qhp46M3ccwupWu4gsAqLGwLQvuCYW85JP3vqYlze0'
userId = '1074134945'
requestUrl = backlogUrl + apiUrl + "?apiKey=" + apiKey + "&assigneeId[]=" + userId
cronJob = require('cron').CronJob

module.exports = (robot) ->
  new cronJob(
    cronTime: "0 0 10 * * 1-5"
    start: true
    onTick: ->
      greet = "[botテスト]皆様おはようございます！\n"
      endGreet = "\n本日もよろしくお願いします！"

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
          robot.send {room: "96205045"}, greet + "今日はlesson-frontにチケットはありませんでした！\n" + endGreet
        else
          robot.send {room: "96205045"}, greet + message + ticket + endGreet
  )

  new cronJob(
    cronTime: "0 0 19 * * 1-5"
    start: true
    onTick: ->
      robot.send {room: "96205045"}, "[botテスト]定時タイム"
  )

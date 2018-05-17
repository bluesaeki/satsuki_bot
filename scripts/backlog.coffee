backlogUrl = 'https://blue-inc.backlog.jp/'

# 人の増減でいじる
member_a = ["宮下　あづみ","大石　智之","宮平　依歩","今西　麻衣","平田　まりこ","小谷　明之","木下　万莉菜","篠原　咲都","木村　千聡"]
member_b = ["佐藤　琳子","清水　弘明","橋本　真希","池田　ゆず","石井　輝","清水　彩美","豊　翔太","建部　翔太","徳丸　日奈子","大内　広葉","古園　晃栄"]

menter_a = "[To:2024961] [To:2362112] [To:2112520] [To:2486076] Aチームの皆さん！\n\n"
menter_b = "[To:2110187] [To:2069944] [To:2178425] Bチームの皆さん！\n\n"

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
      res.end "OK"
      return false
    
    try
      url = "#{backlogUrl}view/#{body.project.projectKey}-#{body.content.key_id}"

      if body.content.comment?.id?
        url += "#comment-#{body.content.comment.id}"

      message = ""

      if body.createdUser.name in member_a
        message += menter_a
      else if body.createdUser.name in member_b
        message += menter_b
      else
        message += "※担当が割り振られていない模様\n\n"

      message += "lesson-frontにレビュー依頼が来たよ！\n"
      message += "[info][title]Backlog[/title]"
      message += "#{body.createdUser.name}さんによって課題が更新されました\n"
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
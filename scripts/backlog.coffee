backlogUrl = 'https://blue-inc.backlog.jp/'

 # 人の増減でいじる
member_a = ["宮下　あづみ","大石　智之","宮平　依歩","今西　麻衣","平田　まりこ","小谷　明之","木下　万莉菜","篠原　咲都","木村　千聡","上田　祐平", "佐藤　真里奈"]
member_b = ["佐藤　琳子","清水　弘明","橋本　真希","池田　ゆず","石井　輝","清水　彩美","豊　翔太","建部　翔太","徳丸　日奈子","大内　広葉","古園　晃栄","笠松　芽未"]
member_s_sugimoto = ["宮下　あづみ", "松岡　香凛", "笠松　芽未", "神道　なつみ", "菅野　沙織", "久保　舞土里"]
member_s_furukawa = ["佐藤　真里奈", "草川　佳奈"]
member_r_imae = ["宮平　依歩", "今西　麻衣", "杉原　翔太", "山本　桃華", "中山　紋華", "小野寺　美月", "石井　輝", "福永　ひとみ"]
member_y_samoto = ["上田　祐平"]
member_n_ishikawa = ["大石　智之", "瀬脇　夏美"]
member_y_fujita = ["清水　彩美", "吉川　実由記"]
member_a_saeki = ["平田　まりこ", "佐々木　麗子"]
menber_t_inoue = ["小谷　明之"]

menter_a = "[To:2024961] [To:2362112] [To:2112520] [To:2486076] Aチームの皆さん！\n\n"
menter_b = "[To:2110187] [To:2069944] [To:2178425] Bチームの皆さん！\n\n"
menter_a = "CC : [To:2024961] [To:2362112] [To:2112520] [To:2486076] Aチームの皆さん！\n\n"
menter_b = "CC : [To:2110187] [To:2069944] [To:2178425] Bチームの皆さん！\n\n"
menter_s_sugimoto = "[To:2112520] 杉本 将【10263】さん\n\n" + menter_a
menter_s_furukawa = "[To:2486076] 古川 茂樹【10317】さん\n\n" + menter_a
menter_y_samoto = "[To:2178425] 佐本 祐一【10247】さん\n\n" + menter_b
menter_n_ishikawa = "[To:2069944] 石川 奈歩【10226】さん\n\n" + menter_b
menter_t_inoue = "[To:2024961] 井上 拓哉【10113】さん\n\n" + menter_a
menter_r_imae = "[To:2110187] 今江 陵介【10228】さん\n\n"
menter_y_fujita = "[To:2024943] 藤田 裕治【10046】さん\n\n"
menter_a_saeki = "[To:2025042] 佐伯 明紀【10171】さん\n\n"

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

      if body.createdUser.name in member_s_sugimoto
        message += menter_s_sugimoto
      else if body.createdUser.name in member_s_furukawa
        message += menter_s_furukawa
      else if body.createdUser.name in member_r_imae
        message += menter_r_imae
      else if body.createdUser.name in member_s_suzuki
        message += menter_s_suzuki
      else if body.createdUser.name in member_y_samoto
        message += menter_y_samoto
      else if body.createdUser.name in member_n_ishikawa
        message += menter_n_ishikawa
      else if body.createdUser.name in member_y_fujita
        message += menter_y_fujita
      else if body.createdUser.name in member_r_sasaki
        message += menter_r_sasaki
      else if body.createdUser.name in member_a_saeki
        message += menter_a_saeki
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
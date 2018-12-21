 backlogUrl = 'https://blue-inc.backlog.jp/'
 
 # 人の増減でいじる
-member_a = ["宮下　あづみ","大石　智之","宮平　依歩","今西　麻衣","平田　まりこ","小谷　明之","木下　万莉菜","篠原　咲都","木村　千聡","上田　祐平", "佐藤　真里奈"]
-member_b = ["佐藤　琳子","清水　弘明","橋本　真希","池田　ゆず","石井　輝","清水　彩美","豊　翔太","建部　翔太","徳丸　日奈子","大内　広葉","古園　晃栄","笠松　芽未"]
+member_s_sugimoto = ["宮下　あづみ", "松岡　香凛", "笠松　芽未"]
+member_s_furukawa = ["佐藤　真里奈"]
+member_r_imae = ["宮平　依歩", "今西　麻衣"]
+member_s_suzuki = ["石井　輝"]
+member_y_samoto = ["上田　祐平"]
+member_n_ishikawa = ["大石　智之"]
+member_y_fujita = ["清水　彩美"]
+member_r_sasaki = ["清水　弘明", "橋本　真希", "大内　広葉", "佐藤　琳子", "小谷　明之", "瀬脇 夏美"]
+member_a_saeki = ["平田　まりこ"]
 
-menter_a = "[To:2024961] [To:2362112] [To:2112520] [To:2486076] Aチームの皆さん！\n\n"
-menter_b = "[To:2110187] [To:2069944] [To:2178425] Bチームの皆さん！\n\n"
+menter_a = "CC : [To:2024961] [To:2362112] [To:2112520] [To:2486076] Aチームの皆さん！\n\n"
+menter_b = "CC : [To:2110187] [To:2069944] [To:2178425] Bチームの皆さん！\n\n"
+menter_s_sugimoto = "[To:2112520] 杉本 将【10263】さん\n\n" + menter_a
+menter_s_furukawa = "[To:2486076] 古川 茂樹【10317】さん\n\n" + menter_a
+menter_r_imae = "[To:2110187] 今江 陵介【10228】さん\n\n" + menter_b
+menter_s_suzuki = "[To:2362112] 鈴木 紗知【10294】さん\n\n" + menter_a
+menter_y_samoto = "[To:2178425] 佐本 祐一【10247】さん\n\n" + menter_b
+menter_n_ishikawa = "[To:2069944] 石川 奈歩【10226】さん\n\n" + menter_b
+menter_y_fujita = "[To:2024943] 藤田 裕治【10046】さん\n\n"
+menter_r_sasaki = "[To:2025045] 佐々木 麗子【10173】さん\n\n"
+menter_a_saeki = "[To:2025042] 佐伯 明紀【10171】さん\n\n"
 
 module.exports = (robot) ->
   robot.router.post "/room/:room", (req, res) ->

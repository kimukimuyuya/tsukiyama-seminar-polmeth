library(readxl)

farmstay <- read_excel("city2023.xlsx", na = "")
farmstay0 <- subset(farmstay, farmstay$月 == 1)

plot(farmstay0$農泊採択地域数, farmstay0$年間訪問者数, xlab = "農泊採択地域数", ylab = "年間訪問者数", main = "全国の農泊採択地域数と年間訪問者数")

# 農泊採択地域数と年間訪問者数の単回帰分析
#result <- lm(log(年間訪問者数) ~ 農泊採択地域数, data = farmstay0)
result <- lm(年間訪問者数 ~ 農泊採択地域数, data = farmstay0)
summary(result)
abline(result, col = "red")

# 2021年度の市町村区ごとの耕地面積率を算出
farmarea <- read.csv("city2021.csv", fileEncoding = "SJIS", na.strings = "-")
farmarea21 <- subset(farmarea, farmarea$調査年 == "2021年度")
farmarea21$総面積 <- as.integer(farmarea21$総面積)
farmarea21$耕地面積 <- as.integer(farmarea21$耕地面積)
farmarea21$耕地面積率 <- farmarea21$耕地面積 / farmarea21$総面積 * 100

# farmstayに耕地面積率を追加
farmstay1 <- merge(farmstay0, farmarea21, by.x = "地域コード", by.y = "地域.コード", all.x = TRUE)

# 年間訪問者数を従属変数として、農泊採択地域数を独立変数、耕地面積率を統制変数とする重回帰分析
result2 <- lm(年間訪問者数 ~ 農泊採択地域数 + 耕地面積率, data = farmstay1)
summary(result2)

library(car)
vif(result2)

#統制変数４つ追加（人口密度、65歳以上比率、財政規模、第１次産業就業者比率）
control20 <- read.csv("control2020.csv", fileEncoding = "SJIS", na.strings = c("-", "***"))
control <- read.csv("control.csv", fileEncoding = "SJIS", na.strings = c("-", "***"))
control14 <- subset(control, control$調査年 == "2014年度", select = c("地域.コード", "事業所数",　"事業所数.宿泊業.飲食サービス業."))
control19 <- subset(control, control$調査年 == "2019年度", select = c("地域.コード", "農家数.販売農家."))
farmstay2 <- merge(farmstay1, control20, by.x = "地域コード", by.y = "地域.コード", all.x = TRUE)
farmstay2 <- merge(farmstay2, control14, by.x = "地域コード", by.y = "地域.コード", all.x = TRUE)
farmstay2 <- merge(farmstay2, control19, by.x = "地域コード", by.y = "地域.コード", all.x = TRUE)
climate <- read.csv("climate.csv", fileEncoding = "SJIS", na.strings = c("-", "***"))
climate <- subset(climate, climate$調査年 == "2020年度")
farmstay2 <- merge(farmstay2, climate, by.x = "都道府県名", by.y = "地域", all.x = TRUE)
farmstay2$宿泊業飲食サービス業事業所数比率 <- farmstay2$事業所数.宿泊業.飲食サービス業. / farmstay2$事業所数 * 100
farmstay2$農家数.販売農家.　<- as.integer(farmstay2$農家数.販売農家.)

library(readr)
write_excel_csv(farmstay2, "farmstay_data2.csv")

result3 <- lm(年間訪問者数 ~ 農泊採択地域数 + 耕地面積率 + 人口密度 + X65歳以上人口割合 + 標準財政規模 + 第1次産業就業者比率 + 宿泊業飲食サービス業事業所数比率, data = farmstay2)
result4 <- lm(年間訪問者数 ~ 農泊採択地域数 + 耕地面積率 + 人口密度 + X65歳以上人口割合 + 標準財政規模 + 第1次産業就業者比率 + 宿泊業飲食サービス業事業所数比率 + 農家数.販売農家., data = farmstay2)
result5 <- lm(年間訪問者数 ~ 農泊採択地域数 + 耕地面積率 + 人口密度 + X65歳以上人口割合 + 標準財政規模 + 第1次産業就業者比率+ 宿泊業飲食サービス業事業所数比率 + 農家数.販売農家. + 年平均気温 + 降水日数, data = farmstay2)

library(memisc)
results <- mtable(result2, result3, result4, result5, digits = 4)
results
summary(result2)


vif(result3)




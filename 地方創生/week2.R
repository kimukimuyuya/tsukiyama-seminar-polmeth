library(readxl)

farmstay <- read_excel("city2023.xlsx", na = "")
farmstay0 <- subset(farmstay, farmstay$月 == 1)

exclude_regions <- c("東京", "神奈川", "千葉", "埼玉", "愛知", "大阪", "京都", "兵庫")

farmstay1 <- subset(farmstay0, !(farmstay0$都道府県名 %in% exclude_regions))

plot(farmstay1$農泊採択地域数, farmstay1$年間訪問者数, xlab = "農泊採択地域数", ylab = "年間訪問者数", main = "全国の農泊採択地域数と年間訪問者数")

# 農泊採択地域数と年間訪問者数の単回帰分析
#result <- lm(log(年間訪問者数) ~ 農泊採択地域数, data = farmstay1)
result <- lm(年間訪問者数 ~ 農泊採択地域数, data = farmstay1)
summary(result)
abline(result, col = "red")

# 2021年度の市町村区ごとの耕地面積率を算出
farmarea <- read.csv("city2021.csv", fileEncoding = "SJIS", na.strings = "-")
farmarea21 <- subset(farmarea, farmarea$調査年 == "2021年度")
farmarea21$総面積 <- as.integer(farmarea21$総面積)
farmarea21$耕地面積 <- as.integer(farmarea21$耕地面積)
farmarea21$耕地面積率 <- farmarea21$耕地面積 / farmarea21$総面積 * 100

# farmstayに耕地面積率を追加
farmstay2 <- merge(farmstay1, farmarea21, by.x = "地域コード", by.y = "地域.コード", all.x = TRUE)

# 年間訪問者数を従属変数として、農泊採択地域数を独立変数、耕地面積率を統制変数とする重回帰分析
result2 <- lm(年間訪問者数 ~ 農泊採択地域数 + 耕地面積率, data = farmstay2)
summary(result2)



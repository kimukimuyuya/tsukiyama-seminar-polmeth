library(readxl)

farmstay <- read_excel("city2023.xlsx", na = "")
farmstay1 <- subset(farmstay, farmstay$月 == 1)

plot(farmstay1$農泊採択地域数, farmstay1$年間訪問者数, xlab = "農泊採択地域数", ylab = "年間訪問者数", main = "全国の農泊採択地域数と年間訪問者数")
result <- lm(年間訪問者数 ~ 農泊採択地域数, data = farmstay1)
summary(result)
abline(result, col = "red")

Miyagi <- subset(farmstay, farmstay$都道府県名 == "宮城県")
MiyagiJanuary <- subset(Miyagi, Miyagi$月 == 1)

plot(MiyagiJanuary$農泊採択地域数, MiyagiJanuary$人数, xlab = "農泊採択地域数", ylab = "人数", main = "宮城県の農泊採択地域数と人数")
result <- lm(人数 ~ 農泊採択地域数, data = MiyagiJanuary)
summary(result)
abline(result, col = "red")


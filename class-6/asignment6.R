df <- read.csv("SSDSE-A-2023.csv", fileEncoding = "SJIS")
climate <- read.csv("climate.csv", fileEncoding = "SJIS")


df$災害復旧費割合 <- df$災害復旧費.市町村財政. / df$歳出決算総額.市町村財政. * 100
df$宿泊飲食サービス事業所割合 <- df$事業所数.民営..宿泊業.飲食サービス業. / df$事業所数.民営. * 100

df <- merge(df, climate, by = "都道府県", all.x = TRUE)

plot(df$宿泊飲食サービス事業所割合, df$災害復旧費割合)
text(df$宿泊飲食サービス事業所割合, df$災害復旧費割合, labels = df$都道府県, pos = 1)

result1 <- lm(df$宿泊飲食サービス事業所割合 ~ df$災害復旧費割合 + df$日降水量1mm以上の日数)
summary(result1)
df <- read.csv("SSDSE-A-2023.csv", fileEncoding = "SJIS")
climate <- read.csv("climate.csv", fileEncoding = "SJIS")


#df$災害復旧費割合 <- df$災害復旧費.市町村財政. / df$歳出決算総額.市町村財政. * 100
#df$宿泊飲食サービス事業所割合 <- df$事業所数.民営..宿泊業.飲食サービス業. / df$事業所数.民営. * 100

#df <- merge(df, climate, by = "都道府県", all.x = TRUE)

#plot(df$宿泊飲食サービス事業所割合, df$災害復旧費割合)
#text(df$宿泊飲食サービス事業所割合, df$災害復旧費割合, labels = df$都道府県, pos = 1)

#result1 <- lm(df$宿泊飲食サービス事業所割合 ~ df$災害復旧費割合 + df$日降水量1mm以上の日数)
#summary(result1)

df$災害復旧費割合 <- df$災害復旧費.市町村財政. / df$歳出決算総額.市町村財政. * 100
df$第一次産業就業者割合 <- df$第１次産業就業者数 / df$就業者数 * 100
df$転出者割合 <- df$転出者数.日本人移動者. / df$総人口 * 10000
df$人口密度 <- df$総人口 / df$可住地面積
df$高齢化率 <- df$X65歳以上人口 / df$総人口 * 100
df$面積当たり高校数 <- df$高等学校数 / df$可住地面積 * 100

result1 <- lm(df$転出者割合 ~ df$第一次産業就業者割合)
plot(df$第一次産業就業者割合, df$転出者割合)

result2 <- lm(df$転出者割合 ~  df$第一次産業就業者割合 + df$災害復旧費割合 + df$人口密度 + df$高齢化率)
summary(result2)

result3 <- lm(df$転出者割合 ~  df$第一次産業就業者割合 + df$災害復旧費割合 + df$人口密度 + df$高齢化率 + df$面積当たり高校数)
vif(result3)

results <- mtable(result1, result2, result3, digits = 4)
results


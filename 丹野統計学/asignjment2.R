# co2データの準備
class(co2)
data(co2)  # データの読み込み
plot(co2, main = "Monthly CO2 Concentration", ylab = "CO2 (ppm)", xlab = "Year")

# 時系列分析用ライブラリのロード
library(forecast)

# モデル化（ARIMAの自動選択）
co2_model <- auto.arima(co2)

# モデルの要約
summary(co2_model)

# 将来予測（2016年1月まで12ステップ予測）
future_forecast <- forecast(co2_model, h = 217)

# 予測のプロット
plot(future_forecast,
     xlab = "Year", ylab = "CO2 (ppm)")

# 2016年1月の予測値
predicted_value <- future_forecast$mean[217]
lower_bound <- future_forecast$lower[217,2]
upper_bound <- future_forecast$upper[217,2]
cat("2016年1月の予測値:\n")
cat("予測値:", predicted_value, "ppm\n")
cat("95%信頼区間: [", lower_bound, ",", upper_bound, "] ppm\n")
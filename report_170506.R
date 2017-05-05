# 資料來源：農委會糧食供需年報

data = read.table(file='./cereals_data.txt', header=T)
#plot(data$year, data$produce, ylim=c(1000000, 1600000), xaxt="n", xlab='year', ylab='produce(ton)')
#abline(lm(data$produce ~ data$year))
#axis(1, xaxp=c(95, 104, 9))
#title('Trend')

#d = data.frame(matrix(NA, nrow=30, ncol=3))
#colnames(d)[1] = 'year'
#colnames(d)[2] = 'ton'
#colnames(d)[3] = 'type'

#d$year = c(data$year, data$year, data$year)
#d$ton = c(data$produce, data$import, data$export)
#d$type = c(matrix(1, nrow=10, ncol=1), matrix(2, nrow=10, ncol=1), matrix(3, nrow=10, ncol=1))

library(plotly)
#plot_ly(d, x=~year, y=~ton, color=~type, type='scatter', mode='lines')
need = data$produce + data$import - data$export

sell_in = data$produce - data$export

# all data - import vs need
plot_ly(data, x = ~year, y = ~produce, name = '國內產量', type = 'scatter', mode = 'lines+markers') %>%
        add_trace(y = ~import, name = '進口量', mode = 'lines+markers') %>%
        add_trace(y = ~export, name = '出口量', mode = 'lines+markers') %>%
        add_trace(y = need, name = '糧食需求量', mode = 'lines+markers')
# 國內產量逐年上升
plot_ly(data, x = ~year, y = ~produce, name = '國內產量', type = 'scatter', mode = 'markers') %>%
        add_trace(y = fitted(lm(data$produce ~ data$year)), name = '趨勢線', type = 'scatter', mode = 'lines')
# 出口量上升
plot_ly(data, x = ~year, y = ~export, name = '出口量', type = 'scatter', mode = 'markers') %>%
        add_trace(y = fitted(lm(data$export ~ data$year)), name = '趨勢線', type = 'scatter', mode = 'lines')
# 內銷量上升趨勢不明顯
plot_ly(data, x = ~year, y = sell_in, name = '內銷量', type = 'scatter', mode = 'markers') %>%
  add_trace(y = fitted(lm(sell_in ~ data$year)), name = '趨勢線', type = 'scatter', mode = 'lines')



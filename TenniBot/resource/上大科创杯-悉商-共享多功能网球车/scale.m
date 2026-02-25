clear all;clc;

% 年份
years = [2019, 2020, 2021, 2022, 2023, 2024, 2025];

% 中国网球市场规模（元）
china_market = [1370e8, NaN, NaN, NaN, 2194e8, NaN, 3514e8];

% TenniCar市场规模（元）
tennicar_market = [6250e4, NaN, NaN, NaN, 11710e4, NaN, 16030e4];

% 计算市场规模
% 假设年增长率为17%
growth_rate = 0.17;
for i = 2:length(years)-1
    if isnan(china_market(i))
        china_market(i) = china_market(i-1) * (1 + growth_rate);
    end
    if isnan(tennicar_market(i))
        tennicar_market(i) = tennicar_market(i-1) * (1 + growth_rate);
    end
end

% 将市场规模转换为亿元和十万元表示
china_market = china_market / 1e8;
tennicar_market = tennicar_market / 1e5;

% 创建柱状图
figure;
bar(years, [china_market; tennicar_market]');
xlabel('年份');
ylabel('市场规模');
legend('中国网球市场(约亿元)', 'TenniCar市场预测(约十万元)');
title('中国网球市场和TenniCar市场规模');

hold on; % 保持图形，以便绘制折线图

% 添加数据标签
text([years-0.15, years+0.2],[china_market+50, tennicar_market+50], num2str([china_market, tennicar_market]', '%.1f'), ...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');

% 绘制实线折线图（2019-2023年）
plot(years(1:5), china_market(1:5), 'b-', 'LineWidth', 2);
plot(years, tennicar_market, 'r--', 'LineWidth', 2);

% 绘制虚线折线图（2023-2025年）
plot(years(5:7), china_market(5:7), 'b--', 'LineWidth', 2);
plot(years, tennicar_market, 'r--', 'LineWidth', 2);


% 设置刻度
xticks(years);
xlim([2018.5 2025.5]);

% 调整图例
legend('中国网球市场(约亿元)', 'TenniCar市场(约十万元)','Location', 'northwest');

hold off; % 取消保持图形状态



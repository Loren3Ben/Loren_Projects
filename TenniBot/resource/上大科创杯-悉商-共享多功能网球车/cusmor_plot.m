clc; clear all;

% 函数以及字体设置
fontSize = 14;
fontWeight = 'bold';

% 定义新的颜色
lightColors = [0.7 0.7 0.7; 0.5 0.5 0.5; 0.3 0.3 0.3];

age_labels = {'18岁以下(30%)', '18-25岁(40%)', '25岁以上(30%)'};
age_data = [30, 40, 30];
age_explode = [0.1 0.1 0.1];
skill_labels = {'初学者(20%)', '中级水平(50%)', '高级水平(30%)'};
skill_data = [20, 50, 30];
skill_explode = [0.1 0.1 0.1];
club_size_labels = {'小型俱乐部(50%)', '中型俱乐部(30%)', '大型俱乐部(20%)'};
club_size_data = [50, 30, 20];
club_size_explode = [0.1 0.1 0.1];
club_facility_labels = {'室内场地(40%)', '室外场地(60%)'};
club_facility_data = [40, 60];
club_facility_explode = [0.1 0.1];
university_type_labels = {'体育学院(20%)', '综合大学(40%)', '其他专业大学(40%)'};
university_type_data = [20, 40, 40];
university_type_explode = [0.1 0.1 0.1];
university_size_labels = {'小型大学(30%)', '中型大学(40%)', '大型大学(30%)'};
university_size_data = [30, 40, 30];
university_size_explode = [0.1 0.1 0.1];

% 学员年龄段分布
figure;
h = pie3(age_data, age_explode, age_labels);
title('学员年龄段分布', 'FontSize', fontSize, 'FontWeight', fontWeight);
colormap(lightColors);
addPercentageLabels(age_data, age_explode, age_labels);
legend(age_labels, 'Location', 'northeast');

% 学员技术水平分布
figure;
h = pie3(skill_data, skill_explode, skill_labels);
title('学员技术水平分布', 'FontSize', fontSize, 'FontWeight', fontWeight);
colormap(lightColors);
addPercentageLabels(skill_data, skill_explode, skill_labels);
legend(skill_labels, 'Location', 'northeast');

% 俱乐部规模分布
figure;
h = pie3(club_size_data, club_size_explode, club_size_labels);
title('俱乐部规模分布', 'FontSize', fontSize, 'FontWeight', fontWeight);
colormap(lightColors);
addPercentageLabels(club_size_data, club_size_explode, club_size_labels);
legend(club_size_labels, 'Location', 'northeast');

% 俱乐部场地情况分布
figure;
h = pie3(club_facility_data, club_facility_explode, club_facility_labels);
title('俱乐部场地情况分布', 'FontSize', fontSize, 'FontWeight', fontWeight);
colormap(lightColors);
addPercentageLabels(club_facility_data, club_facility_explode, club_facility_labels);
legend(club_facility_labels, 'Location', 'northeast');

% 大学专业性质分布
figure;
h = pie3(university_type_data, university_type_explode, university_type_labels);
title('大学专业性质分布', 'FontSize', fontSize, 'FontWeight', fontWeight);
colormap(lightColors);
addPercentageLabels(university_type_data, university_type_explode, university_type_labels);
legend(university_type_labels, 'Location', 'northeast');

% 大学学生人数分布
figure;
h = pie3(university_size_data, university_size_explode, university_size_labels);
title('大学学生人数分布', 'FontSize', fontSize, 'FontWeight', fontWeight);
colormap(lightColors);
addPercentageLabels(university_size_data, university_size_explode, university_size_labels);
legend(university_size_labels, 'Location', 'northeast');

% 创建函数用于标注百分比
function addPercentageLabels(data, explode, labels)
    for i = 1:length(data)
        txt = sprintf('%.1f%%', 100 * data(i) / sum(data));
        text(explode(i)*1.1, 0, 0, txt, 'FontSize', 10, 'FontWeight', 'bold', 'Color', 'k');
    end
end


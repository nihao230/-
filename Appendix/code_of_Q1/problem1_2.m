%%设置导入选项并导入相应数据
opts = spreadsheetImportOptions("NumVariables", 10);

% 指定工作表和范围
opts.Sheet = "接收情况1";
opts.DataRange = "A3:J1003";

% 指定列名称和数据类型
opts.VariableNames = ["TOA1", "TOA4", "TDOA12", "TDOA34", "DFD12", "AOAtanalpha4", "AOAtanbeta4", "RSSI1", "RSSI2", "RSSI3"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];

% 导入数据
S1 = readtable("fujian.xlsx", opts, "UseExcel", false);

%% 转换为输出类型
reception_case1_data = table2array(S1);

save reception_case1_data reception_case1_data
%% 清除所有临时变量
clear opts
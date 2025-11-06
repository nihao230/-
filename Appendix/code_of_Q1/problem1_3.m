%%设置导入选项并导入相应数据
opts = spreadsheetImportOptions("NumVariables", 10);

% 指定工作表和范围
opts.Sheet = "接收情况2";
opts.DataRange = "A3:J1003";

% 指定列名称和类型
opts.VariableNames = ["TOA2", "TOA3", "TDOA34", "DFD12", "DFD34", "AOAtanalpha4", "AOAtanbeta4", "RSSI1", "RSSI3", "RSSI4"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];

% 导入数据
S2 = readtable("fujian.xlsx", opts, "UseExcel", false);

%% 转换为输出类型
reception_case2_data = table2array(S2);
save reception_case2_data reception_case2_data
%% 清除临时变量
clear opts
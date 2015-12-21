% Bayesian Optimization の使い方
clear
close all


% 最適化（最大化）したい評価関数の設定
optfunc = @(x) sin(x) + 2 * cos(x/2) + 3 * sin(x/3) - 8 * cos(x/10);

% 最初に与えるデータセットの生成
Xinit = 100 * rand - 50;
Yinit = optfunc(Xinit);

% Bayesian Optimization で最適点を探索
Nite = 30;  % BOの繰り返し回数
[xopt, fopt] = BO(optfunc, Xinit, Yinit, Nite);

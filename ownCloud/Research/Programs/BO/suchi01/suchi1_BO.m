%% BO 数値例 (1次元)

% 最適化（最大化）したい評価関数の設定
optfunc = @(x) sin(x) + 2 * cos(x/2) + 3 * sin(x/3) - 8 * cos(x/10);
X_BO = {};
Y_BO = {};
xopt_BO = {};
fopt_BO = {};
X_LH = {};
Y_LH = {};

for i = 1 : 100

  i
  
  % 最初に与えるデータセットの生成
  Xinit = 0;  % 中央値を初期値として与えている
  Yinit = optfunc(Xinit);
  Nite  = 19;

  % BO による最適化およびそのデータの取得
  [xopt, fopt, X, Y] = BO(optfunc, Xinit, Yinit, Nite);
  X_BO{i} = X;
  Y_BO{i} = Y;
  xopt_BO{i} = xopt;
  fopt_BO{i} = fopt;
  
  % Latin Hypercube sampling用にデータを生成
  [N,M] = size(X_BO);
  X_LH{i} = lhsdesign(N,M);
  Y_LH{i} = optfunc(X_LH{i});
    
end

% データの保存
save('suchi01.mat','X_BO','Y_BO','xopt_BO','fopt_BO','X_LH','Y_LH');
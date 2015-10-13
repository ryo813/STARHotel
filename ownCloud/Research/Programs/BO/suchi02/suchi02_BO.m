%% BO 数値例 (2次元)

% 最適化（最大化）したい評価関数の設定
optfunc = @(x) -sum(x.^2);
X_BO = {};
Y_BO = {};
xopt_BO = {};
fopt_BO = {};
X_LH = {};
Y_LH = {};
tcalc = {};

for i = 1 : 100

  i
  
  tic
  
  % 最初に与えるデータセットの生成
  Xinit = rand(1,2);  % 中央値が最適値であるため，乱数で与える
  Yinit = optfunc(Xinit);
  Nite  = 49;

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
  
  tcalc{i} = toc;
    
end

% データの保存
save('suchi02.mat','X_BO','Y_BO','xopt_BO','fopt_BO','X_LH','Y_LH','tcalc');
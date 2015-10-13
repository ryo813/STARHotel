% LW-PLS と jDE に基づく操業条件最適化
clear
load suchi03.mat

% 等間隔の格子点，ランダム，ラテン格標本の3種類でデータを生成
% サンプル数 N はベイズ的最適化と同じ 20 とする
N = 50;
M = 10;   % 入力変数の数
xst = -1;
xfn =  1;

% 最適化(最大化)を行う関数
optfunc = @(x) -sum(x.^2);

for i = 1 : 100
  
  i


  %% ランダム
  rnd.X = 2 * rand(N,M) - 1;
  for n = 1 : N
    rnd.Y(n,1) = optfunc(rnd.X(n,:));
  end
  [rnd.xopt,rnd.fest] = LWPLS_jDE(rnd.X,rnd.Y);
  rnd.fopt  = optfunc(rnd.xopt);


  %% ラテン格標本
  lhs.X = 2 * lhsdesign(N,M) - 1;
  for n = 1 : N
    lhs.Y(n,1) = optfunc(lhs.X(n,:));
  end
  [lhs.xopt,lhs.fest] = LWPLS_jDE(lhs.X,lhs.Y);
  lhs.fopt  = optfunc(lhs.xopt);
  
  
  %% ベイズ的最適化
  bopt.X      = X_BO{i};
  bopt.Y      = Y_BO{i};
  bopt.xopt   = xopt_BO{i};
  bopt.fopt   = fopt_BO{i};
  
  
  %% ベイズ的最適化 + LW-PLS + jDE
  bopt_lwjde.X = X_BO{i};
  bopt_lwjde.Y = Y_BO{i};
  [bopt_lwjde.xopt,bopt_lwjde.fest] = LWPLS_jDE(bopt_lwjde.X, bopt_lwjde.Y);
  bopt_lwjde.fopt  = optfunc(bopt_lwjde.xopt);
  
  
  %% データのセーブ
  save(['Result/data',num2str(i),'.mat'],'eqit','rnd','lhs','bopt','bopt_lwjde')
  
end
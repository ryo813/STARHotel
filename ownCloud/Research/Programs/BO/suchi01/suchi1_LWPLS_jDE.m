% LW-PLS と jDE に基づく操業条件最適化
clear
load suchi01.mat

% 等間隔の格子点，ランダム，ラテン格標本の3種類でデータを生成
% サンプル数 N はベイズ的最適化と同じ 20 とする
N = 20;
M = 1;   % 入力変数の数
xst = -50;
xfn =  50;

% 最適化(最大化)を行う関数
optfunc = @(x) sin(x) + 2 * cos(x/2) + 3 * sin(x/3) - 8 * cos(x/10);

for i = 1 : 100
  
  i

  %% 等間隔の格子点
  intvl = (xfn - xst) / 19;
  eqit.X = (xst : intvl : xfn)';
  eqit.Y = optfunc(eqit.X);
  [eqit.xopt,eqit.fest] = LWPLS_jDE(eqit.X,eqit.Y);
  eqit.fopt = optfunc(eqit.xopt);


  %% ランダム
  rnd.X = 100 * rand(N,1) - 50;
  rnd.Y = optfunc(rnd.X);
  [rnd.xopt,rnd.fest] = LWPLS_jDE(rnd.X,rnd.Y);
  rnd.fopt  = optfunc(rnd.xopt);


  %% ラテン格標本
  lhs.X = 100 * lhsdesign(N,1) - 50;
  lhs.Y = optfunc(lhs.X);
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
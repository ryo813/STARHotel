% LW-PLS �� jDE �Ɋ�Â����Ə����œK��
clear
load suchi01.mat

% ���Ԋu�̊i�q�_�C�����_���C���e���i�W�{��3��ނŃf�[�^�𐶐�
% �T���v���� N �̓x�C�Y�I�œK���Ɠ��� 20 �Ƃ���
N = 20;
M = 1;   % ���͕ϐ��̐�
xst = -50;
xfn =  50;

% �œK��(�ő剻)���s���֐�
optfunc = @(x) sin(x) + 2 * cos(x/2) + 3 * sin(x/3) - 8 * cos(x/10);

for i = 1 : 100
  
  i

  %% ���Ԋu�̊i�q�_
  intvl = (xfn - xst) / 19;
  eqit.X = (xst : intvl : xfn)';
  eqit.Y = optfunc(eqit.X);
  [eqit.xopt,eqit.fest] = LWPLS_jDE(eqit.X,eqit.Y);
  eqit.fopt = optfunc(eqit.xopt);


  %% �����_��
  rnd.X = 100 * rand(N,1) - 50;
  rnd.Y = optfunc(rnd.X);
  [rnd.xopt,rnd.fest] = LWPLS_jDE(rnd.X,rnd.Y);
  rnd.fopt  = optfunc(rnd.xopt);


  %% ���e���i�W�{
  lhs.X = 100 * lhsdesign(N,1) - 50;
  lhs.Y = optfunc(lhs.X);
  [lhs.xopt,lhs.fest] = LWPLS_jDE(lhs.X,lhs.Y);
  lhs.fopt  = optfunc(lhs.xopt);
  
  
  %% �x�C�Y�I�œK��
  bopt.X      = X_BO{i};
  bopt.Y      = Y_BO{i};
  bopt.xopt   = xopt_BO{i};
  bopt.fopt   = fopt_BO{i};
  
  %% �x�C�Y�I�œK�� + LW-PLS + jDE
  bopt_lwjde.X = X_BO{i};
  bopt_lwjde.Y = Y_BO{i};
  [bopt_lwjde.xopt,bopt_lwjde.fest] = LWPLS_jDE(bopt_lwjde.X, bopt_lwjde.Y);
  bopt_lwjde.fopt  = optfunc(bopt_lwjde.xopt);
  
  
  %% �f�[�^�̃Z�[�u
  save(['Result/data',num2str(i),'.mat'],'eqit','rnd','lhs','bopt','bopt_lwjde')
  
  
end
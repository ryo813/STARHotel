% LW-PLS �� jDE �Ɋ�Â����Ə����œK��
clear
load suchi02.mat

% ���Ԋu�̊i�q�_�C�����_���C���e���i�W�{��3��ނŃf�[�^�𐶐�
% �T���v���� N �̓x�C�Y�I�œK���Ɠ��� 20 �Ƃ���
N = 50;
M = 1;   % ���͕ϐ��̐�
xst = -1;
xfn =  1;

% �œK��(�ő剻)���s���֐�
optfunc = @(x) -sum(x.^2);

for i = 1 : 100
  
  i

  %% �����_��
  rnd.X = 2 * rand(N,2) - 1;
  for n = 1 : N
    rnd.Y(n,1) = optfunc(rnd.X(n,:));
  end
  [rnd.xopt,rnd.fest] = LWPLS_jDE(rnd.X,rnd.Y);
  rnd.fopt  = optfunc(rnd.xopt);


  %% ���e���i�W�{
  lhs.X = 2 * lhsdesign(N,2) - 1;
  for n = 1 : N
    lhs.Y(n,1) = optfunc(lhs.X(n,:));
  end
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
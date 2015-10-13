%% BO ���l�� (1����)

% �œK���i�ő剻�j�������]���֐��̐ݒ�
optfunc = @(x) sin(x) + 2 * cos(x/2) + 3 * sin(x/3) - 8 * cos(x/10);
X_BO = {};
Y_BO = {};
xopt_BO = {};
fopt_BO = {};
X_LH = {};
Y_LH = {};

for i = 1 : 100

  i
  
  % �ŏ��ɗ^����f�[�^�Z�b�g�̐���
  Xinit = 0;  % �����l�������l�Ƃ��ė^���Ă���
  Yinit = optfunc(Xinit);
  Nite  = 19;

  % BO �ɂ��œK������т��̃f�[�^�̎擾
  [xopt, fopt, X, Y] = BO(optfunc, Xinit, Yinit, Nite);
  X_BO{i} = X;
  Y_BO{i} = Y;
  xopt_BO{i} = xopt;
  fopt_BO{i} = fopt;
  
  % Latin Hypercube sampling�p�Ƀf�[�^�𐶐�
  [N,M] = size(X_BO);
  X_LH{i} = lhsdesign(N,M);
  Y_LH{i} = optfunc(X_LH{i});
    
end

% �f�[�^�̕ۑ�
save('suchi01.mat','X_BO','Y_BO','xopt_BO','fopt_BO','X_LH','Y_LH');
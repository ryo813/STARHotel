%% BO ���l�� (2����)

% �œK���i�ő剻�j�������]���֐��̐ݒ�
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
  
  % �ŏ��ɗ^����f�[�^�Z�b�g�̐���
  Xinit = rand(1,2);  % �����l���œK�l�ł��邽�߁C�����ŗ^����
  Yinit = optfunc(Xinit);
  Nite  = 49;

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
  
  tcalc{i} = toc;
    
end

% �f�[�^�̕ۑ�
save('suchi02.mat','X_BO','Y_BO','xopt_BO','fopt_BO','X_LH','Y_LH','tcalc');
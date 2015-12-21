% Bayesian Optimization �̎g����
clear
close all


% �œK���i�ő剻�j�������]���֐��̐ݒ�
optfunc = @(x) sin(x) + 2 * cos(x/2) + 3 * sin(x/3) - 8 * cos(x/10);

% �ŏ��ɗ^����f�[�^�Z�b�g�̐���
Xinit = 100 * rand - 50;
Yinit = optfunc(Xinit);

% Bayesian Optimization �ōœK�_��T��
Nite = 30;  % BO�̌J��Ԃ���
[xopt, fopt] = BO(optfunc, Xinit, Yinit, Nite);

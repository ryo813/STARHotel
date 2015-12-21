function K = MaternKernel(X1,X2,theta,theta0)
% ------------------------------------------------------------------------
% K = MaternKernel(X1,X2,theta,theta0)
%
% Input
%  X1     (N1 * M)  :  Input matrix 1
%  X2     (N2 * M)  :  Input matrix 2
%  theta  (1  * M)  :  scale parameters of input variables called sigma
%                     (caltion: not squared sigma.^2)
%  theta0 (1  * 1)  :  amplitude parameter of Matern kernel
%
% Output
%  K      (N1 * N2) : Gram matrix with Matern kernel
% ------------------------------------------------------------------------

% setting
N1 = size(X1,1);
N2 = size(X2,1);

%%% calculating (fast version) %%%

% Step1: Constructing new input matrices X1_sig and X2_sig
%         that is put on the weight sigma
X1_sig  = X1 .* ( ones(N1,1) * (1./theta) );
X2_sig  = X2 .* ( ones(N2,1) * (1./theta) );

% Step2: Calculating R matrix using fast calculation technique
%          used in Gaussian kernel
% derive squared sum
x1_sq = sum(X1_sig.^2, 2);
x2_sq = sum(X2_sig.^2, 2);
% vectorize
X1_sq = x1_sq * ones(1,N2);
X2_sq = x2_sq * ones(1,N1);
R     = X1_sq + X2_sq' - 2 * X1_sig * X2_sig';
R( R < 0 ) = 0;
Rh = sqrt(R);  % square root of matrix R
K  = theta0 * ( ones(N1,N2) + sqrt(5) * Rh + 5/3 * R ) ...
           .* exp( -sqrt(5) * Rh );

% avoid that K is not a symmetric matrix
if N1 == N2
  K  = ( K + K' ) / 2;
end
function [yq,W,T,P,R,B,xm,xs,ym,ys,xmw,ymw,omega] = max_LWPLS2(X,Y,xq,LV,phi,scflag,weight)
% ------------------------------------------------------------------------
%  [yq,W,T,P,R,B,xm,xs,ym,ys,xmw,ymw,omega] =
%                  LWPLS2(X,Y,xq,LV,phi,scflag,weight)
%
%  Description:
%   Locally Weighted Partial Least Squares: LWPLS2
%
%  Input:
%    X        (N * M)  : Input variable Matrix
%    Y        (N * L)  : Output variable Matrix
%    xq       (1 * M)  : Query vector
%    LV       (1 * 1)  : number of latent variables
%    phi      (1 * 1)  : localization parameter
%    scflag   (1 * 1)  : scaling flag (default: 0)
%                          0 -> not scaling
%                          1 -> scaling within alogorithm only
%                          2 -> scaling within algorithm and yq scaled
%    wight    (M * 1)  : diagonal element of weight matrix (default: I)
%
%  Output:
%    yq       (1 * L)  : Estimation output variable
%    W        (M * LV) : Weight Matrix
%    T        (N * LV) : Score Matrix
%    P        (M * LV) : Loading Matrix
%    R        (M * LV) : Weight Matrix without deflation X
%    B        (M * L)  : coefficient matrix
%    xm       (1 * M)  : x central value
%    xs       (1 * M)  : x standart deviation
%    ym       (1 * L)  : y central value
%    ys       (1 * L)  : y standart deviation
%    xmw      (1 * M)  : x weighted central value
%    ymw      (1 * L)  : y weighted central value
%    omega    (N * 1)  : similarity vecter calculated based on xq
%
%  Coded by Ryosuke YOSHIZAKI, Kyoto Univ., Apr. 07, 2015
% ------------------------------------------------------------------------

% Initialize
[N,M]   = size(X);
L       = size(Y,2);
epsilon = 1e-5;
if nargin < 7
  weight = ones(M,1);
  if nargin < 6
    scflag = 0;
  end
end

% Normalization
if scflag == 0
  xm = zeros(1,size(X,2));
  xs = ones(1,size(X,2));
  ym = zeros(1,size(Y,2));
  ys = ones(1,size(Y,2));
elseif scflag == 1
  [X,xm,xs] = autoscale(X);
  xs(xs==0) = inf;
  [Y,ym,ys] = autoscale(Y);
  xq = ( xq - xm ) ./ xs;
else
  [X,xm,xs] = autoscale(X);
  xs(xs==0) = inf;
  [Y,~,~] = autoscale(Y);
  ym = zeros(1,size(Y,2));
  ys = ones(1,size(Y,2));
  xq = ( xq - xm ) ./ xs;
end

% Initialization
W  = zeros(M,LV);
T  = zeros(N,LV);
P  = zeros(M,LV);
Q  = zeros(L,LV);
tq = zeros(1,LV);

% Calculate weight matrix omega
E        = X - repmat(xq,N,1);
dist     = sqrt(E.^2 * weight);
omega    = exp( -dist * phi / std(dist) );

% weighted centering
omega_center = omega ./ sum(omega) * N;
xmw = mean(X .* repmat(omega_center,1,M));
ymw = mean(Y .* repmat(omega_center,1,L));
Xpls = X - repmat(xmw, N, 1);
Ypls = Y - repmat(ymw, N, 1);
xqw  = xq - xmw;

% LWPLS2 Algorithm with SVD
yq = ymw;  %  initial setting
for lv = 1 : LV
  % contrivance to avoid calculating SVD for zero-close Xpls
  if epsilon < norm(Xpls)
    % Set Xr, Yr and xqr
    XOY = Xpls'*(repmat(omega,1,L).*Ypls);
    [Wmat, ~, ~] = svd(XOY, 0);
    W(:,lv) = Wmat(:,1);
    % Derive the r-th latent variables
    T(:,lv) = Xpls * W(:,lv);
    % Derive the matrices to calculate faster
    OT      = omega   .* T(:,lv);
    TOT     = T(:,lv)' * OT;
    % Derive the r-th loading vectors
    P(:,lv) = Xpls' * OT / TOT;
    Q(:,lv) = Ypls' * OT / TOT;
    % Derive the r-th latent variable
    tq(lv)  = xqw * W(:,lv);
    % Updata estimation value: yq
    yq      = yq + tq(lv) * Q(:,lv)';
    % Deflation
    Xpls = Xpls - T(:,lv) * P(:,lv)';
    Ypls = Ypls - T(:,lv) * Q(:,lv)';
    xqw  = xqw  - tq(lv)  * P(:,lv)';
  end
end

% calculate matricies
Xnan = isnan(Xpls);
if epsilon < norm(Xpls)
  R = W * inv(P' * W);
  B = R * Q';
% when SVD cannot conduct
elseif sum(Xnan(:)) ~= 0
  R = inf(M,LV);
  B = R * Q';
else
  % inv is substituted for pinv
  % because P'*W is not full-rank matrix
  R = W * pinv(P' * W);
  B = R * Q';
end

% re-scaling
yq = yq .* ys + ym;

yq = -yq;  % for maximization



% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% Copyright (c) 2015. The Human Systems Laboratory,
% Department of Systems Science, Graduated School of Informatics,
% Kyoto University (HSL).
% All rights reserved.
% Republication or redistribution is prohibited without the prior
% written consent of HSL.
%
% IN NO EVENT SHALL HSL BE LIABLE TO ANY PARTY FOR DIRECT, INDIRECT,
% SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES, INCLUDING LOST PROFITS,
% ARISING OUT OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION.
%
% HSL SPECIFICALLY DISCLAIMS ANY WARRANTIES, INCLUDING,
% BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
% FITNESS FOR A PARTICULAR PURPOSE.
% THE SOFTWARE AND ACCOMPANYING DOCUMENTATION,
% IF ANY, PROVIDED HEREUNDER IS PROVIDED "AS IS".
% HSL HAS NO OBLIGATION TO PROVIDE MAINTENANCE, SUPPORT,
% UPDATES, ENHANCEMENTS, OR MODIFICATIONS.
% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
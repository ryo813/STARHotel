function [PRESS, LV, phi] = LWPLS2_cv(Xtrain,Ytrain,vecLV,vecPhi,scflag,weight)
% -----------------------------------------------------------------------
%  [PRESS, LV, phi] = LWPLS2_cv(Xtrain,Ytrain,vecLV,vecPhi,scflag)
%
%  Description:
%   Leave-one-out cross validation (LOOCV)
%    for Locally-Weighted Partial Least Squares: LWPLS2
%
%  Input:
%    Xtrain   (N * M)  : input variable matrix for training
%    Ytrain   (N * L)  : output variable matrix for training
%    vecLV    (1 * P1) : candidate vactor of latent variables
%    vecPhi   (1 * P2) : candidate vector of localization parameters
%    scflag   (1 * 1)  : scaling flag (default: 0)
%                          0 -> not scaling
%                          1 -> scaling within alogorithm only
%                          2 -> scaling within algorithm and yq scaled
%    weight   (M * 1)  : diagonal element of weight matrix (default: I)
%
%  Output:
%    PRESS    (1 * 1)  : prediction error sum of squares
%    LV       (1 * 1)  : number of latent variable
%    phi      (1 * 1)  : localization parameter
%
%  Coded by Ryosuke YOSHIZAKI, Kyoto Univ., Apr. 13, 2015
% -----------------------------------------------------------------------

%%% setting %%%
[N,M] = size(Xtrain);
P1    = length(vecLV);
P2    = length(vecPhi);
Press = zeros(P1,P2);
if nargin < 6
  weight = ones(M,1);
  if nargin < 5
    scflag = 0;
  end
end
% acuqiring the mean and std value to devide Yq
if scflag == 2
  [~,ym,ys] = autoscale(Ytrain);
end

%%% calculate Press %%%
for p1 = 1 : P1
  for p2 = 1 : P2
    for n = 1 : N
      % extract data for validation
      [X,Y,Xq,Yq] = extractDataset(Xtrain,Ytrain,n);
      % developing LWPLS2 model and get estimation Yhat
      [Yhat,~,~,~,~,~,~,~,~,~,~,~,~] = ...
         LWPLS2(X,Y,Xq,vecLV(p1),vecPhi(p2),scflag,weight);
      % accumulate Press
      if scflag == 2
        Nq = size(Yq,1);
        Yq = ( Yq - repmat(ym,Nq,1) ) ./ repmat(ys,Nq,1);
      end
      Press(p1,p2) = Press(p1,p2) + norm(Yhat - Yq)^2;
    end
  end
end

%%% search minimum PRESS point %%%
[PRESS, posLV, posPhi] = minMat(Press);
LV  = vecLV(posLV);
phi = vecPhi(posPhi);



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
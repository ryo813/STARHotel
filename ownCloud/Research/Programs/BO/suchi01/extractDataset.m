function [X,Y,Xq,Yq] = extractDataset(Xtrain,Ytrain,exIndex)
% ------------------------------------------------------------
%  [X,Y,Xq,Yq] = extractDataset(Xtrain,Ytrain,exIndex)
%
%   Description:
%     This function extract dataset for cross validation
%
%   Input:
%     Xtrain  (N  * M)   :  X training data
%     Ytrain  (N  * L)   :  Y training data
%     exIndex (Nq * 1)   :  extnucting number
%
%   Output
%     X       (N-Nq * M) :  input matrix
%     Y       (N-Nq * L) :  output matrix
%     Xq      (Nq * M)   :  query matrix of input
%     Yq      (Nq * M)   :  query matrix of output
%
%  Coded by Ryosuke YOSHIZAKI, Kyoto Univ., Apr. 07, 2015
% ------------------------------------------------------------

%%% extracting data %%%
Xq = Xtrain(exIndex,:);
Yq = Ytrain(exIndex,:);
X  = Xtrain;
Y  = Ytrain;
X(exIndex,:) = [];
Y(exIndex,:) = [];



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
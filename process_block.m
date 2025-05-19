% 4B

function [ newB, num_zeros ] = process_block( B, tol )
% Applies compression algorithm to a 15x15 block of integers
% and produces a new image matrix and a count of zeros in
% the compressed coefficient matrix.

% Consumed values:
%   B is a 15x15 image matrix
%   tol is a nonnegative number used in the compression of the
%       Fourier coefficients (only coefficients greater than tol are maintained)

% Produced values:
%   newB is a 15x15 image matrix, resulting from applying ifft2 to our
%       compressed coefficient matrix (type uint8)
%   num_zeros is the number of coefficients that are 0 in the
%       compressed coefficient matrix (some of them may have been 0 originally)

    % Apply 2-d fft to the 15x15 block
    FB = fft2(B);
    % Discard entries with real values less than the tolerance
    % mask is a matrix of binary values indicating if the entry is less than tol or not
    % use the inversed values of mask as a map on FB to discard (mult by 0) the < tol entries
    maxValue = tol;
    mask = abs(FB) < maxValue;
    newF = FB.*~mask;
    % Apply the inverse operation to this "compressed" matrix
    newB = ifft2(newF);
    % Convert complex entries back to real values that are in range
    newB = uint8(real(newB));
    % Count num of zero entries in newB
    numofzeros = newB == 0;
    num_zeros = sum(numofzeros, "all");
end
    
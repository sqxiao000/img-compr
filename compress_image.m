function [ compressedP, compression_rate ] = compress_image( P, tol )
% Compresses an image setting small Fourier coefficients to 0

% Consumed values:
%   P is a n x m x 3 colour image matrix
%   tol is a nonnegative number used in the compression of the
%       Fourier coefficients (only coefficients greater than tol are maintained)

% Produced values:
%   compressedP is the n x m x 3 colour image matrix, which is the same
%       size as P, but which is constructed from the compressed Fourier coefficients of P
%   compression_rate is a number between 0 and 100, which gives the
%       percentage of zero Fourier coefficients set to 0 (i.e. whose values were less than tol).
%       compression_rate is calculated as the total number of Fourier
%       coefficients set to 0 in the compression process divided by the
%       number of pixels in the padded image matrix of P.

    % save the original size of P
    [rows,columns,colours] = size(P);
    % Pad matrix is assist with 15x15 block processing
    paddedP = pad15(P);
    sz = size(paddedP);
    padded_rows = sz(1);
    padded_columns = sz(2);
    % initialize compressedP to all uint8 zeros.
    compressedP = zeros(padded_rows, padded_columns, colours, 'uint8');
    num_zeros = padded_rows*padded_columns*colours;
    % for each colour
    for colour = 1:3
    % Divide paddedP(:,:,colour) into 15x15 blocks, processing each in term, and saving the result in compressedP.
        rows_of_15 = padded_rows/15;
        cols_of_15 = padded_columns/15;
        for r = 0:rows_of_15 - 1
            for c = 0:cols_of_15 - 1
                block = paddedP(15*r+1:15*r+15,15*c+1:15*c+15,colour);
                [modified,nz] = process_block(block, tol);
                num_zeros = num_zeros - (225-nz);      % modify num_zeros by subtracting number of non-zero entries in this block
                compressedP(15*r+1:15*r+15,15*c+1:15*c+15,colour) = modified;
            end
        end
    end
    % Trim any extra rows and columns of P
    compressedP = compressedP(1:rows, 1:columns, 1:colours);
    % ensure uint8 values
    compressedP = uint8(compressedP);
    % Compute percentage of 0 entries by multiplying by 100 and rounding
    compression_rate = round(100*(num_zeros/(padded_rows*padded_columns*3)));
end
    

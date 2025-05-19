function [ P_padded ] = pad15( P )
    %pad - produces a new matrix like P, except that the number of rows and
    %columns are both multiples of 15.
    % Note that P is n x m x 3.
    % Rows and columns of 0 are added to the "end" of P, if needed.
    % save original size of P
    [rows,columns,colours] = size(P);
    % determine the number of "extra" rows and columns in P
    rm15 = mod(rows, 15);
    cm15 = mod(columns, 15);

    % Determine new row and column numbers that are now multiples of 15.
    % Use to initialize P_pad and P_padded.
    prows = rows+15-rm15;
    pcols = columns+15-cm15;

    % Add 15-rm15 rows of zeros to each of the colour matrices
    % Initialize 0-matrix with extended rows (if applicable).
    % The number of rows in each of P1, P2, P3 is now a multiple of 15.
    if rm15 > 0
        P_pad = zeros(prows, columns, colours);
        P_pad(1:rows, 1:columns, :) = P;
    else
        P_pad = P;
    end

    % Add 15-cm15 columns to the already enlarged matrices
    % Initialize new 0-matrix with extended columns (if applicable).
    % The number of columns in each of P1, P2, P3 is now a multiple of 15.
    if cm15 > 0
        P_padded = zeros(prows, pcols, colours);
        P_padded(1:rows, 1:columns, :) = P_pad;
    else
        P_padded = P_pad;
    end
end

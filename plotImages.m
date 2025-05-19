function [ ] = plotImages( image_file)
% plotImages plots the image in image_file with various levels of compression

    % Consumed value:
    %   image_file is the name of a jpg/jpeg file in the current
    %       folder that will be displayed with approximately 50, 80, and 95% compression

    orient landscape;

    % Experiment with the values of tol50, tol80, tol95
    % to achieve compressions rates close to 50%, 80%, and 95%

    P = imread(image_file);
    subplot(2,2,1);
    image(P);
    title("Original Image");
    axis off;
    subplot(2,2,2);
    tol50 = 3500; % adjust this value
    [cP50, comp50] = compress_image(P, tol50);
    image(cP50);
    title(strcat("Compression Rate: ",num2str(comp50)));
    axis off;
    subplot(2,2,3);
    tol80 = 29900; % adjust this value
    [cP80, comp80] = compress_image(P, tol80);
    image(cP80);
    title(strcat("Compression Rate: ",num2str(comp80)));
    axis off;
    subplot(2,2,4);
    tol95 = 34300; % adjust this value
    [cP95, comp95] = compress_image(P, tol95);
    image(cP95);
    title(strcat("Compression Rate: ",num2str(comp95)));
    axis off;
end

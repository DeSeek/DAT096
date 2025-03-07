
% test file and comparison between manually and calling directly
testblock = [52, 55, 61, 66, 70, 61, 64, 73;
         63, 59, 55, 90, 109, 85, 69, 72;
         62, 59, 68, 113, 144, 104, 66, 73;
         63, 58, 71, 122, 154, 106, 70, 69;
         67, 61, 68, 104, 126, 88, 68, 70;
         79, 65, 60, 70, 77, 68, 58, 75;
         85, 71, 64, 59, 55, 61, 65, 83;
         87, 79, 69, 68, 65, 76, 78, 94];


% manually
dct_result1 = dct8manual(testblock);
disp('DCT Result (Ma):');
disp(dct_result1);

% calling directly
dct_result2 = dct2(testblock);
disp('DCT Result (Dr):');
disp(dct_result2);
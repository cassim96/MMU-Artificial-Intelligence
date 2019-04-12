% a script to do the coding in the very simplest way...

% 1. load the training data
train_images = loadMNISTImages('train-images.idx3-ubyte');
train_labels = loadMNISTLabels('train-labels.idx1-ubyte');

% 2. convert the images into a 2D matrix
train_params = reshape(train_images, size(train_images, 1) * size(train_images, 2), size(train_images, 3));

% 3. save them to a CSV file
saveMNIST_csvfile('train_data1.csv',train_params,train_labels);

% 4. now repeat that for the testing data
test_images = loadMNISTImages('t10k-images.idx3-ubyte');
test_labels = loadMNISTLabels('t10k-labels.idx1-ubyte');
test_params = reshape(test_images, size(test_images, 1) * size(test_images, 2), size(test_images, 3));
saveMNIST_csvfile('test_data1.csv',test_params,test_labels);

% N.B. your instructions are to ensure that there are an equal number of
% '4' and non-'4' images in the *training* set. You should ensure that the
% distributuon of non-'4' images stays the same. This can be done in EXCEL
% (i.e. on the csv-file).
% Stages:
% 1. Add an extra column to the file, with each value set to be a random
% number (put "=rand()" in the second cell of the column, and then copy 
% this down into the lower ones).
% 2. Sort the file (avaiable under the "data" tab) on "label" and then 
% this new random column.
% 3. Count the number of times "one" appears in the "label" column
% 4. Delete all lines more than this many lines below the last "one"
% 5. Delete the random-number column.
% N.B. *Don't* do this to the test data.
% A procedure for doing this in MATLAB will follow.
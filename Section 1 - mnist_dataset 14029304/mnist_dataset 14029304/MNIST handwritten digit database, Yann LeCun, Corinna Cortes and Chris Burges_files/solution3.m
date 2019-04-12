% a script to do the coding with some compresion
% a) automatic selection of distractor images
% b) sum rows and columns (separately)
% c) discard any zero-variance parameters

% 1. load the training data
train_images = loadMNISTImages('train-images.idx3-ubyte');
train_labels = loadMNISTLabels('train-labels.idx1-ubyte');

% 2. remove the excess non-'4' images
[train_images, train_labels] = nc_equaliseDistribution(4,train_images,train_labels);

% 3. get the means of the rows and columns of each image
train_params = squeeze([mean(train_images,1) permute(mean(train_images,2),[2 1 3])]);

% 4. measure the variance of the different pixels and discard those which
% are zero
train_stds = std(train_params');
tokeep = find(train_stds>0);
train_params = train_params(tokeep,:);

% 5. save them to a CSV file
saveMNIST_csvfile('train_data3.csv',train_params,train_labels);

% 5. now repeat that for the testing data - don't fiddle the excess
test_images = loadMNISTImages('t10k-images.idx3-ubyte');
test_labels = loadMNISTLabels('t10k-labels.idx1-ubyte');
test_params = squeeze([mean(test_images,1) permute(mean(test_images,2),[2 1 3])]);
test_params = test_params(tokeep,:);
saveMNIST_csvfile('test_data3.csv',test_params,test_labels);


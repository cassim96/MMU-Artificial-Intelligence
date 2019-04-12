% 1. load the training data
train_images = loadMNISTImages('train-images.idx3-ubyte');
train_labels = loadMNISTLabels('train-labels.idx1-ubyte');

% 2. convert the images into a 2D matrix
train_params = reshape(train_images, size(train_images, 1) * size(train_images, 2), size(train_images, 3));

% 3. remove the excess non-'4' images
[train_images, train_labels] = nc_equaliseDistribution(4,train_images,train_labels);

% 4. get the means of the rows and columns of each image
train_params = squeeze([mean(train_images,1) permute(mean(train_images,2),[2 1 3])]);

% 5. measure the variance of the different pixels and discard those which
% are zero
train_stds = std(train_params');
tokeep = find(train_stds>0);
train_params = train_params(tokeep,:);

% 6. save them to a CSV file
saveMNIST_csvfile('train_data1.csv',train_params,train_labels);

% 7. now repeat that for the testing data
test_images = loadMNISTImages('t10k-images.idx3-ubyte');
test_labels = loadMNISTLabels('t10k-labels.idx1-ubyte');
test_params = reshape(test_images, size(test_images, 1) * size(test_images, 2), size(test_images, 3));
saveMNIST_csvfile('test_data1.csv',test_params,test_labels);

% 8. combine the files
combine_csvfiles('train_data1.csv','test_data1.csv','train_test_data1.csv');
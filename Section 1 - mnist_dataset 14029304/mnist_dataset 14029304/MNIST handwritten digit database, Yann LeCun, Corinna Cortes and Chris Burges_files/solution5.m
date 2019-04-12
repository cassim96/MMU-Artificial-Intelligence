% a script to do the coding in a more complex way
% a) build a collections of PC models
% b) equalise the distributions
% c) get the representation-radius and -error for each image
% d) do the same encoding for each test image.

% 1. load the training data
train_images = loadMNISTImages('train-images.idx3-ubyte');
train_labels = loadMNISTLabels('train-labels.idx1-ubyte');

% 2. Build a set PC models
pc_set = nc_trainPCModels(train_images,train_labels,0.95,50.0);

% 3. remove the excess non-'4' images
[train_images, train_labels] = nc_equaliseDistribution(4,train_images,train_labels);

% 3. encode the images on the models
[train_params,train_labels] = nc_encodePCModels(pc_set,train_images,train_labels,50.0);

% 4. save them to a CSV file
saveMNIST_csvfile('train_data5.csv',train_params,train_labels);

% 5. now repeat that for the testing data - don't fiddle the excess
test_images = loadMNISTImages('t10k-images.idx3-ubyte');
test_labels = loadMNISTLabels('t10k-labels.idx1-ubyte');
test_params = nc_encodePCModels(pc_set,test_images);
saveMNIST_csvfile('test_data5.csv',test_params,test_labels);

% 6. combine the files
combine_csvfiles('train_data5.csv','test_data5.csv','train_test_data5.csv');

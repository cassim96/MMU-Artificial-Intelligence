% a script to do the coding in a more complex way
% a) discard excess one-4 images
% b) use Ohtsu's algorithm to threshold the images
% c) use CCA to ensure only the largest single unit is procesed
% d) use morphology to get the edge
% e) use a chain code to record the size and perimeter
% f) use co-occurence matrices on the whole image to get a texture measure
% g) vary the offset to maximize discrimination
% h) combine the shape and texture measures before outputting the data 

% 1. load the training data
train_images = loadMNISTImages('train-images.idx3-ubyte');
train_labels = loadMNISTLabels('train-labels.idx1-ubyte');

% 2. remove the excess non-'4' images
[train_images, train_labels] = nc_equaliseDistribution(4,train_images,train_labels);

% 3. threshold the images
thres_train_images = nc_ohtsuThreshold(train_images);

% 4. get the area and perimeter from the chain code
offsets = [0 1 2 3 4 0 0 0 0; 0 0 0 0 0 1 2 3 4];
quant = 2;
train_params = nc_cooccurParams(thres_train_images,offsets,quant);

% 5. Some may have zero variance
train_stds = std(train_params,0,2);
tokeep = find(train_stds>0);
train_params = train_params(tokeep,:);

% 5. save them to a CSV file
saveMNIST_csvfile('train_data4.csv',train_params,train_labels);

% 5. now repeat that for the testing data - do't alter the distribution
test_images = loadMNISTImages('t10k-images.idx3-ubyte');
test_labels = loadMNISTLabels('t10k-labels.idx1-ubyte');
thres_test_images = nc_ohtsuThreshold(test_images);
test_params = nc_cooccurParams(thres_test_images,offsets,quant);
test_params = test_params(tokeep,:);
saveMNIST_csvfile('test_data4.csv',test_params,test_labels);

% 6. combine the files
combine_csvfiles('train_data4.csv','test_data4.csv','train_test_data4.csv');

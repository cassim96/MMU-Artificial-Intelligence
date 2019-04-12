
train_images = loadMNISTImages('train-images.idx3-ubyte');
train_labels = loadMNISTLabels('train-labels.idx1-ubyte');
train_params = reshape(train_images, size(train_images, 1) * size(train_images, 2), size(train_images, 3));

test_images = loadMNISTImages('t10k-images.idx3-ubyte');
test_labels = loadMNISTLabels('t10k-labels.idx1-ubyte');
test_params = reshape(test_images, size(test_images, 1) * size(test_images, 2), size(test_images, 3));

saveMNIST_csvfile('training.csv',train_params,train_labels);
saveMNIST_csvfile('testing.csv',test_params,test_labels);
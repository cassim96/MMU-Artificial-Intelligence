function models = nc_trainPCModels(images, labels, prop, percent)

% this builds a PCA model for the images linked with each individual type
% of label.
% prop is the fraction (range 0 - 1) of the variance in each ensemble to be
% modelled.
% percent is the proportion (range 0 - 100) of the images with each label 
% to be used as the ensemble 

labelSet = unique(labels);
models = cell(length(labelSet),1);
for i=1:length(labelSet)
   theseLabels = find(labels==labelSet(i));
   numUse = floor(percent*length(theseLabels)/100);   
   theseImages = images(:,:,theseLabels(1:numUse));
   thisData = reshape(theseImages, size(theseImages, 1) * size(theseImages, 2), size(theseImages, 3))';
   models{i} = nc_genpc(thisData,prop);
   models{i}.label = labelSet(i);
end
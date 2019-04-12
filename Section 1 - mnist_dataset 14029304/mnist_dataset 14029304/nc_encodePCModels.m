function [params,varargout] = nc_encodePCModels(models, images, varargin)

% this just takes the images and give their radius and error on each model
% varargin allows two different forms: if length(varargin)== 0, we just
% process all the images. If length(varargin==2) we use labels and
% percentage to avoid the images used in the training ensemble.

inData = reshape(images, size(images, 1) * size(images, 2), size(images, 3))';
if length(varargin)==2
   
    labels = varargin{1};
    percent = varargin{2};
    labelSet = unique(labels);
    useLabels = [];
    
    for i=1:length(labelSet)
        theseLabels = find(labels==labelSet(i)); 
        numUse = length(theseLabels)-floor(percent*length(theseLabels)/100);
        useLabels = [useLabels; theseLabels(numUse:end)];
    end    
    inData = inData(useLabels,:);
    varargout{1} = labels(useLabels);
end
    params = zeros(size(inData,1),length(models)*2);
    for i = 1 : length(models)
        for j = 1 : size(inData,1);   
            thisData = inData(j,:) - models{i}.mean;
            thisParam = thisData * models{i}.comp;   
            params(j,i) = sqrt(sum(thisParam.^2));   
            thisProj = thisParam * models{i}.comp';   
            params(j,i+length(models)) = sqrt(sum((thisData-thisProj).^2));   
        end
    end
params = params';
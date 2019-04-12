function outimages = nc_ohtsuThreshold(inimages)
% undertakes Ohtsu thresholding for each plane of the inimages

if max(max(max(inimages)))<=1
    inimages = floor(inimages * 99);
    maxrange = 99;
    numinc = 100;
else
    maxrange = 255;
    numinc = 256;
end
    

outimages = zeros(size(inimages,1),size(inimages,2),size(inimages,3));
range = (0:maxrange);
for j = 1 : size(inimages,3)
    
    inimage = inimages(:,:,j);
    histo = hist(reshape(inimage,numel(inimage),1),range);
    th1 = zeros(1,numinc);
    th2 = zeros(1,numinc);
    thres = zeros(1,numinc);
    for i=1:numinc
        
        if sum(histo(1:i))>0
            th1(i) = sum(histo(1:i).*range(1:i))/sum(histo(1:i));
        else
            th1(i) = 0;
        end
        if sum(histo(i:end))>0
            th2(i) = sum(histo(i:end).*range(i:end))/sum(histo(i:end));
        else
            th2(i) = 0;
        end
        
        thres(i) = (th1(i) + th2(i))/2;
    end
    diffs = ((thres-range).^2).^0.5;
    minthres = find(diffs==min(diffs),1);
    outimage = zeros(size(inimage));
    outimage(inimage>=minthres)=1;
    outimages(:,:,j) = outimage;
end
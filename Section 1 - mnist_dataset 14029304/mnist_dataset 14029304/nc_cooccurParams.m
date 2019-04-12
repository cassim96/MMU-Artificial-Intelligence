function outparams = nc_cooccurParams(inimages,offsets,quant)

outparams = zeros(size(offsets,2)*quant*quant,size(inimages,3));
for i = 1:size(inimages,3)
    k = 1;
    for j = 1:size(offsets,2)
        
        params = nc_cooccur(inimages(:,:,i),offsets(:,j),quant);
        outparams(k:k-1+quant^2,i) = reshape(params,quant^2,1);
        k = k + quant^2;
        
    end
end



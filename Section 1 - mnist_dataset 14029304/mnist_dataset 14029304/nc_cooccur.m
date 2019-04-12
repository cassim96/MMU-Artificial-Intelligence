function outmat = nc_cooccur(inimage,displace,quant)

outmat = zeros(quant,quant);
if max(max(inimage))>1
    inimage = ceil(inimage/(256/(quant-1)))+1;
else
    inimage = ceil(inimage*(quant-1))+1;
end
for i=max([1 1+displace(1)]):min([size(inimage,1) size(inimage,1)-displace(1)])
    for j=max([1 1+displace(2)]):min([size(inimage,2) size(inimage,2)-displace(2)])
        
        v1 = inimage(i,j);
        v2 = inimage(i+displace(1),j+displace(2));
        outmat(v1,v2) = outmat(v1,v2)+1;
       
    end
end
outmat = outmat/sum(sum(outmat));
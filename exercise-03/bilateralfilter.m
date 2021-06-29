function [B] = bilateralfilter(A, w, sigma)
[X,Y] = meshgrid(-w:w,-w:w);
G = exp(-(X.^2+Y.^2)/(2*sigma(1)^2));

n = size(A);
B = zeros(n);
for i = 1:n(1)
   for j = 1:n(2)
         i_vals = max(i-w,1):min(i+w,n(1));
         j_vals = max(j-w,1):min(j+w,n(2));
         
         I = A(i_vals,j_vals);
         
         H = exp(-(I-A(i,j)).^2/(2*sigma(2)^2));
      
         F = G((i_vals)-i+w+1,(j_vals)-j+w+1).*H;
         B(i,j) = sum(F(:).*I(:))/sum(F(:));      
   end
end

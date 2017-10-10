function faceRecognition
%% Load Database of faces (AT&T face database)
Train=loadDatabase;

%% Randomly pick an image from the dataset
ri=round(400*rand(1,1));
r=Train(:,ri);
v=Train(:,[1:ri-1,ri+1:end]);
N=20; %Number of signatures

%% Subtracting the mean from the v
O=uint8(ones(1,size(v,2)));
m=uint8(mean(v,2));
vzm=v-uint8(single(m)*single(O));


%% Calculating the Eigen vector of correlation matrix
L=single(vzm)'*single(vzm);
[V,D]=eig(L);
V=single(vzm)*V;
V=V(:,end:-1: end-(N-1));


%% Calculating the signature for each image
cv=zeros(size(v,2),N);
for i=1:size(v,2)
    cv(i,:)=single(vzm(:,i))'*V;
end


%% Recognition
subplot(121);
imshow(reshape(r,112,92));
title('Image to Find','Fontweight','bold','Fontsize',16);
subplot(122);
p=r-m;
s=single(p)'*V;
z=[];
for i=1:size(v,2)
        z=[z,norm(cv(i,:)-s,2)];

    if(rem(i,20)==0),imshow(reshape(v(:,i),112,92)),end;
   
   drawnow;
end
[a,i]=min(z);
subplot(122);
imshow(reshape(v(:,i),112,92));title('Found!','Fontweight','bold','Fontsize',16,'color','red');


end







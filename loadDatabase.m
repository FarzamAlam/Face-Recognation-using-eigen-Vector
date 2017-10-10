function Train =loadDatabase()
persistent loaded;
persistent weight;
if(isempty(loaded))
    v=zeros(10304,400);
   for i=1:40
       cd('AT&T');
      cd(strcat('s',num2str(i)));
      s=pwd;
      for j=1:10
      a=imread(strcat(num2str(j),'.pgm'));
      v(:,(i-1)*10+j)=reshape(a,size(a,1)*size(a,2),1);
      end
      cd .. ;
      cd ..;
   end
   weight=uint8(v);
end
loaded =1;
Train=weight;
save Train;

end
function I=numericalMeanEstimation(x,f1,f2, offset, nphot)
% I=numericalMeanEstimation(x,f1,f2, offset, nphot)

if ~exist('offset','var')
    offset=0;
end
if ~exist('nphot','var')
    nphot=1;
end
l(:,1)=nphot*f1;
l(:,2)=nphot*f2;
l(:,3)=nphot*(f1+f2);
l(:,4)=zeros(length(f1),1);
lstrong=l+offset;
N=size(l,2);
dx=x(2)-x(1);

prec=10^-10; 
pcdf=poisscdf(0:50*max(lstrong(:)),max(lstrong(:)));
nmax = sum(pcdf<1-prec);

n=0:nmax;
ln=length(n);
lf=length(f1);
nmat = repmat(n',1,lf);

r=zeros(ln,lf,N);
Po=zeros(ln,lf,N);
dlsmat=zeros(ln,lf,N);
maskdl=zeros(ln,lf,N);
for jj=1:N
    lsmat = repmat(lstrong(:,jj)',ln,1);
    maskdl(:,:,jj)=lsmat>10^-8; % Restriction to non-zero lambda (over space)
    dlsmat(:,:,jj)= repmat(gradient(lstrong(:,jj),dx)',ln,1);
    r(:,:,jj)=(nmat-lsmat)./lsmat;
    Po(:,:,jj)=poissonpdfmulti(n,lstrong(:,jj));
end

rPo=Po.*r.*maskdl;
sPo=sum(Po(:,:,1:3),3);


It11=dlsmat(:,:,1).^2.*sum(rPo(:,:,[1,3]),3).^2;
It22=dlsmat(:,:,2).^2.*sum(rPo(:,:,[2,3]),3).^2;
It12=dlsmat(:,:,1).*dlsmat(:,:,2).*sum(rPo(:,:,[1,3]),3).*sum(rPo(:,:,[2,3]),3);
% just testng something
% warning('just testng something in numericalMeanEstimation.m !!!')
% It11=sum(rPo(:,:,[1,3]),3).^2;
% It22=sum(rPo(:,:,[2,3]),3).^2;
% It12=sum(rPo(:,:,[1,3]),3).*sum(rPo(:,:,[2,3]),3);

prec=10^-8;
mask = It11>prec;
I(1,1)=1/4*dx*trapz(It11(mask)./sPo(mask));
mask = It22>prec;
I(2,2)=1/4*dx*trapz(It22(mask)./sPo(mask));
mask = It12>prec;
I(1,2)=1/4*dx*trapz(It12(mask)./sPo(mask));
I(2,1)=I(1,2);
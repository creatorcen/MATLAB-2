% function [X1,X2,dh,minX]=testNMF2
% function [X1,X2,dh,minX]=testNMF2(w,h,p)
[n,m]=size(w*h);
npix = p.nx*p.ny;
wbg = (1/npix)*ones(npix,1);
p.maxh=500;

% xtrue = [15 15+p.separ(1)];
% % nsteps  =
% [X1, X2] = meshgrid(xtrue(1)-0.1:xstep:xtrue(2)+0.1, 14.8:0.05:16.5);
[X1, X2] = meshgrid(14.8:0.05:15.5, 14.8:0.05:15.5);
% [X1, X2] = meshgrid(14.8:0.05:16.5, 14.8:0.05:16.5);




%[X1, X2] = meshgrid(14.8:0.05:15.6, 14.8:0.05:15.6);

% p.maxh=100;

% xmat = [15 15 15+p.separ(1) 15;
%     15+p.separ(1) 15 15 15;
%     15+p.separ(1)/2 15 15+p.separ(1)/2 15;
%     15 15 16 15;
%     15 15 15+p.separ(1) 16];
for ixmat=1:size(X1,1)
    for jxmat=1:size(X1,2)
        x=[X1(ixmat, jxmat), 15, X2(ixmat, jxmat), 15];
        wg = makegauss(x, p.s, [p.nx p.ny]);
        w = [reshape(wg, p.nx*p.ny,size(wg,3)), wbg];
        % normalization of all w:
        sumw = sum(w,1);
        w = w./repmat(sumw,n,1); %normalization of each component
        h = h.*repmat(sumw',1,m); %to keep the multiplication equal
        
        x1=repmat(sum(w,1)',1,m);
        %%%%%test
        h=hinit;
        iih=1;
        for ih = 1: p.maxh
            y1=w'*(v./(w*h));
            h(h_dovec,:)=h(h_dovec,:).*(y1(h_dovec,:))./x1(h_dovec,:);
            h=max(h,eps); % adjust small values to avoid undeflow
%             d(k) = ddivergence(v, w*h);
%             %%%testing
% %             dh(ixmat,iih)=d(k);
% %             iih=iih+1;
%             %%%testing
%             
%             dd(k) = abs(d(k)-d(k-1));
%             fprintf('[%g] Ddivergence %g\n',k, d(k))
%             k=k+1;
        end
        dh(ixmat,jxmat)=ddivergence(v, w*h);
        fprintf('[%g %g] Ddivergence %g\n',ixmat, jxmat, dh(ixmat,jxmat))
        
    end
end
miXval = min(dh(:));
[mx,my]=find(miXval==dh);
minX=[X1(mx,my), X2(mx,my)]


% 
% plot(dh')
% makelegend(xmat,'pos','iter H', 'ddiv');
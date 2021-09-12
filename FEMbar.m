function Stress = FEMbar(F,x,Tnod,mat,Tmat)

%-------------------------------------------------------------------------%
% ASSIGNMENT 1
%-------------------------------------------------------------------------%
% Date: 18-02-2019
% Author/s: Francisco Lupiañez Ayala, Jose Antonio Torres Lerma

%% SOLVER

n_el=12;
R=zeros(2,4,n_el);
for e=1:n_el
    x1=x(Tnod(e,1),1);
    x2=x(Tnod(e,2),1);
    y1=x(Tnod(e,1),2);
    y2=x(Tnod(e,2),2);
    l=sqrt((x2-x1)^2+(y2-y1)^2);
    R=(1/l)*[x2-x1 y2-y1 0 0; 0 0 x2-x1 y2-y1];
    Kprima=mat(1)*mat(2)/l*[1 -1; -1 1];
    K=R'*Kprima*R;
    for r=1:4
        for s=1:4
            K_el(r,s,e)=K(r,s);
        end
    end
end

% Td definition
for e=1:n_el
    for a=1:2
        for j=1:2
            i=2*(a-1)+j;
            Td(e,i)=2*(Tnod(e,a)-1)+j;
        end
    end
end

% ASSEMBLY PROCESS
K_G=zeros(16,16);
for e=1:n_el
    for i=1:4
        I=Td(e,i);
        for j=1:4
            J=Td(e,j);
            K_G(I,J)=K_G(I,J)+K_el(i,j,e);
        end
    end
end

% Displacements and reactions
vR=[1 2 9 10];
vL=[3 4 5 6 7 8 11 12 13 14 15 16];
K_RR=K_G(vR,vR);
K_RL=K_G(vR,vL);
K_LR=K_G(vL,vR);
K_LL=K_G(vL,vL);
F_extL=[0; F; 0; F; 0; F; 0; 0; 0; 0; 0; 0];
uL=inv(K_LL)*F_extL;
R_R=K_RL*uL;

% Strain and stress
u_T=zeros(16,1);
u_T(vL)=uL;
for e=1:n_el
    x1=x(Tnod(e,1),1);
    x2=x(Tnod(e,2),1);
    y1=x(Tnod(e,1),2);
    y2=x(Tnod(e,2),2);
    l=sqrt((x2-x1)^2+(y2-y1)^2);
    R=(1/l)*[x2-x1 y2-y1 0 0; 0 0 x2-x1 y2-y1];
    for i=1:4
        I=Td(e,i);
        u_e(i,1)=u_T(I,1);
    end
    uprima_e=R*u_e;
    Strain(e,1)=(1/l)*[-1 1]*uprima_e;
    Stress(e,1)=mat(1)*Strain(e,1);
end

end
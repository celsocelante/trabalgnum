%PASSO 1
function r = diferencasDivididas(x,y)
	%Calcula a tabela de diferenças divididas e armazena na matriz dd
	n = length(x);
	dd = zeros(n);
	
	dd(:,1) = y';
	r = dd;
	k = 1;
	for j=2:n
		for i=j:n
		    dd(i,j)= (dd(i-1,j-1)-dd(i,j-1)) / (x(i-j+1)-x(i));
			r(i-k,j) = dd(i,j);
		end
		k = k + 1;
	end
endfunction


%PASSO 2
function pb = selecionaPontosBase(n, x, z)
	%Seleciona os pontos base com base na ordem do polinômio interpolador (dado por n)
	pb = zeros(1,n+1);
	for i=1:length(x)
		x(1,i) = abs(z-x(1,i));	
	end
	[A,I] = sort(x);
	pb = sort(I(1,1:n+1));
endfunction


%PASSO 3
function interpola(n, x, y, z)
	%Armazena os indices dos pontos base para a interpolação
	pb = selecionaPontosBase(n,x,z);
	
	%Seleciona os pontos base
	for i = 1:length(pb)
		xn(1,i) = x(1,pb(1,i));
		yn(1,i) = y(1,pb(1,i));
	end
	
	disp("\n\nAs n+1 abscissas escolhidas entre as m abscissas informadas e suas respectivas ordenadas: \n");
	xn
	yn

	%Calcula diferença dividida a partir dos pontos base
	dd = diferencasDivididas(xn,yn);


	%Faz a interpolação
	pz = dd(1,1);
	soma = 0;
	for i = 2:length(xn)
		produto = 1;
		for j = 1:i-1
			produto = produto*(z-xn(1,j));
		end
		soma = soma + produto * dd(1,i);
	end

	
	pz = pz + soma;

	disp("O valor interpolado pelo metodo de Newton: ");
	pz
	
	disp("O valor aproximado do erro de truncamento calculado: ");
	calculaErroTruncamento(z,n,x,y)



endfunction


%PASSO 4
function  calculaErroTruncamento(z, n, x, y)		
	pb = selecionaPontosBase(n,x,z);
	

	for i = 1:length(pb)
		xn(1,i) = x(1,pb(1,i));
		yn(1,i) = y(1,pb(1,i));
	end
	

	produto=1;
	for i=1:length(xn)
		produto = produto*(z-xn(1,i));
	end
	
	dd = diferencasDivididas(x,y);
	[r,c] = size(dd);
	maxdd=dd(1,1);

	for i=1:r
		for j=1:n+2
			if(dd(i,j) > maxdd)
				maxdd=dd(i,j);
			endif
		end
	end

	erro = abs(produto*maxdd)

endfunction


x  = input("Entre com o vetor de abscissas x: ");

y = input("Entre com o vetor de ordenadas y: ");

n = input("Informe o grau do polinomio interpolador: ");

z = input("Informe o valor z a ser interpolado: ");



%interpola(2, [0.2,0.34,0.4,0.52,0.6,0.72], [0.16,0.22,0.27,0.29,0.32,0.37], 0.47)
interpola(n,x,y,z);
















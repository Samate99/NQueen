function [x, Ex] = queen(n)
    tic;
    
    function E = energy(x)
        conflicts = 0;
        for i = 1:n-1
            for j = i+1:n
                if x(i) == x(j) || abs(x(i) - x(j)) == abs(i - j)
                    conflicts = conflicts + 1;
                end
            end
        end
        E = conflicts;
    end

    function x_new = generateNeighbor(x)
        i = randi(n);
        j = randi(n);
        x_new = x;
        x_new(i) = j;
    end

    x = randperm(n);  
    E = energy(x);  
    T = 1;  
    Tmin = 0.01;  
    alpha = 0.99;  

    while T > Tmin
        x_new = generateNeighbor(x);
        E_new = energy(x_new);
        deltaE = E_new - E;

        if deltaE < 0 || exp(-deltaE / T) > rand()
            x = x_new;
            E = E_new;
        end

        T = T * alpha;  
    end

    x = x(:)';
    Ex = E;

    elapsed_time = toc;
       fprintf('Futási idő: %.4f másodperc\n', elapsed_time);
end

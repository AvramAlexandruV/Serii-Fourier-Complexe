function fourierComplex
    clear; clc;

    function [C0, Cp, Cn] = coef(t, z, N)
        C0 =  trapz(t, z);
        for k = 1 : N
            Cp(k) = trapz(t, z .* exp(-1i * k * 2 * pi * t));
            Cn(k) = trapz(t, z .* exp(1i * k * 2 * pi * t));
        end
    end
    
    % x -> partea reala 
    % y -> partea imaginara
    % offset -> folosit pentru a scrie literele una langa alta

    function drawLetter(x, y, offset, axis_x, axis_y)
        % rotim imaginea
        
        y = -y + max(y);

        z = (x + offset) + i*y;
        t = [0 : 1/(length(z)-1) : 1];

        [C0, Cp, Cn] = coef(t, z, N);
        z_ap=C0;
        t_repr=[0:1/M:1];
        for k=1:N
            z_ap=z_ap+Cn(k)*exp(-k*1i*2*pi*t_repr)+Cp(k)*exp(k*i*2*pi*t_repr);
        end;

        figure(1)
        plot(real(z_ap), imag(z_ap),'m')
        axis([0 axis_x+10 0 axis_y])
        hold on
    end

    % program 1
    function drawLetterMod(x, y, offset)
        y = -y + max(y);

        z = (x + offset) + i*y;
        t = [0 : 1/(length(z)-1) : 1];

        [C0, Cp, Cn] = coef(t, z, N);
        z_ap=C0;
        t_repr=[0:1/M:1];
        for k=1:N
            z_ap=z_ap+Cn(k)*exp(-k*1i*2*pi*t_repr)+Cp(k)*exp(k*i*2*pi*t_repr);
        end;

        figure(10)
        
        for k=1:5:M+1
            plot(real(z_ap(1:k)), imag(z_ap(1:k)),'m')
            axis([0 20+max(real(z_ap)) 0 20+max(imag(z_ap))])
            hold on
            pause(1/500)
        end

        figure(11)
        imshow("letters/k_mare/K.jpg")
        hold on
        rl = real(z_ap) + 1;
        im = -1*imag(z_ap) + 153;
        plot(rl, im, 'LineWidth', 2, 'Color', 'green')    
    end

    % letterName -> litera pentru care vrem sa preluam coordonatele
    % x -> returnam coordonatele de pe axa verticala
    % y -> returnam coordonatele de pe axa orizontala

    function [x, y] = loadLetter(letterName)
        if isstrprop(letterName, 'upper')
            xFilePath = fullfile('letters', letterName + '_mare', letterName + '_X.txt');
            yFilePath = fullfile('letters', letterName + '_mare', letterName + '_Y.txt');
        else
            xFilePath = fullfile('letters', letterName + '_mic', letterName + '_X.txt');
            yFilePath = fullfile('letters', letterName + '_mic', letterName + '_Y.txt');
        end
        
        x = load(xFilePath)';
        y = load(yFilePath)';
    end

% date utilizator
N = 60 % numar termeni pozitivi in SF
M = 1000 % -1 + numar momente t de reprezentare in [0 1]

cuvant = input('Introdu un cuvant: ', 's');
array_caractere = char(cuvant);
length(array_caractere)

windowSize_x = 0;
windowSize_y = 0;
for k = 1:length(array_caractere)
    [x, y] = loadLetter(string(array_caractere(k)));
    windowSize_x = windowSize_x + max(x);

    if max(y) > windowSize_y
        windowSize_y = max(y)
    end
end;
figure(1)
axis([0 windowSize_x 0 200])

offs = 0;
for k = 1:length(array_caractere)
    pause(1)
    [x, y] = loadLetter(string(array_caractere(k)));
    %drawLetter(x, y, offs, windowSize_x, windowSize_y)
    drawLetterMod(x, y, offs);
    offs = offs + max(x);
end

end
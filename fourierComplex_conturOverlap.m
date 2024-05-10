function fourierComplex_conturOverlap
    clear; clc;

    function [C0, Cp, Cn] = coef(t, z, N)
        C0 =  trapz(t, z);
        for k = 1 : N
            Cp(k) = trapz(t, z .* exp(-1i * k * 2 * pi * t));
            Cn(k) = trapz(t, z .* exp(1i * k * 2 * pi * t));
        end
    end

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
        
        figure(11)
        imshow("letters/k_mare/K.jpg")
        pause

        figure(10)
        
        for k=1:2:M+1
            plot(real(z_ap(1:k)), imag(z_ap(1:k)),'m')
            axis([0 20+max(real(z_ap)) 0 20+max(imag(z_ap))])
            hold on
            pause(1/100)
        end

        figure(11)
        imshow("letters/k_mare/K.jpg")
        hold on
        rl = real(z_ap) + 1;
        im = -1*imag(z_ap) + 153;
        plot(rl, im, 'LineWidth', 2, 'Color', 'green')    
    end

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

windowSize_x = 0;
windowSize_y = 0;

[x, y] = loadLetter("K");
windowSize_x = max(x);
windowSize_y = max(y)
  
figure(1)
axis([0 windowSize_x 0 200])

offs = 0;
drawLetterMod(x, y, offs);


end
%{ Выставляем частоту дискретизации. %}
sampling_frequency = 50000;

%{ Создаем временной вектор продолжительностью в 0.0005 секунды. %}
time = (0:1/sampling_frequency:0.0005)';

%{ Задаем интересующие нас частоты. %}
frequency_1 = 21000;
frequency_2 = 18000;

%{ Синтезируем две квадратные волны. %}
square_wave_1 = (square(frequency_1 * 2 * pi * time, 50) + 1) * 0.5;
square_wave_2 = (square(frequency_2 * 2 * pi * time, 50) + 1) * 0.5;

%{ Конкатенируем половины обеих волн для симуляции прыжка частоты. %}
square_wave_3 = [...
    square_wave_1(1:length(square_wave_1)/2);...
    square_wave_2(length(square_wave_2)/2+1:length(square_wave_2))];

%{ Создаем скоп для каждой волны. %}
scope_1 = dsp.TimeScope(...
    'Name', '21kHz square wave',...
    'SampleRate',sampling_frequency,...
    'TimeSpan',0.0005);

scope_2 = dsp.TimeScope(...
    'Name', '18kHz square wave',...
    'SampleRate',sampling_frequency,...
    'TimeSpan',0.0005);

scope_3 = dsp.TimeScope(...
    'Name', '21+18kHz square wave',...
    'SampleRate',sampling_frequency,...
    'TimeSpan',0.0005);

%{ Передаем волны в скопы. %}
scope_1(square_wave_1);
scope_2(square_wave_2);
scope_3(square_wave_3);

%{
    Итерируем через массив семплов обеих волн отбирая numberOfSamples
    для анализа паттерна.
%}

i = 1;
numberOfSamples = 6;

while i + numberOfSamples <= length(square_wave_3)
    test_subject = square_wave_3(i:i+numberOfSamples-1);
    
    k = 1;
    match_found = false;
    
    while k + numberOfSamples <= length(square_wave_1)
        original = square_wave_1(k:k+numberOfSamples-1);
        
        if test_subject == original
            match_found = true;
            break;
        end
            
        k = k + numberOfSamples;
    end
    
    if match_found == false
        msgbox(sprintf('Jump detected at %u',i));
        break;
    end
    
    i = i + numberOfSamples;
end

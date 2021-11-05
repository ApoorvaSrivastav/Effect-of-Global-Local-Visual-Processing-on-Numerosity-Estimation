%% Initialisation
% Here we call some default settings for setting up Psychtoolbox
PsychDefaultSetup(2);
Screen('Preference', 'SkipSyncTests', 1);
AssertOpenGL; 
HideCursor();
InitializePsychSound(1);
voicetrigger=0.03;
maxsecs=2;
wavfilename=[];
% Initilising audio parameters
freq = 44100;

Observer=input('\n Subject Name.:','s');
pahandle = PsychPortAudio('Open', [], 2, 0, freq, 2);
PsychPortAudio('GetAudioData', pahandle, 10);
soundstart=PsychPortAudio('Start', pahandle, 0, 0, 1);
PsychPortAudio('Stop', pahandle);
PsychPortAudio('Close', pahandle);

% Get the screen numbers. This gives us a number for each of the screens
% attached to our computer.
screens = Screen('Screens');

% To draw we select the maximum of these numbers. So in a situation where we
% have two screens attached to our monitor we will draw to the external
% screen.
screenNumber = max(screens);
% Define black and white (white will be 1 and black 0). This is because
% in general luminace values are defined between 0 and 1 with 255 steps in
% between. All values in Psychtoolbox are defined between 0 and 1
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);

% Do a simply calculation to calculate the luminance value for grey. This
% will be half the luminace values for white
grey = white / 2;

% Open an on screen window using PsychImaging and color it black.
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black);
% Get the size of the on screen window
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
% Get the centre coordinate of the window
[xCenter, yCenter] = RectCenter(windowRect);

%% Experiment Begins
%Instruction slide insert here
    theImage = imread('instructions.png');

    % Get the size of the image
    [s1, s2, s3] = size(theImage);

    % Here we check if the image is too big to fit on the screen and abort if
    % it is. See ImageRescaleDemo to see how to rescale an image.
    if s1 > screenYpixels || s2 > screenYpixels
        disp('ERROR! Image is too big to fit on the screen');
        sca;
        return;
    end

    % Make the image into a texture
    imageTexture = Screen('MakeTexture', window, theImage);
   
    % Draw the image to the screen, unless otherwise specified PTB will draw
    % the texture full size in the center of the screen. We first draw the
    % image in its correct orientation.
    Screen('DrawTexture', window, imageTexture, [], [], 0);

    % Flip to the screen
    Screen('Flip', window);

    % Wait for key press
    KbStrokeWait;
    
DrawFormattedText(window, 'Press Any Key To Begin',...
    'center', 'center', white);
Screen('Flip', window);
KbStrokeWait;

%defining grid for the dot structure
dim = 6;

x=transpose([-4,-3,-2,-1,0,1,2]);
y=transpose([-4,-3,-2,-1,0,1,2]);

% Here we scale the grid so that it is in pixel coordinates. We just scale
% it by the screen size so that it will fit. This is simply a
% multiplication. Notive the "." before the multiplicaiton sign. This
% allows us to multiply each number in the matrix by the scaling value.
pixelScale = screenYpixels / (dim * 2 + 2);
x = x .* pixelScale;
y = y .* pixelScale;
c1=0;
c2=0;
c3=0;
c4=0;
c5=0;
c6=0;
c7=0;
c8=0;
c9=0;
c10=0;
% We can define a center for the dot coordinates to be relative to. Here
% we set the centre to be the centre of the screen
dotCenter = [xCenter yCenter];

% Set the color of our dot
dotColors = white;

% Set the size of the dots randomly between 10 and 30 pixels
dotSizes = 20;

file = 'Trial.xlsx';
trial=xlsread(file);
c=0;
jitter=(.950:.01:1.150);

%% Begining of Trials
while true
    
    if trial(:,4)==1 %c==3 
        
        break;
    end 
    if c==60||c==120||c==180
        DrawFormattedText(window, 'You Can take a break...press any key when you are ready again',...
       'center', 'center', white);
        Screen('Flip', window);
        KbStrokeWait;
    end
    % Drawing reuired dots
    k= randi(240);
    if trial(k,4)==0
    
    %Before Showing the Global/Local Image 
    if(trial(k,2)==0)
        Screen(window,'TextSize',20);
        DrawFormattedText(window, 'Focus on Global Component ',...
                         'center', 'center', [1,0,0]);
        Screen('Flip', window);
        % Wait for two seconds
        KbStrokeWait;
    else
        Screen(window,'TextSize',20);
        DrawFormattedText(window, 'Focus on Local Component',...
                         'center', 'center', [0,1,0]);
        Screen('Flip', window);
        % Wait for two seconds
        KbStrokeWait;
    end
    %Showing the Global/Local Image 
    while(true)
        im =randi(24);
        if(im==1 && c1<25)
            theImage2 = imread('Hs.png');
            trial(k,8)= 'h';
            trial(k,9)='s';
            c1= c1 + 1;
            break;
        elseif(im==2 && c2<25)
            theImage2 = imread('Ht.png');
            trial(k,8)='h';
            trial(k,9)='t';
            c2= c2 + 1;
            break;
        elseif(im==3 && c3<25)
            theImage2 = imread('Ol.png');
            trial(k,8)='o';
            trial(k,9)='l';
            c3= c3 + 1;
            break;
        elseif(im==4 && c4<25)
            theImage2 = imread('Ou.png');
            trial(k,8)='o';
            trial(k,9)='u';
            c4= c4 + 1;
            break;
        elseif(im==5 && c5<25)
            theImage2 = imread('Sh.png');
            trial(k,8)='s';
            trial(k,9)='h';
            c5= c5 + 1;
            break;
        elseif(im==6 && c6<25)
            theImage2 = imread('Ss.png');
            trial(k,8)='s';
            trial(k,9)='s';
            c6= c6 + 1;
            break;
        elseif(im==7 && c7<25)
            theImage2 = imread('St.png');
            trial(k,8)='s';
            trial(k,9)='t';
            c7= c7 + 1;
            break;
        elseif(im==8 && c8<25)
            theImage2 = imread('Th.png');
            trial(k,8)='t';
            trial(k,9)='h';
            c8= c8 + 1;
            break;
        elseif(im==9 && c9<25)
            theImage2 = imread('Ts.png');
            trial(k,8)='t';
            trial(k,9)='s';
            c9= c9 + 1;
            break;
        elseif(im==10 && c10<25)
            theImage2 = imread('Tt.png');
            trial(k,8)='t';
            trial(k,9)='t';
            c10= c10 + 1;
            break;
        else
            continue;
        end
    end   
    % Get the size of the image
    [s1, s2, s3] = size(theImage2);

    % Here we check if the image is too big to fit on the screen and abort if
    % it is. See ImageRescaleDemo to see how to rescale an image.
    if s1 > screenYpixels || s2 > screenYpixels
        disp('ERROR! Image is too big to fit on the screen');
        sca;
        return;
    end

    % Make the image into a texture
    imageTexture = Screen('MakeTexture', window, theImage2);

    % Draw the image to the screen, unless otherwise specified PTB will draw
    % the texture full size in the center of the screen. We first draw the
    % image in its correct orientation.
    Screen('DrawTexture', window, imageTexture, [], [], 0);
    
    % Flip to the screen
    Screen('Flip', window);
    % Wait for two seconds
    WaitSecs(1);
    Screen(window,'TextSize',20);
    DrawFormattedText(window, '',...
                         'center', 'center', black);
        
    % Flip to the screen
    Screen('Flip', window);
    % Wait for some seconds
    jitt=RandSample(jitter);
    WaitSecs(jitt);
    
   % Drawing reuired dots
        num= trial(k,3);
        for s = 1:num
            disp(s);
            i= randi(7);
            j= randi(7);
            dotXpos=xCenter + x(i);
            dotYpos=yCenter + y(j);
            % Draw all of our dots to the screen in a single line of code
            % For help see: Screen DrawDots
            Screen('DrawDots', window, [dotXpos dotYpos], dotSizes, dotColors, [], 2);
            
        end
        StimStart=GetSecs;% Time of Stimulus Onset
        trial(k,4)=1;
        c=c+1;
        trial(k,5)=c;
        
    else
        continue;
    end   
    Screen('Flip', window);         
    WaitSecs(0.1);
    Screen('Close');
    %Opening the recording device
    pahandle = PsychPortAudio('Open', [], 2, 0, freq, 2); % opens sound buffer in capture mode
    PsychPortAudio('GetAudioData', pahandle, 10); %allocate buffer with capacity of 10 seconds

    
    PsychPortAudio('Start', pahandle, 0, 0, 1); %starts caputure of sound
    Screen('Flip', window);         
    WaitSecs(0.1);
   
    level = 0;
    while level < voicetrigger % Repeat as long as below trigger-threshold:
        % Fetch current audiodata:
        [audiodata, offset, overflow, tCaptureStart] = PsychPortAudio('GetAudioData', pahandle);
        if ~isempty(audiodata) % Compute maximum signal amplitude in this chunk of data:
            level = max(abs(audiodata(1,:)));
        end
            WaitSecs(0.0001);% Wait for 1 millisecond before next scan:
    end
    endtime=GetSecs();
    
    PsychPortAudio('Stop', pahandle);
    PsychPortAudio('Close', pahandle);
    RT=endtime-StimStart;  % Reaction time Calcultion
    
    trial(k,7)=RT;
    Screen('Flip', window);
    WaitSecs(0.1);
    
    % (No other keypresses will be recorded or allowed)
    FlushEvents('keyDown');
    % You have to use the number and the symbol on number keys. If you use an
    % italian computer (or a non-American one like me), you might have to
    % change the symbol accordingly
    validResponseKeys  = [KbName('t') KbName('h') KbName('s') KbName('u') KbName('o') KbName('l')];
    validResponseKeyName = {'t','l','s','u','o','h'};
    %reply=Ask(window,'Press G for Global and L for Local',[],[],'GetString','center');
    blocktext = ['Enter the alphbet you saw'];
    Screen(window,'TextSize',20);
    Screen('FillRect', window, black);
    [nx, ny, box] = DrawFormattedText(window, blocktext, 'center','center',white);
    
    vbl = Screen('Flip',window);
    keyIsDown = 0;
    pressedKey=0;
    while (1)
        [keyIsDown,secs,keyCode]=KbCheck();
         if any(keyCode(validResponseKeys))
            pressedKey = find(keyCode(validResponseKeys),1);
            trial(k,6) = KbName(find(keyCode,1));

             break;
         end
    end
    Screen('Close');

end   


% Flip to the screen
Screen('Flip', window); 

% Wait for two seconds
KbStrokeWait;
%% End of Experiment
xlswrite('Aish25.xlsx',trial);
save('Aish25.mat');
DrawFormattedText(window, 'Experiment Finished\n\n Thanks a lot for your participation\n\n Press Any Key To Exit',...
    'center', 'center', white);
Screen('Flip', window);
KbStrokeWait;
Screen('CloseAll')
sca;
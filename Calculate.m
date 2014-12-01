% for gui stuff all we need is "input = get(hObject,'String');" to grab the
% individual strings, we can then save these into an array or just as
% seperate variables from there.
% these variables can then easily be used inside scripts like this!
% http://www.mathworks.co.uk/help/matlab/creating_guis/add-code-for-components-in-callbacks.html#f10-1001464

% list of variables gotten from UI (for reference purposes) in the order
% they are created

% initialSpeed
% angleOfMotion
% coefficientOfRestitution
% wallDistance
% wallHeight
% ballStartingHeight
% ballRadius
% ballMass
% airResistance

%handles to the output text data
%XPWReturn -- x pos at the wall
%YPWReturn -- y pos at the wall
%TWReturn  -- time at wall
%XPGReturn -- x pos at ground
%YPGReturn -- y pos at ground
%TGReturn -- time at ground
%XCPReturn -- x current position
%YCPReturn -- y current position
%CTReturn -- current time
%CYVReturn - current y velocity
%CXVReturn -- current x velocity
%YVGReturn -- y velocity at ground
%XVGReturn -- x velocity at ground
%XVWBReturn -- x velocity at wall before cor
%YVWBReturn -- y velocity at wall before cor
%XVWAReturn -- x velocity at wall after cor
%YVWAReturn -- y velocity at wall after cor

%initially set up variables for the program to run :) -AM

isProgramRunning = 1;
isCalculating = 1;
hasHitWall = 0;
hasHitGround = 0;

initialX = ballRadius;
initialY = ballRadius + ballStartingHeight;
airRes = airResistance;
timeStep = 0.01;
mg = ballMass * 9.81;
time = 0;
initialMS = initialSpeed;
initialAngle = angleOfMotion;
%need to convert to radians for matlabby stuff
%angleInRadians = degtorad(initialAngle);
angleInRadians = initialAngle * (pi / 180);
% calculate the initial speeds in relation to angles as well
initialSpeedX = initialMS * cos(angleInRadians);
initialSpeedY = initialMS * sin(angleInRadians);
previousSpeedX = initialSpeedX;
previousSpeedY = initialSpeedY;
currentX = initialX;
currentY = initialY;
xPos = initialX;
yPos = initialY;
%tell it to draw to axes on ui
axes(handles.ballPlot);
grid on;

while(isProgramRunning == 1) % main simulation loop, will exit when simulation is over -AM
    
    % calculate the x positions using the current speed
    xPos = currentX + (timeStep * previousSpeedX);
    yPos = currentY + (timeStep * previousSpeedY);

    nextSpeedX = previousSpeedX + timeStep * (-airRes * previousSpeedX);
    nextSpeedY = previousSpeedY + timeStep * (-airRes * previousSpeedY -mg);

    currentX = xPos;
    currentY = yPos;

    previousSpeedX = nextSpeedX;
    previousSpeedY = nextSpeedY;

    time = time + timeStep;

    % code to update the current value of the static text that will display
    % the outputs. -AM
    set(handles.CTReturn, 'String', num2str(time));
    set(handles.CXPReturn, 'String', num2str(currentX));
    set(handles.CYPReturn, 'String', num2str(currentY));
    set(handles.CXVReturn, 'String', num2str(previousSpeedX));
    set(handles.CYVReturn, 'String', num2str(previousSpeedY));

    %plot (xPos, yPos);
    coordMatrix = [xPos, yPos];
    viscircles(coordMatrix,ballRadius);
    line([-1 wallDistance], [0 0], 'LineWidth', 4, 'color', 'r'); % floor line
    line([wallDistance wallDistance], [-1 wallHeight], 'LineWidth', 4, 'color', 'g'); % wall ball is hitting

    pause(0.0001);

    if(currentX >= wallDistance - ballRadius && currentY <= wallHeight - ballRadius && hasHitWall == 0)
        % we have hit the wall
        % now need to run coefficient calculations

        disp('the wall has been hit by the ball at');
        disp(time);
        disp('seconds');
        disp('Now do some calculations to make it bounce!');

        % code to update the wall values  of the static text that will display
        % the outputs. -AM
        set(handles.TWReturn, 'String', num2str(time));
        set(handles.XPWReturn, 'String', num2str(currentX));
        set(handles.YPWReturn, 'String', num2str(currentY));
        set(handles.XVWBReturn, 'String', num2str(previousSpeedX));
        set(handles.YVWBReturn, 'String', num2str(previousSpeedY));

        % apply coefficient to get new velocities
        previousSpeedX = -coefficientOfRestitution*(previousSpeedX);
        previousSpeedY = -coefficientOfRestitution*(previousSpeedY);

        set(handles.XVWAReturn, 'String', num2str(previousSpeedX));
        set(handles.YVWAReturn, 'String', num2str(previousSpeedY));

        hasHitWall = 1;
    end

    if(currentX >= wallDistance - ballRadius && currentY > wallHeight - ballRadius)
        errorBox = msgbox('The ball has flown over the wall!','Out of Bounds');
        
        set(handles.TGReturn, 'String', 'N/A');
        set(handles.XPGReturn, 'String', 'N/A');
        set(handles.YPGReturn, 'String', 'N/A');
        set(handles.XVGReturn, 'String', 'N/A');
        set(handles.YVGReturn, 'String', 'N/A');
        set(handles.XVWAReturn, 'String', 'N/A');
        set(handles.YVWAReturn, 'String', 'N/A');
        set(handles.TWReturn, 'String', 'N/A');
        set(handles.XPWReturn, 'String', 'N/A');
        set(handles.YPWReturn, 'String', 'N/A');
        set(handles.XVWBReturn, 'String', 'N/A');
        set(handles.YVWBReturn, 'String', 'N/A');
        
        isProgramRunning = 0; % variable to tell is program running -AM
        break;
    end

    if(currentY <= ballRadius)
        % ball has now hit the ground           
        % code to update the wall values  of the static text that will display
        % the outputs. -AM (used to be code in here to display straight to command line, redundant now)
        set(handles.TGReturn, 'String', num2str(time));
        set(handles.XPGReturn, 'String', num2str(currentX));
        set(handles.YPGReturn, 'String', num2str(currentY));
        set(handles.XVGReturn, 'String', num2str(previousSpeedX));
        set(handles.YVGReturn, 'String', num2str(previousSpeedY));

        isProgramRunning = 0; % should stop the calculations from continuing when hitting the ground
        break;

    end

    cla(handles.ballPlot);    
end


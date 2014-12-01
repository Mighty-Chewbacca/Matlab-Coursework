% variable descriptions for inputs
% for gui stuff all we need is "input = get(hObject,'String');" to grab the
% individual strings, we can then save these into an array or just as
% seperate variables from there.
% these variables can then easily be used inside scripts like this!
% http://www.mathworks.co.uk/help/matlab/creating_guis/add-code-for-components-in-callbacks.html#f10-1001464

% list of variables gotten from UI (for reference purposes) in the order
% they are created -AM

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

% simple variable to control the main simulation loop -AM
isProgramRunning = 1;

% variables to control wether the wall/ground is hit or not -AM
hasHitWall = 0;
hasHitGround = 0;

% setting the initial positions from the inputs from the UI -AM
initialX = ballRadius;
initialY = ballRadius + ballStartingHeight;

% grabbing the air resistance from the UI input -AM
airRes = airResistance;

% setting up the timestep that will be used in the simulation,
% if this is made smaller the animation will be much more accurate -AM
timeStep = 0.01;

%calculating mg from the ball mass, and assuming that we are using earths
%gravity force -AM
mg = ballMass * 9.81;

% time starts at 0 seconds -AM
time = 0;

% grabbing the speed and angle from the UI input -AM
initialMS = initialSpeed;
initialAngle = angleOfMotion;

%need to convert to radians for matlabby stuff -AM
%angleInRadians = degtorad(initialAngle);
angleInRadians = initialAngle * (pi / 180);

% calculate the initial speeds in relation to angles as well -AM
initialSpeedX = initialMS * cos(angleInRadians);
initialSpeedY = initialMS * sin(angleInRadians);
% then set them into the variables that will be used in the equations -AM
previousSpeedX = initialSpeedX;
previousSpeedY = initialSpeedY;
% same with these, simply transferring them into the equation (this line is unneeded in hindsight,
%this variable control is one of the main optimisations that could be made) -AM
currentX = initialX;
currentY = initialY;
xPos = initialX;
yPos = initialY;

%tell it to draw to axes on the UI -AM
axes(handles.ballPlot);

% create the limits for the axes, allow them to change according to the
% users values -AM
xlim([0 wallDistance ]);
ylim([0 wallDistance ]);

% turn on the grid to show an accurate
% representation of the balls movement -AM
grid on;

while(isProgramRunning == 1) % main simulation loop, will exit when simulation is over -AM
    
    % calculate the x positions using the current speed  -AM
    xPos = currentX + (timeStep * previousSpeedX);
    yPos = currentY + (timeStep * previousSpeedY);
    % calculate the next speed using the previous speed and the other
    % forces applied to the ball -AM
    nextSpeedX = previousSpeedX + timeStep * (-airRes * previousSpeedX);
    nextSpeedY = previousSpeedY + timeStep * (-airRes * previousSpeedY -mg);
    %set the new positions -AM
    currentX = xPos;
    currentY = yPos;
    %set the new speeds -AM
    previousSpeedX = nextSpeedX;
    previousSpeedY = nextSpeedY;
    % increment time by the timestep declared at the top -AM
    time = time + timeStep;

    % code to update the current value of the static text that will display
    % the outputs. -AM
    set(handles.CTReturn, 'String', num2str(time));
    set(handles.CXPReturn, 'String', num2str(currentX));
    set(handles.CYPReturn, 'String', num2str(currentY));
    set(handles.CXVReturn, 'String', num2str(previousSpeedX));
    set(handles.CYVReturn, 'String', num2str(previousSpeedY));
    % draw the circle by creating a matrix with teh x,y positions and then
    % pass that matrix into the viscircles function giving the radius from
    % the user as the radius -AM
    %plot (xPos, yPos);
    coordMatrix = [xPos, yPos];
    viscircles(coordMatrix,ballRadius);
    %draw the floor and the walls using data from user -AM
    line([-1 wallDistance], [0 0], 'LineWidth', 4, 'color', 'r'); % floor line
    line([wallDistance wallDistance], [-1 wallHeight], 'LineWidth', 4, 'color', 'g'); % wall ball is hitting
    % pause the calculations for long enough that you see the ball moving
    % across the screen -AM
    pause(0.0001);

    % if the x position and y positions are in line with the wall, and it
    % hasnt hit yet -AM
    if(currentX >= wallDistance - ballRadius && currentY <= wallHeight - ballRadius && hasHitWall == 0)
        % we have hit the wall
        % now need to run coefficient calculations

        % code to update the wall values  of the static text that will display
        % the outputs (before coefficient applied). -AM
        set(handles.TWReturn, 'String', num2str(time));
        set(handles.XPWReturn, 'String', num2str(currentX));
        set(handles.YPWReturn, 'String', num2str(currentY));
        set(handles.XVWBReturn, 'String', num2str(previousSpeedX));
        set(handles.YVWBReturn, 'String', num2str(previousSpeedY));

        % apply coefficient formula to get new velocities -AM
        previousSpeedX = -coefficientOfRestitution*(previousSpeedX);
        previousSpeedY = -coefficientOfRestitution*(previousSpeedY);
        % update the text boxes for speed after coefficient applied -AM
        set(handles.XVWAReturn, 'String', num2str(previousSpeedX));
        set(handles.YVWAReturn, 'String', num2str(previousSpeedY));
        %this makes the if statement untrue which allows the ball to
        %continue moving -AM
        hasHitWall = 1;
    end

    %if the current x is at the wall but the y is NOT then it has flown
    %over and we should tell the user this -AM
    if(currentX >= wallDistance - ballRadius && currentY > wallHeight - ballRadius)
        %make a message box appear to tell the user -AM
        errorBox = msgbox('The ball has flown over the wall!','Out of Bounds');
        % update all the text boxes to let the user know it has not hit the
        % wall or ground within our bounds -AM
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

    %clear the graph, statement placed here so that is will not call when
    %the simulation is over -AM
    cla(handles.ballPlot); 
end


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

initialX = ballRadius;
initialY = ballRadius + ballStartingHeight;

airRes = airResistance;
timeStep = 0.01;
mg = ballMass;
time = 0;

initialMS = initialSpeed;
initialAngle = angleOfMotion;

%need to convert to radians for matlabby stuff
angleInRadians = degtorad(initialAngle);

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

while(xPos < wallDistance - ballRadius)
    
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
disp(time);

%plot (xPos, yPos);
coordMatrix = [xPos, yPos];
viscircles(coordMatrix,ballRadius);
line([-1 wallDistance], [0 0], 'LineWidth', 4, 'color', 'r'); % floor line
line([wallDistance wallDistance], [-1 wallHeight], 'LineWidth', 4, 'color', 'g'); % wall ball is hitting

pause(0.025);

if (xPos < wallDistance - ballRadius)
cla(handles.ballPlot);
end

if (yPos < 0)
    disp('below ground');
    break
end

end

if (xPos >= wallDistance - ballRadius)
disp('the wall has been hit by the ball at');
disp(time);
disp('seconds');
disp('Now do some calculations to make it bounce!');

disp(xPos); % will display the final location on the x axis of the ball before it hit the wall
disp(yPos); % will display the final location on the y axis of the ball before it hit the wall
end
grid on;



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
   
    if(isCalculating == 1)
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
        

        %plot (xPos, yPos);
        coordMatrix = [xPos, yPos];
        viscircles(coordMatrix,ballRadius);
        line([-1 wallDistance], [0 0], 'LineWidth', 4, 'color', 'r'); % floor line
        line([wallDistance wallDistance], [-1 wallHeight], 'LineWidth', 4, 'color', 'g'); % wall ball is hitting

        pause(0.001);
        
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
            
            % apply coefficient to get new velocities
            previousSpeedX = -coefficientOfRestitution*(previousSpeedX);
            previousSpeedY = -coefficientOfRestitution*(previousSpeedY);
            
            hasHitWall = 1;
        end
        
        if(currentY <= ballRadius)
            % ball has now hit the ground
            disp('the ball has hit the ground');
            disp(time);
            disp('seconds');
            
            % code to update the wall values  of the static text that will display
            % the outputs. -AM
            set(handles.TWReturn, 'String', num2str(time));
            set(handles.XPWReturn, 'String', num2str(currentX));
            set(handles.YPWReturn, 'String', num2str(currentY));
            
            isCalculating = 0; % should stop the calculations from continuing when hitting the ground
            
        end
        
        cla(handles.ballPlot);
        
    end
    
end


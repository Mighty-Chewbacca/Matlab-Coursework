function varargout = CourseworkUI(varargin)
% COURSEWORKUI MATLAB code for CourseworkUI.fig
%      COURSEWORKUI, by itself, creates a new COURSEWORKUI or raises the existing
%      singleton*.
%
%      H = COURSEWORKUI returns the handle to a new COURSEWORKUI or the handle to
%      the existing singleton*.
%
%      COURSEWORKUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COURSEWORKUI.M with the given input arguments.
%
%      COURSEWORKUI('Property','Value',...) creates a new COURSEWORKUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CourseworkUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CourseworkUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CourseworkUI

% Last Modified by GUIDE v2.5 10-Nov-2014 22:16:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CourseworkUI_OpeningFcn, ...
                   'gui_OutputFcn',  @CourseworkUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before CourseworkUI is made visible.
function CourseworkUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CourseworkUI (see VARARGIN)

% Choose default command line output for CourseworkUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CourseworkUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CourseworkUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function speedInput_Callback(hObject, eventdata, handles)
% hObject    handle to speedInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of speedInput as text
%        str2double(get(hObject,'String')) returns contents of speedInput as a double


% --- Executes during object creation, after setting all properties.
function speedInput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to speedInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function angleInput_Callback(hObject, eventdata, handles)
% hObject    handle to angleInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of angleInput as text
%        str2double(get(hObject,'String')) returns contents of angleInput as a double


% --- Executes during object creation, after setting all properties.
function angleInput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to angleInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function corInput_Callback(hObject, eventdata, handles)
% hObject    handle to corInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of corInput as text
%        str2double(get(hObject,'String')) returns contents of corInput as a double


% --- Executes during object creation, after setting all properties.
function corInput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to corInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function wDistanceInput_Callback(hObject, eventdata, handles)
% hObject    handle to wDistanceInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of wDistanceInput as text
%        str2double(get(hObject,'String')) returns contents of wDistanceInput as a double


% --- Executes during object creation, after setting all properties.
function wDistanceInput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wDistanceInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function wHeightInput_Callback(hObject, eventdata, handles)
% hObject    handle to wHeightInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of wHeightInput as text
%        str2double(get(hObject,'String')) returns contents of wHeightInput as a double


% --- Executes during object creation, after setting all properties.
function wHeightInput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wHeightInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function startingHeightInput_Callback(hObject, eventdata, handles)
% hObject    handle to startingHeightInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of startingHeightInput as text
%        str2double(get(hObject,'String')) returns contents of startingHeightInput as a double


% --- Executes during object creation, after setting all properties.
function startingHeightInput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startingHeightInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in calculateButton.
function calculateButton_Callback(hObject, eventdata, handles)
% hObject    handle to calculateButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%get initial speed
initialSpeed = str2double(get(handles.speedInput, 'string'));
display(initialSpeed);
%get initial angle
angleOfMotion = str2double(get(handles.angleInput, 'string'));
display(angleOfMotion);
%get coefficient of restitution
coefficientOfRestitution = str2double(get(handles.corInput, 'string'));
display(coefficientOfRestitution);
%get distance of wall from starting point
wallDistance = str2double(get(handles.wDistanceInput, 'string'));
display(wallDistance);
%get height of wall
wallHeight = str2double(get(handles.wHeightInput, 'string'));
display(wallHeight);
%get distance of wall from starting point
ballStartingHeight = str2double(get(handles.startingHeightInput, 'string'));
display(ballStartingHeight);


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over speedInput.
function speedInput_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to speedInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function varargout = complexity(varargin)
% COMPLEXITY MATLAB code for complexity.fig
%      COMPLEXITY, by itself, creates a new COMPLEXITY or raises the existing
%      singleton*.
%
%      H = COMPLEXITY returns the handle to a new COMPLEXITY or the handle to
%      the existing singleton*.
%
%      COMPLEXITY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COMPLEXITY.M with the given input arguments.
%
%      COMPLEXITY('Property','Value',...) creates a new COMPLEXITY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before complexity_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to complexity_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help complexity

% Last Modified by GUIDE v2.5 03-Feb-2021 22:05:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @complexity_OpeningFcn, ...
                   'gui_OutputFcn',  @complexity_OutputFcn, ...
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


% --- Executes just before complexity is made visible.
function complexity_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to complexity (see VARARGIN)

% Choose default command line output for complexity
handles.output = hObject;

clBlue = [30/255 136/255 229/255];
%setbgcolor(handles.pb_complexityCalculation, clBlue);
%setbgcolor(handles.pb_statisticAnalysis, clBlue);
%setbgcolor(handles.pb_visualization, clBlue);
%setbgcolor(handles.pb_batchProcessing, clBlue);
axes(handles.axes_logo);
image(imread('LOFTlogo.png'));
set(handles.axes_logo,'Visible','off');
axes(handles.axes_fractal);
image(imread('brain_fractal.png'));
set(handles.axes_fractal,'Visible','off');

% UIWAIT makes complexity wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = complexity_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pb_complexityCalculation.
function pb_complexityCalculation_Callback(hObject, eventdata, handles)
% hObject    handle to pb_complexityCalculation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
complexityCalculation

% --- Executes on button press in pb_statisticAnalysis.
function pb_statisticAnalysis_Callback(hObject, eventdata, handles)
% hObject    handle to pb_statisticAnalysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pb_visualization.
function pb_visualization_Callback(hObject, eventdata, handles)
% hObject    handle to pb_visualization (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pb_batchProcessing.
function pb_batchProcessing_Callback(hObject, eventdata, handles)
% hObject    handle to pb_batchProcessing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pb_help.
function pb_help_Callback(hObject, eventdata, handles)
% hObject    handle to pb_help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pb_quit.
function pb_quit_Callback(hObject, eventdata, handles)
% hObject    handle to pb_quit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

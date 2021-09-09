function varargout = complexity(varargin)
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
    handles.output = hObject;

    clBlue = [30/255 136/255 229/255];

    % Load LOFT Logo
    axes(handles.axes_logo);
    image(imread('LOFTlogo.png'));
    set(handles.axes_logo,'Visible','off');

    % Update handles structure
    guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = complexity_OutputFcn(hObject, eventdata, handles) 
    % Get default command line output from handles structure
    varargout{1} = handles.output;


% --- Executes on button press in pb_complexityCalculation.
function pb_complexityCalculation_Callback(hObject, eventdata, handles)
    complexityCalculation

% --- Executes on button press in pb_statisticAnalysis.
function pb_statisticAnalysis_Callback(hObject, eventdata, handles)
    statistics


% --- Executes on button press in pb_visualization.
function pb_visualization_Callback(hObject, eventdata, handles)
    visualization

% --- Executes on button press in pb_batchProcessing.
function pb_batchProcessing_Callback(hObject, eventdata, handles)
    batchProcessing(handles);

% --- Executes on button press in pb_help.
function pb_help_Callback(hObject, eventdata, handles)
    help

% --- Executes on button press in pb_quit.
function pb_quit_Callback(hObject, eventdata, handles)
    quit

% --- Executes on button press in btn_viewOutput.
function btn_viewOutput_Callback(hObject, eventdata, handles)
    [filename, pathname] = uigetfile('*.nii; *.img', 'Pick image files','MultiSelect', 'on');

    % In case of single file selection 
    if isa(filename, 'char')
        filename = cellstr(filename); 
    end

    %Reconstructing files list with absolute path
    for i=1:length(filename)
        finalFiles{i} = [pathname, filesep, filename{i}];
    end
    displayImage(finalFiles);

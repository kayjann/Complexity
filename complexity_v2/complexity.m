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

% Last Modified by GUIDE v2.5 25-Sep-2020 13:31:52

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
setbgcolor(handles.pb_select_ip_dir, clBlue);
setbgcolor(handles.pb_select_brain_mask, clBlue);
setbgcolor(handles.pb_select_op_dir, clBlue);
setbgcolor(handles.pb_verify_orientation, clBlue);
setbgcolor(handles.pb_complexityCalculation, clBlue);
setbgcolor(handles.pb_statisticAnalysis, clBlue);
setbgcolor(handles.pb_visualization, clBlue);
setbgcolor(handles.pb_batchProcessing, clBlue);
axes(handles.axes_logo);
image(imread('LOFT_logo.png'));
set(handles.axes_logo,'Visible','off');
axes(handles.axes_fractal);
image(imread('brain_fractal.png'));
set(handles.axes_fractal,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes complexity wait for user response (see UIRESUME)
% uiwait(handles.figure1);


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
complexityCalculation % Yeets to complexityCalculation window

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


% --- Executes on button press in pb_select_ip_dir.
function pb_select_ip_dir_Callback(hObject, eventdata, handles)
% hObject    handle to pb_select_ip_dir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ipFormat=cell2mat(inputdlg('Input 3D or 4D','Input selection'));
clGreen=[0/255,191/255,165/255];
clRed=[244/255,67/255,54/255];
if isempty(ipFormat)
    disp('Please choose the input format: 3D or 4D');
    setbgcolor(handles.pb_select_ip_dir,clRed);
else
    if (strcmp(ipFormat,'3D')==1 | strcmp(ipFormat,'3d')==1)
        dirName=uigetdir;
        if (dirName==0)
            disp('no image input directory selected');
            setbgcolor(handles.pb_select_ip_dir,clRed);
        else
            imgStruct=readImages4D(dirName);
            handles.img_4D=imgStruct.img_4D;
            handles.baseName=imgStruct.bName;
            handles.imgVoxDim=imgStruct.voxDim;
            setbgcolor(handles.pb_select_ip_dir,clGreen);
        end
    else
        [fname, pname]=uigetfile('*.*','select the 4D image');
        if (fname==0 & pname==0)
            disp('4D image file not selected');
            setbgcolor(handles.pb_select_ip_dir,clRed);
        else
            imgName=[pname,fname];
            imgStruct = load_nii(imgName);
            handles.img_4D=imgStruct.img;
            [p,f,e]=fileparts(imgName);
            handles.baseName=f;
            handles.imgVoxDim=imgStruct.hdr.dime.pixdim(2:4);
            setbgcolor(handles.pb_select_ip_dir,clGreen);
        end
    end
end
guidata(hObject, handles);
disp('Done reading input images');

% --- Executes on button press in pb_select_brain_mask.
function pb_select_brain_mask_Callback(hObject, eventdata, handles)
% hObject    handle to pb_select_brain_mask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clGreen=[0/255,191/255,165/255];
clRed=[244/255,67/255,54/255];
[fname,pname] = uigetfile('*.*','select the brain mask');
if (fname==0 & pname==0)
    disp('Brain mask not selected');
    setbgcolor(handles.pb_select_brain_mask,clRed);
else
    mask_file = [pname,fname];
    mask = load_nii(mask_file);
    if (size(mask.img) ~= size(handles.img_4D(:,:,:,1)))
        msgbox('mask and input image dimensions do not match');
        setbgcolor(handles.pb_select_brain_mask,clRed);
    else
        handles.brainMask = mask.img;
        guidata(hObject, handles);
        setbgcolor(handles.pb_select_brain_mask,clGreen);
    end
end

% --- Executes on button press in pb_select_op_dir.
function pb_select_op_dir_Callback(hObject, eventdata, handles)
% hObject    handle to pb_select_op_dir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clGreen=[0/255,191/255,165/255];
opFolder = uigetdir;
handles.opFolder = opFolder;
setbgcolor(handles.pb_select_op_dir,clGreen);
guidata(hObject, handles);

% --- Executes on button press in pb_verify_orientation.
function pb_verify_orientation_Callback(hObject, eventdata, handles)
% hObject    handle to pb_verify_orientation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mask = verifyImgOri(handles.img_4D(:,:,:,1),handles.brainMask);
handles.brainMask = mask;
clGreen=[0/255,191/255,165/255];
setbgcolor(handles.pb_verify_orientation,clGreen);
guidata(hObject,handles);
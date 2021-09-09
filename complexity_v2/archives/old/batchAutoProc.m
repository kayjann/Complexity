function varargout = batchAutoProc(varargin)
% BATCHAUTOPROC MATLAB code for batchAutoProc.fig
%      BATCHAUTOPROC, by itself, creates a new BATCHAUTOPROC or raises the existing
%      singleton*.
%
%      H = BATCHAUTOPROC returns the handle to a new BATCHAUTOPROC or the handle to
%      the existing singleton*.
%
%      BATCHAUTOPROC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BATCHAUTOPROC.M with the given input arguments.
%
%      BATCHAUTOPROC('Property','Value',...) creates a new BATCHAUTOPROC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before batchAutoProc_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to batchAutoProc_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help batchAutoProc

% Last Modified by GUIDE v2.5 25-Nov-2020 19:36:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @batchAutoProc_OpeningFcn, ...
                   'gui_OutputFcn',  @batchAutoProc_OutputFcn, ...
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


% --- Executes just before batchAutoProc is made visible.
function batchAutoProc_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to batchAutoProc (see VARARGIN)

handles.output = hObject;
axes(handles.axes_logo);
image(imread('LOFT_logo.png'));
set(handles.axes_logo,'Visible','off');
axes(handles.axes_fractal);
image(imread('brain_fractal.png'));
set(handles.axes_fractal,'Visible','off');
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes batchAutoProc wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = batchAutoProc_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit_workingDir_Callback(hObject, eventdata, handles)
% hObject    handle to edit_workingDir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_workingDir as text
%        str2double(get(hObject,'String')) returns contents of edit_workingDir as a double


% --- Executes during object creation, after setting all properties.
function edit_workingDir_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_workingDir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_workingDir.
function pb_workingDir_Callback(hObject, eventdata, handles)
% hObject    handle to pb_workingDir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dirName=uigetdir('Choose a working directory');
handles.workingDir = dirName;
set(handles.edit_workingDir, 'string', handles.workingDir);
guidata(hObject, handles);


function edit_subjectFolderName_Callback(hObject, eventdata, handles)
% hObject    handle to edit_subjectFolderName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_subjectFolderName as text
%        str2double(get(hObject,'String')) returns contents of edit_subjectFolderName as a double


% --- Executes during object creation, after setting all properties.
function edit_subjectFolderName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_subjectFolderName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fmriSubfolderName_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fmriSubfolderName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fmriSubfolderName as text
%        str2double(get(hObject,'String')) returns contents of edit_fmriSubfolderName as a double


% --- Executes during object creation, after setting all properties.
function edit_fmriSubfolderName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fmriSubfolderName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fmriDataName_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fmriDataName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fmriDataName as text
%        str2double(get(hObject,'String')) returns contents of edit_fmriDataName as a double


% --- Executes during object creation, after setting all properties.
function edit_fmriDataName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fmriDataName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_outputDir_Callback(hObject, eventdata, handles)
% hObject    handle to edit_outputDir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_outputDir as text
%        str2double(get(hObject,'String')) returns contents of edit_outputDir as a double


% --- Executes during object creation, after setting all properties.
function edit_outputDir_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_outputDir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_outputDir.
function pb_outputDir_Callback(hObject, eventdata, handles)
% hObject    handle to pb_outputDir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dirName = uigetdir('Select output directory');
handles.outputDir = dirName;
set(handles.edit_outputDir, 'string', dirName);

% --- Executes on button press in pb_load.
function pb_load_Callback(hObject, eventdata, handles)
% hObject    handle to pb_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
working_dir = handles.workingDir;
subject_folder_name = get(handles.edit_subjectFolderName,'String');
fmri_subfolder_name = get(handles.edit_fmriSubfolderName,'String');
fmri_data_name = get(handles.edit_fmriDataName,'String');
output_dir = get(handles.edit_outputDir,'String');
disp(append(working_dir, subject_folder_name, fmri_subfolder_name, fmri_data_name));
files = findfiles(append(subject_folder_name, fmri_subfolder_name, fmri_data_name), working_dir);
disp(files);
disp('Done');
% --- Executes on button press in pb_next.
function pb_next_Callback(hObject, eventdata, handles)
% hObject    handle to pb_next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

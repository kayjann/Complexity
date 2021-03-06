function varargout = batchProcessing(varargin)
% BATCHPROCESSING MATLAB code for batchProcessing.fig
%      BATCHPROCESSING, by itself, creates a new BATCHPROCESSING or raises the existing
%      singleton*.
%
%      H = BATCHPROCESSING returns the handle to a new BATCHPROCESSING or the handle to
%      the existing singleton*.
%
%      BATCHPROCESSING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BATCHPROCESSING.M with the given input arguments.
%
%      BATCHPROCESSING('Property','Value',...) creates a new BATCHPROCESSING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before batchProcessing_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to batchProcessing_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help batchProcessing

% Last Modified by GUIDE v2.5 18-Nov-2020 01:39:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @batchProcessing_OpeningFcn, ...
                   'gui_OutputFcn',  @batchProcessing_OutputFcn, ...
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


% --- Executes just before batchProcessing is made visible.
function batchProcessing_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to batchProcessing (see VARARGIN)

% Choose default command line output for batchProcessing
handles.output = hObject;
axes(handles.axes_logo);
image(imread('LOFT_logo.png'));
set(handles.axes_logo,'Visible','off');
axes(handles.axes_fractal);
image(imread('brain_fractal.png'));
set(handles.axes_fractal,'Visible','off');
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes batchProcessing wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = batchProcessing_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes on button press in pb_workingDirectory.
function pb_workingDirectory_Callback(hObject, eventdata, handles)
% hObject    handle to pb_workingDirectory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

dirName=uigetdir;
if (dirName==0)
    disp('no image input directory selected');
else
    handles.dirName=dirName;
    files = dir(handles.dirName);
    dirFlags = [files.isdir];
    subFolders = files(dirFlags);
    for x = 1:length(subFolders)
        handles.subFolders{x} = fullfile(dirName,subFolders(x).name);
    end
    set(handles.listbox_subjects, 'string', {subFolders.name});
end
    
guidata(hObject, handles);
disp('Done reading input images');

% --- Executes on selection change in listbox_subjects.
function listbox_subjects_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_subjects (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_subjects contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_subjects
handles.output=hObject;
index = get(handles.listbox_scans, 'value');
folder = handles.subFolders{index};
disp(folder);
filelist = findfiles('*.nii*',folder);
imagelist = findfiles('*.img*',folder);
%disp(filelist);
save('filelist.mat','filelist');
for i = 1:length(filelist)
    handles.scans{i} = filelist(i);
end
for i = 1:length(imagelist)
    handles.scans{i+length(filelist)} = imagelist(i);
end
set(handles.listbox_scans, 'string', filelist);

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function listbox_subjects_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_subjects (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_scans.
function listbox_scans_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_scans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_scans contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_scans


% --- Executes during object creation, after setting all properties.
function listbox_scans_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_scans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_add.
function pb_add_Callback(hObject, eventdata, handles)
% hObject    handle to pb_add (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in listbox_batch.
function listbox_batch_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_batch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_batch contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_batch


% --- Executes during object creation, after setting all properties.
function listbox_batch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_batch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_run.
function pb_run_Callback(hObject, eventdata, handles)
% hObject    handle to pb_run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pb_remove.
function pb_remove_Callback(hObject, eventdata, handles)
% hObject    handle to pb_remove (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function varargout = inputViewer(varargin)
% INPUTVIEWER MATLAB code for inputViewer.fig
%      INPUTVIEWER, by itself, creates a new INPUTVIEWER or raises the existing
%      singleton*.
%
%      H = INPUTVIEWER returns the handle to a new INPUTVIEWER or the handle to
%      the existing singleton*.
%
%      INPUTVIEWER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INPUTVIEWER.M with the given input arguments.
%
%      INPUTVIEWER('Property','Value',...) creates a new INPUTVIEWER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before inputViewer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to inputViewer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help inputViewer

% Last Modified by GUIDE v2.5 03-Mar-2021 13:51:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @inputViewer_OpeningFcn, ...
                   'gui_OutputFcn',  @inputViewer_OutputFcn, ...
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


% --- Executes just before inputViewer is made visible.
function inputViewer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to inputViewer (see VARARGIN)
imgFiles = varargin(1);
maskFiles = varargin(2);
imgFiles = imgFiles{1};
maskFiles = maskFiles{1};
set(handles.listbox_scans, 'String', string(imgFiles));
global opRCSL;
handles.output = hObject;
data = load_untouch_nii(handles.listbox_scans.String(handles.listbox_scans.Value));
img = data.img;
nSlices = size(img, 3);
axes(handles.axes_image);
imshow(img(:,:,ceil(nSlices/2)), []);
set(handles.axes_image, 'Visible', 'off');
set(handles.edit_slImage, 'String', num2str(ceil(nSlices/2)));
set(handles.sl_image, 'Value', 0.5);
handles.img = img;
handles.nSlices = nSlices;
opRCSL = 0;
set(handles.listbox_masks, 'String', string(maskFiles));
data = load_untouch_nii(handles.listbox_masks.String(handles.listbox_masks.Value));
img = data.img;
nSlices = size(img,3);
axes(handles.axes_brainMask);
imshow(img(:, :, ceil(nSlices/2)), []);
set(handles.axes_brainMask, 'Visible', 'off');
set(handles.edit_slBrainMask, 'String', num2str(ceil(nSlices/2)));
set(handles.sl_brainMask, 'Value', 0.5);
handles.maskImg = img;
handles.maskSlices = nSlices;
% Choose default command line output for inputViewer

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes inputViewer wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = inputViewer_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox_scans.
function listbox_scans_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_scans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_scans contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_scans
set(handles.txt_scanTitle, 'String', handles.listbox_scans.String(handles.listbox_scans.Value));
data = load_untouch_nii(handles.listbox_scans.String(handles.listbox_scans.Value));
img = data.img;
nSlices = size(img, 3);
axes(handles.axes_image);
imshow(img(:,:,ceil(nSlices/2)), []);
set(handles.axes_image, 'Visible', 'off');
set(handles.edit_slImage, 'String', num2str(ceil(nSlices/2)));
set(handles.sl_image, 'Value', 0.5);
handles.img = img;
handles.nSlices = nSlices;

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


% --- Executes on selection change in listbox_masks.
function listbox_masks_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_masks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.txt_scanTitle, 'String', handles.listbox_scans.String(handles.listbox_scans.Value));
data = load_untouch_nii(handles.listbox_masks.String(handles.listbox_masks.Value));
img = data.img;
nSlices = size(img,3);
axes(handles.axes_brainMask);
imshow(img(:, :, ceil(nSlices/2)), []);
set(handles.axes_brainMask, 'Visible', 'off');
set(handles.edit_slBrainMask, 'String', num2str(ceil(nSlices/2)));
set(handles.sl_brainMask, 'Value', 0.5);
handles.maskImg = img;
handles.maskSlices = nSlices;

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_masks contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_masks


% --- Executes during object creation, after setting all properties.
function listbox_masks_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_masks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function sl_image_Callback(hObject, eventdata, handles)
% hObject    handle to sl_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
sliderValue = get(handles.sl_image, 'Value');
val = ceil(sliderValue*(handles.nSlices-1))+1;
set(handles.edit_slImage, 'String', num2str(val));
axes(handles.axes_image);
imshow(handles.img(:,:,val),[]);
set(handles.axes_image, 'Visible', 'off');

% --- Executes during object creation, after setting all properties.
function sl_image_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sl_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sl_brainMask_Callback(hObject, eventdata, handles)
% hObject    handle to sl_brainMask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sliderValue = get(handles.sl_brainMask, 'Value');
val = ceil(sliderValue*(handles.maskSlices-1))+1;
set(handles.edit_slbrainMask, 'String', num2str(val));
axes(handles.axes_brainMask);
imshow(handles.maskImg(:,:,val),[]);
set(handles.axes_brainMask, 'Visible', 'off');


% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function sl_brainMask_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sl_brainMask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit_slImage_Callback(hObject, eventdata, handles)
% hObject    handle to edit_slImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_slImage as text
%        str2double(get(hObject,'String')) returns contents of edit_slImage as a double


% --- Executes during object creation, after setting all properties.
function edit_slImage_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_slImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_slBrainMask_Callback(hObject, eventdata, handles)
% hObject    handle to edit_slBrainMask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_slBrainMask as text
%        str2double(get(hObject,'String')) returns contents of edit_slBrainMask as a double


% --- Executes during object creation, after setting all properties.
function edit_slBrainMask_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_slBrainMask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function varargout = displayImage(varargin)
% module for displaying 3D images and selecting ROI voxels
% ---------------------------------------------------------- 
% Written by AnithaPriya Krishnan 
% Version 1.0 
% contact: Dr.Danny JJ Wang "jjwang@loni.ucla.edu"; 
% Release = 20130402
% 1) Default configuration: Needs a 3D image as input for displaying the
% images. 
% 2) Can be used for selecting the ROI voxels by passing a 3D image and the
% number of ROI voxels 

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @displayImage_OpeningFcn, ...
                   'gui_OutputFcn',  @displayImage_OutputFcn, ...
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


% --- Executes just before displayImage is made visible.
function displayImage_OpeningFcn(hObject, eventdata, handles, varargin)
files = varargin(1);
files = files{1};
set(handles.listbox_scans, 'String', string(files));
global opRCSL;
handles.output = hObject;
disp(handles.listbox_scans.String{handles.listbox_scans.Value});
data = load_untouch_nii(handles.listbox_scans.String{handles.listbox_scans.Value});
img = data.img;
nSlices = size(img,3);
nSagittalSlices = size(img,2);
nCoronalSlices = size(img,1);
axes(handles.ax_display);
imshow(img(:,:,ceil(nSlices/2)),[]);
set(handles.ax_display,'Visible', 'off');
axes(handles.ax_sagittal);
imshow(reshape(img(ceil(nSagittalSlices/2),:,:),[nSagittalSlices, nSlices]),[]);
set(handles.ax_sagittal,'Visible', 'off');
axes(handles.ax_coronal);
imshow(reshape(img(:,ceil(nCoronalSlices/2),:),[nCoronalSlices, nSlices]),[]);
set(handles.ax_coronal,'Visible', 'off');

set(handles.edt_slNumber,'String', num2str(ceil(nSlices/2))); 
set(handles.sl_display,'Value',0.5);
set(handles.edit_slSagittal,'String', num2str(ceil(nSagittalSlices/2))); 
set(handles.sl_sagittal,'Value',0.5);
set(handles.edit_slCoronal,'String', num2str(ceil(nCoronalSlices/2))); 
set(handles.sl_coronal,'Value',0.5);

set(handles.pb_selectROI,'visible','off'); 
opRCSL = 0;
handles.img = img;
handles.nSlices = nSlices;
handles.nSagittalSlices = nSagittalSlices;
handles.nCoronalSlices = nCoronalSlices;
if (length(varargin)>1)
clBlue = [11/255 132/255 199/255];
set(handles.pb_selectROI,'visible','on');
setbgcolor(handles.pb_selectROI,clBlue);
handles.nPoints = cell2mat(varargin(2));
end
guidata(hObject,handles);
% % UIWAIT makes displayImage wait for user response (see UIRESUME)
if (length(varargin)>1)
uiwait(handles.fig_display);
end
% % Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = displayImage_OutputFcn(hObject, eventdata, handles) 
global opRCSl;
%if isfield(handles,'voxROI')
%    varargout{1} = handles.voxROI;
if (opRCSl ~= 0)
    varargout{1} = opRCSl;
    guidata(hObject, handles);
    delete(handles.fig_display);
else
    varargout{1} = handles.output;
end

% --- Executes on slider movement.
function sl_display_Callback(hObject, eventdata, handles)
sliderValue = get(handles.sl_display,'Value');
%puts the slider value into the edit text component
val = ceil(sliderValue*(handles.nSlices-1))+1;
set(handles.edt_slNumber,'String', num2str(val)); 
axes(handles.ax_display);
disp(size(handles.img));
imshow(handles.img(:,:,val),[]);
set(handles.ax_display,'Visible', 'off');

% --- Executes during object creation, after setting all properties.
function sl_display_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function edt_slNumber_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function edt_slNumber_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_selectROI.
function pb_selectROI_Callback(hObject, eventdata, handles)
global opRCSl;
opRCSl = zeros(handles.nPoints,3);
for i = 1:handles.nPoints
%     set(handles.pb_selectROI,'Enable','off');
    slNum = str2num(get(handles.edt_slNumber,'string'));
    [x y] = ginput(1);
    row = int32(y);
    col = int32(x);
    opRCSl(i,:) = [row col slNum];
    disp(['voxel: ', num2str([row col slNum])]);
    pause(1)
end
handles.voxROI = opRCSl;
guidata(hObject,handles);
uiresume(handles.fig_display);


% --- Executes on selection change in listbox_scans.
function listbox_scans_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_scans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_scans contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_scans
set(handles.txt_scanTitle, 'String', handles.listbox_scans.String{handles.listbox_scans.Value});
data = load_untouch_nii(handles.listbox_scans.String{handles.listbox_scans.Value});
img = data.img;
nSlices = size(img,3);
nSagittalSlices = size(img,2);
nCoronalSlices = size(img,1);
axes(handles.ax_display);
imshow(img(:,:,ceil(nSlices/2)),[]);
set(handles.ax_display,'Visible', 'off');
axes(handles.ax_sagittal);
imshow(reshape(img(ceil(nSagittalSlices/2),:,:),[nSagittalSlices, nSlices]),[]);
set(handles.ax_sagittal,'Visible', 'off');
axes(handles.ax_coronal);
imshow(reshape(img(:,ceil(nCoronalSlices/2),:),[nCoronalSlices, nSlices]),[]);
set(handles.ax_coronal,'Visible', 'off');

set(handles.edt_slNumber,'String', num2str(ceil(nSlices/2))); 
set(handles.sl_display,'Value',0.5);
set(handles.edit_slSagittal,'String', num2str(ceil(nSagittalSlices/2))); 
set(handles.sl_sagittal,'Value',0.5);
set(handles.edit_slCoronal,'String', num2str(ceil(nCoronalSlices/2))); 
set(handles.sl_coronal,'Value',0.5);

set(handles.pb_selectROI,'visible','off'); 
opRCSL = 0;
handles.img = img;
handles.nSlices = nSlices;
handles.nSagittalSlices = nSagittalSlices;
handles.nCoronalSlices = nCoronalSlices;

clBlue = [11/255 132/255 199/255];
set(handles.pb_selectROI,'visible','on');
setbgcolor(handles.pb_selectROI,clBlue);

% % Update handles structure
guidata(hObject, handles);


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


% --- Executes on slider movement.
function sl_sagittal_Callback(hObject, eventdata, handles)
% hObject    handle to sl_sagittal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sliderValue = get(handles.sl_sagittal,'Value');
%puts the slider value into the edit text component
val = ceil(sliderValue*(handles.nCoronalSlices-1))+1;
set(handles.edit_slSagittal,'String', num2str(val));
axes(handles.ax_sagittal);
imshow(reshape(handles.img(val,:,:),[handles.nSagittalSlices, handles.nSlices]),[]);
set(handles.ax_sagittal,'Visible', 'off');
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function sl_sagittal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sl_sagittal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit_slSagittal_Callback(hObject, eventdata, handles)
% hObject    handle to edit_slSagittal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_slSagittal as text
%        str2double(get(hObject,'String')) returns contents of edit_slSagittal as a double


% --- Executes during object creation, after setting all properties.
function edit_slSagittal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_slSagittal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function sl_coronal_Callback(hObject, eventdata, handles)
% hObject    handle to sl_coronal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
sliderValue = get(handles.sl_coronal,'Value');
%puts the slider value into the edit text component
val = ceil(sliderValue*(handles.nSagittalSlices-1))+1;
set(handles.edit_slCoronal,'String', num2str(val));
axes(handles.ax_coronal);
imshow(reshape(handles.img(:,val,:),[handles.nCoronalSlices, handles.nSlices]),[]);
set(handles.ax_coronal,'Visible', 'off');


% --- Executes during object creation, after setting all properties.
function sl_coronal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sl_coronal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit_slCoronal_Callback(hObject, eventdata, handles)
% hObject    handle to edit_slCoronal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_slCoronal as text
%        str2double(get(hObject,'String')) returns contents of edit_slCoronal as a double


% --- Executes during object creation, after setting all properties.
function edit_slCoronal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_slCoronal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

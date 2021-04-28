function varargout = statsinputredo(varargin)
% STATSINPUTREDO MATLAB code for statsinputredo.fig
%      STATSINPUTREDO, by itself, creates a new STATSINPUTREDO or raises the existing
%      singleton*.
%
%      H = STATSINPUTREDO returns the handle to a new STATSINPUTREDO or the handle to
%      the existing singleton*.
%
%      STATSINPUTREDO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STATSINPUTREDO.M with the given input arguments.
%
%      STATSINPUTREDO('Property','Value',...) creates a new STATSINPUTREDO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before statsinputredo_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to statsinputredo_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help statsinputredo

% Last Modified by GUIDE v2.5 27-Apr-2021 21:43:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @statsinputredo_OpeningFcn, ...
                   'gui_OutputFcn',  @statsinputredo_OutputFcn, ...
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


% --- Executes just before statsinputredo is made visible.
function statsinputredo_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to statsinputredo (see VARARGIN)

% Choose default command line output for statsinputredo
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes statsinputredo wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = statsinputredo_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function editOutputDir_Callback(hObject, eventdata, handles)
% hObject    handle to editOutputDir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editOutputDir as text
%        str2double(get(hObject,'String')) returns contents of editOutputDir as a double


% --- Executes during object creation, after setting all properties.
function editOutputDir_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editOutputDir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnOutputDir.
function btnOutputDir_Callback(hObject, eventdata, handles)
% hObject    handle to btnOutputDir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btnManualSelectionG2.
function btnManualSelectionG2_Callback(hObject, eventdata, handles)
% hObject    handle to btnManualSelectionG2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btnBatchSelectionG2.
function btnBatchSelectionG2_Callback(hObject, eventdata, handles)
% hObject    handle to btnBatchSelectionG2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btnManualSelectionG1.
function btnManualSelectionG1_Callback(hObject, eventdata, handles)
% hObject    handle to btnManualSelectionG1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btnBatchSelectionG1.
function btnBatchSelectionG1_Callback(hObject, eventdata, handles)
% hObject    handle to btnBatchSelectionG1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in listboxG2.
function listboxG2_Callback(hObject, eventdata, handles)
% hObject    handle to listboxG2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listboxG2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listboxG2


% --- Executes during object creation, after setting all properties.
function listboxG2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listboxG2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listboxG1.
function listboxG1_Callback(hObject, eventdata, handles)
% hObject    handle to listboxG1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listboxG1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listboxG1


% --- Executes during object creation, after setting all properties.
function listboxG1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listboxG1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnGo.
function btnGo_Callback(hObject, eventdata, handles)
% hObject    handle to btnGo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function numG2_Callback(hObject, eventdata, handles)
% hObject    handle to numG2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numG2 as text
%        str2double(get(hObject,'String')) returns contents of numG2 as a double


% --- Executes during object creation, after setting all properties.
function numG2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numG2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function numG1_Callback(hObject, eventdata, handles)
% hObject    handle to numG1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numG1 as text
%        str2double(get(hObject,'String')) returns contents of numG1 as a double


% --- Executes during object creation, after setting all properties.
function numG1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numG1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

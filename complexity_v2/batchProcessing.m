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

% Last Modified by GUIDE v2.5 13-May-2021 02:11:02

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
tm = javax.swing.ToolTipManager.sharedInstance; %static method to get ToolTipManager object
javaMethodEDT('setInitialDelay',tm,0)
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
handles.lempelZiv = 0;
handles.hurstExp = 0;
handles.LLExp = 0;
handles.fracDim = 0;
handles.apEn = 0;
handles.sampEn = 0;
handles.waveletMSE = 0; 
handles.fuzzyEn = 0;
handles.permEn = 0;


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


% --- Executes on button press in checkbox_lempelZiv.
function checkbox_lempelZiv_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_lempelZiv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_lempelZiv
value = get(hObject,'Value');
handles.lempelZiv = value;
guidata(hObject, handles);


% --- Executes on button press in checkbox_hurstExp.
function checkbox_hurstExp_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_hurstExp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_hurstExp
value = get(hObject,'Value');
handles.hurstExp = value;
guidata(hObject, handles);


% --- Executes on button press in checkbox_LLExp.
function checkbox_LLExp_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_LLExp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_LLExp
value = get(hObject,'Value');
handles.LLExp = value;
guidata(hObject, handles);


% --- Executes on button press in checkbox_fracDim.
function checkbox_fracDim_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_fracDim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_fracDim
value = get(hObject,'Value');
handles.fracDim = value;
guidata(hObject, handles);


% --- Executes on button press in checkbox_apEn.
function checkbox_apEn_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_apEn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_apEn
value = get(hObject,'Value');
handles.apEn = value;
guidata(hObject, handles);


% --- Executes on button press in checkbox_sampEn.
function checkbox_sampEn_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_sampEn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_sampEn
value = get(hObject,'Value');
handles.sampEn = value;
guidata(hObject, handles);


% --- Executes on button press in checkbox_waveletMSE.
function checkbox_waveletMSE_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_waveletMSE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_waveletMSE
value = get(hObject,'Value');
handles.waveletMSE = value;
guidata(hObject, handles);


% --- Executes on button press in checkbox_fuzzyEn.
function checkbox_fuzzyEn_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_fuzzyEn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_fuzzyEn
value = get(hObject,'Value');
handles.fuzzyEn = value;
guidata(hObject, handles);


% --- Executes on button press in checkbox_permEn.
function checkbox_permEn_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_permEn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_permEn
value = get(hObject,'Value');
handles.permEn_normalize = value;
guidata(hObject, handles);




function edit_lempelZiv_m_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_lempelZiv_m_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_lempelZiv_m_start as text
%        str2double(get(hObject,'String')) returns contents of edit_lempelZiv_m_start as a double
m_start = get(hObject,'String');
m_start = str2num(m_start);
handles.lempelZiv_m_start = m_start;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_lempelZiv_m_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_lempelZiv_m_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'TooltipString','For LempelZiv, recomended value for dimensionality(m): 1-5')
guidata(hObject,handles);

function edit_hurstExp_m_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_hurstExp_m_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_hurstExp_m_start as text
%        str2double(get(hObject,'String')) returns contents of edit_hurstExp_m_start as a double
m_start = get(hObject,'String');
m_start = str2num(m_start);
handles.hurstExp_m_start = m_start;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_hurstExp_m_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_hurstExp_m_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'TooltipString','For Hurst Exponent, recomended value for dimensionality(m): 1-5')
guidata(hObject,handles);


function edit_LLExp_m_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_LLExp_m_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_LLExp_m_start as text
%        str2double(get(hObject,'String')) returns contents of edit_LLExp_m_start as a double
m_start = get(hObject,'String');
m_start = str2num(m_start);
handles.LLExp_m_start = m_start;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_LLExp_m_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_LLExp_m_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'TooltipString','For Largest Lyapunov Exponent, recomended value for dimensionality(m): 1-5')
guidata(hObject,handles);


function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_apEn_m_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_apEn_m_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_apEn_m_start as text
%        str2double(get(hObject,'String')) returns contents of edit_apEn_m_start as a double
m_start = get(hObject,'String');
m_start = str2num(m_start);
handles.apEn_m_start = m_start;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_apEn_m_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_apEn_m_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

set(hObject,'TooltipString','For Approx Entropy, recomended value for dimensionality(m): 1-5');
guidata(hObject,handles);


function edit_sampEn_m_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sampEn_m_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sampEn_m_start as text
%        str2double(get(hObject,'String')) returns contents of edit_sampEn_m_start as a double
m_start = get(hObject,'String');
disp('entered mstart for samp');
m_start = str2num(m_start);
handles.sampEn_m_start = m_start;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_sampEn_m_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sampEn_m_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'TooltipString','For Sample Entropy, recomended value for dimensionality(m): 1-5')
guidata(hObject,handles);


function edit_waveletMSE_m_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_waveletMSE_m_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_waveletMSE_m_start as text
%        str2double(get(hObject,'String')) returns contents of edit_waveletMSE_m_start as a double
m_start = get(hObject,'String');
m_start = str2num(m_start);
handles.waveletMSE_m_start = m_start;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_waveletMSE_m_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_waveletMSE_m_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'TooltipString','For Wavelength MSE, recomended value for dimensionality(m): 1-5')
guidata(hObject,handles);


function edit_fuzzyEn_m_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fuzzyEn_m_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fuzzyEn_m_start as text
%        str2double(get(hObject,'String')) returns contents of edit_fuzzyEn_m_start as a double
m_start = get(hObject,'String');
m_start = str2num(m_start);
handles.fuzzyEn_m_start = m_start;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_fuzzyEn_m_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fuzzyEn_m_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'TooltipString','For Fuzzy Entropy, recomended value for dimensionality(m): 1-5')
guidata(hObject,handles);


function edit_permEn_m_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_permEn_m_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_permEn_m_start as text
%        str2double(get(hObject,'String')) returns contents of edit_permEn_m_start as a double
m_start = get(hObject,'String');
m_start = str2num(m_start);
handles.permEn_m_start = m_start;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_permEn_m_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_permEn_m_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'TooltipString','For Permutation Entropy, recomended value for dimensionality(m): 1-5')
guidata(hObject,handles);


function edit_lempelZiv_m_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_lempelZiv_m_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_lempelZiv_m_end as text
%        str2double(get(hObject,'String')) returns contents of edit_lempelZiv_m_end as a double
m_end = get(hObject,'String');
m_end = str2num(m_end);
handles.lempelZiv_m_end = m_end;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_lempelZiv_m_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_lempelZiv_m_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'TooltipString','For Lempel-Ziv,recomended value for dimensionality(m): 1-5')
guidata(hObject,handles);


function edit_hurstExp_m_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_hurstExp_m_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_hurstExp_m_end as text
%        str2double(get(hObject,'String')) returns contents of edit_hurstExp_m_end as a double
m_end = get(hObject,'String');
m_end = str2num(m_end);
handles.hurstExp_m_end = m_end;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_hurstExp_m_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_hurstExp_m_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'TooltipString','For Hurst, recomended value for dimensionality(m): 1-5')
guidata(hObject,handles);


function edit_LLExp_m_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_LLExp_m_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_LLExp_m_end as text
%        str2double(get(hObject,'String')) returns contents of edit_LLExp_m_end as a double
m_end = get(hObject,'String');
m_end = str2num(m_end);
handles.LLExp_m_end = m_end;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_LLExp_m_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_LLExp_m_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'TooltipString','For Largest Lyapunov Exponent, recomended value for dimensionality(m): 1-5')
guidata(hObject,handles);

function edit_fracDim_m_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fracDim_m_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fracDim_m_start as text
%        str2double(get(hObject,'String')) returns contents of edit_fracDim_m_start as a double
m_start = get(hObject,'String');
m_start = str2num(m_start);
handles.fracDim_m_start = m_start;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_fracDim_m_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fracDim_m_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'TooltipString','For Higuchi Fractal Dimension, recomended value for dimensionality(m): 1-5')
guidata(hObject,handles);



function edit_fracDim_m_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fracDim_m_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fracDim_m_end as text
%        str2double(get(hObject,'String')) returns contents of edit_fracDim_m_end as a double
m_end = get(hObject,'String');
m_end = str2num(m_end);
handles.fracDim_m_end = m_end;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_fracDim_m_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fracDim_m_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'TooltipString','For Higuchi Fractal Diminsion,recomended value 1-5')
guidata(hObject,handles);



function edit_apEn_m_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_apEn_m_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_apEn_m_end as text
%        str2double(get(hObject,'String')) returns contents of edit_apEn_m_end as a double
m_end = get(hObject,'String');
m_end = str2num(m_end);
handles.apEn_m_end = m_end;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_apEn_m_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_apEn_m_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'TooltipString','For Approx Entropy, recomended value for dimensionality(m): 1-5')
guidata(hObject,handles);


function edit_sampEn_m_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sampEn_m_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sampEn_m_end as text
%        str2double(get(hObject,'String')) returns contents of edit_sampEn_m_end as a double
m_end = get(hObject,'String');
m_end = str2num(m_end);
handles.sampEn_m_end = m_end;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_sampEn_m_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sampEn_m_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'TooltipString','For Sample Entropy, recomended value for dimensionality(m): 1-5')
guidata(hObject,handles);


function edit_waveletMSE_m_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_waveletMSE_m_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_waveletMSE_m_end as text
%        str2double(get(hObject,'String')) returns contents of edit_waveletMSE_m_end as a double
m_end = get(hObject,'String');
m_end = str2num(m_end);
handles.waveletMSE_m_end = m_end;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_waveletMSE_m_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_waveletMSE_m_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'TooltipString','For Wavelength MSE, recomended value for dimensionality(m): 1-5')
guidata(hObject,handles);


function edit_fuzzyEn_m_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fuzzyEn_m_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fuzzyEn_m_end as text
%        str2double(get(hObject,'String')) returns contents of edit_fuzzyEn_m_end as a double
m_end = get(hObject,'String');
m_end = str2num(m_end);
handles.fuzzyEn_m_end = m_end;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_fuzzyEn_m_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fuzzyEn_m_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'TooltipString','For Fuzzy Entropy, recomended value for dimensionality(m): 1-5')
guidata(hObject,handles);


function edit_permEn_m_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_permEn_m_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_permEn_m_end as text
%        str2double(get(hObject,'String')) returns contents of edit_permEn_m_end as a double
m_end = get(hObject,'String');
m_end = str2num(m_end);
handles.permEn_m_end = m_end;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_permEn_m_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_permEn_m_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'TooltipString','For Permutation Entropy, recomended value for dimensionality(m): 1-5')
guidata(hObject,handles);


function edit_lempelZiv_r_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_lempelZiv_r_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_lempelZiv_r_start as text
%        str2double(get(hObject,'String')) returns contents of edit_lempelZiv_r_start as a double
r_start = get(hObject,'String');
r_start = str2num(r_start);
handles.lempelZiv_r_start = r_start;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_lempelZiv_r_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_lempelZiv_r_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'TooltipString','For Lempel-Ziv, recomended value for sensitivity threshold(r): 0.2-0.5')
guidata(hObject,handles);


function edit_hurstExp_r_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_hurstExp_r_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_hurstExp_r_start as text
%        str2double(get(hObject,'String')) returns contents of edit_hurstExp_r_start as a double
r_start = get(hObject,'String');
r_start = str2num(r_start);
handles.hurstExp_r_start = r_start;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_hurstExp_r_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_hurstExp_r_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'TooltipString','For Hurst Exponent, recomended value of r: 0.2-0.5')
guidata(hObject,handles);


function edit_LLExp_r_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_LLExp_r_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_LLExp_r_start as text
%        str2double(get(hObject,'String')) returns contents of edit_LLExp_r_start as a double
r_start = get(hObject,'String');
r_start = str2num(r_start);
handles.LLExp_r_start = r_start;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_LLExp_r_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_LLExp_r_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'TooltipString','For Largest Lyapunov Exponent, recomended value for sensitivity threshold(r): 0.2-0.5')
guidata(hObject,handles);


function edit_fracDim_r_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fracDim_r_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fracDim_r_start as text
%        str2double(get(hObject,'String')) returns contents of edit_fracDim_r_start as a double
r_start = get(hObject,'String');
r_start = str2num(r_start);
handles.fracDim_r_start = r_start;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_fracDim_r_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fracDim_r_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'TooltipString','For Higuchi Fractal Dimension, recomended value for sensitivity threshold(r): 0.2-0.5')
guidata(hObject,handles);


function edit_apEn_r_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_apEn_r_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_apEn_r_start as text
%        str2double(get(hObject,'String')) returns contents of edit_apEn_r_start as a double
r_start = get(hObject,'String');
r_start = str2num(r_start);
handles.apEn_r_start = r_start;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_apEn_r_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_apEn_r_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'TooltipString','For Approx Entropy, recomended value for sensitivity threshold(r): 0.2-0.5')
guidata(hObject,handles);


function edit_sampEn_r_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sampEn_r_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sampEn_r_start as text
%        str2double(get(hObject,'String')) returns contents of edit_sampEn_r_start as a double
r_start = get(hObject,'String');
r_start = str2num(r_start);
handles.sampEn_r_start = r_start;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_sampEn_r_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sampEn_r_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'TooltipString','For Sample Entropy, recomended value for sensitivity threshold(r): 0.2-0.5')
guidata(hObject,handles);


function edit_waveletMSE_r_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_waveletMSE_r_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_waveletMSE_r_start as text
%        str2double(get(hObject,'String')) returns contents of edit_waveletMSE_r_start as a double
r_start = get(hObject,'String');
r_start = str2num(r_start);
handles.waveletMSE_r_start = r_start;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_waveletMSE_r_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_waveletMSE_r_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'TooltipString','For Wavelength MSE, recomended value for sensitivity threshold(r):0.2-0.5')
guidata(hObject,handles);


function edit_fuzzyEn_r_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fuzzyEn_r_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fuzzyEn_r_start as text
%        str2double(get(hObject,'String')) returns contents of edit_fuzzyEn_r_start as a double
r_start = get(hObject,'String');
r_start = str2num(r_start);
handles.fuzzyEn_r_start = r_start;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_fuzzyEn_r_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fuzzyEn_r_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'TooltipString','For Fuzzy Entropy, recomended value for sensitivity threshold(r): 0.2-0.5')
guidata(hObject,handles);


function edit_permEn_r_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_permEn_r_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_permEn_r_start as text
%        str2double(get(hObject,'String')) returns contents of edit_permEn_r_start as a double
r_start = get(hObject,'String');
r_start = str2num(r_start);
handles.permEn_r_start = r_start;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_permEn_r_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_permEn_r_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'TooltipString','For Permutation Entropy, recomended value for sensitivity threshold(r): 0.2-0.5')
guidata(hObject,handles);


function edit_lempelZiv_r_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_lempelZiv_r_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_lempelZiv_r_end as text
%        str2double(get(hObject,'String')) returns contents of edit_lempelZiv_r_end as a double
r_end = get(hObject,'String');
r_end = str2num(r_end);
handles.lempelZiv_r_end = r_end;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_lempelZiv_r_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_lempelZiv_r_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'TooltipString','For Lempel-Ziv, recomended value for sensitivity threshold(r): 0.2-0.5')
guidata(hObject,handles);


function edit_hurstExp_r_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_hurstExp_r_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_hurstExp_r_end as text
%        str2double(get(hObject,'String')) returns contents of edit_hurstExp_r_end as a double
r_end = get(hObject,'String');
r_end = str2num(r_end);
handles.hurstExp_r_end = r_end;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_hurstExp_r_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_hurstExp_r_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'TooltipString','For Hurst Exponent, recomended value for sensitivity threshold(r): 0.2-0.5')
guidata(hObject,handles);


function edit_LLExp_r_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_LLExp_r_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_LLExp_r_end as text
%        str2double(get(hObject,'String')) returns contents of edit_LLExp_r_end as a double
r_end = get(hObject,'String');
r_end = str2num(r_end);
handles.LLExp_r_end = r_end;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_LLExp_r_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_LLExp_r_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'TooltipString','For Largest Lyapunov Exponent, recomended value for sensitivity threshold(r): 0.2-0.5')
guidata(hObject,handles);


function edit_fracDim_r_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fracDim_r_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fracDim_r_end as text
%        str2double(get(hObject,'String')) returns contents of edit_fracDim_r_end as a double
r_end = get(hObject,'String');
r_end = str2num(r_end);
handles.fracDim_r_end = r_end;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_fracDim_r_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fracDim_r_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'TooltipString','For Higuchi Fractal Dimension, recomended value for sensitivity threshold(r): 0.2-0.5')
guidata(hObject,handles);


function edit_apEn_r_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_apEn_r_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_apEn_r_end as text
%        str2double(get(hObject,'String')) returns contents of edit_apEn_r_end as a double
r_end = get(hObject,'String');
r_end = str2num(r_end);
handles.apEn_r_end = r_end;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_apEn_r_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_apEn_r_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'TooltipString','For Approx Entropy, recomended value for sensitivity threshold(r): 0.2-0.5')
guidata(hObject,handles);


function edit_waveletMSE_r_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_waveletMSE_r_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_waveletMSE_r_end as text
%        str2double(get(hObject,'String')) returns contents of edit_waveletMSE_r_end as a double
r_end = get(hObject,'String');
r_end = str2num(r_end);
handles.waveletMSE_r_end = r_end;
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function edit_waveletMSE_r_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_waveletMSE_r_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'TooltipString','For Wavelength MSE, recomended value for sensitivity threshold(r): 0.2-0.5')
guidata(hObject,handles);


function edit_fuzzyEn_r_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fuzzyEn_r_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fuzzyEn_r_end as text
%        str2double(get(hObject,'String')) returns contents of edit_fuzzyEn_r_end as a double
r_end = get(hObject,'String');
r_end = str2num(r_end);
handles.fuzzyEn_r_end = r_end;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_fuzzyEn_r_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fuzzyEn_r_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'TooltipString','For Fuzzy Entropy, recomended value for sensitivity threshold(r): 0.2-0.5')
guidata(hObject,handles);


function edit_permEn_r_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_permEn_r_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_permEn_r_end as text
%        str2double(get(hObject,'String')) returns contents of edit_permEn_r_end as a double
r_end = get(hObject,'String');
r_end = str2num(r_end);
handles.permEn_r_end = r_end;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_permEn_r_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_permEn_r_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'TooltipString','For Permutation Entropy, recomended value for sensitivity threshold(r): 0.2-0.5')
guidata(hObject,handles);


function edit_lempelZiv_scale_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_lempelZiv_scale_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_lempelZiv_scale_start as text
%        str2double(get(hObject,'String')) returns contents of edit_lempelZiv_scale_start as a double
scale_start = get(hObject,'String');
scale_start = str2num(scale_start);
handles.lempelZiv_scale_start = scale_start;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_lempelZiv_scale_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_lempelZiv_scale_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_hurstExp_scale_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_hurstExp_scale_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_hurstExp_scale_start as text
%        str2double(get(hObject,'String')) returns contents of edit_hurstExp_scale_start as a double
scale_start = get(hObject,'String');
scale_start = str2num(scale_start);
handles.hurstExp_scale_start = scale_start;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_hurstExp_scale_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_hurstExp_scale_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_LLExp_scale_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_LLExp_scale_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_LLExp_scale_start as text
%        str2double(get(hObject,'String')) returns contents of edit_LLExp_scale_start as a double
scale_start = get(hObject,'String');
scale_start = str2num(scale_start);
handles.LLExp_scale_start = scale_start;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_LLExp_scale_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_LLExp_scale_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fracDim_scale_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fracDim_scale_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fracDim_scale_start as text
%        str2double(get(hObject,'String')) returns contents of edit_fracDim_scale_start as a double
scale_start = get(hObject,'String');
scale_start = str2num(scale_start);
handles.fracDim_scale_start = scale_start;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_fracDim_scale_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fracDim_scale_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_apEn_scale_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_apEn_scale_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_apEn_scale_start as text
%        str2double(get(hObject,'String')) returns contents of edit_apEn_scale_start as a double
scale_start = get(hObject,'String');
scale_start = str2num(scale_start);
handles.apEn_scale_start = scale_start;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_apEn_scale_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_apEn_scale_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_waveletMSE_scale_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_waveletMSE_scale_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_waveletMSE_scale_start as text
%        str2double(get(hObject,'String')) returns contents of edit_waveletMSE_scale_start as a double
scale_start = get(hObject,'String');
scale_start = str2num(scale_start);
handles.waveletMSE_scale_start = scale_start;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_waveletMSE_scale_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_waveletMSE_scale_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fuzzyEn_scale_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fuzzyEn_scale_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fuzzyEn_scale_start as text
%        str2double(get(hObject,'String')) returns contents of edit_fuzzyEn_scale_start as a double
scale_start = get(hObject,'String');
scale_start = str2num(scale_start);
handles.fuzzyEn_scale_start = scale_start;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_fuzzyEn_scale_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fuzzyEn_scale_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_permEn_scale_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_permEn_scale_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_permEn_scale_start as text
%        str2double(get(hObject,'String')) returns contents of edit_permEn_scale_start as a double
scale_start = get(hObject,'String');
scale_start = str2num(scale_start);
handles.permEn_scale_start = scale_start;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_permEn_scale_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_permEn_scale_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_lempelZiv_scale_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_lempelZiv_scale_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_lempelZiv_scale_end as text
%        str2double(get(hObject,'String')) returns contents of edit_lempelZiv_scale_end as a double
scale_end = get(hObject,'String');
scale_end = str2num(scale_end);
handles.lempelZiv_scale_end = scale_end;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_lempelZiv_scale_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_lempelZiv_scale_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_hurstExp_scale_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_hurstExp_scale_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_hurstExp_scale_end as text
%        str2double(get(hObject,'String')) returns contents of edit_hurstExp_scale_end as a double
scale_end = get(hObject,'String');
scale_end = str2num(scale_end);
handles.hurstExp_scale_end = scale_end;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_hurstExp_scale_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_hurstExp_scale_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_LLExp_scale_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_LLExp_scale_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_LLExp_scale_end as text
%        str2double(get(hObject,'String')) returns contents of edit_LLExp_scale_end as a double
scale_end = get(hObject,'String');
scale_end = str2num(scale_end);
handles.LLExp_scale_end = scale_end;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_LLExp_scale_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_LLExp_scale_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fracDim_scale_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fracDim_scale_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fracDim_scale_end as text
%        str2double(get(hObject,'String')) returns contents of edit_fracDim_scale_end as a double
scale_end = get(hObject,'String');
scale_end = str2num(scale_end);
handles.fracDim_scale_end = scale_end;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_fracDim_scale_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fracDim_scale_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_apEn_scale_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_apEn_scale_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_apEn_scale_end as text
%        str2double(get(hObject,'String')) returns contents of edit_apEn_scale_end as a double
scale_end = get(hObject,'String');
scale_end = str2num(scale_end);
handles.apEn_scale_end = scale_end;
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function edit_apEn_scale_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_apEn_scale_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_sampEn_scale_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sampEn_scale_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sampEn_scale_end as text
%        str2double(get(hObject,'String')) returns contents of edit_sampEn_scale_end as a double
scale_end = get(hObject,'String');
scale_end = str2num(scale_end);
handles.sampEn_scale_end = scale_end;
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function edit_sampEn_scale_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sampEn_scale_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_waveletMSE_scale_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_waveletMSE_scale_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_waveletMSE_scale_end as text
%        str2double(get(hObject,'String')) returns contents of edit_waveletMSE_scale_end as a double
scale_end = get(hObject,'String');
scale_end = str2num(scale_end);
handles.waveletMSE_scale_end = scale_end;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_waveletMSE_scale_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_waveletMSE_scale_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fuzzyEn_scale_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fuzzyEn_scale_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fuzzyEn_scale_end as text
%        str2double(get(hObject,'String')) returns contents of edit_fuzzyEn_scale_end as a double
scale_end = get(hObject,'String');
scale_end = str2num(scale_end);
handles.fuzzyEn_scale_end = scale_end;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_fuzzyEn_scale_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fuzzyEn_scale_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_permEn_scale_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_permEn_scale_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_permEn_scale_end as text
%        str2double(get(hObject,'String')) returns contents of edit_permEn_scale_end as a double
scale_end = get(hObject,'String');
scale_end = str2num(scale_end);
handles.permEn_scale_end = scale_end;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_permEn_scale_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_permEn_scale_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fracDim_k_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fracDim_k_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fracDim_k_start as text
%        str2double(get(hObject,'String')) returns contents of edit_fracDim_k_start as a double
k_start = get(hObject,'String');
k_start = str2num(k_start);
handles.fracDim_k_start = k_start;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_fracDim_k_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fracDim_k_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'TooltipString','For Higuchi Fractal Dimenton,recomended value for k:3-5')
guidata(hObject,handles);


function edit_fracDim_k_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fracDim_k_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fracDim_k_end as text
%        str2double(get(hObject,'String')) returns contents of edit_fracDim_k_end as a double
k_end = get(hObject,'String');
k_end = str2num(k_end);
handles.fracDim_k_end = k_end;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_fracDim_k_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fracDim_k_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'TooltipString','For Higuchi Fractal Dimenton,recomended value for k:3-5')
guidata(hObject,handles);


function edit_fuzzyEn_n_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fuzzyEn_n_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fuzzyEn_n_start as text
%        str2double(get(hObject,'String')) returns contents of edit_fuzzyEn_n_start as a double
n_start = get(hObject,'String');
n_start = str2num(n_start);
handles.fuzzyEn_n_start = n_start;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_fuzzyEn_n_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fuzzyEn_n_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'TooltipString','For Fuzzy Entropy,recomended value for fuzzy power(n):2')
guidata(hObject,handles)


function edit_fuzzyEn_n_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fuzzyEn_n_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fuzzyEn_n_end as text
%        str2double(get(hObject,'String')) returns contents of edit_fuzzyEn_n_end as a double
n_end = get(hObject,'String');
n_end = str2num(n_end);
handles.fuzzyEn_n_end = n_end;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_fuzzyEn_n_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fuzzyEn_n_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'TooltipString','For Fuzzy Entropy,recomended value for fuzzy power(n):2')
guidata(hObject,handles)



function edit_fuzzyEn_tau_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fuzzyEn_tau_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fuzzyEn_tau_start as text
%        str2double(get(hObject,'String')) returns contents of edit_fuzzyEn_tau_start as a double
tau_start = get(hObject,'String');
tau_start = str2num(tau_start);
handles.fuzzyEn_tau_start = tau_start;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_fuzzyEn_tau_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fuzzyEn_tau_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'TooltipString','For Fuzzy Entropy,recomended value for fuzzy power time lag(t):1')
guidata(hObject,handles);


function edit_fuzzyEn_tau_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fuzzyEn_tau_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fuzzyEn_tau_end as text
%        str2double(get(hObject,'String')) returns contents of edit_fuzzyEn_tau_end as a double
tau_end = get(hObject,'String');
tau_end = str2num(tau_end);
handles.fuzzyEn_tau_end = tau_end;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_fuzzyEn_tau_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fuzzyEn_tau_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'TooltipString','For Fuzzy Entropy,recomended value for fuzzy power time lag(t):1')
guidata(hObject,handles);


function edit_permEn_delay_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_permEn_delay_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_permEn_delay_start as text
%        str2double(get(hObject,'String')) returns contents of edit_permEn_delay_start as a double
delay_start = get(hObject,'String');
delay_start = str2num(delay_start);
handles.permEn_delay_start = delay_start;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_permEn_delay_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_permEn_delay_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_permEn_delay_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_permEn_delay_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_permEn_delay_end as text
%        str2double(get(hObject,'String')) returns contents of edit_permEn_delay_end as a double
delay_end = get(hObject,'String');
delay_end = str2num(delay_end);
handles.permEn_delay_end = delay_end;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_permEn_delay_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_permEn_delay_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_permEn_order_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_permEn_order_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_permEn_order_start as text
%        str2double(get(hObject,'String')) returns contents of edit_permEn_order_start as a double
ord_start = get(hObject,'String');
ord_start = str2num(ord_start);
handles.permEn_ord_start = ord_start;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_permEn_order_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_permEn_order_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_permEn_order_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_permEn_order_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_permEn_order_end as text
%        str2double(get(hObject,'String')) returns contents of edit_permEn_order_end as a double


% --- Executes during object creation, after setting all properties.
function edit_permEn_order_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_permEn_order_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox_normalize.
function checkbox_normalize_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_normalize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_normalize



function edit_sampEn_r_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sampEn_r_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sampEn_r_end as text
%        str2double(get(hObject,'String')) returns contents of edit_sampEn_r_end as a double
r_end = get(hObject,'String');
r_end = str2num(r_end);
handles.sampEn_r_end = r_end;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_sampEn_r_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sampEn_r_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'TooltipString','For Sample Entropy, recomended value for sensitivity threshold(r): 0.2-0.5')
guidata(hObject,handles);


function edit_sampEn_scale_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sampEn_scale_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sampEn_scale_start as text
%        str2double(get(hObject,'String')) returns contents of edit_sampEn_scale_start as a double
scale_start = get(hObject,'String');
scale_start = str2num(scale_start);
handles.sampEn_scale_start = scale_start;
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function edit_sampEn_scale_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sampEn_scale_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_inputDir_Callback(hObject, eventdata, handles)
% hObject    handle to edit_inputDir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_inputDir as text
%        str2double(get(hObject,'String')) returns contents of edit_inputDir as a double



% --- Executes during object creation, after setting all properties.
function edit_inputDir_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_inputDir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_inputDir.
function btn_inputDir_Callback(hObject, eventdata, handles)
% hObject    handle to btn_inputDir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ipFormat = cell2mat(inputdlg('Input 3D or 4D', 'Input selection'));
if isempty(ipFormat)
    msgbox('Please choose the input format: 3D or 4D');
else
    if (strcmp(ipFormat,'3D')==1 | strcmp(ipFormat,'3d')==1)
        handles.d3d4='3D';        
    else
        handles.d3d4='4D';
    end
    dirName = uigetdir;
    handles.inputDir = dirName;
    guidata(hObject, handles);
    set(handles.edit_inputDir, 'string', handles.inputDir);
    if (dirName==0)
        msgbox('No image input directory selected','Error Message');
    end
    
end

guidata(hObject, handles);
        

% ipFormat = cell2mat(inputdlg('Input 3D or 4D', 'Input selection'));
% if isempty(ipFormat)
%     disp('Please choose the input format: 3D or 4D');
% else
%     if (strcmp(ipFormat,'3D')==1 | strcmp(ipFormat,'3d')==1)
%         dirName = uigetdir;
%         if (dirName==0)
%             disp('No image input directory selected');
%         else
%             imgStruct = readImages4D(dirName);
%             disp(imgStruct);
%             handles.img_4D = imgStruct.img_4D;
%             handles.baseName = imgStruct.bName;
%             handles.imgVoxDim = imgStruct.voxDim;
%             handles.originator = imgStruct.originator;
%         end
%     else
%         [fname, pname] = uigetfile('*.*','Select the 4D image');
%         if (fname==0 & pname==0)
%             disp('4D image file not selected');
%         else
%             imgName = [pname, fname];
%             imgStruct = load_nii(imgName);
%             handles.img_4D = imgStruct.img;
%             handles.originator = imgStruct.hdr.hist.originator(1:3);
%             [p,f,e] = fileparts(imgName);
%             handles.baseName = f;
%             handles.imgVoxDim = imgStruct.hdr.dime.pixdim(2:4);
%         end
%     end
% end
% guidata(hObject,handles);
% disp('Done reading input images');



function edit_subjectPattern_Callback(hObject, eventdata, handles)
% hObject    handle to edit_subjectPattern (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_subjectPattern as text
%        str2double(get(hObject,'String')) returns contents of edit_subjectPattern as a double


% --- Executes during object creation, after setting all properties.
function edit_subjectPattern_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_subjectPattern (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'TooltipString','For Example: enter btest*/ for selecting test case folders starting with the phrase btest')
guidata(hObject,handles);




function edit_fmriPattern_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fmriPattern (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fmriPattern as text
%        str2double(get(hObject,'String')) returns contents of edit_fmriPattern as a double


% --- Executes during object creation, after setting all properties.
function edit_fmriPattern_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fmriPattern (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_filePattern_Callback(hObject, eventdata, handles)
% hObject    handle to edit_filePattern (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_filePattern as text
%        str2double(get(hObject,'String')) returns contents of edit_filePattern as a double


% --- Executes during object creation, after setting all properties.
function edit_filePattern_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_filePattern (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'TooltipString','For Example: enter *.nii to select all files with .nii extension in the subject folder')
guidata(hObject,handles);




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


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function ans=select_brain_mask(hObject,handles,imgStruct)
 [fname, pname] = uigetfile('*.*','Select the brain mask');
    
if (fname==0 & pname==0)
    disp('Brain mask not selected');
else
    mask_file = [pname, fname];
    mask = load_nii(mask_file);
    if (size(mask.img) ~= size(imgStruct.img_4D(:,:,:,1)))
        msgbox('Mask and Input image dimensions do not match');
    else
        handles.brainMask = mask.img;
        guidata(hObject, handles);
    end
end
ans=mask.img;
% --- Executes on button press in btn_load.
function btn_load_Callback(hObject, eventdata, handles)
% hObject    handle to btn_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
A = sum(strcmp(fieldnames(handles),'inputDir'));
B = sum(strcmp(fieldnames(handles),'outputDir'));
O = sum(strcmp(fieldnames(handles),'opFolder'));
if A==0
   disp('Input not selected');
   msgbox('Input Directory was not selected','Error Message');
   return
end 
% if B==0
%     disp('Brain mask not selected');
%     msgbox('Brain Mask was not selected','Error Message');
%     return
% end

if B==0
    disp('Output Folder not selected');
    msgbox('Please select an Output Directory','Error Message');
    return
end
ipChk = [A B];
clear A B;
subjectPattern = get(handles.edit_subjectPattern, 'String');
fmriPattern = get(handles.edit_fmriPattern, 'String');
filePattern = get(handles.edit_filePattern, 'String');
subject_search = strcat(handles.inputDir,filesep,subjectPattern);
file_search = strcat(handles.inputDir,filesep,subjectPattern,filesep,fmriPattern,filesep,filePattern);
disp('file search');
disp(file_search);
disp('subject search');
disp(dir(subject_search));
subjects = dir(subject_search);
files = dir(file_search);
set(handles.text_dataInfo,'string',([num2str(length(subjects)), ' subjects, ', num2str(length(files)), ' scans loaded']));
if(handles.d3d4=='3D')
        disp('inside 3d case');
        disp(length(files));
        for i=1:length(files)
             folders{i}=[files(i).folder];
        end

        temp = unique(folders,'stable');
        subFolders=temp;
        disp(subFolders); 
        imgStruct = readImages4D(subFolders{1});
        %handles.brainMask=select_brain_mask(hObject,handles,imgStruct);
        for k = 1 :  length(subFolders)
            thisSubFolder = subFolders{k};
            fprintf('Found sub: %s.\n', thisSubFolder);
            imgStruct = readImages4D(thisSubFolder);
            handle(k).img_4D = imgStruct.img_4D;
            handle(k).baseName = imgStruct.bName;
            handle(k).imgVoxDim = imgStruct.voxDim;
            handle(k).size=length(subFolders);   
            if(handles.batchmask_flag==0)
                handle(k).brainMask=handles.mask;
            end
        end
        handles.scans=handle;
        guidata(hObject,handles);
        disp(handles.scans);
elseif(handles.d3d4=='4D')
        disp('inside 4d case');
        opStruct = struct([]);
        files_master = {};
        for i=1:length(files)
            fullpath = [files(i).folder,filesep,files(i).name];
            disp(fullpath);
            files_master{i} = {fullpath};
            imgStruct = niftiread(fullpath);
            opStruct(i).img_4D = imgStruct;
            [p,f,e] = fileparts(files(i).name);
            [p,f,e] = fileparts(f);
            opStruct(i).bName = f;
            %if (size(handles.mask) ~= size(opStruct(i).img_4D(:,:,:,1)))
            %    msgbox('Mask and Input image dimensions do not match');
            %end
            folder = [handles.outputDir,filesep,'tmp'];
            gunzip(fullpath,folder);
            tmp_files = dir(folder);
            for j=1:length(tmp_files)
                if strcmp(tmp_files(j).name,'.')
                    continue
                elseif strcmp(tmp_files(j).name,'..')
                    continue
                end
                disp('Loading nii');
                imgStruct = load_nii_hdr([folder, filesep, tmp_files(j).name]);
                delete([folder, filesep, tmp_files(j).name]);
                opStruct(i).originator = imgStruct.hist.originator(1:3);
                opStruct(i).voxDim = imgStruct.dime.pixdim(2:4);
            end
        end
        handles.scans = opStruct;
        handles.files_master = files_master;
        %disp(handles.scans(1));
        %disp(handles.scans(2));
        %disp(handles.scans(3));
        guidata(hObject, handles);
        
end
disp('Done reading input images');

function btn_run_Callback(hObject, eventdata, handles)
% hObject    handle to pb_run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
A = sum(strcmp(fieldnames(handles),'inputDir'));
B1 = sum(strcmp(fieldnames(handles),'brainMask'));
B2 =sum(strcmp(fieldnames(handles),'mask'));
O = sum(strcmp(fieldnames(handles),'outputDir'));
if A==0
   disp('Input not selected');
   msgbox('Input Directory was not selected','Error Message');
   return
end 
if B1==0 && B2 ==0
    disp('Brain mask not selected');
    msgbox('Brain Mask was not selected','Error Message');
    return
else
    if B1==0
        B=B2;
    else
        B=B1;
    end
end

if O==0
    disp('Output Folder not selected');
    msgbox('Please select an Output Directory','Error Message');
    return
end
if handles.lempelZiv
    C = sum(strcmp(fieldnames(handles),'lempelZiv_m_start'));
    D = sum(strcmp(fieldnames(handles),'lempelZiv_m_end'));
    E = sum(strcmp(fieldnames(handles),'lempelZiv_r_start'));
    F = sum(strcmp(fieldnames(handles),'lempelZiv_r_end'));
    G = sum(strcmp(fieldnames(handles),'lempelZiv_scale_start'));
    H = sum(strcmp(fieldnames(handles),'lempelZiv_scale_end'));
    ipChk = [C D E F G H];
    if E==0
        disp('r not selected');
        msgbox('Please enter the value of r for Lempel-Ziv','Error Message');
        return
    end
    clear C D E F G H 
%     set(handles.edit_lempelZiv_m_start, 'Enable', 'off');
%     set(handles.edit_lempelZiv_m_end, 'Enable', 'off');
%     set(handles.edit_lempelZiv_r_start, 'Enable', 'off');
%     set(handles.edit_lempelZiv_r_end, 'Enable', 'off');
%     set(handles.edit_lempelZiv_scale_start, 'Enable', 'off');
%     set(handles.edit_lempelZiv_scale_end, 'Enable', 'off');
    for k=1:length(handles.scans)
        handle=handles.scans(k);
        %disp(handle.baseName)
        handle.outputDir=handles.outputDir;
        %disp(handles.outputDir);
        if(handles.batchmask_flag==1)
            handles.mask=load_untouch_nii(handles.mask_arr(k)).img;
        end
        lempel_ziv_call(handle, handles.mask,handles.lempelZiv_r_start);
        %lempel_ziv_call(handles, handles.brainMask, handles.lempelZiv_m_start, handles.lempelZiv_m_end, handles.lempelZiv_r_start, handles.lempelZiv_r_end, handles.lempelZiv_scale_start, handles.lempelZiv_scale_end);
    end
    
end

if handles.hurstExp
    C = sum(strcmp(fieldnames(handles),'hurstExp_m_start'));
    D = sum(strcmp(fieldnames(handles),'hurstExp_m_end'));
    E = sum(strcmp(fieldnames(handles),'hurstExp_r_start'));
    F = sum(strcmp(fieldnames(handles),'hurstExp_r_end'));
    G = sum(strcmp(fieldnames(handles),'hurstExp_scale_start'));
    H = sum(strcmp(fieldnames(handles),'hurstExp_scale_end'));
    ipChk = [A B C D E F G H];
    if E==0
        disp('r not selected');
        msgbox('r not selected for Hurst Exponent');
        return 
    end
    if G==0
       handles.hurstExp_scale_start=1
       G=1
    end
    if F==0
        handles.hurstExp_r_end=handles.hurstExp_r_start + handles.hurstExp_scale_start/2
    end
    clear C D E F G H 
    
    
    for k=1:length(handles.scans)
        handle=handles.scans(k);
        handle.outputDir=handles.outputDir;
        %disp(handles.outputDir);
        if(handles.batchmask_flag==1)
            handles.mask=load_untouch_nii(handles.mask_arr(k)).img;
        end
        %disp(handle.baseName)
        hurst_ex_call(handle, handles.mask,handles.hurstExp_r_start,handles.hurstExp_r_end,handles.hurstExp_scale_start);
        %call or hurst
    end
end
if handles.LLExp
    C = sum(strcmp(fieldnames(handles),'LLExp_m_start'));
    D = sum(strcmp(fieldnames(handles),'LLExp_m_end'));
    E = sum(strcmp(fieldnames(handles),'LLExp_r_start'));
    F = sum(strcmp(fieldnames(handles),'LLExp_r_end'));
    G = sum(strcmp(fieldnames(handles),'LLExp_scale_start'));
    H = sum(strcmp(fieldnames(handles),'LLExp_scale_end'));
    ipChk = [C D E F G H];
    clear C D E F G H 
    set(handles.edit_LLExp_m_start, 'Enable', 'off');
    set(handles.edit_LLExp_m_end, 'Enable', 'off');
    set(handles.edit_LLExp_r_start, 'Enable', 'off');
    set(handles.edit_LLExp_r_end, 'Enable', 'off');
    set(handles.edit_LLExp_scale_start, 'Enable', 'off');
    set(handles.edit_LLExp_scale_end, 'Enable', 'off');
    for k=1:length(handles.scans)
        handle=handles.scans(k);
        %handle.outputDir=handles.outputDir;
        %disp(handles.outputDir);
        if(handles.batchmask_flag==1)
            handles.mask=load_untouch_nii(handles.mask_arr(k)).img;
        end
        disp(handle.baseName)
        %ap_en_call(handle, handle.brainMask, 2, 3, 0.3, 0.4, 1,0.1);
        %call for llexp
    end
end
if handles.fracDim
    C = sum(strcmp(fieldnames(handles),'fracDim_m_start'));
    D = sum(strcmp(fieldnames(handles),'fracDim_m_end'));
    E = sum(strcmp(fieldnames(handles),'fracDim_r_start'));
    F = sum(strcmp(fieldnames(handles),'fracDim_r_end'));
    G = sum(strcmp(fieldnames(handles),'fracDim_scale_start'));
    H = sum(strcmp(fieldnames(handles),'fracDim_scale_end'));
    I = sum(strcmp(fieldnames(handles),'fracDim_k_start'));
    J = sum(strcmp(fieldnames(handles),'fracDim_k_end'));
    K= sum(strcmp(fieldnames(handles),'fracDim_scale_start'));
    ipChk = [A B I J K];
    
    if I==0
        msgbox('Please select k for Higuchi Fractal Dimension','Error Message')
        return
    end
    if K==0
       handles.fracDim_scale_start=1;
       K=1;
       guidata(hObject, handles);
    end
    if J==0
       handles.fracDim_k_end=handles.fracDim_scale_start+(handles.fracDim_scale_start)/2;
       guidata(hObject, handles);
    end
    clear C D E F G H I J
%     set(handles.edit_fracDim_m_start, 'Enable', 'off');
%     set(handles.edit_fracDim_m_end, 'Enable', 'off');
%     set(handles.edit_fracDim_r_start, 'Enable', 'off');
%     set(handles.edit_fracDim_r_end, 'Enable', 'off');
%     set(handles.edit_fracDim_scale_start, 'Enable', 'off');
%     set(handles.edit_fracDim_scale_end, 'Enable', 'off');
%     set(handles.edit_fracDim_k_start, 'Enable', 'off');
%     set(handles.edit_fracDim_k_end, 'Enable', 'off');
    for k=1:length(handles.scans)
        handle=handles.scans(k);
        %disp(handle.baseName)
        handle.outputDir=handles.outputDir;
        %disp(handles.outputDir);
        if(handles.batchmask_flag==1)
            handles.mask=load_untouch_nii(handles.mask_arr(k)).img;
        end
        frac_dim_call(handle, handles.mask, handles.fracDim_k_start, handles.fracDim_k_end, handles.fracDim_scale_start);
    end
    
end

if handles.apEn
    C = sum(strcmp(fieldnames(handles),'apEn_m_start'));
    D = sum(strcmp(fieldnames(handles),'apEn_m_end'));
    E = sum(strcmp(fieldnames(handles),'apEn_r_start'));
    F = sum(strcmp(fieldnames(handles),'apEn_r_end'));
    G = sum(strcmp(fieldnames(handles),'apEn_scale_start'));
    H = sum(strcmp(fieldnames(handles),'apEn_scale_end'));
    ipChk = [A B C D E F G H];
    if C==0 || E==0
        msgbox('Please select m and r for ApEn','Error Message')
        return
    end
    if G==0
        G=1;
        handles.apEn_scale_start=1;
        guidata(hObject, handles);  
    end
    
    if H==0
        H=1;
        handles.apEn_scale_end=1;
        guidata(hObject, handles); 
    end
    
    if D==0
        handles.apEn_m_end=C+(handles.apEn_scale_start)/2;
        guidata(hObject, handles);
    end
    if F==0
        handles.apEn_r_end=E+(handles.apEn_scale_end)/2;
        guidata(hObject, handles);
    end
    clear C D E F G H 

 
%     set(handles.edit_apEn_m_start, 'Enable', 'off');
%     set(handles.edit_apEn_m_end, 'Enable', 'off');
%     set(handles.edit_apEn_r_start, 'Enable', 'off');
%     set(handles.edit_apEn_r_end, 'Enable', 'off');
%     set(handles.edit_apEn_scale_start, 'Enable', 'off');
%     set(handles.edit_apEn_scale_end, 'Enable', 'off');
    %disp(length(handles.scans));
    
    for i = 1:length(handles.scans)
        %<----for 3d testing--->
           handle=handles.scans(i);
           handle.outputDir=handles.outputDir;
           %disp(handles.outputDir);
            if(handles.batchmask_flag==1)
                handles.mask=load_untouch_nii(handles.mask_arr(i)).img;
            end
           ap_en_call(handle, handles.mask, handles.apEn_m_start, handles.apEn_m_end, handles.apEn_r_start, handles.apEn_r_end, handles.apEn_scale_start, handles.apEn_scale_end);
        %<--------------------->    
%         scan_data = struct();
%         scan_data.img_4D = handles.scans(i).img_4D;
%         disp(size(handles.scans(i).img_4D));
%         scan_data.outputDir = handles.outputDir;
%         scan_data.baseName = handles.scans(i).bName;
%         scan_data.imgVoxDim = handles.scans(i).voxDim;
%         scan_data.originator = handles.scans(i).originator;
%         disp(['Computing ApEn for ',scan_data.baseName]);
%         if(handles.batchmask_flag==1)
%             handles.mask=handles.mask_arr(i);
%         end
%         ap_en_call(scan_data, handles.mask, handles.apEn_m_start, handles.apEn_m_end, handles.apEn_r_start, handles.apEn_r_end, handles.apEn_scale_start, handles.apEn_scale_end);
        
    end    
end
if handles.sampEn
    C = sum(strcmp(fieldnames(handles),'sampEn_m_start'));
    D = sum(strcmp(fieldnames(handles),'sampEn_m_end'));
    E = sum(strcmp(fieldnames(handles),'sampEn_r_start'));
    F = sum(strcmp(fieldnames(handles),'sampEn_r_end'));
    G = sum(strcmp(fieldnames(handles),'sampEn_scale_start'));
    H = sum(strcmp(fieldnames(handles),'sampEn_scale_end'));
    ipChk = [A B C D E F G H];
    if C==0 || E==0
        msgbox('Please select m and r for SampEn','Error Message')
        return
    end
    if G==0
        G=1;
        handles.sampEn_scale_start=1;
        guidata(hObject, handles);  
    end
    
    if H==0
        H=1;
        handles.sampEn_scale_end=1;
        guidata(hObject, handles); 
    end
    
    if D==0
        handles.sampEn_m_end=handles.sampEn_m_start+(handles.sampEn_scale_start)/2;
        guidata(hObject, handles);
    end
    if F==0
        handles.sampEn_r_end=handles.sampEn_r_start+(handles.sampEn_scale_end)/2;
        guidata(hObject, handles);
    end
    clear C D E F G H
    
%     set(handles.edit_sampEn_m_start, 'Enable', 'off');
%     set(handles.edit_sampEn_m_end, 'Enable', 'off');
%     set(handles.edit_sampEn_r_start, 'Enable', 'off');
%     set(handles.edit_sampEn_r_end, 'Enable', 'off');
%     set(handles.edit_sampEn_scale_start, 'Enable', 'off');
%     set(handles.edit_sampEn_scale_end, 'Enable', 'off');
    for k=1:length(handles.scans)
        handle=handles.scans(k);
        %disp(handle.baseName)
        handle.outputDir=handles.outputDir;
           %disp(handles.outputDir);
        if(handles.batchmask_flag==1)
            handles.mask=load_untouch_nii(handles.mask_arr(k)).img;
        end
        samp_en_call(handles, handles.mask, handles.sampEn_m_start, handles.sampEn_m_end, handles.sampEn_r_start, handles.sampEn_r_end, handles.sampEn_scale_start, handles.sampEn_scale_end);
    end
    
end
if handles.waveletMSE
    C = sum(strcmp(fieldnames(handles),'waveletMSE_m_start'));
    D = sum(strcmp(fieldnames(handles),'waveletMSE_m_end'));
    E = sum(strcmp(fieldnames(handles),'waveletMSE_r_start'));
    F = sum(strcmp(fieldnames(handles),'waveletMSE_r_end'));
    G = sum(strcmp(fieldnames(handles),'waveletMSE_scale_start'));
    H = sum(strcmp(fieldnames(handles),'waveletMSE_scale_end'));
    ipChk = [C D E F G H];
    clear C D E F G H 
    set(handles.edit_waveletMSE_m_start, 'Enable', 'off');
    set(handles.edit_waveletMSE_m_end, 'Enable', 'off');
    set(handles.edit_waveletMSE_r_start, 'Enable', 'off');
    set(handles.edit_waveletMSE_r_end, 'Enable', 'off');
    set(handles.edit_waveletMSE_scale_start, 'Enable', 'off');
    set(handles.edit_waveletMSE_scale_end, 'Enable', 'off');
    for k=1:length(handles.arr)
        handle=handles.arr(k);
        disp(handle.baseName)
        handle.outputDir=handles.outputDir;
           %disp(handles.outputDir);
        if(handles.batchmask_flag==1)
            handles.mask=load_untouch_nii(handles.mask_arr(k)).img;
        end
        %call for wavelength mse
    end
    
end
if handles.fuzzyEn
    
    C = sum(strcmp(fieldnames(handles),'fuzzyEn_m_start'));
    D = sum(strcmp(fieldnames(handles),'fuzzyEn_m_end'));
    E = sum(strcmp(fieldnames(handles),'fuzzyEn_r_start'));
    F = sum(strcmp(fieldnames(handles),'fuzzyEn_r_end'));
    G = sum(strcmp(fieldnames(handles),'fuzzyEn_scale_start'));
    H = sum(strcmp(fieldnames(handles),'fuzzyEn_scale_end'));
    I = sum(strcmp(fieldnames(handles),'fuzzyEn_n_start'));
    J = sum(strcmp(fieldnames(handles),'fuzzyEn_n_end'));
    K = sum(strcmp(fieldnames(handles),'fuzzyEn_tau_start'));
    %L = sum(strcmp(fieldnames(handles),'fuzzyEn_tau_end'));
    ipChk = [A B C D E F G H I J K];
    if C==0 || E==0
        msgbox('Please select m and r for Fuzzy Entropy','Error Message')
        return
    end
    if I==0
        I=2;
        handles.fuzzyEn_n_start=2;
        guidata(hObject, handles); 
    end
    if K==0
        K=1;
        handles.fuzzyEn_tau_start=1;
        guidata(hObject, handles); 
    end
    if G==0
        G=1;
        handles.fuzzyEn_scale_start=1;
        guidata(hObject, handles);  
    end
    
    if H==0
        H=1;
        handles.fuzzyEn_scale_end=1;
        guidata(hObject, handles); 
    end
    
    if D==0
        handles.fuzzyEn_m_end=handles.fuzzyEn_m_start+(handles.fuzzyEn_scale_start/2);
        guidata(hObject, handles);
    end
    if F==0
        handles.fuzzyEn_r_end=handles.fuzzyEn_r_start+(handles.fuzzyEn_scale_end/2);
        guidata(hObject, handles);
    end
    clear C D E F G H I J K
    
    
    
%     set(handles.edit_fuzzyEn_m_start, 'Enable', 'off');
%     set(handles.edit_fuzzyEn_m_end, 'Enable', 'off');
%     set(handles.edit_fuzzyEn_r_start, 'Enable', 'off');
%     set(handles.edit_fuzzyEn_r_end, 'Enable', 'off');
%     set(handles.edit_fuzzyEn_scale_start, 'Enable', 'off');
%     set(handles.edit_fuzzyEn_scale_end, 'Enable', 'off');
%     set(handles.edit_fuzzyEn_n_start, 'Enable', 'off');
%     set(handles.edit_fuzzyEn_n_end, 'Enable', 'off');
%     set(handles.edit_fuzzyEn_tau_start, 'Enable', 'off');
%     set(handles.edit_fuzzyEn_tau_end, 'Enable', 'off');   
    for k=1:length(handles.scans)
        handle=handles.scans(k);
        handle.outputDir=handles.outputDir;
           %disp(handles.outputDir);
        if(handles.batchmask_flag==1)
            handles.mask=load_untouch_nii(handles.mask_arr(k)).img;
        end
        fuzzy_en_call(handle, handles.mask, handles.fuzzyEn_m_start, handles.fuzzyEn_m_end, handles.fuzzyEn_r_start, handles.fuzzyEn_r_end, handles.fuzzyEn_scale_start, handles.fuzzyEn_scale_end,handles.fuzzyEn_n_start, handles.fuzzyEn_tau_start);
    end
end
if handles.permEn
%     C = sum(strcmp(fieldnames(handles),'permEn_m_start'));
%     D = sum(strcmp(fieldnames(handles),'permEn_m_end'));
%     E = sum(strcmp(fieldnames(handles),'permEn_r_start'));
%     F = sum(strcmp(fieldnames(handles),'permEn_r_end'));
%     G = sum(strcmp(fieldnames(handles),'permEn_scale_start'));
%     H = sum(strcmp(fieldnames(handles),'permEn_scale_end'));
    I = sum(strcmp(fieldnames(handles),'permEn_ord_start'));
    J = sum(strcmp(fieldnames(handles),'permEn_ord_end'));
    K = sum(strcmp(fieldnames(handles),'permEn_delay_start'));
    L = sum(strcmp(fieldnames(handles),'permEn_delay_end'));
    I = sum(strcmp(fieldnames(handles),'permEn_ord_start'));
    J = sum(strcmp(fieldnames(handles),'permEn_ord_end'));
    K = sum(strcmp(fieldnames(handles),'permEn_delay_start'));
    L = sum(strcmp(fieldnames(handles),'permEn_delay_end'));
    M = sum(strcmp(fieldnames(handles),'permEn_delay_scale'));
    N = sum(strcmp(fieldnames(handles),'permEn_ord_scale'));
    P = sum(strcmp(fieldnames(handles),'permEn_normalize'));
    ipChk = [A B I J K L M N P];
    if I==0 || K==0
        msgbox('Please enter starting vales for order and delay for Permutation Entropy','Error Message')
        return
    end
    if N==0
        handles.permEn_ord_scale=1;
    end
    
    if M==0
        handles.permEn_delay_scale=1;
    end
    if J==0
        handles.permEn_ord_end= handles.permEn_ord_start + (handles.permEn_ord_scale/2);
    end
    
    if L==0
        handles.permEn_delay_end=handles.permEn_delay_start+(handles.permEn_delay_scale/2);
    end
    if P==0
        handles.permEn_normalize=0;
    end
    

    ipChk = [C D E F G H I J K L];
    clear C D E F G H I J K L
%     set(handles.edit_permEn_m_start, 'Enable', 'off');
%     set(handles.edit_permEn_m_end, 'Enable', 'off');
%     set(handles.edit_permEn_r_start, 'Enable', 'off');
%     set(handles.edit_permEn_r_end, 'Enable', 'off');
%     set(handles.edit_permEn_scale_start, 'Enable', 'off');
%     set(handles.edit_permEn_scale_end, 'Enable', 'off');
%     set(handles.edit_permEn_n_start, 'Enable', 'off');
%     set(handles.edit_permEn_n_end, 'Enable', 'off');
%     set(handles.edit_permEn_tau_start, 'Enable', 'off');
%     set(handles.edit_permEn_tau_end, 'Enable', 'off');
    for k=1:length(handles.scans)
        handle=handles.scans(k);
        %disp(handle.baseName)
        handle.outputDir=handles.outputDir;
           %disp(handles.outputDir);
        if(handles.batchmask_flag==1)
            handles.mask=load_untouch_nii(handles.mask_arr(k)).img;
        end
        
 
        %call for perm en
        perm_en_call(handle, handles.mask, handles.permEn_ord_start, handles.permEn_ord_end, handles.permEn_delay_start, handles.permEn_delay_end, handles.permEn_ord_scale, handles.permEn_delay_scale, handles.permEn_normalize)
    end
end

% for k=1:length(handles.arr)
%     handle=handles.arr(k);
%     disp(handle.baseName)
%     ap_en_call(handle, handle.brainMask, 2, 3, 0.3, 0.4, 1,0.1);
% end


% --- Executes on button press in btn_run.
%function btn_run_Callback(hObject, eventdata, handles)
% hObject    handle to btn_run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --- Executes on button press in btn_outputDir.
function btn_outputDir_Callback(hObject, eventdata, handles)
% hObject    handle to btn_outputDir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% opFolder = uigetdir;
% handles.opFolder = opFolder;
% guidata(hObject, handles);
dirName = uigetdir;
handles.outputDir = dirName;
set(handles.edit_outputDir, 'string', handles.outputDir);
mkdir([handles.outputDir,filesep,'tmp']);
guidata(hObject, handles);


% --- Executes on button press in pb_brainMask.
function pb_brainMask_Callback(hObject, eventdata, handles)
% hObject    handle to pb_brainMask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ipFormat = questdlg('How many brain mask would you like to select?', ...
    'Brain Mask Selection','Single','Manual','Batch','Single');
if isempty(ipFormat)
    disp('Please choose brain mask/s');
else
    if (strcmp(ipFormat,'Single')==1)  
        [fname, pname] = uigetfile('*.*','Select the brain mask');
        if (fname==0 & pname==0)
            disp('Brain mask not selected');
        else
            mask_file = [pname, fname];
            mask = load_untouch_nii(mask_file);
            handles.mask = mask.img;
            handles.mask_arr = [mask_file];
            handles.batchmask_flag=0;
            guidata(hObject, handles);
        end
    elseif((strcmp(ipFormat,'Manual')==1))
        
                [fname, pname]=uigetfile('*','Select the Masks(s)','MultiSelect','on');
                if (length(fname)==0)
                    disp('No image input selected');
                else
                    
                    for i=1:length(fname)
                        mask_file=strcat(pname,fname{i});
                        disp(mask_file)
                        %mask_arr(i)=load_untouch_nii(mask_file);
                        mask_arr(i)=mask_file;
                    end
                    handles.mask_arr=mask_arr;
                    handles.batchmask_flag=1;
                    guidata(hObject, handles);
                end
    
    elseif(strcmp(ipFormat,'Batch')==1)
           handles.mask_arr=maskbatchProcessing(handles);
           handles.batchmask_flag=1;
           guidata(hObject, handles);
           disp(handles.mask_arr);
    end
   
    
end


% --- Executes on button press in btn_viewOutput.
function btn_viewOutput_Callback(hObject, eventdata, handles)
% hObject    handle to btn_viewOutput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
files = dir([handles.outputDir, filesep, '*.nii']);
for i=1:length(files)
    final_files{i} = [files(i).folder, filesep, files(i).name];
end
displayImage(final_files);

% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btn_viewInput.
function btn_viewInput_Callback(hObject, eventdata, handles)
% hObject    handle to btn_viewInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(class(handles.mask_arr)=='char')
    inputViewer(handles.files_master, {{handles.mask_arr}});
else
    inputViewer(handles.files_master, handles.mask_arr);
end



function edit71_Callback(hObject, eventdata, handles)
% hObject    handle to edit71 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit71 as text
%        str2double(get(hObject,'String')) returns contents of edit71 as a double


% --- Executes during object creation, after setting all properties.
function edit71_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit71 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function lempel_ziv_call(handles, mask, r_start)
imgSize = size(mask);
brainVox = find(mask == max(mask(:)));
LempelZiv = zeros(imgSize);
msg = ['calculating Lempel Ziv: r=', num2str(r)];
h = waitbar(0,msg);
nFail = 0; 
for vox = 1:length(brainVox)
    [row, col, sl] = ind2sub(imgSize, brainVox(vox));
    TS1 = squeeze(handles.img_4D(row, col, sl, :));
    TS2 = TS1;
    r_val = r * std(double(TS1));
    tmp = lempel_ziv_complexity(TS2);
    LempelZiv(row,col,sl) = tmp(1);
    nFail = nFail + tmp(2);
    waitbar(vox/length(brainVox));
end
close(h);
opFname = [handles.opFolder, filesep, handles.baseName, 'LempelZiv.nii']
niiStruct = make_nii(LempelZiv, handles.imgVoxDim, [], 64, []);
niiStruct.hdr.hk.data_type = 'float64';
niiStruct.hdr.hist.originator(1:3) = handles.originator;
save_nii(niiStruct, opFname, []);

function hurst_ex_call(handles, mask,r_start,r_end,scale)
imgSize = size(mask);
brainVox = find(mask == max(mask(:)));


for r=r_start:scale:r_end
    Hurst_Ex = zeros(imgSize);
    msg = ['calculating Hurst Exponent: r=', num2str(r)];
    h = waitbar(0,msg);
    nFail = 0; 
    for vox = 1:length(brainVox)
        [row, col, sl] = ind2sub(imgSize, brainVox(vox));
        TS1 = squeeze(handles.img_4D(row, col, sl, :));
        TS2 = TS1;
        r_val = r * std(double(TS1));
        tmp = hurst_exponent(TS2);
        Hurst_Ex(row,col,sl) = tmp(1);
        nFail = nFail + tmp(2);
        waitbar(vox/length(brainVox));
    end
    close(h);
    opFname = [handles.opFolder, filesep, handles.baseName, 'Hurst_Ex','_r',num2str(r),'.nii']
    niiStruct = make_nii(Hurst_Ex, handles.imgVoxDim, [], 64, []);
    niiStruct.hdr.hk.data_type = 'float64';
    niiStruct.hdr.hist.originator(1:3) = handles.originator;
    save_nii(niiStruct, opFname, []);
end

function frac_dim_call(handles, mask, k_start, k_end, scale)
imgSize = size(mask);
brainVox = find(mask == max(mask(:)));
if isEmpty(k_end)
    disp('k_end empty')
end
for k = k_start:scale:k_end
    msg = ['calculating FracDim: k=', num2str(k)];
    h = waitbar(0,msg);
    nFail = 0;
    FracDim = zeros(imgSize);
    for vox = 1:length(brainVox)
        [row, col, sl] = ind2sub(imgSize, brainVox(vox));
        TS1 = squeeze(handles.img_4D(row, col, sl, :));
        TS2 = TS1;
        tmp = higuchi_fractal_dimension(TS2, k);
        FracDim(row, col, sl) = tmp(1);
        nFail = nFail + tmp(2);
        waitbar(vox/length(brainVox));
    end
    close(h);
    opFname = [handles.opFolder, filesep, handles.baseName, 'FracDim_k', ...
        num2str(k),'.nii'];
    niiStruct = make_nii(FracDim, handles.imgVoxDim, [], 64, []);
    niiStruct.hdr.hk.data_type = 'float64';
    niiStruct.hdr.hist.originator(1:3) = handles.originator;
    save_nii(niiStruct, opFname, []);
end


function perm_en_call(handles, mask, ord_start, ord_end, delay_start, delay_end, ord_scale, delay_scale, normalize)
imgSize = size(mask);
brainVox = find(mask == max(mask(:)));
for order = ord_start:ord_scale:ord_end
    for delay = delay_start:delay_scale:delay_end
        PermEn = zeros(imgSize);
        msg = ['calculating self PermEn: order=', num2str(order), ',delay=', num2str(delay)];
        h = waitbar(0,msg);
        nFail = 0;
        for vox = 1:length(brainVox)
            [row, col, sl] = ind2sub(imgSize, brainVox(vox));
            TS1 = squeeze(handles.img_4D(row, col, sl,:));
            r_val = r*std(double(TS1));
            tmp = permutation_entropy(TS1, order, delay, normalize);
            PermEn(row, col, sl) = tmp(1);
            nFail = nFail + tmp(2);
            waitbar(vox/length(brainVox));
        end
        close(h);
        opFname = [handles.opFolder, filesep, handles.baseName, 'PermEn_order', ...
            num2str(order), '_delay', num2str(delay), '_norm', num2str(normalize), '.nii'];
        niiStruct = make_nii(PermEn, handles.imgVoxDim, [], 64, []);
        niiStruct.hdr.hk.data_type = 'float64';
        niiStruct.hdr.hist.originator(1:3) = handles.originator;
        save_nii(niiStruct, opFname, []);
    end
end

function fuzzy_en_call(handles, mask, m_start, m_end, r_start, r_end, m_scale, r_scale,n,t)
imgSize = size(mask);
brainVox = find(mask == max(mask(:)));
for m = m_start:m_scale:m_end
    for r = r_start:r_scale:r_end
        FuzzEn = zeros(imgSize);
        msg = ['calculating FuzzyEn: m=',num2str(m),',r=',num2str(r)];
        h = waitbar(0,msg);
        nFail = 0;
        for vox = 1:length(brainVox)
            [row, col, sl] = ind2sub(imgSize, brainVox(vox));
            TS1 = squeeze(handles.img_4D(row, col, sl, :));
            r_val = r * std(double(TS1));
            tmp = FuzEn(TS1,m, r_val,n,t);
            FuzzEn(row, col, sl) = tmp(1);
            nFail = nFail + tmp(1);
            waitbar(vox/length(brainVox));
        end
        close(h);
        opFname = [handles.opFolder, filesep, handles.baseName, 'FuzzyEn_m', ...
            num2str(m), '_r', num2str(r*100), 'per','.nii'];
        niiStruct = make_nii(FuzzEn, handles.imgVoxDim, [], 64, []);
        niiStruct.hdr.hk.data_type = 'float64';
        save_nii(niiStruct, opFname, []);
    end
end

function samp_en_call(handles, mask, m_start, m_end, r_start, r_end, m_scale, r_scale)
imgSize = size(mask);
brainVox = find(mask == max(mask(:)));
for m = m_start:m_scale:m_end
    for r = r_start:r_scale:r_end
        SampEn = zeros(imgSize);
        msg = ['calculating self SampEn: m=',num2str(m),',r=',num2str(r)];
        h = waitbar(0,msg);
        nFail = 0;
        for vox = 1:length(brainVox)
            [row, col, sl] = ind2sub(imgSize, brainVox(vox));
            TS1 = squeeze(handles.img_4D(row, col, sl, :));
            r_val = r * std(double(TS1));
            tmp=lyaprosenTest(TS1, 0.05);
            %tmp = sample_entropy(m, r_val, TS1, 1);
            SampEn(row, col, sl) = tmp(1);
            nFail = nFail + tmp(2);
            waitbar(vox/length(brainVox));
        end
        close(h);
        opFname = [handles.opFolder, filesep, handles.baseName, 'SampEn_m', ...
            num2str(m), '_r', num2str(r*100), 'per','.nii'];
        niiStruct = make_nii(SampEn, handles.imgVoxDim, [], 64, []);
        niiStruct.hdr.hk.data_type = 'float64';
        save_nii(niiStruct, opFname, []);
    end
end


function ap_en_call(handles, mask, m_start, m_end, r_start, r_end, m_scale, r_scale)
imgSize = size(mask);
brainVox = find(mask == max(mask(:)));
for m = m_start:m_scale:m_end
    for r = r_start:r_scale:r_end
        ApEn = zeros(imgSize);
        msg = ['calculating self ApEn: m=',num2str(m),',r=',num2str(r)];
        h = waitbar(0,msg);
        nFail = 0;
        for vox = 1:length(brainVox)
            [row, col, sl] = ind2sub(imgSize, brainVox(vox));
            TS1 = squeeze(handles.img_4D(row, col, sl, :));
            TS2 = TS1;
            r_val = r * std(double(TS1));
            tmp = cross_approx_entropy(m, r_val, TS1, TS2);
            ApEn(row, col, sl) = tmp(1);
            nFail = nFail + tmp(2);
            waitbar(vox/length(brainVox));
        end
        close(h);
        opFname = [handles.outputDir, filesep, handles.baseName, 'ApEn_m', ...
            num2str(m), '_r', num2str(r*100), 'per','.nii'];
        niiStruct = make_nii(ApEn, handles.imgVoxDim, [], 64, []);
        niiStruct.hdr.hk.data_type = 'float64';
        save_nii(niiStruct, opFname, []);
    end
end
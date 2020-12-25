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

% Last Modified by GUIDE v2.5 24-Dec-2020 11:26:15

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


% --- Executes on button press in checkbox_hurstExp.
function checkbox_hurstExp_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_hurstExp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_hurstExp


% --- Executes on button press in checkbox_LLExp.
function checkbox_LLExp_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_LLExp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_LLExp


% --- Executes on button press in checkbox_fracDim.
function checkbox_fracDim_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_fracDim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_fracDim


% --- Executes on button press in checkbox_apEn.
function checkbox_apEn_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_apEn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_apEn


% --- Executes on button press in checkbox_sampEn.
function checkbox_sampEn_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_sampEn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_sampEn


% --- Executes on button press in checkbox_waveletMSE.
function checkbox_waveletMSE_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_waveletMSE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_waveletMSE


% --- Executes on button press in checkbox_fuzzyEn.
function checkbox_fuzzyEn_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_fuzzyEn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_fuzzyEn


% --- Executes on button press in checkbox_permEn.
function checkbox_permEn_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_permEn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_permEn



function edit_lempelZiv_m_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_lempelZiv_m_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_lempelZiv_m_start as text
%        str2double(get(hObject,'String')) returns contents of edit_lempelZiv_m_start as a double


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



function edit_hurstExp_m_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_hurstExp_m_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_hurstExp_m_start as text
%        str2double(get(hObject,'String')) returns contents of edit_hurstExp_m_start as a double


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



function edit_LLExp_m_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_LLExp_m_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_LLExp_m_start as text
%        str2double(get(hObject,'String')) returns contents of edit_LLExp_m_start as a double


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



function edit_sampEn_m_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sampEn_m_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sampEn_m_start as text
%        str2double(get(hObject,'String')) returns contents of edit_sampEn_m_start as a double


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



function edit_waveletMSE_m_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_waveletMSE_m_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_waveletMSE_m_start as text
%        str2double(get(hObject,'String')) returns contents of edit_waveletMSE_m_start as a double


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



function edit_fuzzyEn_m_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fuzzyEn_m_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fuzzyEn_m_start as text
%        str2double(get(hObject,'String')) returns contents of edit_fuzzyEn_m_start as a double


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



function edit_permEn_m_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_permEn_m_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_permEn_m_start as text
%        str2double(get(hObject,'String')) returns contents of edit_permEn_m_start as a double


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



function edit_lempelZiv_m_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_lempelZiv_m_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_lempelZiv_m_end as text
%        str2double(get(hObject,'String')) returns contents of edit_lempelZiv_m_end as a double


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



function edit_hurstExp_m_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_hurstExp_m_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_hurstExp_m_end as text
%        str2double(get(hObject,'String')) returns contents of edit_hurstExp_m_end as a double


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



function edit_LLExp_m_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_LLExp_m_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_LLExp_m_end as text
%        str2double(get(hObject,'String')) returns contents of edit_LLExp_m_end as a double


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



function edit_fracDim_m_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fracDim_m_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fracDim_m_end as text
%        str2double(get(hObject,'String')) returns contents of edit_fracDim_m_end as a double


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



function edit_apEn_m_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_apEn_m_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_apEn_m_end as text
%        str2double(get(hObject,'String')) returns contents of edit_apEn_m_end as a double


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



function edit_sampEn_m_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sampEn_m_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sampEn_m_end as text
%        str2double(get(hObject,'String')) returns contents of edit_sampEn_m_end as a double


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



function edit_waveletMSE_m_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_waveletMSE_m_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_waveletMSE_m_end as text
%        str2double(get(hObject,'String')) returns contents of edit_waveletMSE_m_end as a double


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



function edit_fuzzyEn_m_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fuzzyEn_m_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fuzzyEn_m_end as text
%        str2double(get(hObject,'String')) returns contents of edit_fuzzyEn_m_end as a double


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



function edit_permEn_m_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_permEn_m_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_permEn_m_end as text
%        str2double(get(hObject,'String')) returns contents of edit_permEn_m_end as a double


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



function edit_lempelZiv_r_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_lempelZiv_r_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_lempelZiv_r_start as text
%        str2double(get(hObject,'String')) returns contents of edit_lempelZiv_r_start as a double


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



function edit_hurstExp_r_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_hurstExp_r_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_hurstExp_r_start as text
%        str2double(get(hObject,'String')) returns contents of edit_hurstExp_r_start as a double


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



function edit_LLExp_r_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_LLExp_r_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_LLExp_r_start as text
%        str2double(get(hObject,'String')) returns contents of edit_LLExp_r_start as a double


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



function edit_fracDim_r_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fracDim_r_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fracDim_r_start as text
%        str2double(get(hObject,'String')) returns contents of edit_fracDim_r_start as a double


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



function edit_apEn_r_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_apEn_r_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_apEn_r_start as text
%        str2double(get(hObject,'String')) returns contents of edit_apEn_r_start as a double


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



function edit_sampEn_r_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sampEn_r_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sampEn_r_start as text
%        str2double(get(hObject,'String')) returns contents of edit_sampEn_r_start as a double


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



function edit_waveletMSE_r_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_waveletMSE_r_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_waveletMSE_r_start as text
%        str2double(get(hObject,'String')) returns contents of edit_waveletMSE_r_start as a double


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



function edit_fuzzyEn_r_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fuzzyEn_r_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fuzzyEn_r_start as text
%        str2double(get(hObject,'String')) returns contents of edit_fuzzyEn_r_start as a double


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



function edit_permEn_r_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_permEn_r_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_permEn_r_start as text
%        str2double(get(hObject,'String')) returns contents of edit_permEn_r_start as a double


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



function edit_lempelZiv_r_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_lempelZiv_r_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_lempelZiv_r_end as text
%        str2double(get(hObject,'String')) returns contents of edit_lempelZiv_r_end as a double


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



function edit_hurstExp_r_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_hurstExp_r_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_hurstExp_r_end as text
%        str2double(get(hObject,'String')) returns contents of edit_hurstExp_r_end as a double


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



function edit_LLExp_r_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_LLExp_r_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_LLExp_r_end as text
%        str2double(get(hObject,'String')) returns contents of edit_LLExp_r_end as a double


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



function edit_fracDim_r_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fracDim_r_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fracDim_r_end as text
%        str2double(get(hObject,'String')) returns contents of edit_fracDim_r_end as a double


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



function edit_apEn_r_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_apEn_r_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_apEn_r_end as text
%        str2double(get(hObject,'String')) returns contents of edit_apEn_r_end as a double


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



function edit_waveletMSE_r_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_waveletMSE_r_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_waveletMSE_r_end as text
%        str2double(get(hObject,'String')) returns contents of edit_waveletMSE_r_end as a double


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



function edit_fuzzyEn_r_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fuzzyEn_r_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fuzzyEn_r_end as text
%        str2double(get(hObject,'String')) returns contents of edit_fuzzyEn_r_end as a double


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



function edit_permEn_r_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_permEn_r_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_permEn_r_end as text
%        str2double(get(hObject,'String')) returns contents of edit_permEn_r_end as a double


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



function edit_lempelZiv_scale_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_lempelZiv_scale_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_lempelZiv_scale_start as text
%        str2double(get(hObject,'String')) returns contents of edit_lempelZiv_scale_start as a double


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



function edit_fracDim_k_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fracDim_k_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fracDim_k_end as text
%        str2double(get(hObject,'String')) returns contents of edit_fracDim_k_end as a double


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



function edit_fuzzyEn_n_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fuzzyEn_n_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fuzzyEn_n_start as text
%        str2double(get(hObject,'String')) returns contents of edit_fuzzyEn_n_start as a double


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



function edit_fuzzyEn_n_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fuzzyEn_n_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fuzzyEn_n_end as text
%        str2double(get(hObject,'String')) returns contents of edit_fuzzyEn_n_end as a double


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



function edit_fuzzyEn_tau_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fuzzyEn_tau_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fuzzyEn_tau_start as text
%        str2double(get(hObject,'String')) returns contents of edit_fuzzyEn_tau_start as a double


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



function edit_fuzzyEn_tau_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fuzzyEn_tau_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fuzzyEn_tau_end as text
%        str2double(get(hObject,'String')) returns contents of edit_fuzzyEn_tau_end as a double


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



function edit_permEn_delay_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_permEn_delay_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_permEn_delay_start as text
%        str2double(get(hObject,'String')) returns contents of edit_permEn_delay_start as a double


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



function edit_sampEn_scale_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sampEn_scale_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sampEn_scale_start as text
%        str2double(get(hObject,'String')) returns contents of edit_sampEn_scale_start as a double


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

function select_brain_mask(hObject,handles,imgStruct)
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
% --- Executes on button press in btn_load.
function btn_load_Callback(hObject, eventdata, handles)
% hObject    handle to btn_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    subFolders={'C:\Users\Niyati\Desktop\on-campus\testcases\test2'
        'C:\Users\Niyati\Desktop\on-campus\testcases\test3'};
   
    imgStruct = readImages4D(subFolders{1});
    select_brain_mask(hObject,handles,imgStruct);
    for k = 1 :  length(subFolders)
        thisSubFolder = subFolders{k};
        fprintf('Found sub: %s.\n', thisSubFolder);
        imgStruct = readImages4D(thisSubFolder);
        handle(k).img_4D = imgStruct.img_4D;
        handle(k).baseName = imgStruct.bName;
        handle(k).imgVoxDim = imgStruct.voxDim;
        handle(k).size=length(subFolders);
        handle(k).brainMask=handles.brainMask;
    end
    handles.arr=handle;
    guidata(hObject,handles);
    disp('done reading input images');
    
function btn_run_Callback(hObject, eventdata, handles)
% hObject    handle to pb_run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
for k=1:length(handles.arr)
    handle=handles.arr(k);
    samp_en_call(handle, handle.brainMask, 0.35, 0.35, 2, 2, 0,0);

end
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

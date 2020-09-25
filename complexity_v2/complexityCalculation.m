function varargout = complexityCalculation(varargin)
% COMPLEXITYCALCULATION MATLAB code for complexityCalculation.fig
%      COMPLEXITYCALCULATION, by itself, creates a new COMPLEXITYCALCULATION or raises the existing
%      singleton*.
%
%      H = COMPLEXITYCALCULATION returns the handle to a new COMPLEXITYCALCULATION or the handle to
%      the existing singleton*.
%
%      COMPLEXITYCALCULATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COMPLEXITYCALCULATION.M with the given input arguments.
%
%      COMPLEXITYCALCULATION('Property','Value',...) creates a new COMPLEXITYCALCULATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before complexityCalculation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to complexityCalculation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help complexityCalculation

% Last Modified by GUIDE v2.5 01-Sep-2020 14:39:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @complexityCalculation_OpeningFcn, ...
                   'gui_OutputFcn',  @complexityCalculation_OutputFcn, ...
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


% --- Executes just before complexityCalculation is made visible.
function complexityCalculation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to complexityCalculation (see VARARGIN)

% Choose default command line output for complexityCalculation
handles.output = hObject;
axes(handles.axes_logo);
image(imread('LOFT_logo.png'));
set(handles.axes_logo,'Visible','off');
axes(handles.axes_fractal);
image(imread('brain_fractal.png'));
set(handles.axes_fractal,'Visible','off');
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes complexityCalculation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = complexityCalculation_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function editText_workingDirectory_Callback(hObject, eventdata, handles)
% hObject    handle to editText_workingDirectory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editText_workingDirectory as text
%        str2double(get(hObject,'String')) returns contents of editText_workingDirectory as a double


% --- Executes during object creation, after setting all properties.
function editText_workingDirectory_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editText_workingDirectory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox_fractalDimension.
function checkbox_fractalDimension_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_fractalDimension (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_fractalDimension


% --- Executes on button press in checkbox_hurstExponent.
function checkbox_hurstExponent_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_hurstExponent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_hurstExponent


% --- Executes on button press in checkbox_lempelZivComplexity.
function checkbox_lempelZivComplexity_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_lempelZivComplexity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_lempelZivComplexity


% --- Executes on button press in checkbox_largestLyapunov.
function checkbox_largestLyapunov_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_largestLyapunov (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_largestLyapunov


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


% --- Executes on button press in checkbox_PE.
function checkbox_PE_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_PE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_PE


% --- Executes on button press in pb_run.
function pb_run_Callback(hObject, eventdata, handles)
% hObject    handle to pb_run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function editText_apEn_m_start_Callback(hObject, eventdata, handles)
% hObject    handle to editText_apEn_m_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editText_apEn_m_start as text
%        str2double(get(hObject,'String')) returns contents of editText_apEn_m_start as a double


% --- Executes during object creation, after setting all properties.
function editText_apEn_m_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editText_apEn_m_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editText_sampEn_m_start_Callback(hObject, eventdata, handles)
% hObject    handle to editText_sampEn_m_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editText_sampEn_m_start as text
%        str2double(get(hObject,'String')) returns contents of editText_sampEn_m_start as a double


% --- Executes during object creation, after setting all properties.
function editText_sampEn_m_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editText_sampEn_m_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editText_waveletMSE_m_start_Callback(hObject, eventdata, handles)
% hObject    handle to editText_waveletMSE_m_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editText_waveletMSE_m_start as text
%        str2double(get(hObject,'String')) returns contents of editText_waveletMSE_m_start as a double


% --- Executes during object creation, after setting all properties.
function editText_waveletMSE_m_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editText_waveletMSE_m_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editText_fuzzyEn_m_start_Callback(hObject, eventdata, handles)
% hObject    handle to editText_fuzzyEn_m_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editText_fuzzyEn_m_start as text
%        str2double(get(hObject,'String')) returns contents of editText_fuzzyEn_m_start as a double


% --- Executes during object creation, after setting all properties.
function editText_fuzzyEn_m_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editText_fuzzyEn_m_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editText_PE_m_start_Callback(hObject, eventdata, handles)
% hObject    handle to editText_PE_m_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editText_PE_m_start as text
%        str2double(get(hObject,'String')) returns contents of editText_PE_m_start as a double


% --- Executes during object creation, after setting all properties.
function editText_PE_m_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editText_PE_m_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editText_apEn_m_end_Callback(hObject, eventdata, handles)
% hObject    handle to editText_apEn_m_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editText_apEn_m_end as text
%        str2double(get(hObject,'String')) returns contents of editText_apEn_m_end as a double


% --- Executes during object creation, after setting all properties.
function editText_apEn_m_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editText_apEn_m_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editText_sampEn_m_end_Callback(hObject, eventdata, handles)
% hObject    handle to editText_sampEn_m_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editText_sampEn_m_end as text
%        str2double(get(hObject,'String')) returns contents of editText_sampEn_m_end as a double


% --- Executes during object creation, after setting all properties.
function editText_sampEn_m_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editText_sampEn_m_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editText_waveletMSE_m_end_Callback(hObject, eventdata, handles)
% hObject    handle to editText_waveletMSE_m_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editText_waveletMSE_m_end as text
%        str2double(get(hObject,'String')) returns contents of editText_waveletMSE_m_end as a double


% --- Executes during object creation, after setting all properties.
function editText_waveletMSE_m_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editText_waveletMSE_m_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editText_fuzzyEn_m_end_Callback(hObject, eventdata, handles)
% hObject    handle to editText_fuzzyEn_m_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editText_fuzzyEn_m_end as text
%        str2double(get(hObject,'String')) returns contents of editText_fuzzyEn_m_end as a double


% --- Executes during object creation, after setting all properties.
function editText_fuzzyEn_m_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editText_fuzzyEn_m_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editText_PE_m_end_Callback(hObject, eventdata, handles)
% hObject    handle to editText_PE_m_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editText_PE_m_end as text
%        str2double(get(hObject,'String')) returns contents of editText_PE_m_end as a double


% --- Executes during object creation, after setting all properties.
function editText_PE_m_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editText_PE_m_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editText_apEn_r_start_Callback(hObject, eventdata, handles)
% hObject    handle to editText_apEn_r_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editText_apEn_r_start as text
%        str2double(get(hObject,'String')) returns contents of editText_apEn_r_start as a double


% --- Executes during object creation, after setting all properties.
function editText_apEn_r_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editText_apEn_r_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editText_sampEn_r_start_Callback(hObject, eventdata, handles)
% hObject    handle to editText_sampEn_r_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editText_sampEn_r_start as text
%        str2double(get(hObject,'String')) returns contents of editText_sampEn_r_start as a double


% --- Executes during object creation, after setting all properties.
function editText_sampEn_r_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editText_sampEn_r_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editText_waveletMSE_r_start_Callback(hObject, eventdata, handles)
% hObject    handle to editText_waveletMSE_r_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editText_waveletMSE_r_start as text
%        str2double(get(hObject,'String')) returns contents of editText_waveletMSE_r_start as a double


% --- Executes during object creation, after setting all properties.
function editText_waveletMSE_r_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editText_waveletMSE_r_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editText_fuzzyEn_r_start_Callback(hObject, eventdata, handles)
% hObject    handle to editText_fuzzyEn_r_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editText_fuzzyEn_r_start as text
%        str2double(get(hObject,'String')) returns contents of editText_fuzzyEn_r_start as a double


% --- Executes during object creation, after setting all properties.
function editText_fuzzyEn_r_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editText_fuzzyEn_r_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editText_PE_r_start_Callback(hObject, eventdata, handles)
% hObject    handle to editText_PE_r_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editText_PE_r_start as text
%        str2double(get(hObject,'String')) returns contents of editText_PE_r_start as a double


% --- Executes during object creation, after setting all properties.
function editText_PE_r_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editText_PE_r_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editText_apEn_r_end_Callback(hObject, eventdata, handles)
% hObject    handle to editText_apEn_r_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editText_apEn_r_end as text
%        str2double(get(hObject,'String')) returns contents of editText_apEn_r_end as a double


% --- Executes during object creation, after setting all properties.
function editText_apEn_r_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editText_apEn_r_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editText_sampEn_r_end_Callback(hObject, eventdata, handles)
% hObject    handle to editText_sampEn_r_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editText_sampEn_r_end as text
%        str2double(get(hObject,'String')) returns contents of editText_sampEn_r_end as a double


% --- Executes during object creation, after setting all properties.
function editText_sampEn_r_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editText_sampEn_r_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editText_waveletMSE_r_end_Callback(hObject, eventdata, handles)
% hObject    handle to editText_waveletMSE_r_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editText_waveletMSE_r_end as text
%        str2double(get(hObject,'String')) returns contents of editText_waveletMSE_r_end as a double


% --- Executes during object creation, after setting all properties.
function editText_waveletMSE_r_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editText_waveletMSE_r_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editText_fuzzyEn_r_end_Callback(hObject, eventdata, handles)
% hObject    handle to editText_fuzzyEn_r_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editText_fuzzyEn_r_end as text
%        str2double(get(hObject,'String')) returns contents of editText_fuzzyEn_r_end as a double


% --- Executes during object creation, after setting all properties.
function editText_fuzzyEn_r_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editText_fuzzyEn_r_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editText_PE_r_end_Callback(hObject, eventdata, handles)
% hObject    handle to editText_PE_r_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editText_PE_r_end as text
%        str2double(get(hObject,'String')) returns contents of editText_PE_r_end as a double


% --- Executes during object creation, after setting all properties.
function editText_PE_r_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editText_PE_r_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editText_sampEn_scale_start_Callback(hObject, eventdata, handles)
% hObject    handle to editText_sampEn_scale_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editText_sampEn_scale_start as text
%        str2double(get(hObject,'String')) returns contents of editText_sampEn_scale_start as a double


% --- Executes during object creation, after setting all properties.
function editText_sampEn_scale_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editText_sampEn_scale_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editText_waveletMSE_scale_start_Callback(hObject, eventdata, handles)
% hObject    handle to editText_waveletMSE_scale_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editText_waveletMSE_scale_start as text
%        str2double(get(hObject,'String')) returns contents of editText_waveletMSE_scale_start as a double


% --- Executes during object creation, after setting all properties.
function editText_waveletMSE_scale_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editText_waveletMSE_scale_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editText_fuzzyEn_scale_start_Callback(hObject, eventdata, handles)
% hObject    handle to editText_fuzzyEn_scale_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editText_fuzzyEn_scale_start as text
%        str2double(get(hObject,'String')) returns contents of editText_fuzzyEn_scale_start as a double


% --- Executes during object creation, after setting all properties.
function editText_fuzzyEn_scale_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editText_fuzzyEn_scale_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editText_PE_scale_start_Callback(hObject, eventdata, handles)
% hObject    handle to editText_PE_scale_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editText_PE_scale_start as text
%        str2double(get(hObject,'String')) returns contents of editText_PE_scale_start as a double


% --- Executes during object creation, after setting all properties.
function editText_PE_scale_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editText_PE_scale_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editText_sampEn_scale_end_Callback(hObject, eventdata, handles)
% hObject    handle to editText_sampEn_scale_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editText_sampEn_scale_end as text
%        str2double(get(hObject,'String')) returns contents of editText_sampEn_scale_end as a double


% --- Executes during object creation, after setting all properties.
function editText_sampEn_scale_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editText_sampEn_scale_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editText_waveletMSE_scale_end_Callback(hObject, eventdata, handles)
% hObject    handle to editText_waveletMSE_scale_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editText_waveletMSE_scale_end as text
%        str2double(get(hObject,'String')) returns contents of editText_waveletMSE_scale_end as a double


% --- Executes during object creation, after setting all properties.
function editText_waveletMSE_scale_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editText_waveletMSE_scale_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editText_fuzzyEn_scale_end_Callback(hObject, eventdata, handles)
% hObject    handle to editText_fuzzyEn_scale_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editText_fuzzyEn_scale_end as text
%        str2double(get(hObject,'String')) returns contents of editText_fuzzyEn_scale_end as a double


% --- Executes during object creation, after setting all properties.
function editText_fuzzyEn_scale_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editText_fuzzyEn_scale_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editText_PE_scale_end_Callback(hObject, eventdata, handles)
% hObject    handle to editText_PE_scale_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editText_PE_scale_end as text
%        str2double(get(hObject,'String')) returns contents of editText_PE_scale_end as a double


% --- Executes during object creation, after setting all properties.
function editText_PE_scale_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editText_PE_scale_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

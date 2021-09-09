function statsBatch=statsBatchProcessing(varargin)

% MASKBATCHPROCESSING MATLAB code for maskbatchProcessing.fig
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

% Last Modified by GUIDE v2.5 19-Jan-2021 17:31:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @maskbatchProcessing_OpeningFcn, ...
                   'gui_OutputFcn',  @maskbatchProcessing_OutputFcn, ...
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
function maskbatchProcessing_OpeningFcn(hObject, eventdata, handles, varargin)
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
function varargout = maskbatchProcessing_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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
disp('inside stat batch')
% ipFormat = cell2mat(inputdlg('Input 3D or 4D', 'Input selection'));
% if isempty(ipFormat)
%     msgbox('Please choose the input format: 3D or 4D');
% else
%     if (strcmp(ipFormat,'3D')==1 | strcmp(ipFormat,'3d')==1)
%         handles.d3d4='3D';        
%     else
%         handles.d3d4='4D';
%     end
%     dirName = uigetdir;
%     handles.inputDir = dirName;
%     set(handles.edit_inputDir, 'string', handles.inputDir);
%     if (dirName==0)
%         msgbox('No image input directory selected','Error Message');
%     end
%     
% end
% 
guidata(hObject, handles);
dirName = uigetdir;
handles.inputDir = dirName;
set(handles.edit_inputDir, 'string', handles.inputDir);
guidata(hObject, handles);


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

function edit_subjectPattern_Callback(hObject, eventdata, handles)
% hObject    handle to edit_subjectPattern (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_subjectPattern as text
%        str2double(get(hObject,'String')) returns contents of edit_subjectPattern as a double

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

function edit_fmriPattern_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fmriPattern (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fmriPattern as text
%        str2double(get(hObject,'String')) returns contents of edit_fmriPattern as a double

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




% --- Executes on button press in btn_load.
function btn_load_Callback(hObject, eventdata, handles)
% hObject    handle to btn_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
A = sum(strcmp(fieldnames(handles),'inputDir'));
%B = sum(strcmp(fieldnames(handles),'outputDir'));
ipChk = [A];
clear A;
subjectPattern = get(handles.edit_subjectPattern, 'String');
fmriPattern = get(handles.edit_fmriPattern, 'String');
filePattern = get(handles.edit_filePattern, 'String');
subject_search = strcat(handles.inputDir,filesep,subjectPattern);
file_search = strcat(handles.inputDir,filesep,subjectPattern,filesep,fmriPattern,filePattern);
disp(file_search)
%file_search='C:\Users\Niyati\Desktop\on-campus\testcases\batchtest\btest*\rrBrainMASK*.nii';
subjects = dir(subject_search);
files = dir(file_search);
set(handles.text_dataInfo,'string',([num2str(length(subjects)), ' subjects, ', num2str(length(files)), ' scans loaded']));

disp(subjects)
if (strcmp(handles.d3d4,'3D')==1)
    disp('inside 3d case');
    for i=1:length(files)
        stat_files{i}=strcat(files(i).folder,filesep,files(i).name);
    end
 
    handles.files_arr=stat_files;
    statsBatch=handles.files_arr;
    guidata(hObject, handles);
else
    disp('inside 4d case');
    opStruct = struct([]);
    for i=1:length(files)
        fullpath = [files(i).folder,filesep,files(i).name];
        disp(fullpath);
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
   handles.files_arr = opStruct;
   statsBatch=handles.files_arr;
   guidata(hObject, handles);
end    
    
%statsBatch=handles.files_arr;
%disp(statsBatch)

guidata(hObject, handles);
disp('Done reading input images');



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





% --- Executes on button press in btn_viewOutput.
function btn_viewOutput_Callback(hObject, eventdata, handles)
% hObject    handle to btn_viewOutput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% files = dir([handles.outputDir, filesep, '*.nii']);
% for i=1:length(files)
%     final_files{i} = [files(i).folder, filesep, files(i).name];
% end
displayImage(handles.files_arr);


    


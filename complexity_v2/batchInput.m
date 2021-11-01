function varargout = batchInput(varargin)
% BATCHINPUT MATLAB code for batchInput.fig
%      BATCHINPUT, by itself, creates a new BATCHINPUT or raises the existing
%      singleton*.
%
%      H = BATCHINPUT returns the handle to a new BATCHINPUT or the handle to
%      the existing singleton*.
%
%      BATCHINPUT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BATCHINPUT.M with the given input arguments.
%
%      BATCHINPUT('Property','Value',...) creates a new BATCHINPUT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before batchInput_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to batchInput_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help batchInput

% Last Modified by GUIDE v2.5 14-Oct-2021 14:43:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @batchInput_OpeningFcn, ...
                   'gui_OutputFcn',  @batchInput_OutputFcn, ...
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


% --- Executes just before batchInput is made visible.
function batchInput_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to batchInput (see VARARGIN)

% Choose default command line output for batchInput

% Update handles structure
handles.maskFilePath = "";
handles.output = hObject;
handles.files_master = struct([]);
handles.filePaths =[];
handles.outputDir="";
guidata(hObject, handles);

% UIWAIT makes batchInput wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = batchInput_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;





% *******************     INPUT DIRECTORY      *********************************
function editInputDir_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editInputDir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function editInputDir_Callback(hObject, eventdata, handles)
% hObject    handle to editInputDir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editInputDir as text
%        str2double(get(hObject,'String')) returns contents of editInputDir as a double

function btnInputDir_Callback(hObject, eventdata, handles)
% sets flag is3D4D and editInputDir and saves in handles
ipFormat = cell2mat(inputdlg('Input 3D or 4D', 'Input selection'));
if isempty(ipFormat)
    msgbox('Please choose the input format: 3D or 4D');
else
    if (strcmp(ipFormat,'3D')==1 | strcmp(ipFormat,'3d')==1)
        handles.is3D4D='3D';        
    else
        handles.is3D4D='4D';
    end
    
    dirName = uigetdir;
    handles.inputDir = dirName;
    guidata(hObject, handles);
    set(handles.editInputDir, 'string', handles.inputDir);
    if (dirName==0)
        msgbox('No image input directory selected','Error Message');
    end
    
end
guidata(hObject, handles);
% *******************     INPUT DIRECTORY END     *********************************



% ************************** SUBJECT PATTERN REGEX **********************
function subjectPattern_CreateFcn(hObject, eventdata, handles)
% creates subject pattern field and sets tooltip
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'TooltipString','For Example: enter btest*/ for selecting test case folders starting with the phrase btest')
guidata(hObject,handles);

function subjectPattern_Callback(hObject, eventdata, handles)
% hObject    handle to subjectPattern (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of subjectPattern as text
%        str2double(get(hObject,'String')) returns contents of subjectPattern as a double


% --- Executes during object creation, after setting all properties.

% ************************** SUBJECT PATTERN REGEX END**********************


% ************************** FILE PATTERN REGEX END**********************

function filePattern_Callback(hObject, eventdata, handles)
% hObject    handle to filePattern (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filePattern as text
%        str2double(get(hObject,'String')) returns contents of filePattern as a double


function filePattern_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filePattern (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'TooltipString','For Example: enter *.nii to select all files with .nii extension in the subject folder')
guidata(hObject,handles);
% ************************** FILE PATTERN REGEX END**********************



% *******************     OUTPUT DIRECTORY      *********************************
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
dirName = uigetdir;
handles.outputDir = dirName;
set(handles.editOutputDir, 'string', handles.outputDir);
mkdir([handles.outputDir,filesep,'tmp']);
guidata(hObject, handles);

% *******************     OUTPUT DIRECTORY END     *********************************



% ********************      MASKS    ************************************
% --- Executes on button press in btnSelectMask.
function btnSelectMask_Callback(hObject, eventdata, handles)
% select mask for the subjects
[fname, pname] = uigetfile('*.*','Select the brain mask');
if (fname==0 & pname==0)
    disp('Brain mask not selected');
    msgbox('Brain Mask not selected','Info');
    return
else
    mask_file = [pname, fname];
    handles.maskFilePath = mask_file;
    guidata(hObject, handles);
    msgbox('Brain Mask/s uploaded','Info');
end
    
% ********************      MASKS END   ************************************



% --- Executes on button press in btnSaveSubjects.
function btnSaveSubjects_Callback(hObject, eventdata, handles)
% hObject    handle to btnSaveSubjects (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
files_master = handles.files_master;
fileName = string(inputdlg('Enter the file name', 'File Name'));
if isempty(fileName)
    msgbox('Please enter a file name');
else
    save(fileName+'.mat', 'files_master');
    disp('files saved in '+fileName);
    msgbox('Subjects saved','Info');
end


% --- Executes on button press in btnLoadSubjects.
function btnLoadSubjects_Callback(hObject, eventdata, handles)
% hObject    handle to btnLoadSubjects (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fileName = uigetfile('*.mat','Select the file');
files = load(fileName, 'files_master');
f=files.files_master;
%handles.files_master = f.files_master;

for i = 1:length(f)
    handles.files_master{i} = f{1,i};
    handles.filePaths{i}=f{1,i}.fullpath;
end
guidata(hObject,handles);
disp(handles.filePaths);
loadListBox(hObject, handles)
msgbox('Subjects loaded','Info');

% --- Executes on button press in loadSubjectFiles.
function loadSubjectFiles_Callback(hObject, eventdata, handles)
if (validateInput(hObject, handles))
    return
end
file_search = '';
handles.editInputDir = get(handles.editInputDir,'String');
file_search = strcat(file_search, handles.editInputDir);
handles.editOutputDir = get(handles.editOutputDir, 'String');

if (get(handles.subjectPattern, 'String')=="")
    disp('Subject pattern not specified, skipping.');
    num_subjects = 1;
else
    subjectPattern = get(handles.subjectPattern, 'String');
    subject_search = strcat(handles.editInputDir,filesep,subjectPattern);
    subjects = dir(subject_search);
    num_subjects = length(subjects);
    file_search = strcat(file_search, filesep, subjectPattern);  
end
if (get(handles.filePattern, 'String')=="")
    filePattern = "";
    disp('File pattern not specified, selecting every file ');
else
    filePattern = get(handles.filePattern, 'String');
    file_search = strcat(file_search, filesep, filePattern);
    files = dir(file_search);
    num_files = length(files);
end
disp(file_search);
files = dir(file_search);
disp(length(files));
files_master = {};

if(handles.is3D4D == "4D")
    for i = 1:length(files)
        fullpath = [files(i).folder, filesep, files(i).name]; 
        files_master{i} = struct('fullpath',{fullpath},'is3D4D',handles.is3D4D,'subjectFolder',files(i).folder, 'mask_filePath',handles.maskFilePath,'numSubjects',length(files),'outputDir',handles.outputDir);
        handles.filePaths{i}=fullpath;
        disp(files_master{i});
    end
else
    for i = 1:length(subjects)
        subject=[subjects(i).folder, filesep, subjects(i).name];
        disp(subject);
        files_master{i}=struct('fullpath',subject, 'is3D4D', handles.is3D4D,'subjectFolder', subject, 'mask_filePath', handles.maskFilePath, 'numSubjects',length(subjects), 'outputDir',handles.outputDir);
        handles.filePaths{i} = subject;
        disp(files_master{i})
    end
end
handles.files_master = files_master;
disp('Done reading input images');
msgbox('Done selecting input files','Info Message');
loadListBox(hObject,handles);
guidata(hObject,handles);


% --- validate input.
function inputValidation = validateInput(hObject, handles)
    invalidate = 0;
    if (get(handles.editInputDir, 'String')=="")
        disp('Input not selected');
        msgbox('Input Directory was not selected','Error Message');
        invalidate = 1; 
    end   
    if (get(handles.editOutputDir, 'String')=="")
        disp('Output Directory not selected');
        msgbox('Please select an Output Directory','Error Message');
        invalidate = 1;  
    end
    if (handles.maskFilePath=="")
        disp('Brain Mask not selected');
        msgbox('Please select a brain mask','Error Message');
        invalidate = 1;
    end    
    inputValidation = invalidate;
   

      


% --- Executes on selection change in listboxSubjects.
function listboxSubjects_Callback(hObject, eventdata, handles)
% hObject    handle to listboxSubjects (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listboxSubjects contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listboxSubjects


% --- Executes during object creation, after setting all properties.
function listboxSubjects_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listboxSubjects (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function loadListBox(hObject, handles)
    %arrayScans = extractfield(handles.files_master,'fullpath');
    set(handles.listboxSubjects, 'String', string(handles.filePaths));
    guidata(hObject, handles);


% --- Executes on button press in btnNext.
function btnNext_Callback(hObject, eventdata, handles)
% hObject    handle to btnNext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('calling batchMetrics');
batchMetrics(handles.files_master)

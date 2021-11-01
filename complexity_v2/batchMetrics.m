function varargout = batchMetrics(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @batchMetrics_OpeningFcn, ...
                   'gui_OutputFcn',  @batchMetrics_OutputFcn, ...
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



% --- Executes just before batchMetrics is made visible.
function batchMetrics_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to batchMetrics (see VARARGIN)

% Choose default command line output for batchMetrics
handles.output = hObject;
handles.lempelZiv = 0;
handles.hurst = 0;
handles.higuchi = 0;
handles.approx = 0;
handles.sample = 0;
handles.fuzzy = 0;
handles.perm = 0;

handles.files_master = varargin{1};
handles.metrics_master = struct([]);

guidata(hObject, handles);

% UIWAIT makes batchMetrics wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = batchMetrics_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
varargout{1} = handles.output;


function imgStruct = formImgStruct(fileStruct)
temp= struct();
if (fileStruct.is3D4D == "3D")
    img = readImages4D(fileStruct.fullpath);   
    temp.img_4D = img.img_4D;
    temp.baseName = img.bName;
    temp.imgVoxDim = img.voxDim;
    temp.size = fileStruct.numSubjects;
    temp.originator = img.originator;
else
    imgStruct = load_nii(fileStruct.fullpath);
    temp.img_4D = imgStruct.img; 
    temp.originator = imgStruct.hdr.hist.originator(1:3);
    temp.imgVoxDim = imgStruct.hdr.dime.pixdim(2:4);
    [p,f,e] = fileparts(fileStruct.fullpath);
    [p,f,e] = fileparts(f);
    temp.baseName = f;
    folder = [fileStruct.outputDir,filesep,'tmp'];
    if endsWith(e,".gz")
        gunzip(fileStruct.fullpath, folder);
        tmp_files = dir(folder);
    else
        tmp_files = dir(fileStruct.fullpath);
    end
end
temp.brainMask = load_untouch_nii(fileStruct.mask_filePath).img;
temp.outputDir = fileStruct.outputDir;
imgStruct = temp;
disp('Loaded scan');


% --- Executes on button press in btnRun.
function btnRun_Callback(hObject, eventdata, handles)
% hObject    handle to btnRun (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('Initializing metrics to be run...');
loadMetrics(hObject, handles);
disp('Loaded metric configurations...');
run_configurations = struct([]);
index = 1;
for i = 1:length(handles.files_master)
    disp('Loading file details:');
    disp(handles.files_master{i});
    handle = formImgStruct(handles.files_master{i});
    disp('Configurations generated: ');
    disp(length(handles.metrics_master));
    parfor j = 1:length(handles.metrics_master)
       disp('Calling computation function for ');
       disp(handles.metrics_master{j});
       if strcmp(handles.metrics_master{j}.metric,'lempelZiv')
           lempel_ziv_call(handle, handle.brainMask, handles.metrics_master{j}.r);
       elseif strcmp(handles.metrics_master{j}.metric,'hurst')
           hurst_ex_call(handle, handle.brainMask, handles.metrics_master{j}.r);
       elseif strcmp(handles.metrics_master{j}.metric,'higuchi')
           frac_dim_call(handle, handle.brainMask, handles.metrics_master{j}.k);
       elseif strcmp(handles.metrics_master{j}.metric,'approx')
           ap_en_call(handle, handle.brainMask, handles.metrics_master{j}.m, handles.metrics_master{j}.r);
       elseif strcmp(handles.metrics_master{j}.metric,'sample')
           samp_en_call(handle, handle.brainMask, handles.metrics_master{j}.m, handles.metrics_master{j}.r);
       elseif strcmp(handles.metrics_master{j}.metric,'fuzzy')
           fuzzy_en_call(handle, handle.brainMask, handles.metrics_master{j}.m, handles.metrics_master{j}.n, handles.metrics_master{j}.tau);
       end
    end
end
 
function loadMetrics(hObject, handles)
index = 1;
if handles.lempelZiv
    if ~(isfield(handles,'lempelZiv_rMin'))
        handles.lempelZiv_rMin=0;
    end
    if ~(isfield(handles,'lempelZiv_rMax'))
        handles.lempelZiv_rMax=0;
    end
    if ~(isfield(handles,'lempelZiv_rStep'))
        handles.lempelZiv_rStep=0;
    end
    guidata(hObject, handles);
    rList = metricListFunc(handles.lempelZiv_rMin, handles.lempelZiv_rMax, handles.lempelZiv_rStep);
    for idx = 1:length(rList)        
        metrics_master{index} = struct('metric','lempelZiv','r',rList(idx));
        index = index+1;
    end
end

if handles.hurst
    if ~(isfield(handles,'hurst_rMin'))
        handles.hurst_rMin=0;
    end
    if ~(isfield(handles,'hurst_rMax'))
        handles.hurst_rMax=0;
    end
    if ~(isfield(handles,'hurst_rStep'))
        handles.hurst_rStep=0;
    end
    rList = metricListFunc(handles.hurst_rMin, handles.hurst_rMax, handles.hurst_rStep);
    for idx = 1:length(rList)        
        metrics_master{index} = struct('metric','hurst','r',rList(idx));
        index = index+1;
    end
end

if handles.higuchi
    if ~(isfield(handles,'higuchi_kMin'))
        handles.higuchi_kMin=0;
    end
    if ~(isfield(handles,'higuchi_kMax'))
        handles.higuchi_kMax=0;
    end
    if ~(isfield(handles,'higuchi_kStep'))
        handles.higuchi_kStep=0;
    end
    kList = metricListFunc(handles.higuchi_kMin, handles.higuchi_kMax, handles.higuchi_kStep);
    for idx = 1:length(kList)        
        metrics_master{index} = struct('metric','higuchi','k',kList(idx));
        index = index+1;
    end
end

if handles.approx
    if ~(isfield(handles,'approx_rMin'))
        handles.approx_rMin=0;
    end
    if ~(isfield(handles,'approx_rMax'))
        handles.approx_rMax=0;
    end
    if ~(isfield(handles,'approx_rStep'))
        handles.approx_rStep=0;
    end
    if ~(isfield(handles,'approx_mMin'))
        handles.approx_mMin=0;
    end
    if ~(isfield(handles,'approx_mMax'))
        handles.approx_mMax=0;
    end
    if ~(isfield(handles,'approx_mStep'))
        handles.approx_mStep=0;
    end
    rList = metricListFunc(handles.approx_rMin, handles.approx_rMax, handles.approx_rStep);
    mList = metricListFunc(handles.approx_mMin, handles.approx_mMax, handles.approx_mStep);
    for idx = 1:length(rList) 
        for jdx = 1:length(mList)
            metrics_master{index} = struct('metric','approx','r',rList(idx), 'm', mList(idx));
            index = index+1;
        end 
    end
end

if handles.sample
    if ~(isfield(handles,'sample_rMin'))
        handles.sample_rMin=0;
    end
    if ~(isfield(handles,'sample_rMax'))
        handles.sample_rMax=0;
    end
    if ~(isfield(handles,'sample_rStep'))
        handles.sample_rStep=0;
    end
    if ~(isfield(handles,'sample_mMin'))
        handles.sample_mMin=0;
    end
    if ~(isfield(handles,'sample_mMax'))
        handles.sample_mMax=0;
    end
    if ~(isfield(handles,'sample_mStep'))
        handles.sample_mStep=0;
    end
    rList = metricListFunc(handles.sample_rMin, handles.sample_rMax, handles.sample_rStep);
    mList = metricListFunc(handles.sample_mMin, handles.sample_mMax, handles.sample_mStep);
    for idx = 1:length(rList) 
        for jdx = 1:length(mList)
            metrics_master{index} = struct('metric','sample','r',rList(idx), 'm', mList(idx));
            index = index+1;
        end 
    end
end

if handles.fuzzy
    if ~(isfield(handles,'fuzzy_rMin'))
        handles.fuzzy_rMin=0;
    end
    if ~(isfield(handles,'fuzzy_rMax'))
        handles.fuzzy_rMax=0;
    end
    if ~(isfield(handles,'fuzzy_rStep'))
        handles.fuzzy_rStep=0;
    end
    if ~(isfield(handles,'fuzzy_mMin'))
        handles.fuzzy_mMin=0;
    end
    if ~(isfield(handles,'fuzzy_mMax'))
        handles.fuzzy_mMax=0;
    end
    if ~(isfield(handles,'fuzzy_mStep'))
        handles.fuzzy_mStep=0;
    end
    if ~(isfield(handles,'fuzzy_n'))
        handles.fuzzy_n=2;
    end
    if ~(isfield(handles,'fuzzy_tau'))
        handles.fuzzy_tau=1;
    end
    rList = metricListFunc(handles.fuzzy_rMin, handles.fuzzy_rMax, handles.fuzzy_rStep);
    mList = metricListFunc(handles.fuzzy_mMin, handles.fuzzy_mMax, handles.fuzzy_mStep);
    for idx = 1:length(rList) 
        for jdx = 1:length(mList)
            metrics_master{index} = struct('metric','fuzzy','r',rList(idx), 'm', mList(idx), 'n', handles.fuzzy_n, 'tau', handles.fuzzy_tau);
            index = index+1;
        end 
    end
end
disp(metrics_master);
handles.metrics_master = metrics_master;
guidata(hObject, handles);

function metricList = metricListFunc(min, max, step)
index = 1;
list = [];
if min
    list(index) = min;
    index = index+1;
    if max == 0
        metricList = list;
        return
    else
        if step == 0
            list(index) = max ;
            index = index+1;
        else        
            while (min+step <= max)
                list(index) = min + step;
                min = min+step;
                index = index+1;
                
            end    
        
        end 
    end
   
else
    msgbox('Minimum values for metrics is required','Info');
end
metricList = list;


%***************************LEMPEL ZIV*********************************
%*************************************************************************
% --- Executes on button press in checkboxLempelZiv.
function checkboxLempelZiv_Callback(hObject, eventdata, handles)
value = get(hObject,'Value');
handles.lempelZiv = value;
guidata(hObject, handles);

function rMinLempelZiv_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of rMinLempelZiv as text
%        str2double(get(hObject,'String')) returns contents of rMinLempelZiv as a double
rMin = get(hObject,'String');
rMin = str2num(rMin);
handles.lempelZiv_rMin = rMin;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function rMinLempelZiv_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function rMaxLempelZiv_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of rMaxLempelZiv as text
%        str2double(get(hObject,'String')) returns contents of rMaxLempelZiv as a double
rMax = get(hObject,'String');
rMax = str2num(rMax);
handles.lempelZiv_rMax = rMax;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function rMaxLempelZiv_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function rStepLempelZiv_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of rStepLempelZiv as text
%        str2double(get(hObject,'String')) returns contents of rStepLempelZiv as a double
rStep = get(hObject,'String');
rStep = str2num(rStep);
handles.lempelZiv_rStep = rStep;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function rStepLempelZiv_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function lempel_ziv_call(handles, mask, r)
imgSize = size(mask);
brainVox = find(mask == max(mask(:)));
LempelZiv = zeros(imgSize);
msg = ['calculating Lempel Ziv: r=', num2str(r)];
disp(msg);
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
opFname = [handles.outputDir, filesep, handles.baseName, 'LempelZiv.nii']
niiStruct = make_nii(LempelZiv, handles.imgVoxDim, [], 64, []);
niiStruct.hdr.hk.data_type = 'float64';
niiStruct.hdr.hist.originator(1:3) = handles.originator;
save_nii(niiStruct, opFname, []);


%***********************LEMPEL ZIV END************************************
%*************************************************************************

%*************************************************************************
%******************************HURST START**************************************

function hurst_ex_call(handles, mask, r)
imgSize = size(mask);
brainVox = find(mask == max(mask(:)));
Hurst_Ex = zeros(imgSize);
msg = ['calculating Hurst Exponent: r=', num2str(r)];
disp(msg);
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
opFname = [handles.outputDir, filesep, handles.baseName, 'Hurst_Ex','_r',num2str(r),'.nii']
niiStruct = make_nii(Hurst_Ex, handles.imgVoxDim, [], 64, []);
niiStruct.hdr.hk.data_type = 'float64';
niiStruct.hdr.hist.originator(1:3) = handles.originator;
save_nii(niiStruct, opFname, []);


% --- Executes on button press in checkboxHurst.
function checkboxHurst_Callback(hObject, eventdata, handles)
% Hint: get(hObject,'Value') returns toggle state of checkboxHurst
value = get(hObject,'Value');
handles.hurst = value;
guidata(hObject, handles);

function rMinHurst_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of rMinHurst as text
%        str2double(get(hObject,'String')) returns contents of rMinHurst as a double
rMin = get(hObject,'String');
rMin = str2num(rMin);
handles.hurst_rMin = rMin;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function rMinHurst_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function rMaxHurst_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of rMaxHurst as text
%        str2double(get(hObject,'String')) returns contents of rMaxHurst as a double
rMax = get(hObject,'String');
rMax = str2num(rMax);
handles.hurst_rMax = rMax;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function rMaxHurst_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function rStepHurst_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of rStepHurst as text
%        str2double(get(hObject,'String')) returns contents of rStepHurst as a double
rStep = get(hObject,'String');
rStep = str2num(rStep);
handles.hurst_rStep = rStep;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function rStepHurst_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%**********************HURST END ***************************************
%*************************************************************************



%*************************************************************************
%**********************HIGUCHI START ***************************************

function frac_dim_call(handles, mask, k)
imgSize = size(mask);
brainVox = find(mask == max(mask(:)));

msg = ['calculating FracDim: k=', num2str(k)];
disp(msg);
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
opFname = [handles.outputDir, filesep, handles.baseName, 'FracDim_k', ...
    num2str(k),'.nii'];
niiStruct = make_nii(FracDim, handles.imgVoxDim, [], 64, []);
niiStruct.hdr.hk.data_type = 'float64';
niiStruct.hdr.hist.originator(1:3) = handles.originator;
save_nii(niiStruct, opFname, []);


% --- Executes on button press in checkboxHiguchi.
function checkboxHiguchi_Callback(hObject, eventdata, handles)
% Hint: get(hObject,'Value') returns toggle state of checkboxHiguchi
value = get(hObject,'Value');
handles.higuchi = value;
guidata(hObject, handles);

function kMinHiguchi_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of kMinHiguchi as text
%        str2double(get(hObject,'String')) returns contents of kMinHiguchi as a double
kMin = get(hObject,'String');
kMin = str2num(kMin);
handles.higuchi_kMin = kMin;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function kMinHiguchi_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function kMaxHiguchi_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of kMaxHiguchi as text
%        str2double(get(hObject,'String')) returns contents of kMaxHiguchi as a double
kMax = get(hObject,'String');
kMax = str2num(kMax);
handles.higuchi_kMax = kMax;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function kMaxHiguchi_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function kStepHiguchi_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of kStepHiguchi as text
%        str2double(get(hObject,'String')) returns contents of kStepHiguchi as a double
kStep = get(hObject,'String');
kStep = str2num(kStep);
handles.higuchi_kStep = kStep;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function kStepHiguchi_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%**********************HIGUCHI END ***************************************
%*************************************************************************



%*************************************************************************
%**********************APPROX EN START ***************************************

function ap_en_call(handles, mask, m, r)
imgSize = size(mask);
brainVox = find(mask == max(mask(:)));
ApEn = zeros(imgSize);
msg = ['calculating self ApEn: m=',num2str(m),',r=',num2str(r)];
disp(msg);
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

% --- Executes on button press in checkboxApprox.
function checkboxApprox_Callback(hObject, eventdata, handles)
% Hint: get(hObject,'Value') returns toggle state of checkboxApprox
value = get(hObject,'Value');
handles.approx = value;
guidata(hObject, handles);

function mMinApprox_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of mMinApprox as text
%        str2double(get(hObject,'String')) returns contents of mMinApprox as a double
mMin = get(hObject,'String');
mMin = str2num(mMin);
handles.approx_mMin = mMin;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function mMinApprox_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function mMaxApprox_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of mMaxApprox as text
%        str2double(get(hObject,'String')) returns contents of mMaxApprox as a double
mMax = get(hObject,'String');
mMax = str2num(mMax);
handles.approx_mMax = mMax;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function mMaxApprox_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function rMinApprox_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of rMinApprox as text
%        str2double(get(hObject,'String')) returns contents of rMinApprox as a double
rMin = get(hObject,'String');
rMin = str2num(rMin);
handles.approx_rMin = rMin;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function rMinApprox_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function rMaxApprox_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of rMaxApprox as text
%        str2double(get(hObject,'String')) returns contents of rMaxApprox as a double
rMax = get(hObject,'String');
rMax = str2num(rMax);
handles.approx_rMax = rMax;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function rMaxApprox_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function mStepApprox_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of mStepApprox as text
%        str2double(get(hObject,'String')) returns contents of mStepApprox as a double
mStep = get(hObject,'String');
mStep = str2num(mStep);
handles.approx_mStep = mStep;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function mStepApprox_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function rStepApprox_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of rStepApprox as text
%        str2double(get(hObject,'String')) returns contents of rStepApprox as a double
rStep = get(hObject,'String');
rStep = str2num(rStep);
handles.approx_rStep = rStep;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function rStepApprox_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%**********************APPROX EN END ***************************************
%*************************************************************************




%*************************************************************************
%**********************SAMPLE EN START ***************************************

function samp_en_call(handles, mask, m, r)
imgSize = size(mask);
brainVox = find(mask == max(mask(:)));
SampEn = zeros(imgSize);
msg = ['calculating self SampEn: m=',num2str(m),',r=',num2str(r)];
disp(msg);
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
opFname = [handles.outputDir, filesep, handles.baseName, 'SampEn_m', ...
    num2str(m), '_r', num2str(r*100), 'per','.nii'];
niiStruct = make_nii(SampEn, handles.imgVoxDim, [], 64, []);
niiStruct.hdr.hk.data_type = 'float64';
save_nii(niiStruct, opFname, []);


% --- Executes on button press in checkboxSample.
function checkboxSample_Callback(hObject, eventdata, handles)
% Hint: get(hObject,'Value') returns toggle state of checkboxSample
value = get(hObject,'Value');
handles.sample = value;
guidata(hObject, handles);

function mMinSample_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of mMinSample as text
%        str2double(get(hObject,'String')) returns contents of mMinSample as a double
mMin = get(hObject,'String');
mMin = str2num(mMin);
handles.sample_mMin = mMin;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function mMinSample_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function mMaxSample_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of mMaxSample as text
%        str2double(get(hObject,'String')) returns contents of mMaxSample as a double
mMax = get(hObject,'String');
mMax = str2num(mMax);
handles.sample_mMax = mMax;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function mMaxSample_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function rMinSample_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of rMinSample as text
%        str2double(get(hObject,'String')) returns contents of rMinSample as a double
rMin = get(hObject,'String');
rMin = str2num(rMin);
handles.sample_rMin = rMin;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function rMinSample_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function rMaxSample_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of rMaxSample as text
%        str2double(get(hObject,'String')) returns contents of rMaxSample as a double
rMax = get(hObject,'String');
rMax = str2num(rMax);
handles.sample_rMax = rMax;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function rMaxSample_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function rStepSample_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of rStepSample as text
%        str2double(get(hObject,'String')) returns contents of rStepSample as a double
rStep = get(hObject,'String');
rStep = str2num(rStep);
handles.sample_rStep = rStep;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function rStepSample_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function mStepSample_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of mStepSample as text
%        str2double(get(hObject,'String')) returns contents of mStepSample as a double
mStep = get(hObject,'String');
mStep = str2num(mStep);
handles.sample_mStep = mStep;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function mStepSample_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%**********************SAMPLE EN END ***************************************
%*************************************************************************



%*************************************************************************
%**********************FUZZY EN START ***************************************
function fuzzy_en_call(handles, mask, m, r, n, t)
imgSize = size(mask);
brainVox = find(mask == max(mask(:)));
FuzzEn = zeros(imgSize);
msg = ['calculating FuzzyEn: m=',num2str(m),',r=',num2str(r)];
disp(msg);
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
opFname = [handles.outputDir, filesep, handles.baseName, 'FuzzyEn_m', ...
    num2str(m), '_r', num2str(r*100), 'per','.nii'];
niiStruct = make_nii(FuzzEn, handles.imgVoxDim, [], 64, []);
niiStruct.hdr.hk.data_type = 'float64';
save_nii(niiStruct, opFname, []);

% --- Executes on button press in checkboxFuzzy.
function checkboxFuzzy_Callback(hObject, eventdata, handles)
% Hint: get(hObject,'Value') returns toggle state of checkboxFuzzy
value = get(hObject,'Value');
handles.fuzzy = value;
guidata(hObject, handles);

function mMinFuzzy_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of mMinFuzzy as text
%        str2double(get(hObject,'String')) returns contents of mMinFuzzy as a double
mMin = get(hObject,'String');
mMin = str2num(mMin);
handles.fuzzy_mMin = mMin;
guidata(hObject, handles);
% --- Executes during object creation, after setting all properties.
function mMinFuzzy_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function mMaxFuzzy_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of mMaxFuzzy as text
%        str2double(get(hObject,'String')) returns contents of mMaxFuzzy as a double
mMax = get(hObject,'String');
mMax = str2num(mMax);
handles.fuzzy_mMax = mMax;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function mMaxFuzzy_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function rMinFuzzy_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of rMinFuzzy as text
%        str2double(get(hObject,'String')) returns contents of rMinFuzzy as a double
rMin = get(hObject,'String');
rMin = str2num(rMin);
handles.fuzzy_rMin = rMin;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function rMinFuzzy_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function rMaxFuzzy_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of rMaxFuzzy as text
%        str2double(get(hObject,'String')) returns contents of rMaxFuzzy as a double
rMax = get(hObject,'String');
rMax = str2num(rMax);
handles.fuzzy_rMax = rMax;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function rMaxFuzzy_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function mStepFuzzy_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of mStepFuzzy as text
%        str2double(get(hObject,'String')) returns contents of mStepFuzzy as a double
mStep = get(hObject,'String');
mStep = str2num(mStep);
handles.fuzzy_mStep = mStep;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function mStepFuzzy_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function rStepFuzzy_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of rStepFuzzy as text
%        str2double(get(hObject,'String')) returns contents of rStepFuzzy as a double
rStep = get(hObject,'String');
rStep = str2num(rStep);
handles.fuzzy_rStep = rStep;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function rStepFuzzy_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function nFuzzy_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of nFuzzy as text
%        str2double(get(hObject,'String')) returns contents of nFuzzy as a double
n = get(hObject,'String');
n = str2num(n);
handles.fuzzy_n = n;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function nFuzzy_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function tauFuzzy_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of tauFuzzy as text
%        str2double(get(hObject,'String')) returns contents of tauFuzzy as a double
tau = get(hObject,'String');
tau = str2num(tau);
handles.fuzzy_tau = tau;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function tauFuzzy_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%**********************FUZZY EN END ***************************************
%*************************************************************************

function edit38_Callback(hObject, eventdata, handles)
% hObject    handle to edit38 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit38 as text
%        str2double(get(hObject,'String')) returns contents of edit38 as a double


% --- Executes during object creation, after setting all properties.
function edit38_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit38 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end














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

% Last Modified by GUIDE v2.5 24-Dec-2020 06:01:52

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


% --- Executes on button press in pb_inputDir.
function pb_inputDir_Callback(hObject, eventdata, handles)
% hObject    handle to pb_inputDir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ipFormat = cell2mat(inputdlg('Input 3D or 4D', 'Input selection'));
if isempty(ipFormat)
    disp('Please choose the input format: 3D or 4D');
else
    if (strcmp(ipFormat,'3D')==1 | strcmp(ipFormat,'3d')==1)
        dirName = uigetdir;
        if (dirName==0)
            disp('No image input directory selected');
        else
            imgStruct = readImages4D(dirName);
            disp(imgStruct);
            handles.img_4D = imgStruct.img_4D;
            handles.baseName = imgStruct.bName;
            handles.imgVoxDim = imgStruct.voxDim;
            handles.originator = imgStruct.originator;
        end
    else
        [fname, pname] = uigetfile('*.*','Select the 4D image');
        if (fname==0 & pname==0)
            disp('4D image file not selected');
        else
            imgName = [pname, fname];
            imgStruct = load_nii(imgName);
            handles.img_4D = imgStruct.img;
            handles.originator = imgStruct.hdr.hist.originator(1:3);
            [p,f,e] = fileparts(imgName);
            handles.baseName = f;
            handles.imgVoxDim = imgStruct.hdr.dime.pixdim(2:4);
        end
    end
end
guidata(hObject,handles);
disp('Done reading input images');

% --- Executes on button press in pb_outputDir.
function pb_outputDir_Callback(hObject, eventdata, handles)
% hObject    handle to pb_outputDir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
opFolder = uigetdir;
handles.opFolder = opFolder;
guidata(hObject, handles);

% --- Executes on button press in pb_brainMask.
function pb_brainMask_Callback(hObject, eventdata, handles)
% hObject    handle to pb_brainMask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[fname, pname] = uigetfile('*.*','Select the brain mask');
if (fname==0 & pname==0)
    disp('Brain mask not selected');
else
    mask_file = [pname, fname];
    mask = load_nii(mask_file);
    if (size(mask.img) ~= size(handles.img_4D(:,:,:,1)))
        msgbox('Mask and Input image dimensions do not match');
    else
        handles.brainMask = mask.img;
        guidata(hObject, handles);
    end
end


% --- Executes on button press in pb_verifyOrientation.
function pb_verifyOrientation_Callback(hObject, eventdata, handles)
% hObject    handle to pb_verifyOrientation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mask = verifyImgOri(handles.img_4D(:,:,:,1),handles.brainMask);
handles.brainMask = mask;
guidata(hObject,handles);

function lempel_ziv_call(handles, mask, m_start, m_end, r_start, r_end, scale_start, scale_end)
imgSize = size(mask);
brainVox = find(mask == max(mask(:)));
LempelZiv = zeros(imgSize);
msg = ['calculating Lempel Ziv: m=', num2str(m), ', r=', num2str(r)];
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
        opFname = [handles.opFolder, filesep, handles.baseName, 'ApEn_m', ...
            num2str(m), '_r', num2str(r*100), 'per','.nii'];
        niiStruct = make_nii(ApEn, handles.imgVoxDim, [], 64, []);
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
            tmp = sample_entropy(m, r_val, TS1, 1);
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

function fuzzy_en_call(handles, mask, m_start, m_end, r_start, r_end, m_scale, r_scale)
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
            tmp = FuzEn(TS1,m, r_val,1);
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
% --- Executes on button press in pb_run.
function pb_run_Callback(hObject, eventdata, handles)
% hObject    handle to pb_run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
A = sum(strcmp(fieldnames(handles),'img_4D'));
B = sum(strcmp(fieldnames(handles),'brainMask'));
if handles.lempelZiv
    C = sum(strcmp(fieldnames(handles),'lempelZiv_m_start'));
    D = sum(strcmp(fieldnames(handles),'lempelZiv_m_end'));
    E = sum(strcmp(fieldnames(handles),'lempelZiv_r_start'));
    F = sum(strcmp(fieldnames(handles),'lempelZiv_r_end'));
    G = sum(strcmp(fieldnames(handles),'lempelZiv_scale_start'));
    H = sum(strcmp(fieldnames(handles),'lempelZiv_scale_end'));
    ipChk = [A B C D E F G H];
    clear C D E F G H 
    set(handles.edit_lempelZiv_m_start, 'Enable', 'off');
    set(handles.edit_lempelZiv_m_end, 'Enable', 'off');
    set(handles.edit_lempelZiv_r_start, 'Enable', 'off');
    set(handles.edit_lempelZiv_r_end, 'Enable', 'off');
    set(handles.edit_lempelZiv_scale_start, 'Enable', 'off');
    set(handles.edit_lempelZiv_scale_end, 'Enable', 'off');
    lempel_ziv_call(handles, handles.brainMask, handles.lempelZiv_m_start, handles.lempelZiv_m_end, handles.lempelZiv_r_start, handles.lempelZiv_r_end, handles.lempelZiv_scale_start, handles.lempelZiv_scale_end);
end
if handles.hurstExp
    C = sum(strcmp(fieldnames(handles),'hurstExp_m_start'));
    D = sum(strcmp(fieldnames(handles),'hurstExp_m_end'));
    E = sum(strcmp(fieldnames(handles),'hurstExp_r_start'));
    F = sum(strcmp(fieldnames(handles),'hurstExp_r_end'));
    G = sum(strcmp(fieldnames(handles),'hurstExp_scale_start'));
    H = sum(strcmp(fieldnames(handles),'hurstExp_scale_end'));
    ipChk = [A B C D E F G H];
    clear C D E F G H 
    set(handles.edit_hurstExp_m_start, 'Enable', 'off');
    set(handles.edit_hurstExp_m_end, 'Enable', 'off');
    set(handles.edit_hurstExp_r_start, 'Enable', 'off');
    set(handles.edit_hurstExp_r_end, 'Enable', 'off');
    set(handles.edit_hurstExp_scale_start, 'Enable', 'off');
    set(handles.edit_hurstExp_scale_end, 'Enable', 'off');
end
if handles.LLExp
    C = sum(strcmp(fieldnames(handles),'LLExp_m_start'));
    D = sum(strcmp(fieldnames(handles),'LLExp_m_end'));
    E = sum(strcmp(fieldnames(handles),'LLExp_r_start'));
    F = sum(strcmp(fieldnames(handles),'LLExp_r_end'));
    G = sum(strcmp(fieldnames(handles),'LLExp_scale_start'));
    H = sum(strcmp(fieldnames(handles),'LLExp_scale_end'));
    ipChk = [A B C D E F G H];
    clear C D E F G H 
    set(handles.edit_LLExp_m_start, 'Enable', 'off');
    set(handles.edit_LLExp_m_end, 'Enable', 'off');
    set(handles.edit_LLExp_r_start, 'Enable', 'off');
    set(handles.edit_LLExp_r_end, 'Enable', 'off');
    set(handles.edit_LLExp_scale_start, 'Enable', 'off');
    set(handles.edit_LLExp_scale_end, 'Enable', 'off');
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
    ipChk = [A B C D E F G H I J];
    clear C D E F G H I J
    set(handles.edit_fracDim_m_start, 'Enable', 'off');
    set(handles.edit_fracDim_m_end, 'Enable', 'off');
    set(handles.edit_fracDim_r_start, 'Enable', 'off');
    set(handles.edit_fracDim_r_end, 'Enable', 'off');
    set(handles.edit_fracDim_scale_start, 'Enable', 'off');
    set(handles.edit_fracDim_scale_end, 'Enable', 'off');
    set(handles.edit_fracDim_k_start, 'Enable', 'off');
    set(handles.edit_fracDim_k_end, 'Enable', 'off');
    frac_dim_call(handles, handles.brainMask, handles.fracDim_k_start, handles.fracDim_k_end, handles.fracDim_scale_start);
end
if handles.apEn
    C = sum(strcmp(fieldnames(handles),'apEn_m_start'));
    D = sum(strcmp(fieldnames(handles),'apEn_m_end'));
    E = sum(strcmp(fieldnames(handles),'apEn_r_start'));
    F = sum(strcmp(fieldnames(handles),'apEn_r_end'));
    G = sum(strcmp(fieldnames(handles),'apEn_scale_start'));
    H = sum(strcmp(fieldnames(handles),'apEn_scale_end'));
    ipChk = [A B C D E F G H];
    clear C D E F G H 
    set(handles.edit_apEn_m_start, 'Enable', 'off');
    set(handles.edit_apEn_m_end, 'Enable', 'off');
    set(handles.edit_apEn_r_start, 'Enable', 'off');
    set(handles.edit_apEn_r_end, 'Enable', 'off');
    set(handles.edit_apEn_scale_start, 'Enable', 'off');
    set(handles.edit_apEn_scale_end, 'Enable', 'off');
    ap_en_call(handles, handles.brainMask, handles.apEn_m_start, handles.apEn_m_end, handles.apEn_r_start, handles.apEn_r_end, handles.apEn_scale_start, handles.apEn_scale_end);
end
if handles.sampEn
    C = sum(strcmp(fieldnames(handles),'sampEn_m_start'));
    D = sum(strcmp(fieldnames(handles),'sampEn_m_end'));
    E = sum(strcmp(fieldnames(handles),'sampEn_r_start'));
    F = sum(strcmp(fieldnames(handles),'sampEn_r_end'));
    G = sum(strcmp(fieldnames(handles),'sampEn_scale_start'));
    H = sum(strcmp(fieldnames(handles),'sampEn_scale_end'));
    ipChk = [A B C D E F G H];
    clear C D E F G H 
    set(handles.edit_sampEn_m_start, 'Enable', 'off');
    set(handles.edit_sampEn_m_end, 'Enable', 'off');
    set(handles.edit_sampEn_r_start, 'Enable', 'off');
    set(handles.edit_sampEn_r_end, 'Enable', 'off');
    set(handles.edit_sampEn_scale_start, 'Enable', 'off');
    set(handles.edit_sampEn_scale_end, 'Enable', 'off');
    samp_en_call(handles, handles.brainMask, handles.sampEn_m_start, handles.sampEn_m_end, handles.sampEn_r_start, handles.sampEn_r_end, handles.sampEn_scale_start, handles.sampEn_scale_end);
end
if handles.waveletMSE
    C = sum(strcmp(fieldnames(handles),'waveletMSE_m_start'));
    D = sum(strcmp(fieldnames(handles),'waveletMSE_m_end'));
    E = sum(strcmp(fieldnames(handles),'waveletMSE_r_start'));
    F = sum(strcmp(fieldnames(handles),'waveletMSE_r_end'));
    G = sum(strcmp(fieldnames(handles),'waveletMSE_scale_start'));
    H = sum(strcmp(fieldnames(handles),'waveletMSE_scale_end'));
    ipChk = [A B C D E F G H];
    clear C D E F G H 
    set(handles.edit_waveletMSE_m_start, 'Enable', 'off');
    set(handles.edit_waveletMSE_m_end, 'Enable', 'off');
    set(handles.edit_waveletMSE_r_start, 'Enable', 'off');
    set(handles.edit_waveletMSE_r_end, 'Enable', 'off');
    set(handles.edit_waveletMSE_scale_start, 'Enable', 'off');
    set(handles.edit_waveletMSE_scale_end, 'Enable', 'off');
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
    %K = sum(strcmp(fieldnames(handles),'fuzzyEn_tau_start'));
    %L = sum(strcmp(fieldnames(handles),'fuzzyEn_tau_end'));
    ipChk = [A B C D E F G H I J ];
    clear C D E F G H I J 
    set(handles.edit_fuzzyEn_m_start, 'Enable', 'off');
    set(handles.edit_fuzzyEn_m_end, 'Enable', 'off');
    set(handles.edit_fuzzyEn_r_start, 'Enable', 'off');
    set(handles.edit_fuzzyEn_r_end, 'Enable', 'off');
    set(handles.edit_fuzzyEn_scale_start, 'Enable', 'off');
    set(handles.edit_fuzzyEn_scale_end, 'Enable', 'off');
    set(handles.edit_fuzzyEn_n_start, 'Enable', 'off');
    set(handles.edit_fuzzyEn_n_end, 'Enable', 'off');
    %set(handles.edit_fuzzyEn_tau_start, 'Enable', 'off');
    %set(handles.edit_fuzzyEn_tau_end, 'Enable', 'off');
    fuzzy_en_call(handles, handles.brainMask, handles.fuzzyEn_m_start, handles.fuzzyEn_m_end, handles.fuzzyEn_r_start, handles.fuzzyEn_r_end, handles.fuzzyEn_scale_start, handles.fuzzyEn_scale_end);
    
end
if handles.permEn
    C = sum(strcmp(fieldnames(handles),'permEn_m_start'));
    D = sum(strcmp(fieldnames(handles),'permEn_m_end'));
    E = sum(strcmp(fieldnames(handles),'permEn_r_start'));
    F = sum(strcmp(fieldnames(handles),'permEn_r_end'));
    G = sum(strcmp(fieldnames(handles),'permEn_scale_start'));
    H = sum(strcmp(fieldnames(handles),'permEn_scale_end'));
    I = sum(strcmp(fieldnames(handles),'permEn_ord_start'));
    J = sum(strcmp(fieldnames(handles),'permEn_ord_end'));
    K = sum(strcmp(fieldnames(handles),'permEn_delay_start'));
    L = sum(strcmp(fieldnames(handles),'permEn_delay_end'));
    ipChk = [A B C D E F G H I J K L];
    clear C D E F G H I J K L
    set(handles.edit_permEn_m_start, 'Enable', 'off');
    set(handles.edit_permEn_m_end, 'Enable', 'off');
    set(handles.edit_permEn_r_start, 'Enable', 'off');
    set(handles.edit_permEn_r_end, 'Enable', 'off');
    set(handles.edit_permEn_scale_start, 'Enable', 'off');
    set(handles.edit_permEn_scale_end, 'Enable', 'off');
    set(handles.edit_permEn_n_start, 'Enable', 'off');
    set(handles.edit_permEn_n_end, 'Enable', 'off');
    set(handles.edit_permEn_tau_start, 'Enable', 'off');
    set(handles.edit_permEn_tau_end, 'Enable', 'off');
end
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
handles.permEn = value;
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



function edit_sampEn_m_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sampEn_m_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sampEn_m_start as text
%        str2double(get(hObject,'String')) returns contents of edit_sampEn_m_start as a double
m_start = get(hObject,'String');
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



function edit37_Callback(hObject, eventdata, handles)
% hObject    handle to edit37 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit37 as text
%        str2double(get(hObject,'String')) returns contents of edit37 as a double


% --- Executes during object creation, after setting all properties.
function edit37_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit37 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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



function edit39_Callback(hObject, eventdata, handles)
% hObject    handle to edit39 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit39 as text
%        str2double(get(hObject,'String')) returns contents of edit39 as a double


% --- Executes during object creation, after setting all properties.
function edit39_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit39 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit40_Callback(hObject, eventdata, handles)
% hObject    handle to edit40 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit40 as text
%        str2double(get(hObject,'String')) returns contents of edit40 as a double


% --- Executes during object creation, after setting all properties.
function edit40_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit40 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit41_Callback(hObject, eventdata, handles)
% hObject    handle to edit41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit41 as text
%        str2double(get(hObject,'String')) returns contents of edit41 as a double


% --- Executes during object creation, after setting all properties.
function edit41_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit42_Callback(hObject, eventdata, handles)
% hObject    handle to edit42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit42 as text
%        str2double(get(hObject,'String')) returns contents of edit42 as a double


% --- Executes during object creation, after setting all properties.
function edit42_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit43_Callback(hObject, eventdata, handles)
% hObject    handle to edit43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit43 as text
%        str2double(get(hObject,'String')) returns contents of edit43 as a double


% --- Executes during object creation, after setting all properties.
function edit43_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit44_Callback(hObject, eventdata, handles)
% hObject    handle to edit44 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit44 as text
%        str2double(get(hObject,'String')) returns contents of edit44 as a double


% --- Executes during object creation, after setting all properties.
function edit44_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit44 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit45_Callback(hObject, eventdata, handles)
% hObject    handle to edit45 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit45 as text
%        str2double(get(hObject,'String')) returns contents of edit45 as a double


% --- Executes during object creation, after setting all properties.
function edit45_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit45 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit46_Callback(hObject, eventdata, handles)
% hObject    handle to edit46 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit46 as text
%        str2double(get(hObject,'String')) returns contents of edit46 as a double


% --- Executes during object creation, after setting all properties.
function edit46_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit46 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit47_Callback(hObject, eventdata, handles)
% hObject    handle to edit47 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit47 as text
%        str2double(get(hObject,'String')) returns contents of edit47 as a double


% --- Executes during object creation, after setting all properties.
function edit47_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit47 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit48_Callback(hObject, eventdata, handles)
% hObject    handle to edit48 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit48 as text
%        str2double(get(hObject,'String')) returns contents of edit48 as a double


% --- Executes during object creation, after setting all properties.
function edit48_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit48 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit49_Callback(hObject, eventdata, handles)
% hObject    handle to edit49 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit49 as text
%        str2double(get(hObject,'String')) returns contents of edit49 as a double


% --- Executes during object creation, after setting all properties.
function edit49_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit49 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit50_Callback(hObject, eventdata, handles)
% hObject    handle to edit50 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit50 as text
%        str2double(get(hObject,'String')) returns contents of edit50 as a double


% --- Executes during object creation, after setting all properties.
function edit50_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit50 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit51_Callback(hObject, eventdata, handles)
% hObject    handle to edit51 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit51 as text
%        str2double(get(hObject,'String')) returns contents of edit51 as a double


% --- Executes during object creation, after setting all properties.
function edit51_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit51 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit52_Callback(hObject, eventdata, handles)
% hObject    handle to edit52 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit52 as text
%        str2double(get(hObject,'String')) returns contents of edit52 as a double


% --- Executes during object creation, after setting all properties.
function edit52_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit52 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit53_Callback(hObject, eventdata, handles)
% hObject    handle to edit53 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit53 as text
%        str2double(get(hObject,'String')) returns contents of edit53 as a double


% --- Executes during object creation, after setting all properties.
function edit53_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit53 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit54_Callback(hObject, eventdata, handles)
% hObject    handle to edit54 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit54 as text
%        str2double(get(hObject,'String')) returns contents of edit54 as a double


% --- Executes during object creation, after setting all properties.
function edit54_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit54 (see GCBO)
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



function edit_permEn_ord_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_permEn_ord_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_permEn_ord_start as text
%        str2double(get(hObject,'String')) returns contents of edit_permEn_ord_start as a double
ord_start = get(hObject,'String');
ord_start = str2num(ord_start);
handles.permEn_ord_start = ord_start;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_permEn_ord_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_permEn_ord_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_permEn_ord_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_permEn_ord_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_permEn_ord_end as text
%        str2double(get(hObject,'String')) returns contents of edit_permEn_ord_end as a double


% --- Executes during object creation, after setting all properties.
function edit_permEn_ord_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_permEn_ord_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox_permEn_Normalize.
function checkbox_permEn_Normalize_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_permEn_Normalize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_permEn_Normalize

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
% Update handles structure
handles.files_master = varargin{1};
guidata(hObject, handles);

% UIWAIT makes batchMetrics wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = batchMetrics_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
varargout{1} = handles.output;


function imgStruct = formImgStruct(fileStruct)
disp(fileStruct);
temp= struct();
if (fileStruct.is3D4D == "3D")
    img = readImages4D(fileStruct.fullpath);   
    temp.img_4D = img.img_4D;
    temp.baseName = img.bName;
    temp.imgVoxDim = img.voxDim;
    temp.size = fileStruct.numSubjects;
    temp.originator = img.originator;
    temp.brainMask = load_untouch_nii(fileStruct.mask_filePath).img;
   
else
    
    img = niftiread(fileStruct.fullpath)
    temp.img_4D = img; 
    temp.originator = img.hdr.hist.originator(1:3);
    temp.imgVoxDim = img.hdr.dime.pixdim(2:4);
    [p,f,e] = fileparts(fileStruct.fullpath);
    [p,f,e] = fileparts(f);
    temp.baseName = f;
    
    if endsWith(e,".gz")
        gunzip(fileStruct.fullpath, folder);
        tmp_files = dir(folder);
    else
        tmp_files = dir(fileStruct.folder);
    end
    
end
 temp.outputDir = fileStruct.outputDir;
 imgStruct = temp;


% --- Executes on button press in btnRun.
function btnRun_Callback(hObject, eventdata, handles)
% hObject    handle to btnRun (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
for i = 1:length(handles.files_master)
    handle = formImgStruct(handles.files_master{i});
    lempel_ziv_call(handle,0.2,0.3,0.1)
end
    

% Function for Lempel Ziv Complexity call
function lempel_ziv_call(handles, r_start, r_end, scale)
    mask = handles.brainMask;
    imgSize = size(mask);
    brainVox = find(mask == max(mask(:)));
    loopValues = r_start:scale:r_end;
    parfor idx = 1:numel(loopValues)
        r = loopValues(idx);
        lempelZivResult = zeros(imgSize);
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
            lempelZivResult(row,col,sl) = tmp(1);
            nFail = nFail + tmp(2);
            waitbar(vox/length(brainVox));
        end
        close(h);
        opFname = [handles.outputDir, filesep, handles.baseName, 'LempelZiv','_r',num2str(r),'.nii']
        niiStruct = make_nii(lempelZivResult, handles.imgVoxDim, [], 64, []);
        niiStruct.hdr.hk.data_type = 'float64';
        niiStruct.hdr.hist.originator(1:3) = handles.originator;
        save_nii(niiStruct, opFname, []);        
    end

% Entrypoint to the complexityCalculation window
function varargout = complexityCalculation(varargin)
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
    %static method to get ToolTipManager object
    tm = javax.swing.ToolTipManager.sharedInstance; 
    javaMethodEDT('setInitialDelay',tm,0)

% Initialize variables for handles
function complexityCalculation_OpeningFcn(hObject, eventdata, handles, varargin)
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
    guidata(hObject, handles);

% Handle output for window
function varargout = complexityCalculation_OutputFcn(hObject, eventdata, handles) 
    varargout{1} = handles.output;

% Function to select input directory
function pb_inputDir_Callback(hObject, eventdata, handles)
    inputFormat = cell2mat(inputdlg('Input 3D or 4D', 'Input selection'));

    % Validate input entry 
    if isempty(inputFormat)
        disp('Please choose the input format: 3D or 4D');
    else
        if (strcmp(inputFormat,'3D')==1 || strcmp(inputFormat,'3d')==1)
            % 3d Input case - load files from a folder 
            dirName = uigetdir;

            % Validate input directory selection
            if (dirName==0)
                disp('No image input directory selected');
            else
                imgStruct = readImages4D(dirName);
                
                % Create image structure
                handles.img_4D = imgStruct.img_4D;
                handles.baseName = imgStruct.bName;
                handles.imgVoxDim = imgStruct.voxDim;
                handles.originator = imgStruct.originator;
                disp('Loaded 3D images and created image structure');
            end
        else
            % Load 4D nii file 
            [fileName, pathName] = uigetfile('*.*','Select the 4D image');
            if (fileName==0 & pathName==0)
                disp('4D image file not selected');
            else
                % Load and create image structure
                imgName = [pathName, fileName];
                imgStruct = load_nii(imgName);
                handles.img_4D = imgStruct.img;
                handles.originator = imgStruct.hdr.hist.originator(1:3);
                [p,f,e] = fileparts(imgName);
                handles.baseName = f;
                handles.imgVoxDim = imgStruct.hdr.dime.pixdim(2:4);
                disp('Loaded 4D image and created image structure');
            end
        end
    end
    guidata(hObject,handles);
    disp('Done reading input images');

% Function to choose output directory
function pb_outputDir_Callback(hObject, eventdata, handles)
    opFolder = uigetdir;
    if isempty(opFolder)
        disp('Please select an output directory');
        msgbox('No Output Directory selected','Error Message');
    end
    handles.opFolder = opFolder;
    guidata(hObject, handles);

% Function to select brain mask
function pb_brainMask_Callback(hObject, eventdata, handles)
    [fileName, pathName] = uigetfile('*.*','Select the brain mask');
    if (fileName==0 & pathName==0)
        disp('Brain mask not selected');
        msgbox('Brain Mask was not selected','Error Message');
    else
        mask_file = [pathName, fileName];
        mask = load_nii(mask_file);
        if (size(mask.img) ~= size(handles.img_4D(:,:,:,1)))
            msgbox('Mask and Input image dimensions do not match');
        else
            handles.brainMask = mask.img;
            guidata(hObject, handles);
            disp('Brain mask loaded successfully');
        end
    end

% Function to call verifyOrientation
function pb_verifyOrientation_Callback(hObject, eventdata, handles)
    mask = verifyImgOri(handles.img_4D(:,:,:,1),handles.brainMask);
    handles.brainMask = mask;
    guidata(hObject,handles);

% Function for Lempel Ziv Complexity call
function lempel_ziv_call(handles, mask, r_start, r_end, scale)
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
        opFname = [handles.opFolder, filesep, handles.baseName, 'LempelZiv','_r',num2str(r),'.nii']
        niiStruct = make_nii(lempelZivResult, handles.imgVoxDim, [], 64, []);
        niiStruct.hdr.hk.data_type = 'float64';
        niiStruct.hdr.hist.originator(1:3) = handles.originator;
        save_nii(niiStruct, opFname, []);      
        msg = ['Calculation complete for Lempel Ziv: r=', num2str(r)];  
        disp(msg);
    end

    
function hurst_ex_call(handles, mask,r_start,r_end,scale)
    imgSize = size(mask);
    brainVox = find(mask == max(mask(:)));

    loopValues = r_start:scale:r_end;
    parfor idx = 1:numel(loopValues)
        r = loopValues(idx);
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
        opFname = [handles.opFolder, filesep, handles.baseName, 'Hurst_Ex','_r',num2str(r),'.nii']
        niiStruct = make_nii(Hurst_Ex, handles.imgVoxDim, [], 64, []);
        niiStruct.hdr.hk.data_type = 'float64';
        niiStruct.hdr.hist.originator(1:3) = handles.originator;
        save_nii(niiStruct, opFname, []);
        msg = ['Calculation completed for Hurst Exponent: r=', num2str(r)];
        disp(msg);
    end

function frac_dim_call(handles, mask, k_start, k_end, scale)
    imgSize = size(mask);
    brainVox = find(mask == max(mask(:)));
    loopValues = k_start:scale:k_end;
    parfor idx = 1:numel(loopValues)
        k = loopValues(idx);
        msg = ['calculating Higuchi Fractal Dimension: k=', num2str(k)];
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
        opFname = [handles.opFolder, filesep, handles.baseName, 'FracDim_k', ...
            num2str(k),'.nii'];
        niiStruct = make_nii(FracDim, handles.imgVoxDim, [], 64, []);
        niiStruct.hdr.hk.data_type = 'float64';
        niiStruct.hdr.hist.originator(1:3) = handles.originator;
        save_nii(niiStruct, opFname, []);
        msg = ['Calculation completed for Higuchi Fractal Dimension: k=', num2str(k)];
        disp(msg);
    end

function ap_en_call(handles, mask, m_start, m_end, r_start, r_end, m_scale, r_scale)
    imgSize = size(mask);
    brainVox = find(mask == max(mask(:)));
    
    mLoopValues = m_start:m_scale:m_end;
    rLoopValues = r_start:r_scale:r_end; 
    [X,Y] = meshgrid(mLoopValues,rLoopValues);
    loopGrid = [X(:) Y(:)];

    parfor paramIdx=1:length(loopGrid)
        m = loopGrid(paramIdx,1);
        r = loopGrid(paramIdx,2);
        
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
        opFname = [handles.opFolder, filesep, handles.baseName, 'ApEn_m', ...
            num2str(m), '_r', num2str(r*100), 'per','.nii'];
        niiStruct = make_nii(ApEn, handles.imgVoxDim, [], 64, []);
        niiStruct.hdr.hk.data_type = 'float64';
        save_nii(niiStruct, opFname, []);
        msg = ['Calculation completed for self ApEn: m=',num2str(m),',r=',num2str(r)];
        disp(msg);
    end

function samp_en_call(handles, mask, m_start, m_end, r_start, r_end, m_scale, r_scale)
    imgSize = size(mask);
    brainVox = find(mask == max(mask(:)));
    mLoopValues = m_start:m_scale:m_end;
    rLoopValues = r_start:r_scale:r_end; 
    [X,Y] = meshgrid(mLoopValues,rLoopValues);
    loopGrid = [X(:) Y(:)];

    parfor paramIdx=1:length(loopGrid)
        m = loopGrid(paramIdx,1);
        r = loopGrid(paramIdx,2);
        
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
        msg = ['Calculation completed for self SampEn: m=',num2str(m),',r=',num2str(r)];
        disp(msg);
    end

function perm_en_call(handles, mask, ord_start, ord_end, delay_start, delay_end, ord_scale, delay_scale, normalize)
    imgSize = size(mask);
    brainVox = find(mask == max(mask(:)));
    orderLoopValues = ord_start:ord_scale:ord_end;
    delayLoopValues = delay_start:delay_scale:delay_end; 
    [X,Y] = meshgrid(orderLoopValues,delayLoopValues);
    loopGrid = [X(:) Y(:)];

    parfor paramIdx=1:length(loopGrid)
        order = loopGrid(paramIdx,1);
        delay = loopGrid(paramIdx,2);
        PermEn = zeros(imgSize);
        msg = ['calculating self PermEn: order=', num2str(order), ',delay=', num2str(delay)];
        disp(msg);
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
        msg = ['Calculation completed for self PermEn: order=', num2str(order), ',delay=', num2str(delay)];
        disp(msg);
    end

function fuzzy_en_call(handles, mask, m_start, m_end, r_start, r_end, m_scale, r_scale,n,t)
    imgSize = size(mask);
    brainVox = find(mask == max(mask(:)));
    mLoopValues = m_start:m_scale:m_end;
    rLoopValues = r_start:r_scale:r_end; 
    [X,Y] = meshgrid(mLoopValues,rLoopValues);
    loopGrid = [X(:) Y(:)];

    parfor paramIdx=1:length(loopGrid)
        m = loopGrid(paramIdx,1);
        r = loopGrid(paramIdx,2);
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
        opFname = [handles.opFolder, filesep, handles.baseName, 'FuzzyEn_m', ...
            num2str(m), '_r', num2str(r*100), 'per','.nii'];
        niiStruct = make_nii(FuzzEn, handles.imgVoxDim, [], 64, []);
        niiStruct.hdr.hk.data_type = 'float64';
        save_nii(niiStruct, opFname, []);
        msg = ['Calculation completed for FuzzyEn: m=',num2str(m),',r=',num2str(r)];
        disp(msg);
    end

function pb_run_Callback(hObject, eventdata, handles)
    if sum(strcmp(fieldnames(handles),'img_4D'))==0
        disp('Input not selected');
        msgbox('Input Directory was not selected','Error Message');
        return
    end 
    if sum(strcmp(fieldnames(handles),'brainMask'))==0
        disp('Brain mask not selected');
        msgbox('Brain Mask was not selected','Error Message');
        return
    end

    if sum(strcmp(fieldnames(handles),'opFolder'))==0
        disp('Output Folder not selected');
        msgbox('Please select an Output Directory','Error Message');
        return
    end
    if handles.lempelZiv
        if sum(strcmp(fieldnames(handles),'lempelZiv_r_start'))==0 
            disp('LempelZiv: r_start not selected');
            msgbox('Please enter the value of r_start for Lempel-Ziv','Error Message');
            return
        end
        if sum(strcmp(fieldnames(handles),'lempelZiv_r_end'))==0 
            disp('LempelZiv: r_end not selected');
            msgbox('Please enter the value of r_end for Lempel-Ziv','Error Message');
            return
        end
        if sum(strcmp(fieldnames(handles),'lempelZiv_scale_start'))==0 
            disp('LempelZiv: scale_start not selected');
            msgbox('Please enter the value of scale_start for Lempel-Ziv','Error Message');
            return
        end
   
        lempel_ziv_call(handles, handles.brainMask,handles.lempelZiv_r_start, handles.lempelZiv_r_end, handles.lempelZiv_scale_start);
    end
    if handles.hurstExp
        % if sum(strcmp(fieldnames(handles),'hurstExp_m_start'))==0 
        %     disp('HurstExp: m_start not selected');
        %     msgbox('Please enter the value of m_start for HurstExp','Error Message');
        %     return
        % end
        % if sum(strcmp(fieldnames(handles),'hurstExp_m_end'))==0 
        %     disp('HurstExp: m_end not selected');
        %     msgbox('Please enter the value of m_end for HurstExp','Error Message');
        %     return
        % end
        if sum(strcmp(fieldnames(handles),'hurstExp_r_start'))==0 
            disp('HurstExp: r_start not selected');
            msgbox('Please enter the value of r_start for HurstExp','Error Message');
            return
        end 
        if sum(strcmp(fieldnames(handles),'hurstExp_r_end'))==0 
            disp('HurstExp: r_end not selected');
            msgbox('Please enter the value of r_end for HurstExp','Error Message');
            return
        end
        if sum(strcmp(fieldnames(handles),'hurstExp_scale_start'))==0 
            disp('HurstExp: r_scale not selected');
            msgbox('Please enter the value of r_scale for HurstExp','Error Message');
            return
        end 
        % if sum(strcmp(fieldnames(handles),'hurstExp_scale_end'))==0 
        %     disp('HurstExp: m_scale not selected');
        %     msgbox('Please enter the value of m_scale for HurstExp','Error Message');
        %     return
        % end

        hurst_ex_call(handles, handles.brainMask,handles.hurstExp_r_start,handles.hurstExp_r_end,handles.hurstExp_scale_start);
    end
    if handles.LLExp
        if sum(strcmp(fieldnames(handles),'LLExp_m_start'))==0 
            disp('LLExp: m_start not selected');
            msgbox('Please enter the value of m_start for LLExp','Error Message');
            return
        end
        if sum(strcmp(fieldnames(handles),'LLExp_m_end'))==0 
            disp('LLExp: m_end not selected');
            msgbox('Please enter the value of m_end for LLExp','Error Message');
            return
        end
        if sum(strcmp(fieldnames(handles),'LLExp_r_start'))==0 
            disp('LLExp: r_start not selected');
            msgbox('Please enter the value of r_start for LLExp','Error Message');
            return
        end 
        if sum(strcmp(fieldnames(handles),'LLExp_r_end'))==0 
            disp('LLExp: r_end not selected');
            msgbox('Please enter the value of r_end for LLExp','Error Message');
            return
        end
        if sum(strcmp(fieldnames(handles),'LLExp_scale_start'))==0 
            disp('LLExp: m_scale not selected');
            msgbox('Please enter the value of m_scale for LLExp','Error Message');
            return
        end 
        if sum(strcmp(fieldnames(handles),'LLExp_scale_end'))==0 
            disp('LLExp: r_scale not selected');
            msgbox('Please enter the value of r_scale for LLExp','Error Message');
            return
        end
        disp('Lyapunov Exponent not implemented/found!');
    end
    if handles.fracDim
        if sum(strcmp(fieldnames(handles),'fracDim_k_start'))==0 
            disp('fracDim: k_start not selected');
            msgbox('Please enter the value of k_start for fracDim','Error Message');
            return
        end
        if sum(strcmp(fieldnames(handles),'fracDim_k_end'))==0 
            disp('fracDim: k_end not selected');
            msgbox('Please enter the value of k_end for fracDim','Error Message');
            return
        end
        if sum(strcmp(fieldnames(handles),'fracDim_scale_start'))==0 
            disp('fracDim: k_scale not selected');
            msgbox('Please enter the value of k_scale for fracDim','Error Message');
            return
        end 
        
        frac_dim_call(handles, handles.brainMask, handles.fracDim_k_start, handles.fracDim_k_end, handles.fracDim_scale_start);
    end
    if handles.apEn
        if sum(strcmp(fieldnames(handles),'apEn_m_start'))==0 
            disp('apEn: m_start not selected');
            msgbox('Please enter the value of m_start for apEn','Error Message');
            return
        end
        if sum(strcmp(fieldnames(handles),'apEn_m_end'))==0 
            disp('apEn: m_end not selected');
            msgbox('Please enter the value of m_end for apEn','Error Message');
            return
        end
        if sum(strcmp(fieldnames(handles),'apEn_r_start'))==0 
            disp('apEn: r_start not selected');
            msgbox('Please enter the value of r_start for apEn','Error Message');
            return
        end 
        if sum(strcmp(fieldnames(handles),'apEn_r_end'))==0 
            disp('apEn: r_end not selected');
            msgbox('Please enter the value of r_end for apEn','Error Message');
            return
        end
        if sum(strcmp(fieldnames(handles),'apEn_scale_start'))==0 
            disp('apEn: m_scale not selected');
            msgbox('Please enter the value of m_scale for apEn','Error Message');
            return
        end 
        if sum(strcmp(fieldnames(handles),'apEn_scale_end'))==0 
            disp('apEn: r_scale not selected');
            msgbox('Please enter the value of r_scale for apEn','Error Message');
            return
        end

        ap_en_call(handles, handles.brainMask, handles.apEn_m_start, handles.apEn_m_end, handles.apEn_r_start, handles.apEn_r_end, handles.apEn_scale_start, handles.apEn_scale_end);
    end
    if handles.sampEn
        if sum(strcmp(fieldnames(handles),'sampEn_m_start'))==0 
            disp('sampEn: m_start not selected');
            msgbox('Please enter the value of m_start for sampEn','Error Message');
            return
        end
        if sum(strcmp(fieldnames(handles),'sampEn_m_end'))==0 
            disp('sampEn: m_end not selected');
            msgbox('Please enter the value of m_end for sampEn','Error Message');
            return
        end
        if sum(strcmp(fieldnames(handles),'sampEn_r_start'))==0 
            disp('sampEn: r_start not selected');
            msgbox('Please enter the value of r_start for sampEn','Error Message');
            return
        end 
        if sum(strcmp(fieldnames(handles),'sampEn_r_end'))==0 
            disp('sampEn: r_end not selected');
            msgbox('Please enter the value of r_end for sampEn','Error Message');
            return
        end
        if sum(strcmp(fieldnames(handles),'sampEn_scale_start'))==0 
            disp('sampEn: m_scale not selected');
            msgbox('Please enter the value of m_scale for sampEn','Error Message');
            return
        end 
        if sum(strcmp(fieldnames(handles),'sampEn_scale_end'))==0 
            disp('sampEn: r_scale not selected');
            msgbox('Please enter the value of r_scale for sampEn','Error Message');
            return
        end
        samp_en_call(handles, handles.brainMask, handles.sampEn_m_start, handles.sampEn_m_end, handles.sampEn_r_start, handles.sampEn_r_end, handles.sampEn_scale_start, handles.sampEn_scale_end);
    end
    if handles.waveletMSE
        if sum(strcmp(fieldnames(handles),'waveletMSE_m_start'))==0 
            disp('waveletMSE: m_start not selected');
            msgbox('Please enter the value of m_start for waveletMSE','Error Message');
            return
        end
        if sum(strcmp(fieldnames(handles),'waveletMSE_m_end'))==0 
            disp('waveletMSE: m_end not selected');
            msgbox('Please enter the value of m_end for waveletMSE','Error Message');
            return
        end
        if sum(strcmp(fieldnames(handles),'waveletMSE_r_start'))==0 
            disp('waveletMSE: r_start not selected');
            msgbox('Please enter the value of r_start for waveletMSE','Error Message');
            return
        end 
        if sum(strcmp(fieldnames(handles),'waveletMSE_r_end'))==0 
            disp('waveletMSE: r_end not selected');
            msgbox('Please enter the value of r_end for waveletMSE','Error Message');
            return
        end
        if sum(strcmp(fieldnames(handles),'waveletMSE_scale_start'))==0 
            disp('waveletMSE: m_scale not selected');
            msgbox('Please enter the value of m_scale for waveletMSE','Error Message');
            return
        end 
        if sum(strcmp(fieldnames(handles),'waveletMSE_scale_end'))==0 
            disp('waveletMSE: r_scale not selected');
            msgbox('Please enter the value of r_scale for waveletMSE','Error Message');
            return
        end
        disp('Wavelet MSE not implemented/found!');
    end
    if handles.fuzzyEn
        if sum(strcmp(fieldnames(handles),'fuzzyEn_m_start'))==0 
            disp('fuzzyEn: m_start not selected');
            msgbox('Please enter the value of m_start for fuzzyEn','Error Message');
            return
        end
        if sum(strcmp(fieldnames(handles),'fuzzyEn_m_end'))==0 
            disp('fuzzyEn: m_end not selected');
            msgbox('Please enter the value of m_end for fuzzyEn','Error Message');
            return
        end
        if sum(strcmp(fieldnames(handles),'fuzzyEn_r_start'))==0 
            disp('fuzzyEn: r_start not selected');
            msgbox('Please enter the value of r_start for fuzzyEn','Error Message');
            return
        end 
        if sum(strcmp(fieldnames(handles),'fuzzyEn_r_end'))==0 
            disp('fuzzyEn: r_end not selected');
            msgbox('Please enter the value of r_end for fuzzyEn','Error Message');
            return
        end
        if sum(strcmp(fieldnames(handles),'fuzzyEn_scale_start'))==0 
            disp('fuzzyEn: m_scale not selected');
            msgbox('Please enter the value of m_scale for fuzzyEn','Error Message');
            return
        end 
        if sum(strcmp(fieldnames(handles),'fuzzyEn_scale_end'))==0 
            disp('fuzzyEn: r_scale not selected');
            msgbox('Please enter the value of r_scale for fuzzyEn','Error Message');
            return
        end
        if sum(strcmp(fieldnames(handles),'fuzzyEn_n_start'))==0 
            disp('fuzzyEn: n not selected');
            msgbox('Please enter the value of n for fuzzyEn','Error Message');
            return
        end 
        if sum(strcmp(fieldnames(handles),'fuzzyEn_tau_start'))==0 
            disp('fuzzyEn: tau not selected');
            msgbox('Please enter the value of tau for fuzzyEn','Error Message');
            return
        end 
        fuzzy_en_call(handles, handles.brainMask, handles.fuzzyEn_m_start, handles.fuzzyEn_m_end, handles.fuzzyEn_r_start, handles.fuzzyEn_r_end, handles.fuzzyEn_scale_start, handles.fuzzyEn_scale_end,handles.fuzzyEn_n_start, handles.fuzzyEn_tau_start);        
    end
    if handles.permEn
        if sum(strcmp(fieldnames(handles),'permEn_ord_start'))==0 
            disp('permEn: ord_start not selected');
            msgbox('Please enter the value of ord_start for permEn','Error Message');
            return
        end
        if sum(strcmp(fieldnames(handles),'permEn_ord_end'))==0 
            disp('permEn: ord_end not selected');
            msgbox('Please enter the value of ord_end for permEn','Error Message');
            return
        end
        if sum(strcmp(fieldnames(handles),'permEn_delay_start'))==0 
            disp('permEn: delay_start not selected');
            msgbox('Please enter the value of delay_start for permEn','Error Message');
            return
        end
        if sum(strcmp(fieldnames(handles),'permEn_delay_end'))==0 
            disp('permEn: delay_end not selected');
            msgbox('Please enter the value of delay_end for permEn','Error Message');
            return
        end
        if sum(strcmp(fieldnames(handles),'permEn_ord_scale'))==0 
            disp('permEn: ord_scale not selected');
            msgbox('Please enter the value of ord_scale for permEn','Error Message');
            return
        end
        if sum(strcmp(fieldnames(handles),'permEn_delay_scale'))==0 
            disp('permEn: delay_scale not selected');
            msgbox('Please enter the value of delay_scale for permEn','Error Message');
            return
        end
        
        if sum(strcmp(fieldnames(handles),'permEn_normalize'))==0 
            disp('permEn: normalize not selected');
            msgbox('Please enter the value of normalize for permEn','Error Message');
            return
        end
        perm_en_call(handles, handles.brainMask, handles.permEn_ord_start, handles.permEn_ord_end, handles.permEn_delay_start, handles.permEn_delay_end, handles.permEn_ord_scale, handles.permEn_delay_scale, handles.permEn_normalize)
    end

function checkbox_lempelZiv_Callback(hObject, eventdata, handles)
    value = get(hObject,'Value');
    handles.lempelZiv = value;
    guidata(hObject, handles);

function checkbox_hurstExp_Callback(hObject, eventdata, handles)
    value = get(hObject,'Value');
    handles.hurstExp = value;
    guidata(hObject, handles);

function checkbox_LLExp_Callback(hObject, eventdata, handles)
    value = get(hObject,'Value');
    handles.LLExp = value;
    guidata(hObject, handles);

function checkbox_fracDim_Callback(hObject, eventdata, handles)
    value = get(hObject,'Value');
    handles.fracDim = value;
    guidata(hObject, handles);

function checkbox_apEn_Callback(hObject, eventdata, handles)
    value = get(hObject,'Value');
    handles.apEn = value;
    guidata(hObject, handles);

function checkbox_sampEn_Callback(hObject, eventdata, handles)
    value = get(hObject,'Value');
    handles.sampEn = value;
    guidata(hObject, handles);

function checkbox_waveletMSE_Callback(hObject, eventdata, handles)
    value = get(hObject,'Value');
    handles.waveletMSE = value;
    guidata(hObject, handles);

function checkbox_fuzzyEn_Callback(hObject, eventdata, handles)
    value = get(hObject,'Value');
    handles.fuzzyEn = value;
    guidata(hObject, handles);

function checkbox_permEn_Callback(hObject, eventdata, handles)
    value = get(hObject,'Value');
    handles.permEn = value;
    guidata(hObject, handles);

function edit_lempelZiv_m_start_Callback(hObject, eventdata, handles)
    m_start = get(hObject,'String');
    m_start = str2num(m_start);
    handles.lempelZiv_m_start = m_start;
    guidata(hObject, handles);

function edit_lempelZiv_m_start_CreateFcn(hObject, eventdata, handles)
    set(hObject,'TooltipString','For LempelZiv, recomended value for m: 1-5')
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

    guidata(hObject,handles);

function edit_hurstExp_m_start_Callback(hObject, eventdata, handles)
    m_start = get(hObject,'String');
    m_start = str2num(m_start);
    handles.hurstExp_m_start = m_start;
    guidata(hObject, handles);

function edit_hurstExp_m_start_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject,'TooltipString','For Hurst Exponent, recomended value for r: 1-5')
    guidata(hObject,handles);

function edit_LLExp_m_start_Callback(hObject, eventdata, handles)
    m_start = get(hObject,'String');
    m_start = str2num(m_start);
    handles.LLExp_m_start = m_start;
    guidata(hObject, handles);

function edit_LLExp_m_start_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject,'TooltipString','For Largest Lyapunov Exponent, recomended value for m: 1-5')
    guidata(hObject,handles);

function edit_fracDim_m_start_Callback(hObject, eventdata, handles)
    m_start = get(hObject,'String');
    m_start = str2num(m_start);
    handles.fracDim_m_start = m_start;
    guidata(hObject, handles);

function edit_fracDim_m_start_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject,'TooltipString','For Higuchi Fractal Dimension, recomended value for m: 1-5')
    guidata(hObject,handles);

function edit_apEn_m_start_Callback(hObject, eventdata, handles)
    m_start = get(hObject,'String');
    m_start = str2num(m_start);
    handles.apEn_m_start = m_start;
    guidata(hObject, handles);

function edit_apEn_m_start_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

    set(hObject,'TooltipString','For Approx Entropy, recomended value for m: 1-5');
    guidata(hObject,handles);

function edit_sampEn_m_start_Callback(hObject, eventdata, handles)
    m_start = get(hObject,'String');
    m_start = str2num(m_start);
    handles.sampEn_m_start = m_start;
    guidata(hObject, handles);

function edit_sampEn_m_start_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject,'TooltipString','For Sample Entropy, recomended value for m: 1-5')
    guidata(hObject,handles);

function edit_waveletMSE_m_start_Callback(hObject, eventdata, handles)
    m_start = get(hObject,'String');
    m_start = str2num(m_start);
    handles.waveletMSE_m_start = m_start;
    guidata(hObject, handles);

function edit_waveletMSE_m_start_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject,'TooltipString','For Wavelength MSE, recomended value for m: 1-5')
    guidata(hObject,handles);

function edit_fuzzyEn_m_start_Callback(hObject, eventdata, handles)
    m_start = get(hObject,'String');
    m_start = str2num(m_start);
    handles.fuzzyEn_m_start = m_start;
    guidata(hObject, handles);

function edit_fuzzyEn_m_start_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject,'TooltipString','For Fuzzy Entropy, recomended value for m: 1-5')
    guidata(hObject,handles);

function edit_permEn_m_start_Callback(hObject, eventdata, handles)
    m_start = get(hObject,'String');
    m_start = str2num(m_start);
    handles.permEn_m_start = m_start;
    guidata(hObject, handles);

function edit_permEn_m_start_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject,'TooltipString','For Permutation Entropy, recomended value for m: 1-5')
    guidata(hObject,handles);

function edit_lempelZiv_m_end_Callback(hObject, eventdata, handles)
    m_end = get(hObject,'String');
    m_end = str2num(m_end);
    handles.lempelZiv_m_end = m_end;
    guidata(hObject, handles);

function edit_lempelZiv_m_end_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject,'TooltipString','For Lempel-Ziv,recomended value for m: 1-5')
    guidata(hObject,handles);

function edit_hurstExp_m_end_Callback(hObject, eventdata, handles)
    m_end = get(hObject,'String');
    m_end = str2num(m_end);
    handles.hurstExp_m_end = m_end;
    guidata(hObject, handles);

function edit_hurstExp_m_end_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject,'TooltipString','For Hurst, recomended value for m: 1-5')
    guidata(hObject,handles);

function edit_LLExp_m_end_Callback(hObject, eventdata, handles)
    m_end = get(hObject,'String');
    m_end = str2num(m_end);
    handles.LLExp_m_end = m_end;
    guidata(hObject, handles);

function edit_LLExp_m_end_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject,'TooltipString','For Largest Lyapunov Exponent, recomended value for m: 1-5')
    guidata(hObject,handles);

function edit_fracDim_m_end_Callback(hObject, eventdata, handles)
    m_end = get(hObject,'String');
    m_end = str2num(m_end);
    handles.fracDim_m_end = m_end;
    guidata(hObject, handles);

function edit_fracDim_m_end_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject,'TooltipString','For Higuchi Fractal Diminsion,recomended value 1-5')
    guidata(hObject,handles);

function edit_apEn_m_end_Callback(hObject, eventdata, handles)
    m_end = get(hObject,'String');
    m_end = str2num(m_end);
    handles.apEn_m_end = m_end;
    guidata(hObject, handles);

function edit_apEn_m_end_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject,'TooltipString','For Approx Entropy, recomended value for m: 1-5')
    guidata(hObject,handles);

function edit_sampEn_m_end_Callback(hObject, eventdata, handles)
    m_end = get(hObject,'String');
    m_end = str2num(m_end);
    handles.sampEn_m_end = m_end;
    guidata(hObject, handles);

function edit_sampEn_m_end_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject,'TooltipString','For Sample Entropy, recomended value for m: 1-5')
    guidata(hObject,handles);

function edit_waveletMSE_m_end_Callback(hObject, eventdata, handles)
    m_end = get(hObject,'String');
    m_end = str2num(m_end);
    handles.waveletMSE_m_end = m_end;
    guidata(hObject, handles);

function edit_waveletMSE_m_end_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject,'TooltipString','For Wavelength MSE, recomended value for m: 1-5')
    guidata(hObject,handles);

function edit_fuzzyEn_m_end_Callback(hObject, eventdata, handles)
    m_end = get(hObject,'String');
    m_end = str2num(m_end);
    handles.fuzzyEn_m_end = m_end;
    guidata(hObject, handles);

function edit_fuzzyEn_m_end_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject,'TooltipString','For Fuzzy Entropy, recomended value for m: 1-5')
    guidata(hObject,handles);

function edit_permEn_m_end_Callback(hObject, eventdata, handles)
    m_end = get(hObject,'String');
    m_end = str2num(m_end);
    handles.permEn_m_end = m_end;
    guidata(hObject, handles);

function edit_permEn_m_end_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject,'TooltipString','For Permutation Entropy, recomended value for m: 1-5')
    guidata(hObject,handles);

function edit_lempelZiv_r_start_Callback(hObject, eventdata, handles)
    r_start = get(hObject,'String');
    r_start = str2num(r_start);
    handles.lempelZiv_r_start = r_start;
    guidata(hObject, handles);

function edit_lempelZiv_r_start_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject,'TooltipString','For Lempel-Ziv, recomended value for r: 0.2-0.5')
    guidata(hObject,handles);

function edit_hurstExp_r_start_Callback(hObject, eventdata, handles)
    r_start = get(hObject,'String');
    r_start = str2num(r_start);
    handles.hurstExp_r_start = r_start;
    guidata(hObject, handles);

function edit_hurstExp_r_start_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject,'TooltipString','For Hurst Exponent, recomended value of r: 0.2-0.5')
    guidata(hObject,handles);

function edit_LLExp_r_start_Callback(hObject, eventdata, handles)
    r_start = get(hObject,'String');
    r_start = str2num(r_start);
    handles.LLExp_r_start = r_start;
    guidata(hObject, handles);

function edit_LLExp_r_start_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject,'TooltipString','For Largest Lyapunov Exponent, recomended value for r: 0.2-0.5')
    guidata(hObject,handles);

function edit_fracDim_r_start_Callback(hObject, eventdata, handles)
    r_start = get(hObject,'String');
    r_start = str2num(r_start);
    handles.fracDim_r_start = r_start;
    guidata(hObject, handles);

function edit_fracDim_r_start_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject,'TooltipString','For Higuchi Fractal Dimension, recomended value for r: 0.2-0.5')
    guidata(hObject,handles);

function edit_apEn_r_start_Callback(hObject, eventdata, handles)
    r_start = get(hObject,'String');
    r_start = str2num(r_start);
    handles.apEn_r_start = r_start;
    guidata(hObject, handles);

function edit_apEn_r_start_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject,'TooltipString','For Approx Entropy, recomended value for r: 0.2-0.5')
    guidata(hObject,handles);

function edit_sampEn_r_start_Callback(hObject, eventdata, handles)
    r_start = get(hObject,'String');
    r_start = str2num(r_start);
    handles.sampEn_r_start = r_start;
    guidata(hObject, handles);

function edit_sampEn_r_start_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject,'TooltipString','For Sample Entropy, recomended value for r: 0.2-0.5')
    guidata(hObject,handles);

function edit_waveletMSE_r_start_Callback(hObject, eventdata, handles)
    r_start = get(hObject,'String');
    r_start = str2num(r_start);
    handles.waveletMSE_r_start = r_start;
    guidata(hObject, handles);

function edit_waveletMSE_r_start_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject,'TooltipString','For Wavelength MSE, recomended value for r:0.2-0.5')
    guidata(hObject,handles);

function edit_fuzzyEn_r_start_Callback(hObject, eventdata, handles)
    r_start = get(hObject,'String');
    r_start = str2num(r_start);
    handles.fuzzyEn_r_start = r_start;
    guidata(hObject, handles);

function edit_fuzzyEn_r_start_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject,'TooltipString','For Fuzzy Entropy, recomended value for r: 0.2-0.5')
    guidata(hObject,handles);

function edit_permEn_r_start_Callback(hObject, eventdata, handles)
    r_start = get(hObject,'String');
    r_start = str2num(r_start);
    handles.permEn_r_start = r_start;
    guidata(hObject, handles);

function edit_permEn_r_start_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject,'TooltipString','For Permutation Entropy, recomended value for r: 0.2-0.5')
    guidata(hObject,handles);

function edit_lempelZiv_r_end_Callback(hObject, eventdata, handles)
    r_end = get(hObject,'String');
    r_end = str2num(r_end);
    handles.lempelZiv_r_end = r_end;
    guidata(hObject, handles);

function edit_lempelZiv_r_end_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject,'TooltipString','For Lempel-Ziv, recomended value for r: 0.2-0.5')
    guidata(hObject,handles);

function edit_hurstExp_r_end_Callback(hObject, eventdata, handles)
    r_end = get(hObject,'String');
    r_end = str2num(r_end);
    handles.hurstExp_r_end = r_end;
    guidata(hObject, handles);

function edit_hurstExp_r_end_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject,'TooltipString','For Hurst Exponent, recomended value for r: 0.2-0.5')
    guidata(hObject,handles);

function edit_LLExp_r_end_Callback(hObject, eventdata, handles)
    r_end = get(hObject,'String');
    r_end = str2num(r_end);
    handles.LLExp_r_end = r_end;
    guidata(hObject, handles);

function edit_LLExp_r_end_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject,'TooltipString','For Largest Lyapunov Exponent, recomended value for r: 0.2-0.5')
    guidata(hObject,handles);

function edit_fracDim_r_end_Callback(hObject, eventdata, handles)
    r_end = get(hObject,'String');
    r_end = str2num(r_end);
    handles.fracDim_r_end = r_end;
    guidata(hObject, handles);

function edit_fracDim_r_end_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject,'TooltipString','For Higuchi Fractal Dimension, recomended value for r: 0.2-0.5')
    guidata(hObject,handles);

function edit_apEn_r_end_Callback(hObject, eventdata, handles)
    r_end = get(hObject,'String');
    r_end = str2num(r_end);
    handles.apEn_r_end = r_end;
    guidata(hObject, handles);

function edit_apEn_r_end_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject,'TooltipString','For Approx Entropy, recomended value for r: 0.2-0.5')
    guidata(hObject,handles);

function edit_sampEn_r_end_Callback(hObject, eventdata, handles)
    r_end = get(hObject,'String');
    r_end = str2num(r_end);
    handles.sampEn_r_end = r_end;
    guidata(hObject, handles);

function edit_sampEn_r_end_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject,'TooltipString','For Sample Entropy, recomended value for r: 0.2-0.5')
    guidata(hObject,handles);

function edit_waveletMSE_r_end_Callback(hObject, eventdata, handles)
    r_end = get(hObject,'String');
    r_end = str2num(r_end);
    handles.waveletMSE_r_end = r_end;
    guidata(hObject, handles);

function edit_waveletMSE_r_end_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject,'TooltipString','For Wavelength MSE, recomended value for r: 0.2-0.5')
    guidata(hObject,handles);

function edit_fuzzyEn_r_end_Callback(hObject, eventdata, handles)
    r_end = get(hObject,'String');
    r_end = str2num(r_end);
    handles.fuzzyEn_r_end = r_end;
    guidata(hObject, handles);

function edit_fuzzyEn_r_end_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject,'TooltipString','For Fuzzy Entropy, recomended value for r: 0.2-0.5')
    guidata(hObject,handles);

function edit_permEn_r_end_Callback(hObject, eventdata, handles)
    r_end = get(hObject,'String');
    r_end = str2num(r_end);
    handles.permEn_r_end = r_end;
    guidata(hObject, handles);

function edit_permEn_r_end_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject,'TooltipString','For Permutation Entropy, recomended value for r: 0.2-0.5')
    guidata(hObject,handles);

function edit_lempelZiv_scale_start_Callback(hObject, eventdata, handles)
    scale_start = get(hObject,'String');
    scale_start = str2num(scale_start);
    handles.lempelZiv_scale_start = scale_start;
    guidata(hObject, handles);

function edit_lempelZiv_scale_start_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function edit_hurstExp_scale_start_Callback(hObject, eventdata, handles)
    scale_start = get(hObject,'String');
    scale_start = str2num(scale_start);
    handles.hurstExp_scale_start = scale_start;
    guidata(hObject, handles);

function edit_hurstExp_scale_start_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function edit_LLExp_scale_start_Callback(hObject, eventdata, handles)
    scale_start = get(hObject,'String');
    scale_start = str2num(scale_start);
    handles.LLExp_scale_start = scale_start;
    guidata(hObject, handles);

function edit_LLExp_scale_start_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function edit_fracDim_scale_start_Callback(hObject, eventdata, handles)
    scale_start = get(hObject,'String');
    scale_start = str2num(scale_start);
    handles.fracDim_scale_start = scale_start;
    guidata(hObject, handles);

function edit_fracDim_scale_start_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function edit_apEn_scale_start_Callback(hObject, eventdata, handles)
    scale_start = get(hObject,'String');
    scale_start = str2num(scale_start);
    handles.apEn_scale_start = scale_start;
    guidata(hObject, handles);

function edit_apEn_scale_start_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function edit_sampEn_scale_start_Callback(hObject, eventdata, handles)
    scale_start = get(hObject,'String');
    scale_start = str2num(scale_start);
    handles.sampEn_scale_start = scale_start;
    guidata(hObject, handles);

function edit_sampEn_scale_start_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function edit_waveletMSE_scale_start_Callback(hObject, eventdata, handles)
    scale_start = get(hObject,'String');
    scale_start = str2num(scale_start);
    handles.waveletMSE_scale_start = scale_start;
    guidata(hObject, handles);

function edit_waveletMSE_scale_start_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function edit_fuzzyEn_scale_start_Callback(hObject, eventdata, handles)
    scale_start = get(hObject,'String');
    scale_start = str2num(scale_start);
    handles.fuzzyEn_scale_start = scale_start;
    guidata(hObject, handles);

function edit_fuzzyEn_scale_start_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function edit_permEn_scale_start_Callback(hObject, eventdata, handles)
    scale_start = get(hObject,'String');
    scale_start = str2num(scale_start);
    handles.permEn_ord_scale = scale_start;
    guidata(hObject, handles);

function edit_permEn_scale_start_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function edit_lempelZiv_scale_end_Callback(hObject, eventdata, handles)
    scale_end = get(hObject,'String');
    scale_end = str2num(scale_end);
    handles.lempelZiv_scale_end = scale_end;
    guidata(hObject, handles);

function edit_lempelZiv_scale_end_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function edit_hurstExp_scale_end_Callback(hObject, eventdata, handles)
    scale_end = get(hObject,'String');
    scale_end = str2num(scale_end);
    handles.hurstExp_scale_end = scale_end;
    guidata(hObject, handles);

function edit_hurstExp_scale_end_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function edit_LLExp_scale_end_Callback(hObject, eventdata, handles)
    scale_end = get(hObject,'String');
    scale_end = str2num(scale_end);
    handles.LLExp_scale_end = scale_end;
    guidata(hObject, handles);

function edit_LLExp_scale_end_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function edit_fracDim_scale_end_Callback(hObject, eventdata, handles)
    scale_end = get(hObject,'String');
    scale_end = str2num(scale_end);
    handles.fracDim_scale_end = scale_end;
    guidata(hObject, handles);

function edit_fracDim_scale_end_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function edit_apEn_scale_end_Callback(hObject, eventdata, handles)
    scale_end = get(hObject,'String');
    scale_end = str2num(scale_end);
    handles.apEn_scale_end = scale_end;
    guidata(hObject, handles);

function edit_apEn_scale_end_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function edit_sampEn_scale_end_Callback(hObject, eventdata, handles)
    scale_end = get(hObject,'String');
    scale_end = str2num(scale_end);
    handles.sampEn_scale_end = scale_end;
    guidata(hObject, handles);

function edit_sampEn_scale_end_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function edit_waveletMSE_scale_end_Callback(hObject, eventdata, handles)
    scale_end = get(hObject,'String');
    scale_end = str2num(scale_end);
    handles.waveletMSE_scale_end = scale_end;
    guidata(hObject, handles);

function edit_waveletMSE_scale_end_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function edit_fuzzyEn_scale_end_Callback(hObject, eventdata, handles)
    scale_end = get(hObject,'String');
    scale_end = str2num(scale_end);
    handles.fuzzyEn_scale_end = scale_end;
    guidata(hObject, handles);

function edit_fuzzyEn_scale_end_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function edit_permEn_scale_end_Callback(hObject, eventdata, handles)
    scale_end = get(hObject,'String');
    scale_end = str2num(scale_end);
    handles.permEn_delay_scale = scale_end;
    guidata(hObject, handles);

function edit_permEn_scale_end_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function edit_fracDim_k_start_Callback(hObject, eventdata, handles)
    k_start = get(hObject,'String');
    k_start = str2num(k_start);
    handles.fracDim_k_start = k_start;
    guidata(hObject, handles);

function edit_fracDim_k_start_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject,'TooltipString','For Higuchi Fractal Dimenton,recomended value for k:3-5')
    guidata(hObject,handles);

function edit_fracDim_k_end_Callback(hObject, eventdata, handles)
    k_end = get(hObject,'String');
    k_end = str2num(k_end);
    handles.fracDim_k_end = k_end;
    guidata(hObject, handles);

function edit_fracDim_k_end_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject,'TooltipString','For Higuchi Fractal Dimenton,recomended value for k:3-5')
    guidata(hObject,handles);

function edit_fuzzyEn_n_start_Callback(hObject, eventdata, handles)
    n_start = get(hObject,'String');
    n_start = str2num(n_start);
    handles.fuzzyEn_n_start = n_start;
    guidata(hObject, handles);

function edit_fuzzyEn_n_start_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function edit_fuzzyEn_n_end_Callback(hObject, eventdata, handles)
    n_end = get(hObject,'String');
    n_end = str2num(n_end);
    handles.fuzzyEn_n_end = n_end;
    guidata(hObject, handles);

function edit_fuzzyEn_n_end_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function edit_fuzzyEn_tau_start_Callback(hObject, eventdata, handles)
    tau_start = get(hObject,'String');
    tau_start = str2num(tau_start);
    handles.fuzzyEn_tau_start = tau_start;
    guidata(hObject, handles);

function edit_fuzzyEn_tau_start_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function edit_fuzzyEn_tau_end_Callback(hObject, eventdata, handles)
    tau_end = get(hObject,'String');
    tau_end = str2num(tau_end);
    handles.fuzzyEn_tau_end = tau_end;
    guidata(hObject, handles);

function edit_fuzzyEn_tau_end_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function edit_permEn_delay_start_Callback(hObject, eventdata, handles)
    delay_start = get(hObject,'String');
    delay_start = str2num(delay_start);
    handles.permEn_delay_start = delay_start;
    guidata(hObject, handles);

function edit_permEn_delay_start_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function edit_permEn_delay_end_Callback(hObject, eventdata, handles)
    delay_end = get(hObject,'String');
    delay_end = str2num(delay_end);
    handles.permEn_delay_end = delay_end;
    guidata(hObject, handles);

function edit_permEn_delay_end_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function edit_permEn_ord_start_Callback(hObject, eventdata, handles)
    ord_start = get(hObject,'String');
    ord_start = str2num(ord_start);
    handles.permEn_ord_start = ord_start;
    guidata(hObject, handles);

function edit_permEn_ord_start_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function edit_permEn_ord_end_Callback(hObject, eventdata, handles)
    ord_end = get(hObject,'String');
    ord_end = str2num(ord_end);
    handles.permEn_ord_end = ord_end;
    guidata(hObject, handles);

function edit_permEn_ord_end_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function checkbox_permEn_Normalize_Callback(hObject, eventdata, handles)
    norm = get(hObject,'String');
    normalize = str2num(norm);
    handles.permEn_normalize = normalize;
    guidata(hObject, handles);

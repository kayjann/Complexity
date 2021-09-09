% Function to read 4d image data for a given folder
function opStruct = readImages4D(dirName)
    currDir = pwd;

    % Change to provided directory and find relevant file formats
    cd(dirName);
    hdrInDir = dir('*.hdr');
    niiInDir = dir('*.nii');
    gniiInDir = dir('*.nii.gz');
    
    % Switch back to working directory and figure out what type of images using count of each format
    cd(currDir);
    fileExt =[length(hdrInDir)~=0 length(niiInDir)~=0 length(gniiInDir)~=0];

    if (sum(fileExt)==0)
        msgbox('Input images must be in analyze or NIFTI format');
    elseif (sum(fileExt)>1)
        msgbox('All the input images must be in the same format');
    else
        p = find(fileExt==1);
        if (p==1)
            imageNames = hdrInDir;
        elseif (p==2)
            imageNames = niiInDir;
        else
            imageNames = gniiInDir;
        end
    end

    % Load images to img_4D object and show progress bar
    h = waitbar(0,'Reading images');
    nImages = length(imageNames);
    for i = 1:nImages
        fName = [dirName,filesep,imageNames(i).name];
        imgStruct = load_nii(fName);
        img_4D(:,:,:,i) = imgStruct.img;
        waitbar(i/nImages);
    end
    close(h);

    % Construct structure for 4d data op
    [p,f,e] = fileparts(imageNames(1).name);
    opStruct = struct([]);
    opStruct(1).img_4D = img_4D;
    opStruct(1).bName = f;
    opStruct(1).voxDim = imgStruct.hdr.dime.pixdim(2:4);
    opStruct(1).originator = imgStruct.hdr.hist.originator(1:3);
    return


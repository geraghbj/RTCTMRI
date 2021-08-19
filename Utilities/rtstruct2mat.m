function [Mask,list] = rtstruct2mat(rtstruct, nii_reference)
% rtstruct2roi2
%
% Parse RT structure set.
%
% RT structures for single time point data
%
% Inputs:
%
%   rtstruct - dicomrtstruct header
%   nii_reference - nifti header for reference geometry info
%   scale_factor - interpolate final mask
%
% Angus Lau 2019

%====================================================================
% Parse RT structure
%====================================================================
quat2R = nii_viewer('func_handle', 'quat2R');

%%

nii_reference.hdr.quatern_b = nii_reference.hdr.hist.quatern_b;
nii_reference.hdr.quatern_c = nii_reference.hdr.hist.quatern_c;
nii_reference.hdr.quatern_d = nii_reference.hdr.hist.quatern_d;
nii_reference.hdr.pixdim = nii_reference.hdr.dime.pixdim;
nii_reference.hdr.qoffset_x = nii_reference.hdr.hist.qoffset_x;
nii_reference.hdr.qoffset_y = nii_reference.hdr.hist.qoffset_y;
nii_reference.hdr.qoffset_z = nii_reference.hdr.hist.qoffset_z;
nii_reference.hdr.dim = nii_reference.hdr.dime.dim;
R1 = quat2R(nii_reference.hdr);

%%
Mask = struct();
subitem_list = fields(rtstruct.StructureSetROISequence);

list = cell(size(subitem_list));
for ix_subitem = 1:numel(subitem_list)
    
    subitem = subitem_list{ix_subitem};
    ROIName = rtstruct.StructureSetROISequence.(subitem).ROIName;
    % replace spaces with _
    ROIName = strrep(ROIName, ' ', '_');
    
    ROIName = strrep(ROIName, '+', '_');
    ROIName = strrep(ROIName, '.', '_');
    
    list{ix_subitem} = ROIName;
end

%%

for ix_subitem = 1:numel(subitem_list)
    subitem = subitem_list{ix_subitem};
    
    % Check ROI type
    %ROIType = rtstruct.RTROIObservationsSequence.(subitem).RTROIInterpretedType;
    
    if 1 %strcmp(ROIType, 'ORGAN')
        ROIName = rtstruct.StructureSetROISequence.(subitem).ROIName;
        % replace spaces with _
        ROIName = strrep(ROIName, ' ', '_');
        
        ROIName = strrep(ROIName, '+', '_');
        ROIName = strrep(ROIName, '.', '_');
        
        %if strcmp(ROIName,'ctv4a') || strcmp(ROIName,'gtv4a') || strcmp(ROIName,'ctv3a') || strcmp(ROIName,'gtv3a') || strcmp(ROIName,'ctv1a') || strcmp(ROIName,'ctv2a') || strcmp(ROIName,'gtv2a') || strcmp(ROIName,'gtv1a') || strcmp(ROIName,'gtv') || strcmp(ROIName,'ctv') || strcmp(ROIName,'GTV1') || strcmp(ROIName,'GTV') || strcmp(ROIName,'CTV1') || strcmp(ROIName,'CTV') || strcmp(ROIName,'gtv2') || strcmp(ROIName,'ctv2')
        try %#ok<TRYNC>
            ContourSequence = rtstruct.ROIContourSequence.(subitem).ContourSequence;
            
            slice_list = fields(ContourSequence);
            
            mask = false(nii_reference.hdr.dim(2:4));
            nx = size(mask,1);
            
            for ix = 1:numel(slice_list)
                slice = slice_list{ix};
                
                ContourSequenceSlice = ContourSequence.(slice);
                
                if ~isempty(ContourSequenceSlice.ContourData)
                    N = ContourSequenceSlice.NumberOfContourPoints;
                    ContourData = reshape(ContourSequenceSlice.ContourData, [3 N]);
                    ContourData = cat(1, ContourData, ones(1,N));
                    
                    % Negate dimensions 1 and 2 ... orientation issue?
                    ContourData(1:2,:) = -ContourData(1:2,:);
                    
                    mask_coordinates = R1 \ ContourData;
                    
                    % transpose - for matlab
                    mask_coordinates([1 2],:) = mask_coordinates([2 1],:);
                    
                    % alau@sri
                    % Add mask - take care of disconnected mask
                    idx_slice = round(mask_coordinates(3,1) + 1);
                    mask(:,:,idx_slice) = ...
                        mask(:,:,idx_slice) + ...
                        poly2mask(mask_coordinates(1,:), mask_coordinates(2,:), nx,nx);
                end
            end
            if length(ROIName) > 3
                Mask.(ROIName) = mask;
            else
                Mask.([ROIName '1']) = mask;
            end
        end
        %end
    end
end

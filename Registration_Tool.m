function varargout = Registration_Tool(varargin)
% REGISTRATION_TOOL MATLAB code for Registration_Tool.fig
%      REGISTRATION_TOOL, by itself, creates a new REGISTRATION_TOOL or raises the existing
%      singleton*.
%
%      H = REGISTRATION_TOOL returns the handle to a new REGISTRATION_TOOL or the handle to
%      the existing singleton*.
%
%      REGISTRATION_TOOL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REGISTRATION_TOOL.M with the given input arguments.
%
%      REGISTRATION_TOOL('Property','Value',...) creates a new REGISTRATION_TOOL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Registration_Tool_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Registration_Tool_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Registration_Tool

% Last Modified by GUIDE v2.5 18-Aug-2021 14:39:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Registration_Tool_OpeningFcn, ...
                   'gui_OutputFcn',  @Registration_Tool_OutputFcn, ...
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


% --- Executes just before Registration_Tool is made visible.
function Registration_Tool_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Registration_Tool (see VARARGIN)

% Choose default command line output for Registration_Tool
handles.output = hObject;

script_path = which('Registration_Tool');

if ispc
    slashes = regexp(script_path(2:end),'\');
    root_index = slashes(end);
    handles.root_path = script_path(1:root_index);
	handles.utilities_path = [handles.root_path '\Utilities'];
	path(path,genpath(handles.utilities_path));
else
    slashes = regexp(script_path(2:end),'/');
    root_index = slashes(end);
    handles.root_path = script_path(1:root_index);
	handles.utilities_path = [handles.root_path '/Utilities'];
	path(path,genpath(handles.utilities_path));
end

handles.secondary_names = {};
handles.ctreg_entered = 'false';
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Registration_Tool wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Registration_Tool_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% 
% % --- Executes on button press in rootdir_button.
% function rootdir_button_Callback(hObject, eventdata, handles)
% % hObject    handle to rootdir_button (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% handles
% handles.root_path =  uigetdir;
% guidata(hObject,handles);
% handles.root_path_display.String = handles.root_path;
% handles.root_path_display.Visible = 'on';
% handles.set_dicom_label.Visible = 'on';
% handles.set_patient_button.Visible = 'on';


% --- Executes on button press in set_patient_button.
function set_patient_button_Callback(hObject, eventdata, handles)
% hObject    handle to set_patient_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc

handles.name_listbox.String = {''};
handles.selected_strings = {};
handles.series_info = struct();
handles.label_nifti_update.Visible = 'off';
handles.ctreg_label.Visible = 'off';
handles.ctreg_edit_button.Visible = 'off';
handles.accept_ct.Visible = 'off';
handles.mrreg_accept.Visible = 'off';
handles.mrreg_label.Visible = 'off';
handles.mrreg_menu_label.Visible = 'off';
handles.mrreg_menu.Visible = 'off';
handles.mrreg_edit.Visible = 'off';
handles.primary_start_label.Visible = 'off';
handles.secondary_start_label.Visible = 'off';
handles.translation_label.Visible = 'off';
handles.ct_offset_label_X.Visible = 'off';
handles.ct_offset_label_Y.Visible = 'off';
handles.ct_offset_label_Z.Visible = 'off';
handles.ct_input_X.Visible = 'off';
handles.ct_input_Y.Visible = 'off';
handles.ct_input_Z.Visible = 'off';
handles.mr_start_X.Visible = 'off';
handles.mr_start_Y.Visible = 'off';
handles.mr_start_Z.Visible = 'off';
handles.mr_translation_X.Visible = 'off';
handles.mr_translation_Y.Visible = 'off';
handles.mr_translation_Z.Visible = 'off';
handles.reg_mr2ct_button.Enable = 'off';
handles.scan_strings_list.Visible = 'off';
handles.scan_types_list.Visible = 'off';
handles.label_nifti_label.Visible = 'off';
handles.label_nifti_update.Visible = 'off';
handles.redo_labels.Visible = 'off';
handles.convert_update.Visible = 'off';
handles.nifti_convert_label.Visible = 'off';
handles.nifti_convert_button.Visible = 'off';
handles.label_nifti_listbox_command.Visible = 'off';
handles.label_nifti_listbox_command.Visible = 'off';
handles.yes_button.Visible = 'off';
handles.no_button.Visible = 'off';
handles.select_label_button.Visible = 'off';
handles.label_nifti_listbox.Visible = 'off';


try
    
    handles.dicom_folder = uigetdir();
    handles.dicom_folder_label.String = handles.dicom_folder;
    handles.dicom_folder_label.Visible = 'on';
    
    if ispc
        orig_dir = pwd;
        cd(handles.dicom_folder); cd('..\');
        handles.patient_folder = pwd;
        cd(orig_dir);
    else
        orig_dir = pwd;
        cd(handles.dicom_folder); cd('../');
        handles.patient_folder = pwd;
        cd(orig_dir);
    end

    if ispc
        handles.nifti_folder = [handles.patient_folder '\NIfTI'];
        handles.registered_folder = [handles.nifti_folder '\Registered'];
        handles.contours_folder = [handles.nifti_folder '\Contours'];

        handles.mat_path = [handles.nifti_folder '\T.mat'];
        handles.series_info_path = [handles.nifti_folder '\series_info.mat'];
        handles.tmp_folder = [handles.patient_folder '\tmp'];
        
        warning off; 
        mkdir(handles.nifti_folder); mkdir(handles.tmp_folder);
        mkdir(handles.registered_folder); mkdir(handles.contours_folder);
        warning off;
        
        list = ls(handles.dicom_folder);
        list = cellstr(list);
        subfolders = list(3:end);

        clc;
        disp([num2str(numel(subfolders)) ' subfolders found in ' handles.dicom_folder]);
        disp('.')
        disp('..')
        ls(handles.dicom_folder)
    else

        handles.nifti_folder = [handles.patient_folder '/NIfTI'];
        handles.registered_folder = [handles.nifti_folder '/Registered'];
        handles.contours_folder = [handles.nifti_folder '/Contours'];

        handles.mat_path = [handles.nifti_folder '/T.mat'];
        handles.series_info_path = [handles.nifti_folder '/series_info.mat'];
        handles.tmp_folder = [handles.patient_folder '/tmp'];

        warning off; 
        mkdir(handles.nifti_folder); mkdir(handles.tmp_folder);
        mkdir(handles.registered_folder); mkdir(handles.contours_folder);
        warning off;

        clc;
        disp([num2str(numel(retrieve_list(handles.dicom_folder))) ' subfolders found in ' handles.dicom_folder]);
        disp('.')
        disp('..')
        ls(handles.dicom_folder)

    end

    handles.nifti_convert_label.Visible = 'on';
    handles.nifti_convert_button.Visible = 'on';
    handles.nifti_convert_button.Enable = 'on';

    guidata(hObject,handles);
    
catch
    disp('Invalid folder. Reselect the patient folder')
    if strcmp(handles.dicom_folder_label.String,'0')
        handles.dicom_folder_label.Visible = 'off';
    end
	handles.nifti_convert_label.Visible = 'off';
    handles.nifti_convert_button.Visible = 'off';
    guidata(hObject,handles);
end


% --- Executes on button press in nifti_convert_button.
function nifti_convert_button_Callback(hObject, eventdata, handles)
% hObject    handle to nifti_convert_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% locate dicoms and copy to temporay folder

disp('Converting DICOMs to NIfTI...')

handles.label_nifti_update.Visible = 'off';
handles.scan_types_list.Visible = 'off';
handles.scan_strings_list.Visible = 'off';

if ispc
    dicom_subfolders = retrieve_list_pc(handles.dicom_folder);
    % locate dicoms and copy to temporay folder
    for j=1:numel(dicom_subfolders)
        dicom_subfolder = [handles.dicom_folder '\' dicom_subfolders{j}];
        subfolder_contents = retrieve_list_pc(dicom_subfolder);
        file_prefix = subfolder_contents{1}(1:3);
        if contains(file_prefix,'CT')
            system(['xcopy ' dicom_subfolder '\*.dcm ' handles.tmp_folder]);
        elseif contains(file_prefix,'MR')
            system(['xcopy ' dicom_subfolder '\*.dcm ' handles.tmp_folder]);
        elseif contains(file_prefix,'RG') || contains(file_prefix,'RS')
            handles.RT_folder = dicom_subfolder;
        end
    end
    
else
    dicom_subfolders = retrieve_list(handles.dicom_folder);
    
    for j=1:numel(dicom_subfolders)
        
        dicom_subfolder = [handles.dicom_folder '/' dicom_subfolders{j}];
        
        subfolder_contents = retrieve_list(dicom_subfolder);
        
        file_prefix = subfolder_contents{1}(1:3);
        
        if contains(file_prefix,'CT')
            system(['cp ' dicom_subfolder '/*.dcm ' handles.tmp_folder]);
        elseif contains(file_prefix,'MR')
            system(['cp ' dicom_subfolder '/*.dcm ' handles.tmp_folder]);
        elseif contains(file_prefix,'RG') || contains(file_prefix,'RS')
            handles.RT_folder = dicom_subfolder;
        end
    end
end

% convert dicoms to nifti
dicm2nii(handles.tmp_folder,handles.nifti_folder);

if ispc
    delete([handles.tmp_folder '\*']);
    rmdir(handles.tmp_folder);
    rehash()
    
    %orig_dir = pwd;
    %cd(handles.patient_folder)
    
    %rmdir('tmp');
    %cd(orig_dir);
    %system(['rmdir -rf ' handles.tmp_folder]);
    %rmdir(handles.tmp_folder);
    %disp('was here after')
else
    system(['rm -rf ' handles.tmp_folder]);
end

handles.nifti_convert_button.Enable = 'off';
handles.label_nifti_label.Visible = 'on';
handles.start_button.Visible = 'on';


load([handles.nifti_folder '/dcmHeadersAll.mat']);
scans = fields(h_all);

handles.convert_update.String = handles.nifti_folder;
handles.convert_update.Visible = 'on';

handles.label_nifti_listbox_command.Visible = 'on';
handles.label_nifti_listbox.Visible = 'on';
handles.select_label_button.Visible = 'on';

handles.label_nifti_listbox.String = scans;

total_scans = numel(handles.secondary_names)+1;

handles.scan_names = cell(total_scans,1);
handles.scan_names{1} = 'CT';
handles.scan_names(2:end) = handles.secondary_names;

handles.select_scan_index = 1;

scan_name = handles.scan_names{handles.select_scan_index};
command = ['Select the "' scan_name '" scan:'];
handles.label_nifti_listbox_command.String = command;

handles.start_button.Enable = 'off';

handles.selected_strings = {};

guidata(hObject,handles);


% --- Executes on button press in load_button.
function load_button_Callback(hObject, eventdata, handles)
% hObject    handle to load_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.name_entry.Visible = 'off';
handles.add_button.Visible = 'off';
handles.name_listbox.Visible = 'off';
handles.del_button.Visible = 'off';
handles.save_button.Visible = 'off';
handles.secondary_names_label.Visible = 'off';

handles.selected_strings = {};
handles.series_info = struct();
handles.label_nifti_update.Visible = 'off';
handles.ctreg_label.Visible = 'off';
handles.ctreg_edit_button.Visible = 'off';
handles.accept_ct.Visible = 'off';
handles.mrreg_accept.Visible = 'off';
handles.mrreg_label.Visible = 'off';
handles.mrreg_menu_label.Visible = 'off';
handles.mrreg_menu.Visible = 'off';
handles.mrreg_edit.Visible = 'off';
handles.primary_start_label.Visible = 'off';
handles.secondary_start_label.Visible = 'off';
handles.translation_label.Visible = 'off';
handles.ct_offset_label_X.Visible = 'off';
handles.ct_offset_label_Y.Visible = 'off';
handles.ct_offset_label_Z.Visible = 'off';
handles.ct_input_X.Visible = 'off';
handles.ct_input_Y.Visible = 'off';
handles.ct_input_Z.Visible = 'off';
handles.mr_start_X.Visible = 'off';
handles.mr_start_Y.Visible = 'off';
handles.mr_start_Z.Visible = 'off';
handles.mr_translation_X.Visible = 'off';
handles.mr_translation_Y.Visible = 'off';
handles.mr_translation_Z.Visible = 'off';
handles.reg_mr2ct_button.Enable = 'off';
handles.scan_strings_list.Visible = 'off';
handles.scan_types_list.Visible = 'off';
handles.set_dicom_label.Visible = 'off';
handles.dicom_folder_label.Visible = 'off';
handles.series_info = struct();
handles.nifti_convert_label.Visible = 'off';
handles.convert_update.Visible = 'off';
handles.label_nifti_label.Visible = 'off';
handles.label_nifti_update.Visible = 'off';
handles.nifti_convert_label.Visible = 'off';
handles.nifti_convert_button.Visible = 'off';
handles.set_patient_button.Visible = 'off';
handles.label_nifti_listbox_command.Visible = 'off';
handles.label_nifti_listbox.Visible = 'off';
handles.select_label_button.Visible = 'off';
handles.redo_labels.Visible = 'off';

orig_dir = pwd;
if ispc
    cd([handles.utilities_path '\Config']);
else
    cd([handles.utilities_path '/Config']);
end

file = uigetfile();
    cd(orig_dir);

if file == 0
    
else
    
    if ispc
        load([handles.utilities_path '\Config\' file]);
    else 
        load([handles.utilities_path '/Config/' file]);
    end
    handles.secondary_names = MR_types;
    
	secondary_names = 'MR names: ';
    for i=1:numel(MR_types)
        secondary_names = [secondary_names ' ' MR_types{i}]; %#ok<*AGROW>
        if i<numel(MR_types)
            secondary_names = [secondary_names ','];
        end
    end

    
    handles.secondary_names_label.String = secondary_names;
    handles.secondary_names_label.Visible = 'on';

    handles.del_button.Visible = 'off';
    handles.save_button.Visible = 'off';
    handles.name_listbox.Visible = 'off';
    handles.add_button.Visible = 'off';
    handles.name_entry.Visible = 'off';
    
	handles.set_dicom_label.Visible = 'on';
    handles.set_patient_button.Visible = 'on';
    
    guidata(hObject,handles);
    
end




% --- Executes on button press in new_button.
function new_button_Callback(hObject, eventdata, handles)
% hObject    handle to new_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.name_listbox.Visible = 'on';
handles.name_entry.Visible = 'on';
handles.add_button.Visible = 'on';
handles.del_button.Visible = 'on';
handles.del_button.Enable = 'off';
handles.save_button.Visible = 'on';
handles.save_button.Enable = 'off';
handles.name_listbox.String = {''};
handles.secondary_names = {};
handles.name_listbox.Value = 1;
handles.secondary_names_label.Visible = 'off';


handles.selected_strings = {};
handles.series_info = struct();
handles.label_nifti_update.Visible = 'off';
handles.ctreg_label.Visible = 'off';
handles.ctreg_edit_button.Visible = 'off';
handles.accept_ct.Visible = 'off';
handles.mrreg_accept.Visible = 'off';
handles.mrreg_label.Visible = 'off';
handles.mrreg_menu_label.Visible = 'off';
handles.mrreg_menu.Visible = 'off';
handles.mrreg_edit.Visible = 'off';
handles.primary_start_label.Visible = 'off';
handles.secondary_start_label.Visible = 'off';
handles.translation_label.Visible = 'off';
handles.ct_offset_label_X.Visible = 'off';
handles.ct_offset_label_Y.Visible = 'off';
handles.ct_offset_label_Z.Visible = 'off';
handles.ct_input_X.Visible = 'off';
handles.ct_input_Y.Visible = 'off';
handles.ct_input_Z.Visible = 'off';
handles.mr_start_X.Visible = 'off';
handles.mr_start_Y.Visible = 'off';
handles.mr_start_Z.Visible = 'off';
handles.mr_translation_X.Visible = 'off';
handles.mr_translation_Y.Visible = 'off';
handles.mr_translation_Z.Visible = 'off';
handles.reg_mr2ct_button.Enable = 'off';
handles.scan_strings_list.Visible = 'off';
handles.scan_types_list.Visible = 'off';
handles.set_dicom_label.Visible = 'off';
handles.dicom_folder_label.Visible = 'off';
handles.series_info = struct();
handles.nifti_convert_label.Visible = 'off';
handles.convert_update.Visible = 'off';
handles.label_nifti_label.Visible = 'off';
handles.label_nifti_update.Visible = 'off';
handles.nifti_convert_label.Visible = 'off';
handles.nifti_convert_button.Visible = 'off';
handles.set_patient_button.Visible = 'off';
handles.label_nifti_listbox_command.Visible = 'off';
handles.label_nifti_listbox.Visible = 'off';
handles.select_label_button.Visible = 'off';
handles.redo_labels.Visible = 'off';


guidata(hObject,handles);




% --- Executes on selection change in name_listbox.
function name_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to name_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns name_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from name_listbox


% --- Executes during object creation, after setting all properties.
function name_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to name_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function name_entry_Callback(hObject, eventdata, handles)
% hObject    handle to name_entry (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of name_entry as text
%        str2double(get(hObject,'String')) returns contents of name_entry as a double


% --- Executes during object creation, after setting all properties.
function name_entry_CreateFcn(hObject, eventdata, handles)
% hObject    handle to name_entry (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% 
% % --- Executes on key press with focus on name_entry and none of its controls.
% function name_entry_KeyPressFcn(hObject, eventdata, handles)
% % hObject    handle to name_entry (see GCBO)
% % eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
% %	Key: name of the key that was pressed, in lower case
% %	Character: character interpretation of the key(s) that was pressed
% %	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% % handles    structure with handles and user data (see GUIDATA)
% 
% if strcmp(eventdata.Key,'return')
%     b = handles.name_entry.String
%     handles.secondary_names_label = [handles.secondary_names_label;handles.name_entry.String];
%     handles.name_listbox.String = handles.secondary_names_label;
%     
%     a = handles.secondary_names_label
%     
%     guidata(hObject,handles);
% end
%     
%     


% --- Executes on button press in add_button.
function add_button_Callback(hObject, eventdata, handles)
% hObject    handle to add_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.secondary_names = [handles.secondary_names;handles.name_entry.String];


if length(handles.secondary_names) > length(unique(handles.secondary_names))
    handles.secondary_names = handles.secondary_names(1:end-1);
end

handles.name_listbox.String = handles.secondary_names;

if length(handles.name_listbox.String) == 0
    handles.del_button.Enable = 'off';
    handles.save_button.Enable = 'off';
else
    handles.del_button.Enable = 'on';
    handles.save_button.Enable = 'on';
end

handles.name_entry.String = '';
guidata(hObject,handles);


% --- Executes on button press in del_button.
function del_button_Callback(hObject, eventdata, handles)
% hObject    handle to del_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.secondary_names(handles.name_listbox.Value) = [];
handles.name_listbox.Value = 1;

handles.name_listbox.String = handles.secondary_names;

if length(handles.name_listbox.String) == 0
    handles.del_button.Enable = 'off';
    handles.save_button.Enable = 'off';
end
guidata(hObject,handles);


% --- Executes on button press in save_button.
function save_button_Callback(hObject, eventdata, handles)
% hObject    handle to save_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

MR_types = handles.name_listbox.String;
orig_dir = pwd;

if ispc
    cd([handles.utilities_path '\Config'])
else
    cd([handles.utilities_path '/Config']);
end
%uisave('MR_types','new_config.mat');

[file,path] = uiputfile('new_config.mat');

if path ~= 0
    if ispc
        save([path '\' file],'MR_types');
    else
        save([path '/' file],'MR_types');
    end
    cd(orig_dir);

    handles.MR_types = MR_types;

    secondary_names = 'MR names: ';
    for i=1:numel(MR_types)
        secondary_names = [secondary_names ' ' MR_types{i}]; %#ok<*AGROW>
        if i<numel(MR_types)
            secondary_names = [secondary_names ','];
        end
    end

    handles.secondary_names_label.String = secondary_names;
    handles.secondary_names_label.Visible = 'on';

    handles.del_button.Visible = 'off';
    handles.save_button.Visible = 'off';
    handles.name_listbox.Visible = 'off';
    handles.add_button.Visible = 'off';
    handles.name_entry.Visible = 'off';
    
    handles.set_dicom_label.Visible = 'on';
    handles.set_patient_button.Visible = 'on';

    guidata(hObject,handles);
    
    
end

function new_config_entry_Callback(hObject, eventdata, handles)
% hObject    handle to new_config_entry (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of new_config_entry as text
%        str2double(get(hObject,'String')) returns contents of new_config_entry as a double


% --- Executes during object creation, after setting all properties.
function new_config_entry_CreateFcn(hObject, eventdata, handles)
% hObject    handle to new_config_entry (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on selection change in label_nifti_listbox.
function label_nifti_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to label_nifti_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns label_nifti_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from label_nifti_listbox


% --- Executes during object creation, after setting all properties.
function label_nifti_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to label_nifti_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in select_label_button.
function select_label_button_Callback(hObject, eventdata, handles)
% hObject    handle to select_label_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

selected_index = handles.label_nifti_listbox.Value;
selected_string = handles.label_nifti_listbox.String{selected_index};
handles.selected_strings{handles.select_scan_index} = selected_string;
handles.label_nifti_listbox.String(selected_index) = [];
v = handles.label_nifti_listbox.Value;

if ispc
    handles.series_info.(handles.scan_names{handles.select_scan_index}) = ...
    [handles.nifti_folder '\' selected_string '.nii.gz'];
else
    handles.series_info.(handles.scan_names{handles.select_scan_index}) = ...
    [handles.nifti_folder '/' selected_string '.nii.gz'];
end

if v > 1
    handles.label_nifti_listbox.Value = v-1;
else
    handles.label_nifti_listbox.Value = 1;
end

handles.select_scan_index = handles.select_scan_index+1;

if handles.select_scan_index > numel(handles.scan_names)
    
    handles.select_label_button.Visible = 'off';
    handles.label_nifti_listbox.Visible = 'off';
    
    series_info_fields = fields(handles.series_info);
    
	labels = cell(numel(series_info_fields),1);
    names = labels;
    
    for i=1:numel(handles.scan_names)
        names{i} = handles.selected_strings{i};
        labels{i} = [series_info_fields{i} ':'];
    end

    handles.label_nifti_listbox_command.String = 'Is this correct?';
    
    handles.scan_types_list.Visible = 'on';
    handles.scan_strings_list.Visible = 'on';
    handles.scan_types_list.String = labels;
    handles.scan_strings_list.String = names;
    
    handles.yes_button.Visible = 'on';
    handles.no_button.Visible = 'on';
    guidata(hObject,handles);
else
    scan_name = handles.scan_names{handles.select_scan_index};
    command = ['Select the "' scan_name '" scan:'];
    handles.label_nifti_listbox_command.String = command;

end

guidata(hObject,handles);


% --- Executes on button press in yes_button.
function yes_button_Callback(hObject, eventdata, handles)
% hObject    handle to yes_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.scan_types_list.Visible = 'off';
handles.scan_strings_list.Visible = 'off';
handles.no_button.Visible = 'off';
handles.yes_button.Visible = 'off';
handles.label_nifti_listbox_command.Visible = 'off';

scan_names = '';
for i=1:numel(handles.scan_names)
    scan_names = [scan_names handles.scan_names{i} ', '];
end
scan_names = scan_names(1:end-2);
handles.label_nifti_update.String = scan_names;

handles.ctreg_label.Visible = 'on';
handles.label_nifti_update.Visible = 'on';
handles.ct_input_X.Visible = 'on';handles.ct_input_Y.Visible = 'on';handles.ct_input_Z.Visible = 'on';
handles.ct_offset_label_X.Visible = 'on';handles.ct_offset_label_Y.Visible = 'on';handles.ct_offset_label_Z.Visible = 'on';
handles.accept_ct.Visible = 'on';
handles.ctreg_label.Visible = 'on';
handles.primary_start_label.Visible = 'on';
handles.mrreg_entered = repmat({'false'},[numel(handles.secondary_names) 1]);

handles.ct_input_X.Enable = 'on';
handles.ct_input_Y.Enable = 'on';
handles.ct_input_Z.Enable = 'on';
uicontrol(handles.ct_input_X);


handles.redo_labels.Visible = 'on';

guidata(hObject,handles);



% --- Executes on button press in no_button.
function no_button_Callback(hObject, eventdata, handles)
% hObject    handle to no_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.scan_types_list.Visible = 'off';
handles.scan_strings_list.Visible = 'off';
handles.no_button.Visible = 'off';
handles.yes_button.Visible = 'off';
handles.label_nifti_listbox_command.Visible = 'on';
handles.label_nifti_listbox.Visible = 'on';
handles.select_label_button.Visible = 'on';

if ispc
    load([handles.nifti_folder '\dcmHeadersAll.mat']);
else
    load([handles.nifti_folder '/dcmHeadersAll.mat']);
end

scans = fields(h_all);
   
handles.label_nifti_listbox.String = scans;

handles.select_scan_index = 1;

scan_name = handles.scan_names{handles.select_scan_index};
command = ['Select the "' scan_name '" scan:'];
handles.label_nifti_listbox_command.String = command;

handles.selected_strings = {};
handles.series_info = struct();

guidata(hObject,handles);



function ct_input_X_Callback(hObject, eventdata, handles)
% hObject    handle to ct_input_X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ct_input_X as text
%        str2double(get(hObject,'String')) returns contents of ct_input_X as a double
uicontrol(handles.ct_input_Y)

% --- Executes during object creation, after setting all properties.
function ct_input_X_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ct_input_X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ct_input_Y_Callback(hObject, eventdata, handles)
% hObject    handle to ct_input_Y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ct_input_Y as text
%        str2double(get(hObject,'String')) returns contents of ct_input_Y as a double
uicontrol(handles.ct_input_Z)


% --- Executes during object creation, after setting all properties.
function ct_input_Y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ct_input_Y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ct_input_Z_Callback(hObject, eventdata, handles)
% hObject    handle to ct_input_Z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ct_input_Z as text
%        str2double(get(hObject,'String')) returns contents of ct_input_Z as a double
uicontrol(handles.accept_ct)

% --- Executes during object creation, after setting all properties.
function ct_input_Z_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ct_input_Z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over ct_input_X.
function ct_input_X_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to ct_input_X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in accept_ct.
function accept_ct_Callback(hObject, eventdata, handles)
% hObject    handle to accept_ct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

X = handles.ct_input_X.String;
Y = handles.ct_input_Y.String;
Z = handles.ct_input_Z.String;

handles.series_info.Offset_CT = [str2double(X) str2double(Y) str2double(Z)];
handles.ctreg_entered = 'true';
handles.ctreg_edit_button.Visible = 'on';

handles.ct_input_X.Enable = 'off';
handles.ct_input_Y.Enable = 'off';
handles.ct_input_Z.Enable = 'off';

handles.accept_ct.Visible = 'off';

handles.mrreg_label.Visible = 'on';
handles.mrreg_menu.Visible = 'on';
handles.mrreg_menu.String = handles.secondary_names;
handles.mrreg_index = handles.mrreg_menu.Value;
handles.secondary_start_label.Visible = 'on';
handles.mrreg_menu_label.Visible = 'on';
handles.mr_start_X.Visible = 'on';
handles.mr_start_Y.Visible = 'on';
handles.mr_start_Z.Visible = 'on';
handles.mrreg_accept.Visible = 'on';

handles.translation_label.Visible = 'on';
handles.mr_translation_X.Visible = 'on';
handles.mr_translation_Y.Visible = 'on';
handles.mr_translation_Z.Visible = 'on';

uicontrol(handles.mr_start_X);
guidata(hObject,handles);






% --- Executes on button press in ctreg_edit_button.
function ctreg_edit_button_Callback(hObject, eventdata, handles)
% hObject    handle to ctreg_edit_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.ct_input_X.Enable = 'on';
handles.ct_input_Y.Enable = 'on';
handles.ct_input_Z.Enable = 'on';

handles.accept_ct.Visible = 'on';
uicontrol(handles.ct_input_X)




% --- Executes during object creation, after setting all properties.
function accept_ct_CreateFcn(hObject, eventdata, handles)
% hObject    handle to accept_ct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on key press with focus on accept_ct and none of its controls.
function accept_ct_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to accept_ct (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
key = get(gcf,'CurrentKey');
if(strcmp (key , 'return'))
    accept_ct_Callback(hObject, eventdata, handles)
end


% --- Executes on button press in mrreg_edit.
function mrreg_edit_Callback(hObject, eventdata, handles)
% hObject    handle to mrreg_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.mrreg_accept.Visible = 'on';
uicontrol(handles.mr_start_X);
guidata(hObject,handles);







function mr_start_X_Callback(hObject, eventdata, handles)
% hObject    handle to mr_start_X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mr_start_X as text
%        str2double(get(hObject,'String')) returns contents of mr_start_X as a double
uicontrol(handles.mr_start_Y)

% --- Executes during object creation, after setting all properties.
function mr_start_X_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mr_start_X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mr_start_Y_Callback(hObject, eventdata, handles)
% hObject    handle to mr_start_Y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mr_start_Y as text
%        str2double(get(hObject,'String')) returns contents of mr_start_Y as a double
uicontrol(handles.mr_start_Z)

% --- Executes during object creation, after setting all properties.
function mr_start_Y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mr_start_Y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mr_start_Z_Callback(hObject, eventdata, handles)
% hObject    handle to mr_start_Z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mr_start_Z as text
%        str2double(get(hObject,'String')) returns contents of mr_start_Z as a double
uicontrol(handles.mr_translation_X)

% --- Executes during object creation, after setting all properties.
function mr_start_Z_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mr_start_Z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in mr_start_accept.
function mr_start_accept_Callback(hObject, eventdata, handles)
% hObject    handle to mr_start_accept (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function mr_translation_X_Callback(hObject, eventdata, handles)
% hObject    handle to mr_translation_X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mr_translation_X as text
%        str2double(get(hObject,'String')) returns contents of mr_translation_X as a double
uicontrol(handles.mr_translation_Y)


% --- Executes during object creation, after setting all properties.
function mr_translation_X_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mr_translation_X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mr_translation_Y_Callback(hObject, eventdata, handles)
% hObject    handle to mr_translation_Y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mr_translation_Y as text
%        str2double(get(hObject,'String')) returns contents of mr_translation_Y as a double
uicontrol(handles.mr_translation_Z)


% --- Executes during object creation, after setting all properties.
function mr_translation_Y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mr_translation_Y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mr_translation_Z_Callback(hObject, eventdata, handles)
% hObject    handle to mr_translation_Z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mr_translation_Z as text
%        str2double(get(hObject,'String')) returns contents of mr_translation_Z as a double
uicontrol(handles.mrreg_accept)


% --- Executes during object creation, after setting all properties.
function mr_translation_Z_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mr_translation_Z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in mrreg_accept.
function mrreg_accept_Callback(hObject, eventdata, handles)
% hObject    handle to mrreg_accept (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

X = handles.mr_start_X.String;
Y = handles.mr_start_Y.String;
Z = handles.mr_start_Z.String;

handles.series_info.(['Offset_' handles.secondary_names{handles.mrreg_index}]) ...
    = [str2double(X) str2double(Y) str2double(Z)];

X = handles.mr_translation_X.String;
Y = handles.mr_translation_Y.String;
Z = handles.mr_translation_Z.String;

handles.series_info.(['Translation_' handles.secondary_names{handles.mrreg_index}]) ...
    = [str2double(X) str2double(Y) str2double(Z)];

handles.mrreg_entered{handles.mrreg_index} = 'true';

if sum(contains(handles.mrreg_entered,'false')) > 0
    handles.mrreg_index = find(contains(handles.mrreg_entered,'false'),1);
    handles.mrreg_menu.Value = handles.mrreg_index;
    
	handles.mr_start_X.String = '';
    handles.mr_start_Y.String = '';
    handles.mr_start_Z.String = '';
    
    handles.mr_translation_X.String = '';
    handles.mr_translation_Y.String = '';
    handles.mr_translation_Z.String = '';
    
    uicontrol(handles.mr_start_X);
else
    uicontrol(handles.reg_mr2ct_button);
    handles.mrreg_edit.Visible = 'on';
    handles.mrreg_accept.Visible = 'off';
    handles.reg_mr2ct_button.Enable = 'on';
end
    
    

guidata(hObject,handles);





% --- Executes on selection change in mrreg_menu.
function mrreg_menu_Callback(hObject, eventdata, handles)
% hObject    handle to mrreg_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns mrreg_menu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from mrreg_menu
handles.mrreg_index = handles.mrreg_menu.Value;

mr_name = handles.secondary_names{handles.mrreg_index};

sif = fields(handles.series_info);

if sum(contains(sif,['Offset_' mr_name]))
    
    offset_vals = handles.series_info.(['Offset_' mr_name]);
    handles.mr_start_X.String = num2str(offset_vals(1));
    handles.mr_start_Y.String = num2str(offset_vals(2));
    handles.mr_start_Z.String = num2str(offset_vals(3)); 
else
	handles.mr_start_X.String = '';
    handles.mr_start_Y.String = '';
    handles.mr_start_Z.String = '';
end

if sum(contains(sif,['Translation_' mr_name]))
    
    vals = handles.series_info.(['Translation_' mr_name]);
    handles.mr_translation_X.String = num2str(vals(1));
    handles.mr_translation_Y.String = num2str(vals(2));
    handles.mr_translation_Z.String = num2str(vals(3));
else
    handles.mr_translation_X.String = '';
    handles.mr_translation_Y.String = '';
    handles.mr_translation_Z.String = '';
end

handles.mrreg_accept.Visible = 'on';
uicontrol(handles.mr_start_X)
% update the contents here next
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function mrreg_menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mrreg_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on mrreg_accept and none of its controls.
function mrreg_accept_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to mrreg_accept (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
key = get(gcf,'CurrentKey');
if(strcmp (key , 'return'))
    mrreg_accept_Callback(hObject, eventdata, handles)
end


% --- Executes on button press in reg_mr2ct_button.
function reg_mr2ct_button_Callback(hObject, eventdata, handles)
% hObject    handle to reg_mr2ct_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if ispc
    load([handles.nifti_folder '\dcmHeadersAll.mat']);
else
    load([handles.nifti_folder '/dcmHeadersAll.mat']);
end

%% match spatial registration files

if ispc
    RGs_list = ls([handles.RT_folder '\RGs*']);
    RGs_list = cellstr(RGs_list);
    RGs_info = cell(numel(RGs_list),1);
else
    RGs_list = retrieve_list([handles.RT_folder '/RGs*']);
    RGs_info = cell(numel(RGs_list),1);
end

for i=1:numel(handles.secondary_names)
    
    MR_path = handles.series_info.(handles.secondary_names{i});
    
    if ispc
        MR_split = regexp(MR_path,'\','split');
    else
        MR_split = regexp(MR_path,'/','split');
    end
    MR_name = MR_split{end}(1:end-7);
    MR_uid = h_all.(MR_name){1}.SeriesInstanceUID;
    
    for j=1:numel(RGs_list)
        RGs_info{j} = dicominfo([handles.RT_folder '\' RGs_list{j}]); % spatial reg file
        SeriesInstanceUID = RGs_info{j}.ReferencedSeriesSequence. ...
            Item_2.SeriesInstanceUID;
        if strcmp(SeriesInstanceUID,MR_uid)
            handles.series_info.(['RG_' handles.secondary_names{i}]) = [handles.RT_folder '\' RGs_list{j}];
        end
    end
end

%% create MR to CT transformation matrices and perform registration

% load CT object
nii_ct = load_untouch_nii(handles.series_info.CT);

% CT origin
slice_span_ct = [0;0;nii_ct.hdr.hist.srow_z(3)*(nii_ct.hdr.dime.dim(4)-1)];
xyz_ct = 10*handles.series_info.Offset_CT(:) + slice_span_ct;

if ispc
    mat_path = [handles.nifti_folder '\T.mat'];
else
	mat_path = [handles.nifti_folder '/T.mat'];
end

for i=1:numel(handles.secondary_names)
    
    disp(['Creating ' handles.secondary_names{i} ' transformation matrix...']);
    
    % load MR object
    nii_MR = load_untouch_nii(handles.series_info.(handles.secondary_names{i}));

    % MR origin
    slice_span_MR = [0;0;nii_MR.hdr.hist.srow_z(3)*(nii_MR.hdr.dime.dim(4)-1)];
    xyz_MR = 10*handles.series_info.(['Offset_' handles.secondary_names{i}])(:) + slice_span_MR;

    % load registration object
    RG_info = dicominfo(handles.series_info.(['RG_' handles.secondary_names{i}]));

	% extract transformation matrix
    RG = RG_info.RegistrationSequence ...
                .Item_2.MatrixRegistrationSequence ...
                .Item_1.MatrixSequence.Item_1 ...
                .FrameOfReferenceTransformationMatrix;

    % initialize rotation matrix
    rot_mat = eye(4);

    % copy elements
    rot_mat(1,1:3) = RG(1:3);
    rot_mat(2,1:3) = RG(5:7);
    rot_mat(3,1:3) = RG(9:11);
    rot_mat(4,1:3) = RG(13:15);
    

    % negate some elements ???
    rot_mat(2:3,1) = -rot_mat(2:3,1);
    rot_mat(1,2:3) = -rot_mat(1,2:3);

    % convert rotation matrix to euler angles and negate 3rd element ???
    v = vrrotmat2vec(rot_mat(1:3,1:3));
    v = [v(1:3) rad2deg(v(end))];
    v(3) = -v(3);

    % convert euler angles to rotation matrix
    rot_mat = SpinCalc('EVtoDCM',v,[],0);
    rot_mat(4,1:4) = 0; rot_mat(end) = 1;
        
    % load up the pinnacle translation
    pinnacle_translation = 10*handles.series_info.(['Translation_' handles.secondary_names{i}])(:);
    
    Q = [...
    nii_MR.hdr.hist.srow_x;...
    nii_MR.hdr.hist.srow_y;...
    nii_MR.hdr.hist.srow_z;...
    [0 0 0 1]];

    first = [0;0;0;1];
    last = [(size(nii_MR.img)'-1); 1];
        
    origin = abs(Q*(last-first))/2; origin = origin(1:3);

    % find location of rotated origin
    new_origin = rot_mat(1:3,1:3)*origin;
    

    % keep track of offset induced through rotation
    offset = origin - new_origin;

    % reconcile MR / CT coordinate frames ???
    d0 = xyz_ct - xyz_MR;
    dxyz = pinnacle_translation - d0;
    dxyz(end) = -dxyz(end);

    % build affine transformation matrix
    T_mat = eye(4);
    T_mat(1:3,1:3) = rot_mat(1:3,1:3);
    T_mat(1:3,4) = offset + dxyz;
    
    handles.series_info.(['T_' handles.secondary_names{i} '_to_CT']) = T_mat;
    
	disp(['Registering ' handles.secondary_names{i} ' to CT...']);
    T = handles.series_info.(['T_' handles.secondary_names{i} '_to_CT']);
    save(mat_path,'T');
    nii_xform(handles.series_info.(handles.secondary_names{i}),{handles.series_info.CT,mat_path},[handles.registered_folder '/' handles.secondary_names{i} '.nii.gz']);
    
end


%% make a copy of the CT scan for convenience

if ispc
    copyfile(handles.series_info.CT,[handles.registered_folder,'\ct.nii.gz'])
else
    command = ['cp ' handles.series_info.CT ' ' handles.registered_folder '/ct.nii.gz'];
    system(command);
end

if handles.export_checkbox.Value == 1

    %% find radiation planning contour filename
    if ispc
        list = ls(handles.RT_folder);
        list = cellstr(list);
        struct_list = list(3:end);
    else
        struct_list = retrieve_list(handles.RT_folder); 
    end
        
	RS_count = 0;
    for j = 1:numel(struct_list)
        filename = struct_list{j};
        if strcmp(filename(1:3),'RS.')
            RTStruct_filename = filename;
            RS_count = RS_count + 1;
        end
    end

    if RS_count > 1
        disp('RS_count > 1 ... check files')
    end

    %% convert contours to matrices
    if ispc
        struct_path = [handles.RT_folder '\' RTStruct_filename];
    else
        struct_path = [handles.RT_folder '/' RTStruct_filename];
    end
    disp('Reading RTStruct...')
    warning off; info = dicominfo(struct_path); warning on;
    disp('Converting CT contours to matrices...')
    contours = rtstruct2mat(info, nii_ct); %%

    % copy of the ct to put the contours into
    nii_ct_copy = nii_ct;

    contour_fields = fields(contours);

    disp(contour_fields)
    for j=1:numel(contour_fields) % loop through GTV/CTV
        contour_name = contour_fields{j};
        disp(['Saving ' contour_fields{j} '...(' ...
            num2str(j) '/' num2str(numel(contour_fields)) ')']);
        contour = contours.(contour_name);

        nii_ct_copy.img = cast(contour,class(nii_ct.img));
        if ispc
            contour_path = [handles.contours_folder '\' contour_name '.nii.gz'];
        else
            contour_path = [handles.contours_folder '/' contour_name '.nii.gz'];
        end
        save_untouch_nii(nii_ct_copy,contour_path);
    end

end

disp('')
disp('Complete!')

series_info = handles.series_info;

if ispc
	save([handles.nifti_folder '\series_info.mat'],'series_info')
    delete(mat_path);
    delete([handles.nifti_folder '\dcmHeaders.mat']);
    rehash();
else
    save([handles.nifti_folder '/series_info.mat'],'series_info')
    system(['rm ' mat_path]);
    system(['rm ' handles.nifti_folder '/dcmHeaders.mat']);
end


% --- Executes on button press in redo_labels.
function redo_labels_Callback(hObject, eventdata, handles)
% hObject    handle to redo_labels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.nifti_convert_button.Enable = 'off';
handles.label_nifti_label.Visible = 'on';
handles.start_button.Visible = 'on';

if ispc
    load([handles.nifti_folder '\dcmHeadersAll.mat']);
else
    load([handles.nifti_folder '/dcmHeadersAll.mat']);
end

scans = fields(h_all);

handles.convert_update.String = handles.nifti_folder;
handles.convert_update.Visible = 'on';

handles.label_nifti_listbox_command.Visible = 'on';
handles.label_nifti_listbox.Visible = 'on';
handles.select_label_button.Visible = 'on';

handles.label_nifti_listbox.String = scans;

total_scans = numel(handles.secondary_names)+1;

handles.scan_names = cell(total_scans,1);
handles.scan_names{1} = 'CT';
handles.scan_names(2:end) = handles.secondary_names;

handles.select_scan_index = 1;

scan_name = handles.scan_names{handles.select_scan_index};
command = ['Select the "' scan_name '" scan:'];
handles.label_nifti_listbox_command.String = command;

handles.selected_strings = {};
handles.series_info = struct();
handles.label_nifti_update.Visible = 'off';
handles.ctreg_label.Visible = 'off';
handles.ctreg_edit_button.Visible = 'off';
handles.accept_ct.Visible = 'off';
handles.mrreg_accept.Visible = 'off';
handles.mrreg_label.Visible = 'off';
handles.mrreg_menu_label.Visible = 'off';
handles.mrreg_menu.Visible = 'off';
handles.mrreg_edit.Visible = 'off';
handles.primary_start_label.Visible = 'off';
handles.secondary_start_label.Visible = 'off';
handles.translation_label.Visible = 'off';
handles.ct_offset_label_X.Visible = 'off';
handles.ct_offset_label_Y.Visible = 'off';
handles.ct_offset_label_Z.Visible = 'off';
handles.ct_input_X.Visible = 'off';
handles.ct_input_Y.Visible = 'off';
handles.ct_input_Z.Visible = 'off';
handles.mr_start_X.Visible = 'off';
handles.mr_start_Y.Visible = 'off';
handles.mr_start_Z.Visible = 'off';
handles.mr_translation_X.Visible = 'off';
handles.mr_translation_Y.Visible = 'off';
handles.mr_translation_Z.Visible = 'off';
handles.reg_mr2ct_button.Enable = 'off';
handles.scan_strings_list.Visible = 'off';
handles.scan_types_list.Visible = 'off';



guidata(hObject,handles);


% --- Executes on button press in export_checkbox.
function export_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to export_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of export_checkbox


% --- Executes on key press with focus on reg_mr2ct_button and none of its controls.
function reg_mr2ct_button_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to reg_mr2ct_button (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
key = get(gcf,'CurrentKey');
if(strcmp (key , 'return'))
    reg_mr2ct_button_Callback(hObject, eventdata, handles)
end

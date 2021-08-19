function list = retrieve_list(list_path)

list = ls(list_path);
list = regexp(list,'\s+','split');
list = list(1:end-1);
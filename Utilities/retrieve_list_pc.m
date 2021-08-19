function list = retrieve_list_pc(list_path)

list = ls(list_path);
list = cellstr(list);
list = list(3:end);

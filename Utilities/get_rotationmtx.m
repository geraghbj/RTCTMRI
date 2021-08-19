function [rot_mat,xyz,RGs] = get_rotationmtx(RGs_info)

RGs = RGs_info.RegistrationSequence ...
                .Item_2.MatrixRegistrationSequence ...
                .Item_1.MatrixSequence.Item_1 ...
                .FrameOfReferenceTransformationMatrix;
            
xyz = -RGs(4:4:end-1); xyz(1) = -xyz(1);
            
rot_mat = eye(4);

rot_mat(1,1:3) = RGs(1:3);
rot_mat(2,1:3) = RGs(5:7);
rot_mat(3,1:3) = RGs(9:11);
rot_mat(4,1:3) = RGs(13:15);

rot_mat(2:3,1) = -rot_mat(2:3,1);
rot_mat(1,2:3) = -rot_mat(1,2:3);

v = vrrotmat2vec(rot_mat(1:3,1:3));
v = [v(1:3) rad2deg(v(end))];
v(3) = -v(3);

rot_mat = SpinCalc('EVtoDCM',v,[],0);
rot_mat(4,1:4) = 0; rot_mat(end) = 1;

%%

%RGs = RGs_info{1}.RegistrationSequence.Item_2.MatrixRegistrationSequence.Item_1.MatrixSequence.Item_1.FrameOfReferenceTransformationMatrix
git_folder = '~/Documents/GitHub';
addpath(genpath(fullfile(git_folder, 'mrC')),'-end');
im_path = '/Users/RachelPavlovia/wallpaper_search/img/tiles';

images = subfiles(sprintf('%s/set04/p*.png', im_path), 1);

for a = 1:length(images)
    cur_img = imread(images{a});
    if ~(isequal(cur_img(:,:,1),cur_img(:,:,2),cur_img(:,:,3) ))
        error('unequal dimensions');
    else
        cur_img = cur_img(:,:,1);
    end
    max_val(a) = max(cur_img(:));
    min_val(a) = min(cur_img(:));
    mean_val(a) = mean(cur_img(:));
end

good_idx = all([abs(mean_val'-127) < 1, (min_val' == 0), (max_val' == 252)],1)
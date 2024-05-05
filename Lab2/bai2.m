img = imread('TestRLC.bmp');

[hang_mahoa, cot_mahoa] = size(img);

so_bit_nen = 0;

giatri_mahoa = [];
for i = 1:hang_mahoa
    j_truoc = 1;
    for j = 1:cot_mahoa
        if j < cot_mahoa && img(i, j) == img(i, j+1)
            continue;
        else
            so_bit_lap = j - j_truoc + 1;
            if img(i, j_truoc) == 255
                giatri_mahoa = [giatri_mahoa, ones(1, so_bit_lap)];
            else
                giatri_mahoa = [giatri_mahoa, zeros(1, so_bit_lap)];
            end
            so_bit_nen = so_bit_nen + 8;
            j_truoc = j + 1;
        end
    end
end

ti_le_nen = so_bit_nen / (hang_mahoa * cot_mahoa * 8);
disp(['Tỉ lệ nén: ', num2str(ti_le_nen)]);

so_pixel_nen = length(giatri_mahoa) / 8;

img_giaima = zeros(hang_mahoa, cot_mahoa);

cot_giaima = 1;
hang_giaima = 1;
index = 1;

while index <= so_pixel_nen
    bit16 = giatri_mahoa(index:index+15);

    so_bit_lap = bin2dec(num2str(bit16(1:8)));

    if bit16(9) == 1
        img_giaima(hang_giaima, cot_giaima:cot_giaima+so_bit_lap-1) = 255;
    else
        img_giaima(hang_giaima, cot_giaima:cot_giaima+so_bit_lap-1) = 0;
    end

    cot_giaima = cot_giaima + so_bit_lap;
    if cot_giaima > cot_mahoa
        cot_giaima = 1;
        hang_giaima = hang_giaima + 1;
    end

    index = index + 16;
end

figure;
subplot(1, 2, 1);
imshow(img);
title('Ảnh gốc');

subplot(1, 2, 2);
imshow(uint8(img_giaima));
title('Ảnh sau khi giải mã');

if isequal(img, uint8(img_giaima))
    disp('Không có tổn hao thông tin');
else
    disp('Có tổn hao thông tin');
end

disp(['Số bit bị nén: ', num2str(so_bit_nen)]);

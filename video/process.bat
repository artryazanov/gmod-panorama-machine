set file="Garry's Mod 2023.02.11 - 15.07.32.04.mp4"
set ffmpeg="ffmpeg-2023-02-09-git-159b028df5-full_build/bin/ffmpeg.exe"
set processDir="process"
IF not exist %processDir% (mkdir %processDir%)
%ffmpeg% -y -i %file% -filter:v "crop=in_h/2:in_h/2:0:0" -c:a copy "%processDir%/left.mp4"
%ffmpeg% -y -i %file% -filter:v "crop=in_h/2:in_h/2:in_h/2:0" -c:a copy "%processDir%/forward.mp4"
%ffmpeg% -y -i %file% -filter:v "crop=in_h/2:in_h/2:in_h:0" -c:a copy "%processDir%/right.mp4"
%ffmpeg% -y -i %file% -filter:v "crop=in_h/2:in_h/2:0:in_h/2" -c:a copy "%processDir%/up.mp4"
%ffmpeg% -y -i %file% -filter:v "crop=in_h/2:in_h/2:in_h/2:in_h/2" -c:a copy "%processDir%/down.mp4"
%ffmpeg% -y -i %file% -filter:v "crop=in_h/2:in_h/2:in_h:in_h/2" -c:a copy "%processDir%/back.mp4"
%ffmpeg% -y -i "%processDir%/right.mp4" -i "%processDir%/left.mp4" -filter_complex hstack -c:a copy "%processDir%/tmp1.mp4"
%ffmpeg% -y -i "%processDir%/tmp1.mp4" -i "%processDir%/up.mp4" -filter_complex hstack -c:a copy "%processDir%/tmp2.mp4"
%ffmpeg% -y -i "%processDir%/tmp2.mp4" -i "%processDir%/down.mp4" -filter_complex hstack -c:a copy "%processDir%/tmp3.mp4"
%ffmpeg% -y -i "%processDir%/tmp3.mp4" -i "%processDir%/forward.mp4" -filter_complex hstack -c:a copy "%processDir%/tmp4.mp4"
%ffmpeg% -y -i "%processDir%/tmp4.mp4" -i "%processDir%/back.mp4" -filter_complex hstack -c:a copy "%processDir%/c6x1.mp4"
%ffmpeg% -y -i "%processDir%/c6x1.mp4" -vf v360=c6x1:equirect -c:a copy "360result.mp4"
RMDIR /S /Q %processDir%
pause
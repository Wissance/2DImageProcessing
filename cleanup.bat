:: Project directory cleanup script
@ECHO 'Backups, logs, jou and hs_err removing...'
@del *.backup.*
@del *.jou
@del hs_err_pid*
@del *.log

@ECHO 'Cache removing...'
@RMDIR /S /Q .Xil
@RMDIR /S /Q 2d_image_processing.cache
@RMDIR /S /Q 2d_image_processing.hw
@RMDIR /S /Q 2d_image_processing.ip_user_files

@ECHO 'Runs, sdk and sim removing...'
@RMDIR /S /Q 2d_image_processing.runs
@RMDIR /S /Q 2d_image_processing.sdk
@RMDIR /S /Q 2d_image_processing.sim

pause
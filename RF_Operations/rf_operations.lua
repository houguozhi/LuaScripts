-- reserved
-- script_name = RF_CalAndInit
-- Initialize rf by writing calibration file and analog-init file.

os.execute("cls")

init_file = [[d:\Users\hgz\Documents\AppData\Visual Studio 2010\Projects\HS6200Test\Release\У׼���ʼ���ļ�\pwr_cal_2450]]
cal_file  = [[d:\Users\hgz\Documents\AppData\Visual Studio 2010\Projects\HS6200Test\Release\У׼���ʼ���ļ�\sb_HS62001_-18]]

rf.CeLow()
rf.WriteRegFile(init_file)
rf.CeHighPulse()
--delay(10)
rf.WriteRegFile(cal_file)

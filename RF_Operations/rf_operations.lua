-- reserved
-- script_name = RF_CalAndInit
-- Initialize rf by writing calibration file and analog-init file.

os.execute("cls")

rf.CeLow()
rf.WriteRegFile([[d:\Users\hgz\Documents\AppData\Visual Studio 2010\Projects\HS6200Test\Release\У׼���ʼ���ļ�\pwr_cal_2450]])
rf.CeHighPulse()
--delay(10)
rf.WriteRegFile([[d:\Users\hgz\Documents\AppData\Visual Studio 2010\Projects\HS6200Test\Release\У׼���ʼ���ļ�\sb_HS62001_-18]])

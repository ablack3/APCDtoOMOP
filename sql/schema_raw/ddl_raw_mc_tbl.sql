/***********************
params: database
***********************/

--Select database
USE @database@;
GO


--Drop raw.mc table
IF(OBJECT_ID('raw.mc') IS NOT NULL)
  BEGIN
    DROP TABLE raw.mc;
  END
;
GO

--Create raw.mc table
IF(OBJECT_ID('raw.mc') IS NULL)
  BEGIN
    CREATE TABLE raw.mc (
      MC005_LINE VARCHAR(50)
			,MC005A_VER VARCHAR(10)
			,MC011_REL VARCHAR(50)
			,MC012_GENDER VARCHAR(30)
			,MC014_PATCITY VARCHAR(100)
			,MC015_PATST VARCHAR(20)
			,MC016_PATZIP VARCHAR(10)
			,MC017_PDATE VARCHAR(50)
			,MC018_ADMDAT VARCHAR(50)
			,MC019_ADMHR VARCHAR(20)
			,MC020_ADMTYPE VARCHAR(10)
			,MC021_ADMSR VARCHAR(10)
			,MC022_DISHR VARCHAR(20)
			,MC023_PTDIS VARCHAR(20)
			,MC036_BILLTYPE VARCHAR(20)
			,MC037_FACTYPE VARCHAR(20)
			,MC038_STATUS VARCHAR(20)
			,MC039_ADMDX VARCHAR(60)
			,MC040_ECODE VARCHAR(50)
			,MC041_DX1 VARCHAR(50)
			,MC042_DX2 VARCHAR(50)
			,MC043_DX3 VARCHAR(50)
			,MC044_DX4 VARCHAR(50)
			,MC045_DX5 VARCHAR(50)
			,MC046_DX6 VARCHAR(50)
			,MC047_DX7 VARCHAR(50)
			,MC048_DX8 VARCHAR(50)
			,MC049_DX9 VARCHAR(50)
			,MC050_DX10 VARCHAR(50)
			,MC051_DX11 VARCHAR(50)
			,MC052_DX12 VARCHAR(50)
			,MC053_DX13 VARCHAR(50)
			,MC054_REV VARCHAR(10)
			,MC055_CPT VARCHAR(10)
			,MC056_MOD1 VARCHAR(20)
			,MC057_MOD2 VARCHAR(20)
			,MC057A_MOD3 VARCHAR(20)
			,MC057B_MOD4 VARCHAR(20)
			,MC058_OP VARCHAR(40)
			,MC059_FDATE VARCHAR(50)
			,MC060_LDATE VARCHAR(50)
			,MC061_QTY VARCHAR(50)
			,MC063_TPAY VARCHAR(50)
			,MC064_PREPAID VARCHAR(50)
			,MC065_COPAY VARCHAR(50)
			,MC066_COINS VARCHAR(50)
			,MC067_DED VARCHAR(50)
			,MC069_DISDAT VARCHAR(50)
			,MC071_DRG VARCHAR(50)
			,MC072_DRGVER VARCHAR(20)
			,MC073_APC VARCHAR(40)
			,MC074_APCVER VARCHAR(20)
			,MC075_NDC VARCHAR(50)
			,MC076_BILLPRVIDN VARCHAR(30)
			,MC077_NPI VARCHAR(20)
			,MC078_PRVLNAME VARCHAR(100)
			,MC200_PRINDGNS VARCHAR(50)
			,MC201_POA VARCHAR(50)
			,MC202_ADMDGNS VARCHAR(50)
			,MC203_RFVDGNS1 VARCHAR(50)
			,MC204_RFVDGNS2 VARCHAR(50)
			,MC205_RFVDGNS3 VARCHAR(50)
			,MC206_ECOM1 VARCHAR(50)
			,MC207_POA1 VARCHAR(10)
			,MC208_ECOM2 VARCHAR(50)
			,MC209_POA2 VARCHAR(10)
			,MC210_ECOM3 VARCHAR(50)
			,MC211_POA3 VARCHAR(10)
			,MC212_ECOM4 VARCHAR(50)
			,MC213_POA4 VARCHAR(10)
			,MC214_ECOM5 VARCHAR(50)
			,MC215_POA5 VARCHAR(10)
			,MC216_ECOM6 VARCHAR(50)
			,MC217_POA6 VARCHAR(10)
			,MC218_ECOM7 VARCHAR(50)
			,MC219_POA7 VARCHAR(10)
			,MC220_ECOM8 VARCHAR(50)
			,MC221_POA8 VARCHAR(10)
			,MC222_ECOM9 VARCHAR(50)
			,MC223_POA9 VARCHAR(10)
			,MC224_ECOM10 VARCHAR(50)
			,MC225_POA10 VARCHAR(10)
			,MC226_ECOM11 VARCHAR(50)
			,MC227_POA11 VARCHAR(10)
			,MC228_ECOM12 VARCHAR(50)
			,MC229_POA12 VARCHAR(10)
			,MC230_ECOM13 VARCHAR(50)
			,MC231_POA13 VARCHAR(10)
			,MC232_ECOM14 VARCHAR(50)
			,MC233_POA14 VARCHAR(10)
			,MC234_ECOM15 VARCHAR(50)
			,MC235_POA15 VARCHAR(10)
			,MC236_ECOM16 VARCHAR(50)
			,MC237_POA16 VARCHAR(10)
			,MC238_ECOM17 VARCHAR(50)
			,MC239_POA17 VARCHAR(10)
			,MC240_ECOM18 VARCHAR(50)
			,MC241_POA18 VARCHAR(10)
			,MC242_ECOM19 VARCHAR(50)
			,MC243_POA19 VARCHAR(10)
			,MC244_ECOM20 VARCHAR(50)
			,MC245_POA20 VARCHAR(10)
			,MC246_ECOM21 VARCHAR(50)
			,MC247_POA21 VARCHAR(10)
			,MC248_ECOM22 VARCHAR(50)
			,MC249_POA22 VARCHAR(10)
			,MC250_ECOM23 VARCHAR(50)
			,MC251_POA23 VARCHAR(10)
			,MC252_ECOM24 VARCHAR(50)
			,MC253_POA24 VARCHAR(10)
			,MC254_OTHDX1 VARCHAR(50)
			,MC255_OTHPOA1 VARCHAR(10)
			,MC256_OTHDX2 VARCHAR(50)
			,MC257_OTHPOA2 VARCHAR(10)
			,MC258_OTHDX3 VARCHAR(50)
			,MC259_OTHPOA3 VARCHAR(10)
			,MC260_OTHDX4 VARCHAR(50)
			,MC261_OTHPOA4 VARCHAR(10)
			,MC262_OTHDX5 VARCHAR(50)
			,MC263_OTHPOA5 VARCHAR(10)
			,MC264_OTHDX6 VARCHAR(50)
			,MC265_OTHPOA6 VARCHAR(10)
			,MC266_OTHDX7 VARCHAR(50)
			,MC267_OTHPOA7 VARCHAR(10)
			,MC268_OTHDX8 VARCHAR(50)
			,MC269_OTHPOA8 VARCHAR(10)
			,MC270_OTHDX9 VARCHAR(50)
			,MC271_OTHPOA9 VARCHAR(10)
			,MC272_OTHDX10 VARCHAR(50)
			,MC273_OTHPOA10 VARCHAR(10)
			,MC274_OTHDX11 VARCHAR(50)
			,MC275_OTHPOA11 VARCHAR(10)
			,MC276_OTHDX12 VARCHAR(50)
			,MC277_OTHPOA12 VARCHAR(10)
			,MC278_OTHDX13 VARCHAR(50)
			,MC279_OTHPOA13 VARCHAR(10)
			,MC280_OTHDX14 VARCHAR(50)
			,MC281_OTHPOA14 VARCHAR(10)
			,MC282_OTHDX15 VARCHAR(50)
			,MC283_OTHPOA15 VARCHAR(10)
			,MC284_OTHDX16 VARCHAR(50)
			,MC285_OTHPOA16 VARCHAR(10)
			,MC286_OTHDX17 VARCHAR(50)
			,MC287_OTHPOA17 VARCHAR(10)
			,MC288_OTHDX18 VARCHAR(50)
			,MC289_OTHPOA18 VARCHAR(10)
			,MC290_OTHDX19 VARCHAR(50)
			,MC291_OTHPOA19 VARCHAR(10)
			,MC292_OTHDX20 VARCHAR(50)
			,MC293_OTHPOA20 VARCHAR(10)
			,MC294_OTHDX21 VARCHAR(50)
			,MC295_OTHPOA21 VARCHAR(10)
			,MC296_OTHDX22 VARCHAR(50)
			,MC297_OTHPOA22 VARCHAR(10)
			,MC298_OTHDX23 VARCHAR(50)
			,MC299_OTHPOA23 VARCHAR(10)
			,MC300_OTHDX24 VARCHAR(50)
			,MC301_OTHPOA24 VARCHAR(10)
			,MC302_PRNPRCDRCD VARCHAR(70)
			,MC303_OTHPRCDRCD1 VARCHAR(70)
			,MC304_OTHPRCDRCD2 VARCHAR(70)
			,MC305_OTHPRCDRCD3 VARCHAR(70)
			,MC306_OTHPRCDRCD4 VARCHAR(70)
			,MC307_OTHPRCDRCD5 VARCHAR(70)
			,MC308_OTHPRCDRCD6 VARCHAR(70)
			,MC309_OTHPRCDRCD7 VARCHAR(70)
			,MC310_OTHPRCDRCD8 VARCHAR(70)
			,MC311_OTHPRCDRCD9 VARCHAR(70)
			,MC312_OTHPRCDRCD10 VARCHAR(70)
			,MC313_OTHPRCDRCD11 VARCHAR(70)
			,MC314_OTHPRCDRCD12 VARCHAR(70)
			,MC315_OTHPRCDRCD13 VARCHAR(70)
			,MC316_OTHPRCDRCD14 VARCHAR(70)
			,MC317_OTHPRCDRCD15 VARCHAR(70)
			,MC318_OTHPRCDRCD16 VARCHAR(70)
			,MC319_OTHPRCDRCD17 VARCHAR(70)
			,MC320_OTHPRCDRCD18 VARCHAR(70)
			,MC321_OTHPRCDRCD19 VARCHAR(70)
			,MC322_OTHPRCDRCD20 VARCHAR(70)
			,MC323_OTHPRCDRCD21 VARCHAR(70)
			,MC324_OTHPRCDRCD22 VARCHAR(70)
			,MC325_OTHPRCDRCD23 VARCHAR(70)
			,MC326_OTHPRCDRCD24 VARCHAR(70)
			,MC899_RECTYPE VARCHAR(20)
			,MC901_AGE VARCHAR(50)
			,MC902_IDN VARCHAR(50)
			,MC905_MEDICARE VARCHAR(10)
			,MC906_FILEID VARCHAR(50)
			,MC907_MHDO_CLAIM VARCHAR(100)
			,MC908_MHDO_SUBSSN VARCHAR(100)
			,MC909_MHDO_CONTRACT VARCHAR(100)
			,MC910_MHDO_MEMSSN VARCHAR(100)
			,MC911_MHDO_MEMBERID VARCHAR(100)
			,MC912_PRVIDN VARCHAR(50)
			,MC913_MHDO_PRODUCT VARCHAR(20)
			,MC915_PAID_YR VARCHAR(50)
			,MC916_PAID_MON VARCHAR(50)
			,MC917_INCURRED_YR VARCHAR(50)
			,MC918_INCURRED_MON VARCHAR(50)
			,MC919_PAID_QTR VARCHAR(50)
			,MC920_INCURRED_QTR VARCHAR(50)
			,MC108_ATT_NPI VARCHAR(20) 
			,MC109_ATT_FNAME VARCHAR(40)
			,MC110_ATT_MNAME VARCHAR(25)
			,MC111_ATT_LNAME VARCHAR(100)
			,MC113_ATT_PRVSPEC VARCHAR(20)
			,MC115_OP_NPI VARCHAR(20)
			,MC116_OP_FNAME VARCHAR(40)
			,MC117_OP_MNAME VARCHAR(25)
			,MC118_OP_LNAME VARCHAR(100)
			,MC121_RFR_NPI VARCHAR(20)
			,MC122_RFR_FNAME VARCHAR(40)
			,MC123_RFR_MNAME VARCHAR(25)
			,MC124_RFR_LNAME VARCHAR(100)
			,MC950_SERVICING_NPI VARCHAR(20)
			,MC955_COUNTY_FIPS VARCHAR(50)
    );
  END
;
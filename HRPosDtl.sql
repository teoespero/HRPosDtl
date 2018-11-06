/*
	
	HRPosDtl
	The HRPosDtl table tracks the details of a position.
*/

select 
	DistrictID,
	rtrim(DistrictAbbrev) as DistrictAbbrev,
	DistrictTitle
from tblDistrict

select 
	(select DistrictId from tblDistrict) as OrgId,
	pcd.SlotNum as PosID,
	CONVERT(VARCHAR(10), pcd.EffectiveDate, 110) as DateFrom,
	CONVERT(VARCHAR(10), pcd.InactiveDate, 110) as DateThru,
	pcd.FTE as FTEAuthorized,
	pcd.SiteID,
	si.SiteName,
	cl.ClassificationID as JobCategoryId,
	cl.ClassDescription as JobCategory,
	su.SubClassificationID as JobClassId,
	su.SubClassDesc as JobClass,
	null as BargUnitId,
	pcd.SupervisorEmployeeID as PosIdSupervisor,
	null as DivisionID,
	null as AcademicDeptCode,
	pcd.Comments as Comment,
	jt.JobTitle,
	ct.CompType,
	ser.Series,
	smg.GroupName,
	sm.RowNumber,
	sm.ColNumber,
	sm.StepColumn,
	sm.Value
from tblPositionControlDetails pcd
inner join
	tblJobTitles jt
	on pcd.pcJobTitleID = jt.JobTitleID
	and pcd.InactiveDate is null
inner join
	tblSubClassifications su
	on su.SubClassificationID = jt.SubClassificationID
inner join
	tblClassifications cl
	on cl.ClassificationID = su.scClassificationID
left join
	tblSite si
	on pcd.SiteID = si.SiteID
left join
	tblCompDetails cd
	on pcd.PositionControlID = cd.cdPositionControlID
	and cd.FiscalYear = 2018
	and cd.InactiveDate is null
left join
	tblSalaryMatrix sm
	on sm.SalaryMatrixID = cd.SalaryMatrixID
left join
	tblSalaryMatrixGroup smg
	on sm.mxGroup = smg.SalaryMatrixGroupID
left join
	tblSalaryMatrixSeries ser
	on ser.mxSeriesID = sm.SeriesID
left join
	tblCompType ct
	on ct.CompTypeID = sm.smCompTypeID
order by pcd.SlotNum asc


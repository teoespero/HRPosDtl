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
	pcd.PositionControlID as PosID,
	CONVERT(VARCHAR(10), pcd.EffectiveDate, 110) as DateFrom,
	CONVERT(VARCHAR(10), pcd.InactiveDate, 110) as DateThru,
	pcd.FTE as FTEAuthorized,
	pcd.SiteID,
	jt.SubClassificationID as JobCategoryId,
	jt.JobTitleID as JobClassId,
	null as BargUnitId,
	pcd.SupervisorEmployeeID as PosIdSupervisor,
	null as DivisionID,
	null as AcademicDeptCode,
	pcd.Comments as Comment,
	cl.ClassDescription,
	su.SubClassDesc,
	jt.JobTitle
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




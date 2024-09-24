-- Create tables
CREATE TABLE Crime (
 CrimeID INT PRIMARY KEY,
 IncidentType VARCHAR(255),
 IncidentDate DATE,
 Location VARCHAR(255),
 Description TEXT,
 Status VARCHAR(20)
)
CREATE TABLE Victim (
 VictimID INT PRIMARY KEY,
 CrimeID INT,
 Name VARCHAR(255),
 ContactInfo VARCHAR(255),
 Injuries VARCHAR(255),
 FOREIGN KEY (CrimeID) REFERENCES Crime(CrimeID)
)
CREATE TABLE Suspect (
 SuspectID INT PRIMARY KEY,
 CrimeID INT,
 Name VARCHAR(255),
 Description TEXT,
 CriminalHistory TEXT,
 FOREIGN KEY (CrimeID) REFERENCES Crime(CrimeID)
)

-- Insert sample data
INSERT INTO Crime (CrimeID, IncidentType, IncidentDate, Location, Description, Status)
VALUES
 (1, 'Robbery', '2023-09-15', '123 Main St, Cityville', 'Armed robbery at a convenience store', 'Open'),
 (2, 'Homicide', '2023-09-20', '456 Elm St, Townsville', 'Investigation into a murder case', 'Under
Investigation'),
 (3, 'Theft', '2023-09-10', '789 Oak St, Villagetown', 'Shoplifting incident at a mall', 'Closed');
INSERT INTO Victim (VictimID, CrimeID, Name, ContactInfo, Injuries)
VALUES
 (1, 1, 'John Doe', 'johndoe@example.com', 'Minor injuries'),
 (2, 2, 'Jane Smith', 'janesmith@example.com', 'Deceased'),
  (3, 3, 'Alice Johnson', 'alicejohnson@example.com', 'None');
INSERT INTO Suspect (SuspectID, CrimeID, Name, Description, CriminalHistory)
VALUES
 (1, 1, 'Robber 1', 'Armed and masked robber', 'Previous robbery convictions'),
 (2, 2, 'Unknown', 'Investigation ongoing', NULL),
 (3, 3, 'Suspect 1', 'Shoplifting suspect', 'Prior shoplifting arrests');

-- adding age column and updating age column to Victim and Suspect.
alter table Victim
add Age INT

alter table Suspect
add Age INT

update Victim set Age = 35 where VictimID = 1
update Victim set Age = 24 where VictimID = 2
update Victim set Age = 29 where VictimID = 3

update Suspect set Age = 45 where SuspectID = 1
update Suspect set Age = 30 where SuspectID = 2
update Suspect set Age = 28 where SuspectID = 3

-- solving the queries
 -- 1. Select all open incidents.
 select * 
 from Crime
 where Status='Open'

 --2. Find the total number of incidents.select count(*) as [Total No. Of Incidents]from Crime--3. List all unique incident types.select distinct(IncidentType) from Crime--4. Retrieve incidents that occurred between '2023-09-01' and '2023-09-10'select *from Crime where IncidentDate between '2023-09-01' AND '2023-09-10'--5. List persons involved in incidents in descending order of Incident Date.select * from Suspectselect * from Victimselect v.Name as [Victim Name],v.Age as [Victim Age], s.Name AS [Suspect Name],s.Age as [Suspect Age]
from Crime c
left join Victim v on c.CrimeID = v.CrimeID
left join Suspect s on c.CrimeID = s.CrimeID
order by s.Age desc, v.age desc

--6. Find the average age of persons involved in incidents.

select Age from Victim
union all
select Age from Suspect

select avg(age) as [Avg. Ages]
from (select Age from Victim
union all
select Age from Suspect) as [All Ages]

--7. List incident types and their counts, only for open cases.

select IncidentType, count(CrimeID) as [Incident Count]
from Crime
where Status = 'Open'
group by IncidentType

--8. Find persons with names containing 'Doe'.

select * from Victim
select * from Suspect

select Name
from (select Name 
from Victim
where Name like '%Doe%'
union all
select Name 
from Suspect
where Name like '%Doe%'
) as Names

--9. Retrieve the names of persons involved in open cases and closed cases.

select [all].Name, c.Status
from (select *
from Victim
union all
select * 
from Suspect) as [all]
join Crime as c
on c.CrimeID=[all].CrimeID
where c.Status='Open' or c.Status='Closed'

--10.  List incident types where there are persons aged 30 or 35 involved.

select c.IncidentType
from (select *
from Victim
union all
select * 
from Suspect) as [all]
join Crime c
on c.CrimeID=[all].CrimeID
where [all].age='30' or [all].age='35'

--11. Find persons involved in incidents of the same type as 'Robbery'.

select Name
from (select *
from Victim
union all
select * 
from Suspect) as [all]
join Crime c
on c.CrimeID=[all].CrimeID
where c.IncidentType='Robbery'

--12. List incident types with more than one open case.select IncidentType, count(CrimeID) as [Open Count]from Crimewhere Status='Open'group by IncidentTypehaving count(CrimeID)>1--13. List all incidents with suspects whose names also appear as victims in other incidents.select s.Name,c.IncidentType
from Crime as c
join Suspect as s ON c.CrimeID = s.CrimeID
where exists (select v.Name from Victim as vwhere s.Name=v.Name)--14. Retrieve all incidents along with victim and suspect details.select *, v.Name as [Victim Name], s.Name as [Suspect Name]
FROM Crime as c
join Victim as v on c.CrimeID = v.CrimeID
join Suspect as s on c.CrimeID = s.CrimeID
--15. Find incidents where the suspect is older than any victim.select *FROM Crime as c
join Victim as v on c.CrimeID = v.CrimeID
join Suspect as s on c.CrimeID = s.CrimeID
where s.Age > (select Age 
from Victim as v
where v.CrimeID=s.CrimeID)

--16. Find suspects involved in multiple incidents

Select Name, count(CrimeID) as [No. of Incidents]
from Suspect
group by Name
having count(CrimeID)>1

--17. List incidents with no suspects involved.

select c.*
from Crime as c
left join Suspect as s
on c.CrimeID=s.CrimeID
where s.SuspectID is null

--18. List all cases where at least one incident is of type 'Homicide' and all other incidents are of type 'Robbery'.

select CrimeID, IncidentType
from Crime 
where IncidentType = 'Homicide' 
group by CrimeID,IncidentType
having count(CrimeID)>=1
UNION all
select CrimeID, IncidentType
from Crime 
where IncidentType = 'Robbery'

--19. . Retrieve a list of all incidents and the associated suspects, showing suspects for each incident, or'No Suspect' if there are none.

select isnull(s.Name,'No Suspect') as [Suspect Name],c.IncidentType
from Suspect as s
join Crime as c
on c.CrimeID=s.CrimeID

--20. List all suspects who have been involved in incidents with incident types 'Robbery' or 'Assault'

select isnull(s.Name,'No Suspect') as [Suspect Name],c.IncidentType
from Suspect as s
join Crime as c
on c.CrimeID=s.CrimeID
where c.IncidentType='Robbery' or c.IncidentType='Assault'
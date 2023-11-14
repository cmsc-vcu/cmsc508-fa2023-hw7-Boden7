# hw7-ddl.sql

## DO NOT RENAME OR OTHERWISE CHANGE THE SECTION TITLES OR ORDER.
## The autograder will look for specific code sections. If it can't find them, you'll get a "0"

# Code specifications.
# 0. Where there a conflict between the problem statement in the google doc and this file, this file wins.
# 1. Complete all sections below.
# 2. Table names must MATCH EXACTLY to schemas provided.
# 3. Define primary keys in each table as appropriate.
# 4. Define foreign keys connecting tables as appropriate.
# 5. Assign ID to skills, people, roles manually (you must pick the ID number!)
# 6. Assign ID in the peopleskills and peopleroles automatically (use auto_increment)
# 7. Data types: ONLY use "int", "varchar(255)", "varchar(4096)" or "date" as appropriate.

# Section 1
# Drops all tables.  This section should be amended as new tables are added.

SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS peopleroles;
DROP TABLE IF EXISTS peopleskills;
DROP TABLE IF EXISTS people;
DROP TABLE IF EXISTS skills;
DROP TABLE IF EXISTS roles;
# ... 
SET FOREIGN_KEY_CHECKS=1;

# Section 2
# Create skills( id,name, description, tag, url, time_commitment)
# ID, name, description and tag cannot be NULL. Other fields can default to NULL.
# tag is a skill category grouping.  You can assign it based on your skill descriptions.
# time committment offers some sense of how much time was required (or will be required) to gain the skill.
# You can assign the skill descriptions.  Please be creative!

drop table if exists skills;
create table skills(
    id int NOT NULL,
    name varchar(255) NOT NULL,
    description varchar(4096) NOT NULL DEFAULT '(default description)',
    tag varchar(255) NOT NULL,
    url varchar(255) DEFAULT NULL,
    time_commitment int DEFAULT NULL,
    primary key(id)
);

# Section 3
# Populate skills
# Populates the skills table with eight skills, their tag fields must exactly contain “Skill 1”, “Skill 2”, etc.
# You can assign skill names.  Please be creative!

insert into skills (id, name, tag) values
    (1, 'hotdog eating', 'Skill 1'),
    (2, 'phonebook ripping', 'Skill 2'),
    (3, 'bowling', 'Skill 3'),
    (4, 'time management', 'Skill 4'),
    (5, 'speed reading', 'Skill 5'),
    (6, 'scent tracking', 'Skill 6'),
    (7, 'high vertical jump', 'Skill 7'),
    (8, 'racing', 'Skill 8');


# Section 4
# Create people( id,first_name, last_name, email, linkedin_url, headshot_url, discord_handle, brief_bio, date_joined)
# ID cannot be null, Last name cannot be null, date joined cannot be NULL.
# All other fields can default to NULL.

drop table if exists people;
CREATE TABLE people (
    id int NOT NULL,
    last_name varchar(256) NOT NULL,
    first_name varchar(256) DEFAULT NULL,
    email varchar(256) DEFAULT NULL,
    linkedin_url varchar(256) DEFAULT NULL,
    headshot_url varchar(256) DEFAULT NULL,
    discord_handle varchar(256) DEFAULT NULL,
    brief_bio varchar(4096) DEFAULT NULL,
    date_joined date NOT NULL DEFAULT (CURRENT_DATE),
    PRIMARY KEY (id)
);

# Section 5
# Populate people with six people.
# Their last names must exactly be “Person 1”, “Person 2”, etc.
# Other fields are for you to assign.

insert into people (id, last_name, email) values 
    (1,'Person 1', 'Person_1@gmail.com'),
    (2,'Person 2', 'Person_2@gmail.com'),
    (3,'Person 3', 'Person_3@gmail.com'),
    (4,'Person 4', 'Person_4@gmail.com'),
    (5,'Person 5', 'Person_5@gmail.com'),
    (6,'Person 6', 'Person_6@gmail.com'),
    (7,'Person 7', 'Person_7@gmail.com'),
    (8,'Person 8', 'Person_8@gmail.com'),
    (9,'Person 9', 'Person_9@gmail.com'),
    (10,'Person 10', 'Person_10@gmail.com');

# Section 6
# Create peopleskills( id, skills_id, people_id, date_acquired )
# None of the fields can ba NULL. ID can be auto_increment.

drop table if exists peopleskills;
create table peopleskills (
    id int auto_increment,
    skills_id int,
    people_id int,
    date_acquired date default (current_date),
    primary key (id),
    foreign key (skills_id) references skills (id) on delete cascade,
    foreign key (people_id) references people (id) on delete cascade,
    unique (skills_id, people_id)
);

# Section 7
# Populate peopleskills such that:
# Person 1 has skills 1,3,6;
# Person 2 has skills 3,4,5;
# Person 3 has skills 1,5;
# Person 4 has no skills;
# Person 5 has skills 3,6;
# Person 6 has skills 2,3,4;
# Person 7 has skills 3,5,6;
# Person 8 has skills 1,3,5,6;
# Person 9 has skills 2,5,6;
# Person 10 has skills 1,4,5;
# Note that no one has yet acquired skills 7 and 8.
 
 insert into peopleskills (people_id, skills_id) values
    (1, 1),
    (1, 3),
    (1, 6),
    (2, 3),
    (2, 4),
    (2, 5),
    (3, 1),
    (3, 5),
    (5, 3),
    (5, 6),
    (6, 2),
    (6, 3),
    (6, 4),
    (7, 3),
    (7, 5),
    (7, 6),
    (8, 1),
    (8, 3),
    (8, 5),
    (8, 6),
    (9, 2),
    (9, 5),
    (9, 6),
    (10, 1),
    (10, 4),
    (10, 5);

select * from peopleskills;
select count(*) from peopleskills;

SELECT
    last_name,
    name,
    tag
from
    peopleskills a
    inner join people b on (a.id = b.id)
    inner join skills c on (a.id = c.id)
    order BY
        name,
        last_name;

SELECT
    last_name
from
    people a
        left join peopleskills b on (a.id = b.id)
Where
    b.id is NULL;

SELECT
    name,
    count(*)
from
    peopleskills a
    inner join people b on (a.id = b.id)
    inner join skills c on (a.id = c.id)
group BY
    name;


# Section 8
# Create roles( id, name, sort_priority )
# sort_priority is an integer and is used to provide an order for sorting roles

DROP TABLE IF EXISTS roles;
create table roles(
    id int,
    name varchar(256),
    sort_priority int,
    primary key (id)
);

# Section 9
# Populate roles
# Designer, Developer, Recruit, Team Lead, Boss, Mentor
# Sort priority is assigned numerically in the order listed above (Designer=10, Developer=20, Recruit=30, etc.)

insert into roles ( id, name, sort_priority) values
    (1, 'Designer', 10),
    (2, 'Developer', 20),
    (3, 'Recruit', 30),
    (4, 'Team Lead', 40),
    (5, 'Boss', 50),
    (6, 'Mentor', 60);
    
select * from roles;

# Section 10
# Create peopleroles( id, people_id, role_id, date_assigned )
# None of the fields can be null.  ID can be auto_increment

DROP TABLE IF EXISTS peopleroles;
create table peopleroles (
    id int auto_increment,
    people_id int NOT NULL,
    role_id int NOT NULL,
    date_role_acquired date NOT NULL DEFAULT (current_date),
    primary key (id),
    foreign key (people_id) references people (id) on delete cascade,
    foreign key (role_id) references roles (id) on delete cascade,
    unique (people_id, role_id)
);



# Section 11
# Populate peopleroles
# Person 1 is Developer 
# Person 2 is Boss, Mentor
# Person 3 is Developer and Team Lead
# Person 4 is Recruit
# person 5 is Recruit
# Person 6 is Developer and Designer
# Person 7 is Designer
# Person 8 is Designer and Team Lead
# Person 9 is Developer
# Person 10 is Developer and Designer

insert into peopleroles (people_id, role_id) values
    (1, 2),
    (2, 5),
    (2, 6),
    (3, 2),
    (3, 4),
    (4, 3),
    (5, 3),
    (6, 2),
    (6, 1),
    (7, 1),
    (8, 1),
    (8, 4),
    (9, 2),
    (10, 2),
    (10, 1);

select * from peopleroles;
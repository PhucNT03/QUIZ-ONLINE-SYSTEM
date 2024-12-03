USE master
GO

if exists (select * from sysdatabases where name='QuizSystem') drop database QuizSystem
GO

CREATE DATABASE QuizSystem
GO

USE [QuizSystem]
GO
---------------Create Table----------------
CREATE TABLE dbo.[ViewCount](
	[date]		date NOT NULL PRIMARY KEY,
	[view]		int	
)
CREATE TABLE dbo.[UserRole](
	userRoleId		int	NOT NULL identity(1,1) PRIMARY KEY,
	userRoleName	nvarchar(63) NOT NULL,
	[status]		bit,
)
-------------------------------------------
CREATE TABLE dbo.[PostCate](
	postCateId		int	NOT NULL identity(1,1) PRIMARY KEY,
	postCateName	nvarchar(63) NOT NULL,
	[status]		bit,
)
-------------------------------------------
CREATE TABLE dbo.[SubjectCate](
	subjectCateId		int	NOT NULL identity(1,1) PRIMARY KEY,
	subjectCateName	nvarchar(63) NOT NULL,
	[status]		bit,
)
-------------------------------------------
CREATE TABLE dbo.[TestType](
	testTypeId		int	NOT NULL identity(1,1) PRIMARY KEY,
	testTypeName	nvarchar(63) NOT NULL,
	[status]		bit,
)
-------------------------------------------
CREATE TABLE dbo.[QuizLevel](
	quizLevelId		int	NOT NULL identity(1,1) PRIMARY KEY,
	quizLevelName	nvarchar(63) NOT NULL,
	[status]		bit,
)
-------------------------------------------
CREATE TABLE dbo.[LessonType](
	lessonTypeId	int	NOT NULL identity(1,1) PRIMARY KEY,
	lessonTypeName	nvarchar(63) NOT NULL,
	[status]		bit,
)
-------------------------------------------
CREATE TABLE dbo.[DimensionType](
	dimensionTypeId		int	NOT NULL identity(1,1) PRIMARY KEY,
	dimensionTypeName	nvarchar(63) NOT NULL,
	[status]		bit,
)
-------------------------------------------
CREATE TABLE dbo.[User](
	userId		int				NOT NULL identity(1,1) PRIMARY KEY,
	userName	nvarchar(63)	NOT NULL,
	[password]	nvarchar(255)	NOT NULL,
	roleId		int				NOT NULL,
	profilePic	nvarchar(255),
	userMail	nvarchar(255)	UNIQUE,
	gender		bit, 
	userMobile	nchar(10)		UNIQUE,
	[status]	bit,
	FOREIGN KEY (roleId) REFERENCES dbo.[UserRole](userRoleId),
)
-------------------------------------------
CREATE TABLE dbo.[Subject](
	subjectId		int				NOT NULL identity(1,1) PRIMARY KEY,
	subjectName		nvarchar(255)	NOT NULL,
	[description]	nvarchar(1023)	NOT NULL,
	thumbnail		nvarchar(255),
	featuredSubject bit,
	[status]		bit,
)
-------------------------------------------
CREATE TABLE dbo.[CategorySubject](
	subjectId	int	NOT NULL,
	cateId		int	NOT NULL,
	FOREIGN KEY (subjectId) REFERENCES dbo.[Subject](subjectId),
	FOREIGN KEY (cateId)	REFERENCES dbo.[SubjectCate](subjectCateId),

)
-------------------------------------------
CREATE TABLE dbo.[SubjectExpert](
	subjectId		int,
	userId			int,
	[status]		bit,
	FOREIGN KEY (subjectId) REFERENCES dbo.[Subject](subjectId),
	FOREIGN KEY (userId)	REFERENCES dbo.[User](userId),
)
-------------------------------------------
CREATE TABLE dbo.[Lesson](
	lessonId		int				NOT NULL identity(1,1) PRIMARY KEY,
	subjectId		int				NOT NULL,
	lessonName		nvarchar(255)	NOT NULL,
	lessonOrder		int				NOT NULL,
	lessonTypeId	int				NOT NULL,
	--lessonTopic?
	videoLink		nvarchar(255),
	content			nvarchar(1024),
	[status]		bit,
	FOREIGN KEY (subjectId)		REFERENCES dbo.[Subject](subjectId),
	FOREIGN KEY (lessonTypeId)	REFERENCES dbo.[LessonType](lessonTypeId),
)
-------------------------------------------
CREATE TABLE dbo.[Dimension](
	dimensionId		int				NOT NULL identity(1,1) PRIMARY KEY,
	subjectId		int				NOT NULL,
	dimensionTypeId int				NOT NULL,
	dimensionName	nvarchar(255)	NOT NULL,
	[description]	nvarchar(511)	NOT NULL,
	[status]		bit,
	FOREIGN KEY (subjectId)			REFERENCES dbo.[Subject](subjectId),
	FOREIGN KEY (dimensionTypeId)	REFERENCES dbo.[DimensionType](dimensionTypeId),
)
-------------------------------------------
CREATE TABLE dbo.[PricePackage](
	packId		int				NOT NULL identity(1,1) PRIMARY KEY,
	packName	nvarchar(255)	NOT NULL,
	subjectId	int				NOT NULL,
	duration	int				NOT NULL,
	listPrice	money			NOT NULL,
	salePrice	money,
	[status]	bit,
	FOREIGN KEY	(subjectId)		REFERENCES dbo.[Subject](subjectId),
)
-------------------------------------------
CREATE TABLE dbo.[Question](
	questionId	int				NOT NULL identity(1,1) PRIMARY KEY,
	subjectId	int				NOT NULL,
	dimensionId	int				NOT NULL,
	lessonId	int				NOT NULL,
	content		nvarchar(1023)	NOT NULL,
	media		nvarchar(255),
	explanation	nvarchar(1023),
	[status]	bit,
	FOREIGN KEY (subjectId)		REFERENCES dbo.[Subject](subjectId),
	FOREIGN KEY (dimensionId)	REFERENCES dbo.[Dimension](dimensionId),
	FOREIGN KEY (lessonId)		REFERENCES dbo.[Lesson](lessonId),
)
-------------------------------------------
CREATE TABLE dbo.[Answer](
	answerId		int				NOT NULL identity(1,1) PRIMARY KEY,
	questionId		int				NOT NULL,
	answerContent	nvarchar(1023)	NOT NULL,
	isCorrect		bit				NOT NULL,
	[status]		bit,
	FOREIGN KEY (questionId) REFERENCES dbo.[Question](questionId),
)
-------------------------------------------
CREATE TABLE dbo.[Quiz](
	quizId			int				NOT NULL identity(1,1) PRIMARY KEY,
	lessonId		int				,
	subjectId		int				NOT NULL,
	quizName		nvarchar(255)	,
	quizLevelId		int				,
	quizDuration	int				NOT NULL, --Minutes
	passRate		int, --1-100?
	testTypeId		int				NOT NULL,
	[description]	nvarchar(1023),
	numberQuestion	int				NOT NULL,
	dimensionTypeId int				NOT NULL,
	[status]		bit,
	FOREIGN KEY (lessonId)			REFERENCES dbo.[Lesson](lessonId),
	FOREIGN KEY (subjectId)			REFERENCES dbo.[Subject](subjectId),
	FOREIGN KEY (quizLevelId)		REFERENCES dbo.[QuizLevel](quizLevelId),
	FOREIGN KEY (testTypeId)		REFERENCES dbo.[TestType](testTypeId),
	FOREIGN KEY (dimensionTypeId)	REFERENCES dbo.[DimensionType](dimensionTypeId),
)
-------------------------------------------
CREATE TABLE dbo.[QuizQuestion](
	quizId		int	NOT NULL,
	questionId	int NOT NULL,
	[status]	bit,
	FOREIGN KEY (quizId)		REFERENCES dbo.[Quiz](quizId),
	FOREIGN KEY (questionId)	REFERENCES dbo.[Question](questionId),
)
-------------------------------------------
CREATE TABLE dbo.[CustomerQuiz](
	quizTakeId	int			NOT NULL identity(1,1) PRIMARY KEY,
	quizId		int			NOT NULL,
	userId		int			NOT NULL,
	score		int,
	[time]      int,
	sumitedAt	datetime	NOT NULL,
	[status]	bit,
	

	FOREIGN KEY (quizId) REFERENCES dbo.[Quiz](quizId),
	FOREIGN KEY (userId) REFERENCES dbo.[User](userId),
)
-------------------------------------------
CREATE TABLE dbo.[TakeAnswer](
	takeAnswerId	int	NOT NULL identity(1,1) PRIMARY KEY,
	quizTakeId		int	NOT NULL,
	questionId		int	NOT NULL,
	answerId		int	,
	[status]		bit,
	FOREIGN KEY (quizTakeId)	REFERENCES dbo.[CustomerQuiz](quizTakeId),
	FOREIGN KEY (questionId)	REFERENCES dbo.[Question](questionId),
	FOREIGN KEY (answerId)		REFERENCES dbo.[Answer](answerId),
)
-------------------------------------------
CREATE TABLE dbo.[Registration](
	regId			int				NOT NULL identity(1,1) PRIMARY KEY,
	userId			int				NOT NULL,
	regTime			datetime		NOT NULL,
	packId			int				NOT NULL,
	cost			money,
	validFrom		datetime		NOT NULL,
	validTo			datetime		NOT NULL,
	lastUpdatedBy	int				NOT NULL, --Last updated by
	note			nvarchar(255),
	[status]		bit,
	FOREIGN KEY (userId) REFERENCES dbo.[User](userId),
	FOREIGN KEY (packId) REFERENCES dbo.[PricePackage](packId),
	FOREIGN KEY (lastUpdatedBy) REFERENCES dbo.[User](userId),
)
-------------------------------------------
CREATE TABLE dbo.[Blog](
	blogId		int				NOT NULL identity(1,1) PRIMARY KEY,
	blogTitle	nvarchar(255),
	created		datetime		NOT NULL,
	lastEdited	datetime		NOT NULL,
	author		int				NOT NULL, --User id
	detail		nvarchar(2047)	NOT NULL,
	thumbnail	nvarchar(255),
	[status]		bit,
	FOREIGN KEY (author) REFERENCES dbo.[User](userId),
)
-------------------------------------------
CREATE TABLE dbo.[BlogCate](
	blogId	int	NOT NULL,
	postCateId	int NOT NULL,
	[status]		bit,
	FOREIGN KEY (blogId) REFERENCES dbo.[Blog](blogId),
	FOREIGN KEY (postCateId) REFERENCES dbo.[PostCate](postCateId),
)
-------------------------------------------
CREATE TABLE dbo.[Slider](
	sliderId	int				NOT NULL identity(1,1) PRIMARY KEY,
	sliderTitle nvarchar(255)	NOT NULL,
	[image]		nvarchar(255),
	[link]		int,
	note		nvarchar(255),
	[status]	bit,
	FOREIGN KEY (link) REFERENCES dbo.[Subject](subjectId),
)
----------Insert Data----------------------
----------dbo.[UserRole]-------------------
INSERT INTO dbo.UserRole(userRoleName,status) VALUES('Customer',1);
INSERT INTO dbo.UserRole(userRoleName,status) VALUES('Marketing',1);
INSERT INTO dbo.UserRole(userRoleName,status) VALUES('Sale',1);
INSERT INTO dbo.UserRole(userRoleName,status) VALUES('Expert',1);
INSERT INTO dbo.UserRole(userRoleName,status) VALUES('Admin',1);
----------dbo.[PostCate]-------------------
INSERT INTO dbo.PostCate(postCateName,status) VALUES('Tips and Tricks',1);
INSERT INTO dbo.PostCate(postCateName,status) VALUES('Review and Recommendation',1);
INSERT INTO dbo.PostCate(postCateName,status) VALUES('Casuals',1);
INSERT INTO dbo.PostCate(postCateName,status) VALUES('Rest and Relax',1);
----------dbo.[SubjectCate]----------------
INSERT INTO dbo.SubjectCate(subjectCateName,status) VALUES('Computer Science',1);--1
INSERT INTO dbo.SubjectCate(subjectCateName,status) VALUES('Java',1);			--2
INSERT INTO dbo.SubjectCate(subjectCateName,status) VALUES('OOP-Object Oriented Programming',1);--3
INSERT INTO dbo.SubjectCate(subjectCateName,status) VALUES('C',1);--4
INSERT INTO dbo.SubjectCate(subjectCateName,status) VALUES('C#',1);--5
INSERT INTO dbo.SubjectCate(subjectCateName,status) VALUES('Web Design',1);--6
INSERT INTO dbo.SubjectCate(subjectCateName,status) VALUES('Digital Art',1);--7
INSERT INTO dbo.SubjectCate(subjectCateName,status) VALUES('Japanese',1);--8
INSERT INTO dbo.SubjectCate(subjectCateName,status) VALUES('English',1);--9
INSERT INTO dbo.SubjectCate(subjectCateName,status) VALUES('Algebra',1);--10
INSERT INTO dbo.SubjectCate(subjectCateName,status) VALUES('Organic Chemistry',1);--11
INSERT INTO dbo.SubjectCate(subjectCateName,status) VALUES('Basic Economic',1);--12
INSERT INTO dbo.SubjectCate(subjectCateName,status) VALUES('Buiseness Ethics',1);--13
INSERT INTO dbo.SubjectCate(subjectCateName,status) VALUES('CSS',1);--14
----------dbo.[TestType]-------------------
INSERT INTO dbo.TestType(testTypeName,status) VALUES('Simulation',1);
INSERT INTO dbo.TestType(testTypeName,status) VALUES('Lesson-Quiz',1);
INSERT INTO dbo.TestType(testTypeName,status) VALUES('Practice',1);
----------dbo.[QuizLevel]------------------
INSERT INTO dbo.QuizLevel(quizLevelName,status) VALUES('Hard',1);
INSERT INTO dbo.QuizLevel(quizLevelName,status) VALUES('Medium',1);
INSERT INTO dbo.QuizLevel(quizLevelName,status) VALUES('Easy',1);
----------dbo.[LessonType]-----------------
INSERT INTO dbo.LessonType(lessonTypeName,status) VALUES('Subject-Topic',1);
INSERT INTO dbo.LessonType(lessonTypeName,status) VALUES('Lesson',1);
INSERT INTO dbo.LessonType(lessonTypeName,status) VALUES('Quiz',1);
----------dbo.[DimensionType]--------------
INSERT INTO dbo.DimensionType(dimensionTypeName,status) VALUES('Domain',1);
INSERT INTO dbo.DimensionType(dimensionTypeName,status) VALUES('Group',1);
----------dbo.[User]-----------------------
INSERT INTO dbo.[User](userName,[password],roleId,profilePic,userMail,gender,userMobile,[status]) 
				VALUES('DuongNH',1,5,'','DuongNHHE150328@fpt.edu.vn',1,'0696044711',1);
INSERT INTO dbo.[User](userName,[password],roleId,profilePic,userMail,gender,userMobile,[status]) 
				VALUES('NamDH',1,5,'','NamDHHE150519@fpt.edu.vn',1,'0969044712',1);
INSERT INTO dbo.[User](userName,[password],roleId,profilePic,userMail,gender,userMobile,[status]) 
				VALUES('TuanPA',1,5,'','TuanPAHE150543@fpt.edu.vn',1,'0969044713',1);
INSERT INTO dbo.[User](userName,[password],roleId,profilePic,userMail,gender,userMobile,[status]) 
				VALUES('ChucNV',1,5,'','ChucNVHE150618@fpt.edu.vn',1,'0969044714',1);
INSERT INTO dbo.[User](userName,[password],roleId,profilePic,userMail,gender,userMobile,[status]) 
				VALUES('TungBT',1,5,'','TungBTHE150621@fpt.edu.vn',1,'0969044715',1);
INSERT INTO dbo.[User](userName,[password],roleId,profilePic,userMail,gender,userMobile,[status]) 
				VALUES('Expert1',1,4,'','Expert1@gmail.com',0,'0969044716',1);
INSERT INTO dbo.[User](userName,[password],roleId,profilePic,userMail,gender,userMobile,[status]) 
				VALUES('Expert2',1,4,'','Expert2@gmail.com',1,'0969044717',1);
INSERT INTO dbo.[User](userName,[password],roleId,profilePic,userMail,gender,userMobile,[status]) 
				VALUES('User1',1,1,'','User1@gmail.com',1,'0969044718',1);
INSERT INTO dbo.[User](userName,[password],roleId,profilePic,userMail,gender,userMobile,[status]) 
				VALUES('User2',1,1,'','User2@gmail.com',1,'0969044719',1);
INSERT INTO dbo.[User](userName,[password],roleId,profilePic,userMail,gender,userMobile,[status]) 
				VALUES('User3',1,1,'','User3@gmail.com',1,'0969044720',1);
INSERT INTO dbo.[User](userName,[password],roleId,profilePic,userMail,gender,userMobile,[status]) 
				VALUES('User4',1,1,'','User4@gmail.com',1,'0969044721',1);
INSERT INTO dbo.[User](userName,[password],roleId,profilePic,userMail,gender,userMobile,[status]) 
				VALUES('Sale1',1,3,'','Sale1@gmail.com',0,'0969696969',1);
----------dbo.[Subject]--------------------
INSERT INTO dbo.[Subject](subjectName,[description],thumbnail,featuredSubject,[status])
				   VALUES('OOP with Java','Object Oriented Programming Fundamentals with Java.','java-oops.png',1,1);--1
INSERT INTO dbo.[Subject](subjectName,[description],thumbnail,featuredSubject,[status])
				   VALUES('Elementary Japanese 101','Japanese from zero.','nihongo101.png',1,1);--2
INSERT INTO dbo.[Subject](subjectName,[description],thumbnail,featuredSubject,[status])
				   VALUES('Physics in Programming','Basic physics and its role in programming.','physInProgramming.png',0,1);--3
INSERT INTO dbo.[Subject](subjectName,[description],thumbnail,featuredSubject,[status])
				   VALUES('Photoshop 101','Manipulates reality with just your mouse.','pts101.png',1,1);--4
----------dbo.[CategorySubject]------------
INSERT INTO dbo.CategorySubject(subjectId,cateId) VALUES(1,2);
INSERT INTO dbo.CategorySubject(subjectId,cateId) VALUES(1,3);
INSERT INTO dbo.CategorySubject(subjectId,cateId) VALUES(2,8);
INSERT INTO dbo.CategorySubject(subjectId,cateId) VALUES(3,1);
INSERT INTO dbo.CategorySubject(subjectId,cateId) VALUES(3,10);
INSERT INTO dbo.CategorySubject(subjectId,cateId) VALUES(4,7);
----------dbo.[SubjectExpert]--------------
INSERT INTO dbo.SubjectExpert(subjectId,userId,[status]) VALUES(1,6,1);
INSERT INTO dbo.SubjectExpert(subjectId,userId,[status]) VALUES(2,7,1);
INSERT INTO dbo.SubjectExpert(subjectId,userId,[status]) VALUES(3,6,1);
INSERT INTO dbo.SubjectExpert(subjectId,userId,[status]) VALUES(3,7,1);
INSERT INTO dbo.SubjectExpert(subjectId,userId,[status]) VALUES(4,6,1);
----------dbo.[Lesson]---------------------
INSERT INTO dbo.Lesson(subjectId,lessonName,lessonOrder,lessonTypeId,videoLink,content,[status])
				VALUES(1,'Introduction',1,1,'','Welcome to this course. Maybe right now you dont know how to code in a object oriented way or dont even know Java but at the end of this course, we hope youll be able to master it.',1);
INSERT INTO dbo.Lesson(subjectId,lessonName,lessonOrder,lessonTypeId,videoLink,content,[status])
				VALUES(1,'4 main ideas of OOP in Java',2,2,'','OOP concepts in Java are the main ideas behind Java Object Oriented Programming. They are an abstraction, encapsulation, inheritance, and polymorphism. ... Basically, Java OOP concepts let us create working methods and variables, then re-use all or part of them without compromising security.',1);
INSERT INTO dbo.Lesson(subjectId,lessonName,lessonOrder,lessonTypeId,videoLink,content,[status])
				VALUES(1,'Quiz: 4 main ideas of OOP in Java',3,3,'','First quiz, but dont be too afraid.',1);
INSERT INTO dbo.Lesson(subjectId,lessonName,lessonOrder,lessonTypeId,videoLink,content,[status])
				VALUES(2,'Introduction',1,1,'','Japanese for the absolute beginners, whether for academic purposes, work or if you just admire Japan and its culture',1);
INSERT INTO dbo.Lesson(subjectId,lessonName,lessonOrder,lessonTypeId,videoLink,content,[status])
				VALUES(2,'Hiragana',2,2,'https://youtu.be/K-nw5EUxDz0','Hiragana and katakana are both kana systems. With few exceptions, each mora in the Japanese language is represented by one character (or one digraph) in each system. This may be either a vowel such as "a" (hiragana あ); a consonant followed by a vowel such as "ka" (か); or "n" (ん), a nasal sonorant which, depending on the context, sounds either like English m, n or ng ([ŋ]) when syllable-final or like the nasal vowels of French, Portuguese or Polish. Because the characters of the kana do not represent single consonants (except in the case of ん "n"), the kana are referred to as syllabic symbols and not alphabetic letters.',1);
INSERT INTO dbo.Lesson(subjectId,lessonName,lessonOrder,lessonTypeId,videoLink,content,[status])
				VALUES(2,'Basic Greetings',3,2,'https://youtu.be/o9O18DkU2Yc',
'Konnichiwa (Hi; Good afternoon.)
Ohayō gozaimasu/ Ohayō (Good morning [formal/informal])
Konbanwa (Good evening)
Hajimemashite. (How do you do?)
O-genki desu ka. (How are you? [formal])
Genki? (How are you? [informal])
Maiku-san wa? (How about you, Mike?)
Hai, genki desu. (Yes, I’m fine.)
Ē, māmā desu. (Well, so-so.)
Hai, watashi mo genki desu. (Yes, I’m fine, too.)
Mata ashita. (See you tomorrow.)
Sayōnara. (Goodbye.)
Oyasumi nasai. (Good night.)
'
,1);
INSERT INTO dbo.Lesson(subjectId,lessonName,lessonOrder,lessonTypeId,videoLink,content,[status])
				VALUES(2,'Small Quiz',4,3,'','Just a little practice and you can do it',1);
INSERT INTO dbo.Lesson(subjectId,lessonName,lessonOrder,lessonTypeId,videoLink,content,[status])
				VALUES(2,'See you again',5,1,'','Keep on learning!',1);
INSERT INTO dbo.Lesson(subjectId,lessonName,lessonOrder,lessonTypeId,videoLink,content,[status])
				VALUES(3,'Introduction',1,1,'','Introduce realism in apps and games!',1);
INSERT INTO dbo.Lesson(subjectId,lessonName,lessonOrder,lessonTypeId,videoLink,content,[status])
				VALUES(3,'Basics',2,2,'','Physics programmers create software that forms the basis of crashes, collisions and other things that move. When, for example, a car drives through water or bursts into flames, the effect needs to be similar to what would happen in real life. Physics programmers write the code, based on the laws of physics, to make this happen. It requires high-level knowledge of both physics and programming. It also requires a sense of gameplay and the right blend of realism and fun.',1);
INSERT INTO dbo.Lesson(subjectId,lessonName,lessonOrder,lessonTypeId,videoLink,content,[status])
				VALUES(3,'Small Quiz',3,3,'','Its not done yet, more lessons are on their way.',1);
INSERT INTO dbo.Lesson(subjectId,lessonName,lessonOrder,lessonTypeId,videoLink,content,[status])
				VALUES(4,'Introduction',1,1,'','Learn how to photoshop for your own needs, and for higher, professional jobs.',1);
INSERT INTO dbo.Lesson(subjectId,lessonName,lessonOrder,lessonTypeId,videoLink,content,[status])
				VALUES(4,'Some crucial skills needed in photoshop',2,2,'https://youtu.be/IyR_uYsRdPs','The key to photoshop is patience.',1);
INSERT INTO dbo.Lesson(subjectId,lessonName,lessonOrder,lessonTypeId,videoLink,content,[status])
				VALUES(4,'Small Quiz',3,3,'','Just the basics so far.',1);
----------dbo.[Dimension]------------------
INSERT INTO dbo.Dimension(dimensionName,dimensionTypeId,subjectId,[description],[status]) VALUES('Java Programming',1,1,'',1);
INSERT INTO dbo.Dimension(dimensionName,dimensionTypeId,subjectId,[description],[status]) VALUES('Japanese',2,2,'',1);
INSERT INTO dbo.Dimension(dimensionName,dimensionTypeId,subjectId,[description],[status]) VALUES('Physics',1,3,'',1);
INSERT INTO dbo.Dimension(dimensionName,dimensionTypeId,subjectId,[description],[status]) VALUES('Graphics Design',1,4,'',1);
----------dbo.[PricePackage]---------------
INSERT INTO dbo.PricePackage(packName,subjectId,duration,listPrice,salePrice,[status]) VALUES('3 months package',1,3,10.0,5,1)
INSERT INTO dbo.PricePackage(packName,subjectId,duration,listPrice,salePrice,[status]) VALUES('6 months package',1,6,20.0,10,1)
INSERT INTO dbo.PricePackage(packName,subjectId,duration,listPrice,salePrice,[status]) VALUES('12 months package',1,12,30.0,20,1)
INSERT INTO dbo.PricePackage(packName,subjectId,duration,listPrice,salePrice,[status]) VALUES('3 months package',2,3,2,null,1)
INSERT INTO dbo.PricePackage(packName,subjectId,duration,listPrice,salePrice,[status]) VALUES('6 months package',2,6,4,null,1)
INSERT INTO dbo.PricePackage(packName,subjectId,duration,listPrice,salePrice,[status]) VALUES('12 months package',2,12,6,null,1)
----------dbo.[Question]-------------------
INSERT INTO dbo.Question(subjectId,dimensionId,lessonId,[content],media,explanation,[status]) VALUES(2,2,5,'Watashi','https://www.youtube.com/embed/0PQ9mgc55ic','nihongo',1)
INSERT INTO dbo.Question(subjectId,dimensionId,lessonId,[content],media,explanation,[status]) VALUES(2,2,5,'Neko','https://icatcare.org/app/uploads/2018/07/Thinking-of-getting-a-cat.png','nihongo',1)
INSERT INTO dbo.Question(subjectId,dimensionId,lessonId,[content],media,explanation,[status]) VALUES(2,2,5,'Ohayo','https://www.thoughtco.com/thmb/06i-nrtpR2ZKY7G06_6yY3LktVw=/768x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/aamorning-9cf2e2f4546248899d2020857ce457bb.jpg','nihongo',1)
INSERT INTO dbo.Question(subjectId,dimensionId,lessonId,[content],media,explanation,[status]) VALUES(2,2,5,'Anata',NULL,'nihongo',1)
INSERT INTO dbo.Question(subjectId,dimensionId,lessonId,[content],media,explanation,[status]) VALUES(2,2,5,'Konbanwa',NULL,'nihongo',1)
INSERT INTO dbo.Question(subjectId,dimensionId,lessonId,[content],media,explanation,[status]) VALUES(2,2,5,'Arigatou gozaimasu',NULL,'nihongo',1)
INSERT INTO dbo.Question(subjectId,dimensionId,lessonId,[content],media,explanation,[status]) VALUES(2,2,5,'Mijikai',NULL,'nihongo',1)
INSERT INTO dbo.Question(subjectId,dimensionId,lessonId,[content],media,explanation,[status]) VALUES(2,2,5,'Tokei',NULL,'nihongo',1)
INSERT INTO dbo.Question(subjectId,dimensionId,lessonId,[content],media,explanation,[status]) VALUES(2,2,5,'Ashi',NULL,'nihongo',1)
INSERT INTO dbo.Question(subjectId,dimensionId,lessonId,[content],media,explanation,[status]) VALUES(2,2,5,'Kami',NULL,'nihongo',1)
INSERT INTO dbo.Question(subjectId,dimensionId,lessonId,[content],media,explanation,[status]) VALUES(1,1,1,'What is Object Oriented Programming?',NULL,'OOP Introduction',1)
INSERT INTO dbo.Question(subjectId,dimensionId,lessonId,[content],media,explanation,[status]) VALUES(1,1,1,'What are the main features of OOPs?',NULL,'OOP Introduction',1)
INSERT INTO dbo.Question(subjectId,dimensionId,lessonId,[content],media,explanation,[status]) VALUES(1,1,1,'What is an object?',NULL,'OOP Introduction',1)
INSERT INTO dbo.Question(subjectId,dimensionId,lessonId,[content],media,explanation,[status]) VALUES(1,1,1,'What is a class?',NULL,'OOP Introduction',1)
INSERT INTO dbo.Question(subjectId,dimensionId,lessonId,[content],media,explanation,[status]) VALUES(1,1,2,'What is inheritance?',NULL,'OOP Details',1)
INSERT INTO dbo.Question(subjectId,dimensionId,lessonId,[content],media,explanation,[status]) VALUES(1,1,2,'What is polymorphism?',NULL,'OOP Details',1)
INSERT INTO dbo.Question(subjectId,dimensionId,lessonId,[content],media,explanation,[status]) VALUES(1,1,2,'What is encapsulation?',NULL,'OOP Details',1)
INSERT INTO dbo.Question(subjectId,dimensionId,lessonId,[content],media,explanation,[status]) VALUES(1,1,2,'What is Data Abstraction?',NULL,'OOP Details',1)
INSERT INTO dbo.Question(subjectId,dimensionId,lessonId,[content],media,explanation,[status]) VALUES(4,4,12,'What is Adobe Photoshop?',NULL,'Photoshop Introduction',1)
INSERT INTO dbo.Question(subjectId,dimensionId,lessonId,[content],media,explanation,[status]) VALUES(4,4,12,'Which of the following can you NOT do with Photoshop?',NULL,'Photoshop Introduction',1)
INSERT INTO dbo.Question(subjectId,dimensionId,lessonId,[content],media,explanation,[status]) VALUES(4,4,12,'Once you build the layers in your graphic design, you cannot rearrange them?',NULL,'Photoshop Introduction',1)
INSERT INTO dbo.Question(subjectId,dimensionId,lessonId,[content],media,explanation,[status]) VALUES(4,4,12,'Photoshop documents are composed of layers, which can basically be described as single transparent sheets which hold particular pieces of an image?',NULL,'Photoshop Details',1)
INSERT INTO dbo.Question(subjectId,dimensionId,lessonId,[content],media,explanation,[status]) VALUES(4,4,12,'Primary colors consist of:?',NULL,'Photoshop Details',1)

-------------------------------------------
----------dbo.[Answer]---------------------
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(1,'I',1,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(1,'You',0,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(1,'Friend',0,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(1,'Foe',0,1)--1
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(2,'Cat',1,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(2,'Dog',0,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(2,'Ant',0,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(2,'Elephant',0,1)--2
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(3,'Good Morning',1,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(3,'Ring',0,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(3,'Television',0,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(3,'Work',0,1)--3
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(4,'You',1,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(4,'Snake',0,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(4,'Dice',0,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(4,'Brain',0,1)--4
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(5,'Good Night',1,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(5,'Ten',0,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(5,'Sky',0,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(5,'Castle',0,1)--5
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(6,'Thank you',1,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(6,'Sorry',0,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(6,'Angry',0,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(6,'Happy',0,1)--6
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(7,'Short',1,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(7,'Long',0,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(7,'Straight',0,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(7,'Curved',0,1)--7
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(8,'Clock',1,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(8,'Dishes',0,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(8,'Meet',0,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(8,'Chicken',0,1)--8
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(9,'Leg',1,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(9,'Face',0,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(9,'Ear',0,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(9,'Eye',0,1)--9
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(10,'Hair',1,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(10,'Finger',0,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(10,'Foot',0,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(10,'Food',0,1)--10
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(11,'Object-oriented programming (OOP) is a fundamental programming paradigm used by nearly every developer at some point in their career.',1,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(11,'Object-oriented programming (OOP) is something.',0,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(11,'Object-oriented programming (OOP) is important in Java.',0,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(11,'All the above.',0,1)--11
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(12,'Classes,Objects,Inheritance,Polymorphism,Data Abstraction and Encapsulation.',1,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(12,'Classes,Objects,Inheritance,Polymorphism,Data Abstraction and Encapsulation,Dynamic Binding,Message Passing.',0,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(12,'Classes,Objects,Inheritance,Polymorphism.',0,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(12,'All the above',0,1)--12
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(13,'An object is a noun (or pronoun) governed by a verb or a preposition.',0,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(13,'Object is an instance of a class. An object in OOPS is nothing but a self-contained component which consists of methods and properties to make a particular type of data useful.A material thing that can be seen and touched.',1,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(13,'A person or thing to which a specified action or feeling is directed.',0,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(13,'All the above',0,1)--13
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(14,'Class in Java determines how an object will behave and what the object will contain.',0,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(14,'It is a basic concept of Object-Oriented Programming which revolve around the real-life entities.',0,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(14,'Class are a blueprint or a set of instructions to build a specific type of object.',1,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(14,'A Class in object oriented programming is a blueprint or prototype that defines the variables and the methods.',0,1)--14
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(15,'The extends keyword extends a class and is an indicator that a class is being inherited by another class.',0,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(15,'It is a basic concept of Object-Oriented Programming which revolve around the real-life entities.',0,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(15,'Inheritance uses the “extends” keyword to create a derived class by reusing base class code.',0,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(15,'Inheritance in Java is a concept that acquires the properties from one class to other classes.',1,1)--15
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(16,'the presence of genetic variation within a population, upon which natural selection can operate.',0,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(16,'Polymorphism is the method in an object-oriented programming language that performs different things as per the objectclass.',1,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(16,'the occurrence of different forms among the members of a population or colony, or in the life cycle of an individual organism.',0,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(16,'Polymorphism in Java is a concept that acquires the properties from one class to other classes.',0,1)--16
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(17,'The extends keyword extends a class and is an indicator that a class is being inherited by another class.',0,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(17,'A variable in a class are set as “private” as shown below. It can only be accessed with the methods defined in the class. No other class or object can access them.',0,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(17,'If a data member is private, it means it can only be accessed within the same class. No outside class can access private data member or variable of other class.',0,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(17,'Encapsulation in Java is a mechanism to wrap up variables(data) and methods(code) together as a single unit.',1,1)--17
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(18,'Abstraction in Programming is about hiding unwanted details while showing most essential information.',0,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(18,'An abstract class can have both abstract and non-abstract methods.',0,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(18,'Abstraction is the concept of object-oriented programming that “shows” only essential attributes and “hides” unnecessary information',1,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(18,'Inheritance in Java is a concept that acquires the properties from one class to other classes.',0,1)--18
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(19,'Adobe Photoshop is software that is extensively used for raster image editing, graphic design and digital art.',1,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(19,'Shadows and other effects such as alpha compositing can be applied.',0,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(19,'It is also possible of apply several color models to these layers – CMYK, RGB, Spot Color, and Duotone and Lap color space.',0,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(19,'Adobe Photoshop was originally developed in 1987 by Thomas and John Knoll, and then Adobe Systems Inc. bought the license to distribute in 1988.',0,1)--19
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(20,'Restore old photographs.',0,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(20,'Create original artwork.',0,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(20,'Create Flash movies.',1,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(20,'Open JPEG files.',0,1)--20
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(21,'True.',0,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(21,'False.',1,1)--21
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(22,'True.',1,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(22,'False.',0,1)--22
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(23,'Yellow, orange and green.',0,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(23,'Blue, red and yellow.',1,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(23,'The mix of two complimentary colors.',0,1)
INSERT INTO dbo.Answer(questionId,answerContent,isCorrect,status) VALUES(23,'Blue, blue-green, and green.',0,1)--23
-------------------------------------------
----------dbo.[Quiz]-----------------------
INSERT INTO dbo.Quiz(lessonId,subjectId,quizName,quizLevelId,quizDuration,passRate,testTypeId,[description],numberQuestion,dimensionTypeId,[status]) VALUES(5,2,'Practice Quiz',3,7200,NULL,2,NULL,10,2,1)
INSERT INTO dbo.Quiz(lessonId,subjectId,quizName,quizLevelId,quizDuration,passRate,testTypeId,[description],numberQuestion,dimensionTypeId,[status]) VALUES(5,2,'Exam Quiz',3,900,NULL,1,NULL,10,2,1)
INSERT INTO dbo.Quiz(lessonId,subjectId,quizName,quizLevelId,quizDuration,passRate,testTypeId,[description],numberQuestion,dimensionTypeId,[status]) VALUES(5,2,'Exam Quiz',3,30,NULL,1,NULL,10,2,1)
-------------------------------------------
----------dbo.[QuizQuestion]---------------
INSERT INTO dbo.QuizQuestion(quizId,questionId,[status]) VALUES(1,1,1)
INSERT INTO dbo.QuizQuestion(quizId,questionId,[status]) VALUES(1,2,1)
INSERT INTO dbo.QuizQuestion(quizId,questionId,[status]) VALUES(1,3,1)
INSERT INTO dbo.QuizQuestion(quizId,questionId,[status]) VALUES(1,4,1)
INSERT INTO dbo.QuizQuestion(quizId,questionId,[status]) VALUES(1,5,1)
INSERT INTO dbo.QuizQuestion(quizId,questionId,[status]) VALUES(1,6,1)
INSERT INTO dbo.QuizQuestion(quizId,questionId,[status]) VALUES(1,7,1)
INSERT INTO dbo.QuizQuestion(quizId,questionId,[status]) VALUES(1,8,1)
INSERT INTO dbo.QuizQuestion(quizId,questionId,[status]) VALUES(1,9,1)
INSERT INTO dbo.QuizQuestion(quizId,questionId,[status]) VALUES(1,10,1)
INSERT INTO dbo.QuizQuestion(quizId,questionId,[status]) VALUES(2,1,1)
INSERT INTO dbo.QuizQuestion(quizId,questionId,[status]) VALUES(2,2,1)
INSERT INTO dbo.QuizQuestion(quizId,questionId,[status]) VALUES(2,3,1)
INSERT INTO dbo.QuizQuestion(quizId,questionId,[status]) VALUES(2,4,1)
INSERT INTO dbo.QuizQuestion(quizId,questionId,[status]) VALUES(2,5,1)
INSERT INTO dbo.QuizQuestion(quizId,questionId,[status]) VALUES(2,6,1)
INSERT INTO dbo.QuizQuestion(quizId,questionId,[status]) VALUES(2,7,1)
INSERT INTO dbo.QuizQuestion(quizId,questionId,[status]) VALUES(2,8,1)
INSERT INTO dbo.QuizQuestion(quizId,questionId,[status]) VALUES(2,9,1)
INSERT INTO dbo.QuizQuestion(quizId,questionId,[status]) VALUES(2,10,1)
INSERT INTO dbo.QuizQuestion(quizId,questionId,[status]) VALUES(3,1,1)
INSERT INTO dbo.QuizQuestion(quizId,questionId,[status]) VALUES(3,2,1)
INSERT INTO dbo.QuizQuestion(quizId,questionId,[status]) VALUES(3,3,1)
INSERT INTO dbo.QuizQuestion(quizId,questionId,[status]) VALUES(3,4,1)
INSERT INTO dbo.QuizQuestion(quizId,questionId,[status]) VALUES(3,5,1)
INSERT INTO dbo.QuizQuestion(quizId,questionId,[status]) VALUES(3,6,1)
INSERT INTO dbo.QuizQuestion(quizId,questionId,[status]) VALUES(3,7,1)
INSERT INTO dbo.QuizQuestion(quizId,questionId,[status]) VALUES(3,8,1)
INSERT INTO dbo.QuizQuestion(quizId,questionId,[status]) VALUES(3,9,1)
INSERT INTO dbo.QuizQuestion(quizId,questionId,[status]) VALUES(3,10,1)

-------------------------------------------
----------dbo.[CustomerQuiz]---------------
-------------------------------------------
----------dbo.[TakeAnswer]-----------------
-------------------------------------------
----------dbo.[Registration]---------------
INSERT INTO dbo.Registration([userId],[regTime],[packId],[cost],[validFrom],[validTo],[lastUpdatedBy],[note],[status]) VALUES (1,'2020-12-12',2,20.0,'2020-12-12','2021-6-12',1,null,1)
INSERT INTO dbo.Registration([userId],[regTime],[packId],[cost],[validFrom],[validTo],[lastUpdatedBy],[note],[status]) VALUES (1,'2021-10-12',5,20.0,'2020-12-12','2021-6-12',1,null,NULL)
INSERT INTO dbo.Registration([userId],[regTime],[packId],[cost],[validFrom],[validTo],[lastUpdatedBy],[note],[status]) VALUES (8,'2021-10-7',1,20.0,'2021-10-8','2022-6-12',1,null,1)
INSERT INTO dbo.Registration([userId],[regTime],[packId],[cost],[validFrom],[validTo],[lastUpdatedBy],[note],[status]) VALUES (8,'2021-10-8',2,20.0,'2021-10-9','2022-6-12',1,null,NULL)
INSERT INTO dbo.Registration([userId],[regTime],[packId],[cost],[validFrom],[validTo],[lastUpdatedBy],[note],[status]) VALUES (9,'2021-10-7',2,20.0,'2021-10-8','2022-6-12',1,null,1)
INSERT INTO dbo.Registration([userId],[regTime],[packId],[cost],[validFrom],[validTo],[lastUpdatedBy],[note],[status]) VALUES (9,'2021-10-6',1,20.0,'2021-10-7','2022-6-12',1,null,0)
INSERT INTO dbo.Registration([userId],[regTime],[packId],[cost],[validFrom],[validTo],[lastUpdatedBy],[note],[status]) VALUES (10,'2021-10-7',3,20.0,'2021-10-11','2022-6-12',1,null,1)
INSERT INTO dbo.Registration([userId],[regTime],[packId],[cost],[validFrom],[validTo],[lastUpdatedBy],[note],[status]) VALUES (10,'2021-10-6',5,20.0,'2021-10-11','2022-6-12',1,null,NULL)
INSERT INTO dbo.Registration([userId],[regTime],[packId],[cost],[validFrom],[validTo],[lastUpdatedBy],[note],[status]) VALUES (11,'2021-10-6',5,20.0,'2021-10-11','2022-6-12',1,null,0)
INSERT INTO dbo.Registration([userId],[regTime],[packId],[cost],[validFrom],[validTo],[lastUpdatedBy],[note],[status]) VALUES (11,'2021-10-7',4,20.0,'2021-10-11','2022-6-12',1,null,NULL)
INSERT INTO dbo.Registration([userId],[regTime],[packId],[cost],[validFrom],[validTo],[lastUpdatedBy],[note],[status]) VALUES (7,'2021-10-8',3,20.0,'2021-10-15','2022-6-12',1,null,1)
INSERT INTO dbo.Registration([userId],[regTime],[packId],[cost],[validFrom],[validTo],[lastUpdatedBy],[note],[status]) VALUES (7,'2021-10-6',5,20.0,'2021-10-7','2022-6-12',1,null,NULL)
INSERT INTO dbo.Registration([userId],[regTime],[packId],[cost],[validFrom],[validTo],[lastUpdatedBy],[note],[status]) VALUES (6,'2021-10-9',5,20.0,'2021-10-9','2022-6-12',1,null,1)
INSERT INTO dbo.Registration([userId],[regTime],[packId],[cost],[validFrom],[validTo],[lastUpdatedBy],[note],[status]) VALUES (6,'2021-10-10',4,20.0,'2021-10-12','2022-6-12',1,null,0)
-------------------------------------------
----------dbo.[Blog]-----------------------
insert into Blog(blogTitle,created,lastEdited,author,detail,thumbnail,status) values('Rita’s Way: Why is it so Effective?','2021-08-10','2021-09-10','1','RMC Learning Solutions was founded in 1991 by Rita Mulcahy, who spent years working as a trainer and consultant. What started off as a project management training company with the intention of helping people pass the PMP® exam eventually grew into what it is today: a trusted and proven resource for training and exam prep courses led by renowned experts in their field.
Using our unique Accelerated Learning Theory, RMC will teach you more in much less time. RMC’s guidance, tools, and techniques are used around the world, in a variety of industries from software development and financial services, to construction, to government agencies.','images\blog\Rita.jpg','1')
insert into Blog(blogTitle,created,lastEdited,author,detail,thumbnail,status) values('Write Useful Comments','2021-08-11','2021-09-11','2','Comments are crucial. You won’t appreciate them until you leave your thousand-line script for a couple of days and return to and try and make sense of it. Useful comments make life easier for yourself and those after you who have to maintain your code.
Write meaningful, single line comments for vague lines; write full parameter and functionality descriptions for functions and methods; for tricky logic blocks, describe the logic in words before it if necessary. And don’t forget, always keep your comments up to date!','images\blog\rmc.png','1')
insert into Blog(blogTitle,created,lastEdited,author,detail,thumbnail,status) values('7 Ways to Be a Healthy Web Programmer','2021-08-12','2021-09-12','2','It’s becoming common knowledge that sitting is the new smoking. We’ve probably all sat in front of our workstations for hours at a time. It’s creating your back problems, straining your eyes, and sapping your energy, and it’s probably why you have a migraine.
So take a walk instead! A recent study has shown that adults who walked for 40 minutes three times a week for a year literally grew their hippocampus! The hippocampus is the part of your brain that helps create new memories. It also helps regulate the autonomic nervous system, as well as your mood. In addition to the cognitive benefits, walking for 20 minutes will cause you to burn an average of 70–140 calories. On top of that, walking’s a great way to prevent back pain!','images\blog\manage.jpg','1')
insert into Blog(blogTitle,created,lastEdited,author,detail,thumbnail,status) values('Decision Making: Going Forward in Reverse','2021-08-13','2021-09-13','1','Busy managers analyze many situations and make hundreds of decisions every day. Why, for example, are sales up in one city but down in another? Would an investment in new equipment mean higher productivity or greater confusion? Is now a good time to look for a joint venture partner, or is it better to wait? Rarely, however, do we stop to think about how we think.
Each decision is the outcome of a complex process that usually involves two different kinds of thinking: looking backward to understand the past and looking forward to predict the future.','images\blog\chess.jpg','1')
insert into Blog(blogTitle,created,lastEdited,author,detail,thumbnail,status) values('Coding Math: What You Should Know','2021-08-14','2021-09-14','3','Programming is all about dealing with numbers and building logic around them. Mathematics is one of the most important tools for programmers to develop sophisticated applications. Without the knowledge of mathematics, a programmer is basically handicapped. Think of it like you know the English language, but you don’t know how to write an essay.
Therefore, it is important for all programmers to be well versed with certain topics in mathematics that are central to programming. In this blog, we will talk about some of such topics.','images\blog\math.jpg','1')
insert into Blog(blogTitle,created,lastEdited,author,detail,thumbnail,status) values('Future of AI','2021-08-15','2021-09-15','3','In a nondescript building close to downtown Chicago, Marc Gyongyosi and the small but growing crew of IFM/Onetrack.AI have one rule that rules them all: think simple. The words are written in simple font on a simple sheet of paper that’s stuck to a rear upstairs wall of their industrial two-story workspace. What they’re doing here with artificial intelligence, however, isn’t simple at all.
Sitting at his cluttered desk, located near an oft-used ping-pong table and prototypes of drones from his college days suspended overhead, Gyongyosi punches some keys on a laptop to pull up grainy video footage of a forklift driver operating his vehicle in a warehouse. It was captured from overhead courtesy of a Onetrack.AI “forklift vision system.”','images\blog\ai.jpg','1')
insert into Blog(blogTitle,created,lastEdited,author,detail,thumbnail,status) values('What is Agile?','2021-08-16','2021-09-16','1','Agile is an iterative approach to project management and software development that helps teams deliver value to their customers faster and with fewer headaches. Instead of betting everything on a "big bang" launch, an agile team delivers work in small, but consumable, increments. Requirements, plans, and results are evaluated continuously so teams have a natural mechanism for responding to change quickly','images\blog\Agile.png','1')
insert into Blog(blogTitle,created,lastEdited,author,detail,thumbnail,status) values('Using workflows for fun & profit','2021-08-17','2021-09-17','2','Every software team has a process they use to complete work. Normalizing that process–i.e., establishing it as a workflow–makes it clearly structured and repeatable, which, in turn, makes it scalable. At Atlassian, we take an iterative approach to workflow management because it helps us meet our goals faster and exemplifies our team culture. We are experts in agile workflow management (if we do say so ourselves), and we want to help you become experts too.','images\blog\workflow.png','1')
insert into Blog(blogTitle,created,lastEdited,author,detail,thumbnail,status) values('Why is it important to learn English?','2021-08-18','2021-09-18','2','There are many, many reasons why learning a new language is a good idea. It allows you to communicate with new people. It helps you to see things from a different perspective, or get a deeper understanding of another culture. It helps you to become a better listener. It even has health benefits, as studies have shown that people who speak two or more languages have more active minds later in life!
Those are all reasons to learn any language – but did you know that there are 6,500 languages still spoken in the world today? With such an enormous number to choose from, why pick English?
Here are five big reasons that learning English can improve your life.','images\blog\english.jpg','1')
insert into Blog(blogTitle,created,lastEdited,author,detail,thumbnail,status) values('Why study Japanese?','2021-08-19','2021-09-19','1','Japanese consumers spend 100s of billions of dollars each year on consumer goods and services like food, clothing, travel, and entertainment. The typical household has over $100,000 in savings and a disposable monthly income of $3,800. With all of that cash to spend, it is perhaps not surprising then that the United States exports more goods and services to Japan than any other overseas destination. In 2004, exports to Japan accounted for $54 billion of the U.S. GDP. In addition to these exports, 1000s of U.S. companies have successful branches in Japan. In 2004 alone, U.S. businesses spent $78 billion in direct investment in Japan.
Being able to communicate with potential customers in their own language is key to winning their business. In addition, when you learn Japanese, you become not only proficient in the language but also gain an insider view of the culture. Understanding the Japanese work ethic, their business etiquette, and knowing which cultural faux pas to avoid can often make or break an important business deal.','images\blog\nihongo.jpg','1')
insert into Blog(blogTitle,created,lastEdited,author,detail,thumbnail,status) values('Milk proteins may interfere with tea compounds, but research is mixed','2021-08-20','2021-09-20','1','Given that both tea and milk contain health-promoting compounds and nutrients, combing the two may seem beneficial.
In fact, one study in over 1,800 adults in China found that both tea and milk consumption were independently linked to a lower risk of oral cancer and that they may have a particularly beneficial effect when consumed together (10Trusted Source).
Yet, some studies suggest that the proteins in milk may interfere with the absorption and antioxidant activity of the compounds tea (11Trusted Source).
One study in 16 adult women observed that drinking 2 cups (500 ml) of plain black tea significantly increased blood flow, which can help improve heart function, compared with drinking water. Meanwhile, drinking black tea with skim milk did not have these effects (11Trusted Source).','images\blog\tea.png','1')
----------dbo.[BlogCate]-------------------
insert into BlogCate values('1','2','1')
insert into BlogCate values('2','1','1')
insert into BlogCate values('3','3','1')
insert into BlogCate values('4','1','1')
insert into BlogCate values('5','2','1')
insert into BlogCate values('6','4','1')
insert into BlogCate values('7','2','1')
insert into BlogCate values('8','2','1')
insert into BlogCate values('9','3','1')
insert into BlogCate values('10','3','1')
insert into BlogCate values('11','4','1')
----------dbo.[Slider]---------------------
insert into Slider(sliderTitle,image,link,note,status) values ('OOP with Java','oopJavaSlider.png','1','iidesune','1');
insert into Slider(sliderTitle,image,link,note,status) values ('NiHongo 101','japanese101Slider.png','2','iidesune','1');
insert into Slider(sliderTitle,image,link,note,status) values ('Physic in Programming','physicInProgramming.png','3','iidesune','1');
insert into Slider(sliderTitle,image,link,note,status) values ('Photoshop 101','photoshop101Slider.png','4','iidesune','1');
------------------------------------------
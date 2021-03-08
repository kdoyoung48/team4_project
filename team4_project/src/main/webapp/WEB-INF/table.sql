CREATE SEQUENCE board_gallery_seq;
CREATE TABLE board_gallery(
	num NUMBER PRIMARY KEY, 
	writer VARCHAR2(100),
	caption VARCHAR2(100), 
	imagePath VARCHAR2(100), 
	regdate DATE
);

CREATE SEQUENCE board_free_seq;
CREATE TABLE board_free(
	num NUMBER PRIMARY KEY, 
	writer VARCHAR2(100) NOT NULL, 
	title VARCHAR2(100) NOT NULL, 
	category VARCHAR2(100) NOT NULL, 
	content CLOB, 
	viewCount NUMBER, 
	regdate DATE 
);

CREATE SEQUENCE board_free_comment_seq;
CREATE TABLE board_free_comment(
	num NUMBER PRIMARY KEY, 
	writer VARCHAR2(100),
	content VARCHAR2(500),
	target_id VARCHAR2(100),
	ref_group NUMBER, 
	comment_group NUMBER,
	deleted CHAR(3) DEFAULT 'no',
	regdate DATE
);

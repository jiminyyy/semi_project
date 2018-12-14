show user;
-- USER이(가) "SALADMARKET"입니다.


-- 회원 등급(member_level) 테이블 생성; 1~3등급
create table member_level 
(lvnum       number         not null -- 등급번호; 1, 2, 3
,lvname      varchar2(100)  not null -- 등급명; bronze, silver, gold
,lvbenefit   clob           not null -- 등급혜택
,lvcontents  clob           not null -- 등급조건내용
,constraint  PK_level primary key (lvnum)
);
  
create sequence seq_member_level_lvnum
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

select *
from member_level;

-- 쿠폰(coupon) 테이블 생성 
create table coupon 
(cpnum          number not null             -- 쿠폰번호 
,cpname         varchar2(100) not null      -- 쿠폰명 
,discountper    number not null         -- 할인율
,cpstatus        number  default 1 not null         -- 쿠폰 사용 상태; 0:사용됨 1:미사용
,cpusemoney   number not null           -- 쿠폰 사용 조건; ex. 1만원 이상 사용시 ~~
,cpuselimit      number not null           -- 쿠폰 할인금액 제한; ex. 최대 5000원
,constraint PK_coupon primary key(cpnum)
,constraint CK_coupon_cpstatus check( cpstatus in(0, 1) )
);

create sequence seq_coupon_cpnum
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

select *
from coupon;

-- 회원(member) 테이블 생성 
create table member 
(mnum               number                not null  -- 회원번호
,userid             varchar2(100)         not null  -- 회원아이디
,name               varchar2(10)          not null  -- 회원명
,email              varchar2(200)         not null  -- 이메일(AES256 암호화)
,phone              varchar2(400)         not null  -- 휴대폰(AES256 암호화)
,birthday           date                  not null  -- 생년월일
,postnum            number                not null  -- 우편번호
,address1           varchar2(200)         not null  -- 주소
,address2           varchar2(200)         not null  -- 상세주소
,point              number default 0      not null  -- 포인트
,registerdate       date default sysdate  not null  -- 가입일자
,last_logindate     date default sysdate  not null  -- 마지막로그인일자
,last_changepwdate  date default sysdate  not null  -- 비밀번호변경일자
,status             number default 1      not null  -- 회원탈퇴유무 / 0:탈퇴 1:활동 2:휴면
,summoney           number default 0      not null  -- 누적구매금액
,fk_lvnum           number default 1      not null  -- 회원등급번호
,constraint PK_member_mnum	primary key(mnum)
,constraint UQ_member_userid unique(userid)
,constraint FK_member_lvnum foreign key(fk_lvnum)
                                references member_level(lvnum)
,constraint CK_member_status check( status in(0, 1, 2) )
);

create sequence seq_member_mnum
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

select *
from member;

-- 보유쿠폰(my_coupon) 테이블 생성 
create table my_coupon 
(fk_userid   varchar2(100) not null  -- 회원아이디 
,fk_cpnum  number not null  -- 쿠폰번호
,cpexpiredate date not null         -- 쿠폰 사용 기한
,constraint FK_my_coupon_userid foreign key(fk_userid)
                                  references member(userid)
,constraint FK_my_coupon_cpnum foreign key(fk_cpnum)
                                  references coupon(cpnum)
);

select *
from my_coupon;

-- 관리자(admin) 테이블 생성 
create table admin 
(adminid varchar2(100) -- 관리자아이디 
,adminpw varchar2(200) -- 관리자암호 
);

select *
from admin;

insert into admin values('admin', 'qwer1234$');

-----------------------------------------------------------------------------

-- 상품패키지(product_package) 테이블 생성 
create table product_package 
(pacnum       number default 0  not null    -- 상품패키지번호 
,pacname      varchar2(100)     not null    -- 상품패키지명 
,paccontents  clob                          -- 패키지내용 
,pacimage     varchar2(200)                 -- 패키지이미지 
,constraint PK_product_package primary key(pacnum)
,constraint UQ_product_package unique(pacname)
);

create sequence seq_product_Package_pacnum
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

select *
from product_package;

-- 대분류상세(large_detail) 테이블 생성 
create table large_detail 
(ldnum   number         not null  -- 대분류상세번호 
,ldname  varchar2(100)  not null  -- 대분류명 
,constraint PK_large_detail	primary key(ldnum)
,constraint UQ_large_detail unique (ldname)
);

create sequence seq_large_detail_ldnum
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

select *
from large_detail;

-- 소분류상세(small_detail) 테이블 생성
create table small_detail 
(sdnum     number         not null  -- 소분류상세번호
,fk_ldname  varchar2(100)       not null  -- 대분류상세명
,sdname    varchar2(100)  not null  -- 소분류명
,constraint PK_small_detail	primary key(sdnum)
,constraint FK_small_detail_ldname foreign key(fk_ldname)
                                  references large_detail(ldname)
,constraint UQ_small_detaill unique (sdname)
);

create sequence seq_small_detail_sdnum
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

select *
from small_detail;

-- 스펙태그(spec_tag) 테이블 생성 / (Hit, Best, New)
create table spec_tag 
(stnum   number         not null  -- 스펙태그번호 
,stname  varchar2(100)  not null  -- 스펙태그명 
,constraint PK_spec_tag	primary key(stnum)
,constraint UQ_spec_tag unique (stname)
);

create sequence seq_spec_tag_stnum
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

select *
from spec_tag;

-- 카테고리태그(category_tag) 테이블 생성 
create table category_tag 
(ctnum   number         not null  -- 카테고리번호 
,ctname  varchar2(100)  not null  -- 카테고리명 
,constraint PK_category_tag primary key(ctnum)
,constraint UQ_category_tag unique (ctname)
);

create sequence seq_category_tag_ctnum
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

select *
from category_tag;

-- 이벤트태그(event_tag) 테이블 생성 
create table event_tag 
(etnum   number  not null  -- 이벤트번호 
,etname  varchar2(100)     -- 이벤트명
,etimagefilename varchar2(200) -- 이벤트 이미지
,constraint PK_event_tag primary key(etnum)
,constraint UQ_event_tag unique (etname)
);

create sequence seq_event_tag_etnum
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

select *
from event_tag;

-- 상품(product) 테이블 생성
create table product 
(pnum          number  not null                -- 상품번호 
,fk_pacname     varchar2(100)  not null                -- 상품패키지명
,fk_sdname      varchar2(100)  not null                -- 소분류상세명 
,fk_ctname      varchar2(100)  not null                -- 카테고리태그명 
,fk_stname      varchar2(100)  not null                -- 스펙태그명 
,fk_etname      varchar2(100)  not null      -- 이벤트태그명
,pname         varchar2(100)  not null         -- 상품명 
,price         number default 0  not null      -- 원가 
,saleprice     number default 0  not null      -- 판매가 
,point         number default 0  not null      -- 포인트 
,pqty          number default 0  not null      -- 재고량 
,pcontents     clob                            -- 상품설명 
,pcompanyname  varchar2(100)  not null         -- 상품회사명 
,pexpiredate varchar2(200) default '상세내용참조'  not null -- 유통기한 
,allergy       clob                            -- 알레르기정보 
,weight        number default 0  not null      -- 용량 
,salecount     number default 0  not null      -- 판매량 
,plike         number default 0  not null      -- 상품좋아요 
,pdate         date default sysdate  not null  -- 상품등록일자
,constraint PK_product_pnum primary key(pnum)
,constraint FK_product_pacname foreign key(fk_pacname)
                               references product_package(pacname)
,constraint FK_product_sdname foreign key(fk_sdname)
                               references small_detail(sdname)
,constraint FK_product_ctname foreign key(fk_ctname)
                               references category_tag(ctname)
,constraint FK_product_stname foreign key(fk_stname)
                               references spec_tag(stname)
,constraint FK_product_etname foreign key(fk_etname)
                               references event_tag(etname)
);

create sequence seq_product_pnum
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

select *
from product;

-- 상품백업(Product_backup) 테이블 생성 
create table product_backup 
(deletenum     number  not null         -- deletenum 
,pnum          number  not null                -- 상품번호 
,fk_pacname     number  not null                -- 상품패키지명
,fk_sdname      number  not null                -- 소분류상세명 
,fk_ctname      number  not null                -- 카테고리태그명 
,fk_stname      number  not null                -- 스펙태그명 
,fk_etname      number  default 0 not null      -- 이벤트태그명
,pname         varchar2(100)  not null         -- 상품명 
,price         number default 0  not null      -- 원가 
,saleprice     number default 0  not null      -- 판매가 
,point         number default 0  not null      -- 포인트 
,pqty          number default 0  not null      -- 재고량 
,pcontents     clob                            -- 상품설명 
,pcompanyname  varchar2(100)  not null         -- 상품회사명 
,pexpiredate   date default sysdate  not null  -- 유통기한 
,allergy       clob                            -- 알레르기정보 
,weight        number default 0  not null      -- 용량 
,salecount     number default 0  not null      -- 판매량 
,plike         number default 0  not null      -- 상품좋아요 
,pdate         date default sysdate  not null  -- ?상품판매일자
,constraint PK_product_backup primary key(deletenum)
);

create sequence seq_product_backup_deletenum
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


-- 찜(pick) 테이블 생성 
create table pick 
(picknum    number         not null  -- 찜번호 
,fk_userid  varchar2(100)  not null  -- 회원아이디 
,fk_pnum    number         not null  -- 상품번호    
,constraint PK_pick_picknum primary key(picknum)
,constraint FK_pick_userid foreign key(fk_userid)
                            references member(userid)
,constraint FK_pick_pnum foreign key(fk_pnum)
                           references product(pnum)
);

create sequence seq_pick_picknum
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 장바구니 테이블 생성
 create table product_cart
 (cartno  number               not null   --  장바구니 번호
 ,fk_userid  varchar2(20)         not null   --  사용자ID
 ,fk_pnum    number(8)            not null   --  제품번호 
 ,oqty    number(8) default 0  not null   --  주문량
 ,status  number(1) default 1             --  삭제유무; 0: 삭제 1: 생성
 ,constraint PK_product_cart_cartno primary key(cartno)
 ,constraint FK_product_cart_userid foreign key(fk_userid)
                                references member(userid) 
 ,constraint FK_product_cart_pnum foreign key(fk_pnum)
                                references product(pnum)
 ,constraint CK_product_cart_status check( status in(0,1) ) 
 );

 create sequence seq_product_cart_cartno
 start with 1
 increment by 1
 nomaxvalue
 nominvalue
 nocycle
 nocache;


-- 상품이미지(product_images) 테이블 생성 
create table product_images 
(pimgnum       number         not null -- 상품이미지번호 
,pimgfilename  varchar2(100)  not null -- 상품이미지파일명 
,fk_pnum       number         not null -- 상품번호 
,constraint PK_product_images primary key(pimgnum)
,constraint FK_product_images_ldnum foreign key(fk_pnum)
                                      references product(pnum)
);

create sequence seq_product_images_pimgnum
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

select *
from product_images;

-- 리뷰게시판(review_borad) 테이블 생성 
create table review_borad 
(rbnum        number  not null                -- 리뷰번호 
,fk_pnum      number  not null                -- 상품번호 
,fk_userid    varchar2(100)  not null         -- 사용자아이디 
,rbtitle      varchar2(100)  not null         -- 리뷰제목 
,rbgrade      number default 0      not null  -- 리뷰평점 
,rbwritedate  date default sysdate  not null  -- 리뷰작성일자 
,rbcontents   clob  not null                  -- 리뷰내용
,rbimage    varchar2(200)                 -- 리뷰이미지
,rbviewcount  number default 0  not null      -- 리뷰조회수 
,rblike       number default 0  not null      -- 리뷰좋아요 
,rbstatus     number default 1  not null   
,constraint PK_review_borad primary key(rbnum)
,constraint FK_review_borad_pnum foreign key(fk_pnum)
                                   references product(pnum)
,constraint FK_review_borad_userid foreign key(fk_userid)
                                    references member(userid)
,constraint CK_review_borad_rbstatus check( rbstatus in(0,1) )
);

create sequence seq_review_borad_rbnum
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

select *
from review_borad;

-- 리뷰게시판댓글(review_comment) 테이블 생성 
create table review_comment 
(rcnum        number         not null         -- 리뷰댓글번호
,fk_rbnum     number         not null         -- 리뷰게시판번호
,fk_userid    varchar2(100)  not null         -- 사용자아이디
,name      varchar2(10) not null                -- 사용자이름  
,rcwritedate  date default sysdate  not null  -- 리뷰댓글작성일자 
,rccontents   number  not null                -- 리뷰댓글내용 
,constraint PK_review_comment primary key(rcnum)
,constraint FK_review_comment_rbnum foreign key(fk_rbnum)
                                       references review_borad(rbnum)
,constraint FK_review_comment_userid foreign key(fk_userid)
                                        references member(userid)
);

create sequence seq_review_comment_rcnum
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

select *
from review_comment;

-- 상품주문(product_order)  테이블 생성 
create table product_order 
(odrcode        varchar2(100)  not null         -- 주문코드 / 회사코드-주문일자-seq (ex. s-20181123-1
,fk_userid      varchar2(100)  not null         -- 사용자아이디 
,odrtotalprice  number         not null         -- 주문총액 
,odrtotalpoint  number         not null         -- 주문총포인트 
,odrdate        date default sysdate  not null  -- 주문일자
,constraint PK_product_order primary key(odrcode)
,constraint FK_product_order_userid foreign key(fk_userid)
                                      references member(userid)
);

create sequence seq_product_order_odrcode
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

create table product_order_temp
as
select *
from product_order;

-- 주문상세(product_order_detail) 테이블 생성 
create table product_order_detail 
(odrdnum        number not null            -- 주문상세번호 
,fk_pnum        number not null            -- 상품번호 
,fk_odrcode     varchar2(100) not null     -- 주문코드 
,oqty           number not null            -- 주문수량 
,odrprice       number not null            -- 주문시 상품가격
,odrstatus  number default 0 not null  -- 배송상태 / 0:배송전(주문완료) 1:배송중 2:배송완료 3: 주문취소 4: 교환환불
,deliverdate    date                       -- 배송완료일자?
,invoice        varchar2(200)              -- 운송장번호 
,constraint PK_order_detail	primary key (odrdnum)
,constraint FK_order_detail_pnum foreign key(fk_pnum)
                                   references product(pnum)                             
,constraint FK_order_detail_odrcode foreign key(fk_odrcode) 
                                       references product_order(odrcode)  on delete cascade
,constraint CK_order_detail_odrstatus check( odrstatus in(0, 1, 2, 3, 4) )
);

create sequence seq_order_detail_odrdnum
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


create table product_order_detail_temp
as
select *
from product_order_detail;

-- 주문취소(order_cancel) 테이블 생성
create table order_cancel 
(odrcnum       number not null  -- 주문취소번호
,odrccontents  clob not null    -- 주문취소사유
,fk_odrcode     varchar2(100)  not null -- 주문코드
,constraint PK_order_cancel primary key(odrcnum)
,constraint FK_order_cancel_odrcode foreign key(fk_odrcode) 
                                       references product_order(odrcode)  on delete cascade
);

create sequence seq_order_cancel_odrcnum
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 결제정보 저장 테이블
--(회원아이디/결제일시/결제금액/세부결제수단/결제상태(실패/성공))
create table payment 
(paynum  number             not null    -- 결제정보인덱스
,fk_userid varchar2(100)    not null    -- 사용자아이디
,paydate    date               not null    -- 결제일시
,payamounts number        not null      -- 결제금액
,paymethod     varchar2(100)    not null    -- 결제수단
,paystatus      number      not null        -- 결제상태(0; 실패/1; 성공)
,constraint PK_payment primary key(paynum)
,constraint FK_payment_userid foreign key(fk_userid)
                                      references member(userid)
,constraint CK_payment check( paystatus in(0, 1) )

);

create sequence seq_payment_paynum
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

create table payment_temp
as
select *
from payment;

alter table my_coupon add(cpstatus number default 1 not null);

alter table product
modify fk_pacname null;

alter table product
drop constraint FK_product_pacname;

commit;

--------------------------------------------------------------------------------------------------------------------------------------------------

select rnum, pacnum, prodname, paccontents, pacimage, pnum
        , sdname, ctname, stname, etname, pname, price
        , saleprice, point, pqty, pcontents
        , pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate
from
(
    select rownum as rnum,pacnum, case when pacname = '없음' then pname else pacname end as prodname
						, paccontents, pacimage, pnum
						, sdname, ctname, stname, etname, pname, price
						, saleprice, point, pqty, pcontents
						, pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate
    from 
    (
        select pacnum, pacname, paccontents, pacimage, pnum
                , sdname, ctname, stname, etname, pname, price
                , saleprice, point, pqty, pcontents
                , pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate
        from
        (
            select pacnum, pacname, paccontents, pacimage, pnum
                    , sdname, ctname, stname, etname, pname, price
                    , saleprice, point, pqty, pcontents
                    , pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate
            from
            (
                select row_number() over(partition by pacnum order by saleprice) as rno
                    , b.pacnum, b.pacname, b.paccontents, b.pacimage, a.pnum
                    , fk_sdname as sdname, a.fk_ctname as ctname, a.fk_stname as stname, a.fk_etname as etname
                    , a.pname, a.price, a.saleprice, a.point, a.pqty, a.pcontents
                    , a.pcompanyname, a.pexpiredate, allergy, a.weight, a.salecount, a.plike, a.pdate
                from product a JOIN product_package b
                ON a.fk_pacname = b.pacname
            ) V
            where rno = 1 and pacnum != 1
            union all
            select pacnum, pacname, paccontents, pimgfilename, pnum
                    , sdname, ctname, stname, etname, pname
                    , price, saleprice, point, pqty, pcontents
                    , pcompanyname, pexpiredate, allergy, weight, salecount
                    , plike, pdate
            from
            (
                select row_number() over(partition by pname order by saleprice) as rno
                        , b.pacnum, b.pacname, b.paccontents, b.pacimage, pnum
                        , fk_sdname AS sdname, a.fk_ctname AS ctname, a.fk_stname AS stname, a.fk_etname AS etname, a.pname
                        , a.price, a.saleprice, a.point, a.pqty, a.pcontents
                        , a.pcompanyname, a.pexpiredate, allergy, a.weight, a.salecount
                        , a.plike, a.pdate, c.pimgfilename
                from product a JOIN product_package b
                ON a.fk_pacname = b.pacname
                JOIN product_images c
                ON a.pnum = c.fk_pnum
                where pacnum = 1
            ) V
            where rno = 1
        )T
        --where sdname = '물/주스'
        where sdname in (select sdname from small_detail where fk_ldname = (select ldname from large_detail where ldnum = 1))
        order by pdate desc, pname asc
    ) E
) F
where rnum between 1 and 8;

-
select *
from product
where fk_sdname in (select sdname from small_detail where fk_ldname = 'DIY');


select *
from product;

-------------------------------------------------------------
create or replace view view_product
as
 select pacnum, pacname, paccontents, pacimage, pnum
                , sdname, ctname, stname, etname, pname, price
                , saleprice, point, pqty, pcontents
                , pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate
        from
        (
            select pacnum, pacname, paccontents, pacimage, pnum
                    , sdname, ctname, stname, etname, pname, price
                    , saleprice, point, pqty, pcontents
                    , pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate
            from
            (
                select row_number() over(partition by pacnum order by saleprice) as rno
                    , b.pacnum, b.pacname, b.paccontents, b.pacimage, a.pnum
                    , fk_sdname as sdname, a.fk_ctname as ctname, a.fk_stname as stname, a.fk_etname as etname
                    , a.pname, a.price, a.saleprice, a.point, a.pqty, a.pcontents
                    , a.pcompanyname, a.pexpiredate, allergy, a.weight, a.salecount, a.plike, a.pdate
                from product a JOIN product_package b
                ON a.fk_pacname = b.pacname
            ) V
            where rno = 1 and pacnum != 1
            union all
            select pacnum, pacname, paccontents, pimgfilename, pnum
                    , sdname, ctname, stname, etname, pname
                    , price, saleprice, point, pqty, pcontents
                    , pcompanyname, pexpiredate, allergy, weight, salecount
                    , plike, pdate
            from
            (
                select row_number() over(partition by pname order by saleprice) as rno
                        , b.pacnum, b.pacname, b.paccontents, b.pacimage, pnum
                        , fk_sdname AS sdname, a.fk_ctname AS ctname, a.fk_stname AS stname, a.fk_etname AS etname, a.pname
                        , a.price, a.saleprice, a.point, a.pqty, a.pcontents
                        , a.pcompanyname, a.pexpiredate, allergy, a.weight, a.salecount
                        , a.plike, a.pdate, c.pimgfilename
                from product a JOIN product_package b
                ON a.fk_pacname = b.pacname
                JOIN product_images c
                ON a.pnum = c.fk_pnum
                where pacnum = 1
            ) V
            where rno = 1
        )T;
	   
	   
select rnum, pacnum, prodname, paccontents, pacimage, pnum
        , sdname, ctname, stname, etname, pname, price
        , saleprice, point, pqty, pcontents
        , pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate
from
(
    select rownum as rnum,pacnum, case when pacname = '없음' then pname else pacname end as prodname
						, paccontents, pacimage, pnum
						, sdname, ctname, stname, etname, pname, price
						, saleprice, point, pqty, pcontents
						, pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate
    from 
    (
        select pacnum, pacname, paccontents, pacimage, pnum
                , sdname, ctname, stname, etname, pname, price
                , saleprice, point, pqty, pcontents
                , pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate
        from view_product
	   where sdname in (select sdname from small_detail where fk_ldname = (select ldname from large_detail where ldnum = 1))
        order by pdate desc, pname asc
    ) E
) F
where rnum between 1 and 8;

-----------------------------------------------
String sql = "select rnum, pacnum, prodname, paccontents, pacimage, pnum\n"+
"        , sdname, ctname, stname, etname, pname, price\n"+
"        , saleprice, point, pqty, pcontents\n"+
"        , pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate\n"+
"from\n"+
"(\n"+
"    select rownum as rnum,pacnum, case when pacname = '없음' then pname else pacname end as prodname\n"+
"						, paccontents, pacimage, pnum\n"+
"						, sdname, ctname, stname, etname, pname, price\n"+
"						, saleprice, point, pqty, pcontents\n"+
"						, pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate\n"+
"    from \n"+
"    (\n"+
"        select pacnum, pacname, paccontents, pacimage, pnum\n"+
"                , sdname, ctname, stname, etname, pname, price\n"+
"                , saleprice, point, pqty, pcontents\n"+
"                , pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate\n"+
"        from view_product\n"+
"	   where sdname in (select sdname from small_detail where fk_ldname = (select ldname from large_detail where ldnum = 1))\n"+
"        order by pdate desc, pname asc\n"+
"    ) E\n"+
") F\n"+
"where rnum between 1 and 8";

--
 select rnum, pacnum, prodname, paccontents, pacimage, pnum
         , sdname, ctname, stname, etname, pname, price
         , saleprice, point, pqty, pcontents
         , pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate
 from
 (
     select rownum as rnum,pacnum, case when pacname = '없음' then pname else pacname end as prodname
 						, paccontents, pacimage, pnum
 						, sdname, ctname, stname, etname, pname, price
 						, saleprice, point, pqty, pcontents
 						, pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate
     from 
     (
         select pacnum, pacname, paccontents, pacimage, pnum
                 , sdname, ctname, stname, etname, pname, price
                 , saleprice, point, pqty, pcontents
                 , pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate
         from view_product
  	   where sdname in (select sdname from small_detail where fk_ldname = (select ldname from large_detail where ldnum = 1))
         order by pdate desc, pname asc
     ) E
 ) F
 where pname like '%'|| '호박' || '%' and rnum between 1 and 8;
 
 
 --
 select rnum, pacnum, prodname, paccontents, pacimage, pnum
         , sdname, ctname, stname, etname, pname, price
         , saleprice, point, pqty, pcontents
         , pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate
 from
 (
     select rownum as rnum,pacnum, case when pacname = '없음' then pname else pacname end as prodname
 						, paccontents, pacimage, pnum
 						, sdname, ctname, stname, etname, pname, price
 						, saleprice, point, pqty, pcontents
 						, pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate
     from 
     (
         select pacnum, pacname, paccontents, pacimage, pnum
                 , sdname, ctname, stname, etname, pname, price
                 , saleprice, point, pqty, pcontents
                 , pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate
         from view_product
  	   where sdname in (select sdname from small_detail where fk_ldname = (select ldname from large_detail where ldnum = 1))
         order by pdate desc, pname asc
     ) E
 ) F
 where pname like '%'|| '' || '%' and rnum between 1 and 8;
 
 select *
 from product a join product_images b
 ON a.pnum = b.fk_pnum;
 
 select *
 from product_images;
 
 ---
create or replace trigger trg_package
after update of pacname on product_package for each row
begin
    update product
    set fk_pacname=:NEW.pacname where fk_pacname=:OLD.pacname;
END;

create or replace trigger trg_categorytag
after update of ctname on category_tag for each row
begin
    update product
    set fk_ctname=:NEW.ctname where fk_ctname=:OLD.ctname;
END;

create or replace trigger trg_eventtag
after update of etname on event_tag for each row
begin
    update product
    set fk_etname=:NEW.etname where fk_etname=:OLD.etname;
END;

-- 이미지 테이블 on delete cascade 추가하기
alter table product_images
drop constraint FK_product_images_ldnum;

-- > 제약조건 추가하기
alter table product_images
add constraint FK_product_images_ldnum foreign key(fk_pnum)
                                      references product(pnum)on delete cascade;
							   
---
 select rnum, pacnum, prodname, paccontents, pacimage, pnum
         , sdname, ctname, stname, etname, pname, price
         , saleprice, point, pqty, pcontents
         , pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate
 from
 (
     select rownum as rnum,pacnum, case when pacname = '없음' then pname else pacname end as prodname
 						, paccontents, pacimage, pnum
 						, sdname, ctname, stname, etname, pname, price
 						, saleprice, point, pqty, pcontents
 						, pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate
     from 
     (
         select pacnum, pacname, paccontents, pacimage, pnum
                 , sdname, ctname, stname, etname, pname, price
                 , saleprice, point, pqty, pcontents
                 , pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate
         from view_product
  	   where sdname in (select sdname from small_detail where fk_ldname = (select ldname from large_detail where ldnum = 1))
         order by pdate desc, pname asc
     ) E
 ) F
 where stname like '%'|| 'HIT' || '%' and rnum between 1 and 8 
 
 --
 select rnum, pacnum, prodname, paccontents, pacimage, pnum
		    , sdname, ctname, stname, etname, pname, price
		    , saleprice, point, pqty, pcontents
		    , pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate
from
 (
	 select rownum as rnum, pacnum, prodname, paccontents, pacimage, pnum
		    , sdname, ctname, stname, etname, pname, price
		    , saleprice, point, pqty, pcontents
		    , pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate
	 from
	 (
		select rownum as rnum,pacnum, case when pacname = '없음' then pname else pacname end as prodname
							, paccontents, pacimage, pnum
							, sdname, ctname, stname, etname, pname, price
							, saleprice, point, pqty, pcontents
							, pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate
		from 
		(
		    select pacnum, pacname, paccontents, pacimage, pnum
				  , sdname, ctname, stname, etname, pname, price
				  , saleprice, point, pqty, pcontents
				  , pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate
		    from view_product
		   where sdname in (select sdname from small_detail where fk_ldname = (select ldname from large_detail where ldnum = 2))
		    order by pdate desc, pname asc
		) E
	 ) F
 where prodname like '%'|| '청' || '%' 
 ) T 
 where rnum between 1 and 8;
 --
 select rnum, pacnum, prodname, paccontents, pacimage, pnum
         , sdname, ctname, stname, etname, pname, price
         , saleprice, point, pqty, pcontents
         , pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate
 from
 (
     select rownum as rnum,pacnum, case when pacname = '없음' then pname else pacname end as prodname
 						, paccontents, pacimage, pnum
 						, sdname, ctname, stname, etname, pname, price
 						, saleprice, point, pqty, pcontents
 						, pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate
     from 
     (
         select pacnum, pacname, paccontents, pacimage, pnum
                 , sdname, ctname, stname, etname, pname, price
                 , saleprice, point, pqty, pcontents
                 , pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate
         from view_product
  	   where sdname in (select sdname from small_detail where sdnum = 2)
         order by pdate desc, pname asc
     ) E
 ) F
 where stname like '%'|| 'HIT' || '%' and rnum between 1 and 8 
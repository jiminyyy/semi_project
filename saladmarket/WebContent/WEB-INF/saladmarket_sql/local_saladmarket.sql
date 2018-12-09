show user;
-- USER��(��) "SALADMARKET"�Դϴ�.


-- ȸ�� ���(member_level) ���̺� ����; 1~3���
create table member_level 
(lvnum       number         not null -- ��޹�ȣ; 1, 2, 3
,lvname      varchar2(100)  not null -- ��޸�; bronze, silver, gold
,lvbenefit   clob           not null -- �������
,lvcontents  clob           not null -- ������ǳ���
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

-- ����(coupon) ���̺� ���� 
create table coupon 
(cpnum          number not null             -- ������ȣ 
,cpname         varchar2(100) not null      -- ������ 
,discountper    number not null         -- ������
,cpstatus        number  default 1 not null         -- ���� ��� ����; 0:���� 1:�̻��
,cpusemoney   number not null           -- ���� ��� ����; ex. 1���� �̻� ���� ~~
,cpuselimit      number not null           -- ���� ���αݾ� ����; ex. �ִ� 5000��
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

-- ȸ��(member) ���̺� ���� 
create table member 
(mnum               number                not null  -- ȸ����ȣ
,userid             varchar2(100)         not null  -- ȸ�����̵�
,name               varchar2(10)          not null  -- ȸ����
,email              varchar2(200)         not null  -- �̸���(AES256 ��ȣȭ)
,phone              varchar2(400)         not null  -- �޴���(AES256 ��ȣȭ)
,birthday           date                  not null  -- �������
,postnum            number                not null  -- �����ȣ
,address1           varchar2(200)         not null  -- �ּ�
,address2           varchar2(200)         not null  -- ���ּ�
,point              number default 0      not null  -- ����Ʈ
,registerdate       date default sysdate  not null  -- ��������
,last_logindate     date default sysdate  not null  -- �������α�������
,last_changepwdate  date default sysdate  not null  -- ��й�ȣ��������
,status             number default 1      not null  -- ȸ��Ż������ / 0:Ż�� 1:Ȱ�� 2:�޸�
,summoney           number default 0      not null  -- �������űݾ�
,fk_lvnum           number default 1      not null  -- ȸ����޹�ȣ
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

-- ��������(my_coupon) ���̺� ���� 
create table my_coupon 
(fk_userid   varchar2(100) not null  -- ȸ�����̵� 
,fk_cpnum  number not null  -- ������ȣ
,cpexpiredate date not null         -- ���� ��� ����
,constraint FK_my_coupon_userid foreign key(fk_userid)
                                  references member(userid)
,constraint FK_my_coupon_cpnum foreign key(fk_cpnum)
                                  references coupon(cpnum)
);

select *
from my_coupon;

-- ������(admin) ���̺� ���� 
create table admin 
(adminid varchar2(100) -- �����ھ��̵� 
,adminpw varchar2(200) -- �����ھ�ȣ 
);

select *
from admin;

insert into admin values('admin', 'qwer1234$');

-----------------------------------------------------------------------------

-- ��ǰ��Ű��(product_package) ���̺� ���� 
create table product_package 
(pacnum       number default 0  not null    -- ��ǰ��Ű����ȣ 
,pacname      varchar2(100)     not null    -- ��ǰ��Ű���� 
,paccontents  clob                          -- ��Ű������ 
,pacimage     varchar2(200)                 -- ��Ű���̹��� 
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

-- ��з���(large_detail) ���̺� ���� 
create table large_detail 
(ldnum   number         not null  -- ��з��󼼹�ȣ 
,ldname  varchar2(100)  not null  -- ��з��� 
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

-- �Һз���(small_detail) ���̺� ����
create table small_detail 
(sdnum     number         not null  -- �Һз��󼼹�ȣ
,fk_ldname  varchar2(100)       not null  -- ��з��󼼸�
,sdname    varchar2(100)  not null  -- �Һз���
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

-- �����±�(spec_tag) ���̺� ���� / (Hit, Best, New)
create table spec_tag 
(stnum   number         not null  -- �����±׹�ȣ 
,stname  varchar2(100)  not null  -- �����±׸� 
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

-- ī�װ��±�(category_tag) ���̺� ���� 
create table category_tag 
(ctnum   number         not null  -- ī�װ���ȣ 
,ctname  varchar2(100)  not null  -- ī�װ��� 
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

-- �̺�Ʈ�±�(event_tag) ���̺� ���� 
create table event_tag 
(etnum   number  not null  -- �̺�Ʈ��ȣ 
,etname  varchar2(100)     -- �̺�Ʈ��
,etimagefilename varchar2(200) -- �̺�Ʈ �̹���
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

-- ��ǰ(product) ���̺� ����
create table product 
(pnum          number  not null                -- ��ǰ��ȣ 
,fk_pacname     varchar2(100)  not null                -- ��ǰ��Ű����
,fk_sdname      varchar2(100)  not null                -- �Һз��󼼸� 
,fk_ctname      varchar2(100)  not null                -- ī�װ��±׸� 
,fk_stname      varchar2(100)  not null                -- �����±׸� 
,fk_etname      varchar2(100)  not null      -- �̺�Ʈ�±׸�
,pname         varchar2(100)  not null         -- ��ǰ�� 
,price         number default 0  not null      -- ���� 
,saleprice     number default 0  not null      -- �ǸŰ� 
,point         number default 0  not null      -- ����Ʈ 
,pqty          number default 0  not null      -- ��� 
,pcontents     clob                            -- ��ǰ���� 
,pcompanyname  varchar2(100)  not null         -- ��ǰȸ��� 
,pexpiredate varchar2(200) default '�󼼳�������'  not null -- ������� 
,allergy       clob                            -- �˷��������� 
,weight        number default 0  not null      -- �뷮 
,salecount     number default 0  not null      -- �Ǹŷ� 
,plike         number default 0  not null      -- ��ǰ���ƿ� 
,pdate         date default sysdate  not null  -- ��ǰ�������
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

-- ��ǰ���(Product_backup) ���̺� ���� 
create table product_backup 
(deletenum     number  not null         -- deletenum 
,pnum          number  not null                -- ��ǰ��ȣ 
,fk_pacname     number  not null                -- ��ǰ��Ű����
,fk_sdname      number  not null                -- �Һз��󼼸� 
,fk_ctname      number  not null                -- ī�װ��±׸� 
,fk_stname      number  not null                -- �����±׸� 
,fk_etname      number  default 0 not null      -- �̺�Ʈ�±׸�
,pname         varchar2(100)  not null         -- ��ǰ�� 
,price         number default 0  not null      -- ���� 
,saleprice     number default 0  not null      -- �ǸŰ� 
,point         number default 0  not null      -- ����Ʈ 
,pqty          number default 0  not null      -- ��� 
,pcontents     clob                            -- ��ǰ���� 
,pcompanyname  varchar2(100)  not null         -- ��ǰȸ��� 
,pexpiredate   date default sysdate  not null  -- ������� 
,allergy       clob                            -- �˷��������� 
,weight        number default 0  not null      -- �뷮 
,salecount     number default 0  not null      -- �Ǹŷ� 
,plike         number default 0  not null      -- ��ǰ���ƿ� 
,pdate         date default sysdate  not null  -- ?��ǰ�Ǹ�����
,constraint PK_product_backup primary key(deletenum)
);

create sequence seq_product_backup_deletenum
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


-- ��(pick) ���̺� ���� 
create table pick 
(picknum    number         not null  -- ���ȣ 
,fk_userid  varchar2(100)  not null  -- ȸ�����̵� 
,fk_pnum    number         not null  -- ��ǰ��ȣ    
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

-- ��ٱ��� ���̺� ����
 create table product_cart
 (cartno  number               not null   --  ��ٱ��� ��ȣ
 ,fk_userid  varchar2(20)         not null   --  �����ID
 ,fk_pnum    number(8)            not null   --  ��ǰ��ȣ 
 ,oqty    number(8) default 0  not null   --  �ֹ���
 ,status  number(1) default 1             --  ��������; 0: ���� 1: ����
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


-- ��ǰ�̹���(product_images) ���̺� ���� 
create table product_images 
(pimgnum       number         not null -- ��ǰ�̹�����ȣ 
,pimgfilename  varchar2(100)  not null -- ��ǰ�̹������ϸ� 
,fk_pnum       number         not null -- ��ǰ��ȣ 
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

-- ����Խ���(review_borad) ���̺� ���� 
create table review_borad 
(rbnum        number  not null                -- �����ȣ 
,fk_pnum      number  not null                -- ��ǰ��ȣ 
,fk_userid    varchar2(100)  not null         -- ����ھ��̵� 
,rbtitle      varchar2(100)  not null         -- �������� 
,rbgrade      number default 0      not null  -- �������� 
,rbwritedate  date default sysdate  not null  -- �����ۼ����� 
,rbcontents   clob  not null                  -- ���䳻��
,rbimage    varchar2(200)                 -- �����̹���
,rbviewcount  number default 0  not null      -- ������ȸ�� 
,rblike       number default 0  not null      -- �������ƿ� 
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

-- ����Խ��Ǵ��(review_comment) ���̺� ���� 
create table review_comment 
(rcnum        number         not null         -- �����۹�ȣ
,fk_rbnum     number         not null         -- ����Խ��ǹ�ȣ
,fk_userid    varchar2(100)  not null         -- ����ھ��̵�
,name      varchar2(10) not null                -- ������̸�  
,rcwritedate  date default sysdate  not null  -- �������ۼ����� 
,rccontents   number  not null                -- �����۳��� 
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

-- ��ǰ�ֹ�(product_order)  ���̺� ���� 
create table product_order 
(odrcode        varchar2(100)  not null         -- �ֹ��ڵ� / ȸ���ڵ�-�ֹ�����-seq (ex. s-20181123-1
,fk_userid      varchar2(100)  not null         -- ����ھ��̵� 
,odrtotalprice  number         not null         -- �ֹ��Ѿ� 
,odrtotalpoint  number         not null         -- �ֹ�������Ʈ 
,odrdate        date default sysdate  not null  -- �ֹ�����
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

-- �ֹ���(product_order_detail) ���̺� ���� 
create table product_order_detail 
(odrdnum        number not null            -- �ֹ��󼼹�ȣ 
,fk_pnum        number not null            -- ��ǰ��ȣ 
,fk_odrcode     varchar2(100) not null     -- �ֹ��ڵ� 
,oqty           number not null            -- �ֹ����� 
,odrprice       number not null            -- �ֹ��� ��ǰ����
,odrstatus  number default 0 not null  -- ��ۻ��� / 0:�����(�ֹ��Ϸ�) 1:����� 2:��ۿϷ� 3: �ֹ���� 4: ��ȯȯ��
,deliverdate    date                       -- ��ۿϷ�����?
,invoice        varchar2(200)              -- ������ȣ 
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

-- �ֹ����(order_cancel) ���̺� ����
create table order_cancel 
(odrcnum       number not null  -- �ֹ���ҹ�ȣ
,odrccontents  clob not null    -- �ֹ���һ���
,fk_odrcode     varchar2(100)  not null -- �ֹ��ڵ�
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

-- �������� ���� ���̺�
--(ȸ�����̵�/�����Ͻ�/�����ݾ�/���ΰ�������/��������(����/����))
create table payment 
(paynum  number             not null    -- ���������ε���
,fk_userid varchar2(100)    not null    -- ����ھ��̵�
,paydate    date               not null    -- �����Ͻ�
,payamounts number        not null      -- �����ݾ�
,paymethod     varchar2(100)    not null    -- ��������
,paystatus      number      not null        -- ��������(0; ����/1; ����)
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

--------------------------------------------------------------------------------------------------------------------------------------------------

select rnum, pacnum, pacname, paccontents, pacimage, pnum
        , sdname, ctname, stname, etname, pname, price
        , saleprice, point, pqty, pcontents
        , pcompanyname, pexpiredate, allergy, weight, salecount, plike, pdate
from
(
    select rownum as rnum,pacnum, pacname, paccontents, pacimage, pnum
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
        --where sdname = '��/�ֽ�'
        where sdname = '�ǰ���'
        order by pdate desc, pname asc
    ) E
) F
where rnum between 1 and 8;


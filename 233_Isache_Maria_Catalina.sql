 create  sequence generare_id
start with 1
increment by 1
maxvalue 100000
nocycle
nocache;

create table ELEVI (
    elev_id number(5),
    nume varchar(25) constraint not_null_nume not null,
    prenume varchar(25) constraint not_null_prenume not null,
    data_nastere date,
    sex char(1),
    scoala_id number(5),
    oras_id number(2),
    constraint pk_elevi primary key(elev_id)
    );

create table ORASE (
    oras_id number(2),
    nume_oras varchar(25) constraint not_null_nume_oras not null,
    constraint pk_orase primary key(oras_id)
    );  

create table PROFESORI_INDRUMATORI (
    profesor_id number(5),
    nume varchar(25) constraint not_null_numeP not null,
    prenume varchar(25) constraint not_null_prenumeP not null,
    scoala_id number(5),
    constraint pk_profesori_indrumatori primary key(profesor_id)
    );
    
create table SCOLI (
    scoala_id number(5),
    nume_scoala varchar(50) constraint not_null_nume_scoala not null,
    locatie_id number(5),
    constraint pk_scoli primary key(scoala_id)
    ); 

create table MATERII (
    materie_id number(2),
    nume_materie varchar(25) constraint not_null_nume_materie not null,
    constraint pk_materie primary key(materie_id)
    ); 
    
create table PROBE (
    proba_id number(5),
    materie_id number(2),
    clasa number(2),
    data_proba date default sysdate,
    locatie_id number(5),
    durata number(3),
    constraint pk_probe primary key(proba_id)
    );

create table LOCATII (
    locatie_id number(5),
    oras_id number(2),
    strada varchar(50),
    nr_strada number(3),
    cod_postal char(6),
    constraint pk_locatii primary key(locatie_id)
    );

create table LOTURI (
    lot_id number(5),
    oras_id number(2),
    materie_id number(2),
    cazare_id number(5),
    an number(4),
    constraint pk_loturi primary key(lot_id)
    );
    
create table PROFESORI_INSOTITORI (
    profesor_id number(5),
    nume varchar(25) constraint not_null_numePI not null,
    prenume varchar(25) constraint not_null_prenumePI not null,
    nr_telefon char(10),
    constraint pk_profesori_insotitori primary key(profesor_id)
    );
    
create table CAZARI (
    cazare_id number(5),
    nume varchar(50) constraint not_null_nume_cazare not null,
    locatie_id number(5),
    oras_id number(2),
    capacitate number(4),
    constraint pk_cazari primary key(cazare_id)
    );
    
create table CAMERE (
    nr_camera number(3),
    cazare_id number(5),
    capacitate number(2),
    constraint pk_camere primary key(nr_camera,cazare_id)
    );
    
create table PREDA (
    elev_id number(5),
    profesor_id number(5),
    materie_id number(2),
    an number(4),
    constraint pk_preda primary key(elev_id, profesor_id, materie_id)
);

create table PARTICIPA (
    elev_id number(5),
    proba_id number(5),
    oras_id number(2),
    scoala_id number(5), 
    premiu varchar(10),
    constraint pk_participa primary key(elev_id, proba_id, oras_id, scoala_id)
);

create table APARTINE (
    elev_id number(5),
    lot_id number(5),
    constraint pk_apartine primary key(elev_id, lot_id)
);

create table INSOTESTE (
    profesor_id number(5),
    lot_id number(5),
    constraint pk_insoteste primary key(profesor_id, lot_id)
);

alter table ELEVI
add constraint fk_oras foreign key(oras_id) references ORASE(oras_id);

alter table ELEVI
add constraint fk_scoala foreign key(scoala_id) references SCOLI(scoala_id);

alter table PROFESORI_INDRUMATORI
add constraint fk_scoalap foreign key(scoala_id) references SCOLI(scoala_id);

alter table SCOLI
add constraint fk_locatie_s foreign key(locatie_id) references LOCATII(locatie_id);

alter table PROBE
add constraint fk_locatie_p foreign key(locatie_id) references LOCATII(locatie_id);

alter table PROBE
add constraint fk_materie_p foreign key(materie_id) references MATERII(materie_id);

alter table LOTURI
add constraint fk_oras_l foreign key(oras_id) references ORASE(oras_id);

alter table LOTURI
add constraint fk_materie_l foreign key(materie_id) references MATERII(materie_id);

alter table LOTURI
add constraint fk_cazare_l foreign key(cazare_id) references CAZARI(cazare_id);

alter table LOCATII
add constraint fk_oras_lc foreign key(oras_id) references ORASE(oras_id);

alter table CAZARI
add constraint fk_oras_c foreign key(oras_id) references ORASE(oras_id);

alter table CAZARI
add constraint fk_locatie_c foreign key(locatie_id) references LOCATII(locatie_id);

alter table CAMERE
add constraint fk_cazare_c foreign key(cazare_id) references CAZARI(cazare_id);

alter table PREDA
add constraint fk_materie_pr foreign key(materie_id) references MATERII(materie_id);

alter table PREDA
add constraint fk_elev_p foreign key(elev_id) references ELEVI(elev_id);

alter table PREDA
add constraint fk_profesor_p foreign key(profesor_id) references PROFESORI_INDRUMATORI(profesor_id);

alter table PARTICIPA
add constraint fk_elev_pp foreign key(elev_id) references ELEVI(elev_id);

alter table PARTICIPA
add constraint fk_oras_pp foreign key(oras_id) references ORASE(oras_id);

alter table PARTICIPA
add constraint fk_scoala_pp foreign key(scoala_id) references SCOLI(scoala_id);

alter table PARTICIPA
add constraint fk_proba_pp foreign key(proba_id) references PROBE(proba_id);

alter table APARTINE
add constraint fk_elev_a foreign key(elev_id) references ELEVI(elev_id);

alter table APARTINE
add constraint fk_lot_a foreign key(lot_id) references LOTURI(lot_id);

alter table INSOTESTE
add constraint fk_lot_i foreign key(lot_id) references LOTURI(lot_id);

alter table INSOTESTE
add constraint fk_profesor_i foreign key(profesor_id) references PROFESORI_INSOTITORI(profesor_id);


insert into MATERII
values (generare_id.nextval, 'Matematica');
insert into MATERII
values (generare_id.nextval, 'Informatica');
insert into MATERII
values (generare_id.nextval, 'Romana');
insert into MATERII
values (generare_id.nextval, 'Engleza');
insert into MATERII
values (generare_id.nextval, 'Istorie');


drop sequence generare_id;
create  sequence generare_id
start with 1
increment by 1
maxvalue 100000
nocycle
nocache;

insert into ORASE
values (generare_id.nextval, 'Bucuresti');
insert into ORASE
values (generare_id.nextval, 'Iasi');
insert into ORASE
values (generare_id.nextval, 'Cluj');
insert into ORASE
values (generare_id.nextval, 'Timisoara');
insert into ORASE
values (generare_id.nextval, 'Constanta');

select * 
from orase;

drop sequence generare_id;
create  sequence generare_id
start with 1
increment by 1
maxvalue 100000
nocycle
nocache;


insert into LOCATII
values (generare_id.nextval, 1, 'Splaiul Independentei', 204, '010158');
insert into LOCATII
values (generare_id.nextval, 4, 'St. Cuza', 16, '400132');
insert into LOCATII
values (generare_id.nextval,2, 'Bd. Alexandru cel Bun', 37, '700633');
insert into LOCATII
values (generare_id.nextval,1, 'Calea Victoriei', 4, '010023');
insert into LOCATII
values (generare_id.nextval, 5, 'St. Mincu', 36, '301340');


drop sequence generare_id;
create  sequence generare_id
start with 1
increment by 1
maxvalue 100000
nocycle
nocache;

    
insert into SCOLI
values (generare_id.nextval, 'Colegiul National Sfantul Sava', 1);
insert into SCOLI
values (generare_id.nextval,  'Colegiul National Iasi', 2);
insert into SCOLI
values (generare_id.nextval, 'Scoala Gimnaziala Nr. 30', 4);
insert into SCOLI
values (generare_id.nextval, 'Scoala Gimnazial? Spectrum Constanta', 5);
insert into SCOLI
values (generare_id.nextval, 'Scoala Ion Creanga', 3);
select * from locatii;

drop sequence generare_id;
create  sequence generare_id
start with 1
increment by 1
maxvalue 100000
nocycle
nocache;


insert into PROFESORI_INDRUMATORI
values (generare_id.nextval, 'Sava','Alin', 3);
insert into PROFESORI_INDRUMATORI
values (generare_id.nextval,  'Lucanu','Gabriel', 1);
insert into PROFESORI_INDRUMATORI
values (generare_id.nextval, 'Sandu','Raluca', 2);
insert into PROFESORI_INDRUMATORI
values (generare_id.nextval, 'Popescu','Ioan', 5);
insert into PROFESORI_INDRUMATORI
values (generare_id.nextval, 'Adam','Alin', 4);

select * from profesori_indrumatori;
drop sequence generare_id;
create  sequence generare_id
start with 1
increment by 1
maxvalue 100000
nocycle
nocache;

insert into PROBE
values (generare_id.nextval, 2, 10, to_date('15/04/2020', 'DD/MM/YYYY'), 3, 180);
insert into PROBE
values (generare_id.nextval, 1, 9, to_date('15/05/2018', 'DD/MM/YYYY'), 1, 360);
insert into PROBE
values (generare_id.nextval, 3, 12, to_date('15/04/2018', 'DD/MM/YYYY'), 1, 180);
insert into PROBE
values (generare_id.nextval, 3, 7, to_date('15/05/2019', 'DD/MM/YYYY'), 5, 120);
insert into PROBE
values (generare_id.nextval, 4, 6, to_date('15/04/2020', 'DD/MM/YYYY'), 2, 120);

drop sequence generare_id;
create  sequence generare_id
start with 1
increment by 1
maxvalue 100000
nocycle
nocache;

select * from probe;

insert into ELEVI
values (generare_id.nextval, 'Istrate', 'Ana', to_date('10/01/2002', 'DD/MM/YYYY'), 'F', 3, 1);
insert into ELEVI
values (generare_id.nextval, 'Iordache', 'Radu', to_date('08/03/2006', 'DD/MM/YYYY'), 'M', 2, 2);
insert into ELEVI
values (generare_id.nextval, 'Sandu', 'Smaranda', to_date('19/09/2005', 'DD/MM/YYYY'), 'F', 3, 4);
insert into ELEVI
values (generare_id.nextval, 'Barbu', 'Ioan', to_date('12/12/2006', 'DD/MM/YYYY'), 'M', 1, 1);
insert into ELEVI
values (generare_id.nextval,  'Costache', 'Adrian', to_date('02/03/2005', 'DD/MM/YYYY'), 'M', 4, 5);
insert into ELEVI
values (6, 'Istrate', 'Bogdana', to_date('11/01/2003', 'DD/MM/YYYY'), 'F', 3, 2);
insert into ELEVI
values (7, 'Ispirescu', 'Ionut', to_date('08/03/2004', 'DD/MM/YYYY'), 'M', 2, 1);
insert into ELEVI
values (8, 'Apostu', 'Sandra', to_date('19/09/2006', 'DD/MM/YYYY'), 'F', 3, 2);
insert into ELEVI
values (9, 'Bogdan', 'Rares', to_date('12/10/2006', 'DD/MM/YYYY'), 'M', 1, 2);
insert into ELEVI
values (10,  'Deleanu', 'Simon', to_date('03/05/2006', 'DD/MM/YYYY'), 'M', 4, 1);

drop sequence generare_id;
create  sequence generare_id
start with 1
increment by 1
maxvalue 100000
nocycle
nocache;

insert into PARTICIPA
values (1,2, 1,3,'Premiul I');
insert into PARTICIPA
values (2,3, 2, 2, Null);
insert into PARTICIPA
values (3,4, 4,3, 'Premiul II');
insert into PARTICIPA
values (4,3, 1, 1, 'Mentiune');
insert into PARTICIPA
values (5,3, 5,3, 'Mentiune');

insert into PREDA
values (1,3,4,2019);
insert into PREDA
values (2,1,4,2018);
insert into PREDA
values (3,2,5,2017);
insert into PREDA
values (4,5,5,2018);
insert into PREDA
values (5,4,2,2018);
insert into PREDA
values (1,3,2,2020);
insert into PREDA
values (1,1,4,2021);
insert into PREDA
values (3,4,2,2018);
insert into PREDA
values (4,5,3,2019);
insert into PREDA
values (5,3,2,2020);

select * 
from Preda;
 
drop sequence generare_id;
create  sequence generare_id
start with 1
increment by 1
maxvalue 100000
nocycle
nocache;


insert into CAZARI
values (generare_id.nextval,'Pensiunea Margareta',4,200);
insert into CAZARI
values (generare_id.nextval,'Pensiunea Dorina',2,120);
insert into CAZARI
values (generare_id.nextval,'Pensiunea Zana',3,56);
insert into CAZARI
values (generare_id.nextval, 'Hotel Unirea',2,500);
insert into CAZARI
values (generare_id.nextval,'Hotel Moxa',1,250);

select * 
from Cazari;

drop sequence generare_id;
create  sequence generare_id
start with 1
increment by 1
maxvalue 100000
nocycle
nocache;

insert into CAMERE
values (generare_id.nextval, 1,3);
insert into CAMERE
values (generare_id.nextval, 1,2);
insert into CAMERE
values (generare_id.nextval, 1,3);
drop sequence generare_id;
create  sequence generare_id
start with 1
increment by 1
maxvalue 100000
nocycle
nocache;
insert into CAMERE
values (generare_id.nextval, 2,4);
insert into CAMERE
values (generare_id.nextval, 2,3);
drop sequence generare_id;
create  sequence generare_id
start with 1
increment by 1
maxvalue 100000
nocycle
nocache;
insert into CAMERE
values (generare_id.nextval, 3,3);
insert into CAMERE
values (generare_id.nextval, 3,4);
insert into CAMERE
values (1, 4,2);
insert into CAMERE
values (1, 5,3);

select * 
from CAMERE;

select * 
from elevi;


drop sequence generare_id;
create  sequence generare_id
start with 1
increment by 1
maxvalue 100000
nocycle
nocache;
insert into PROFESORI_INSOTITORI
values (generare_id.nextval, 'Ciobanu','Ana', '0749469685');
insert into PROFESORI_INSOTITORI
values (generare_id.nextval,  'Isai','Andrei', '0745849548');
insert into PROFESORI_INSOTITORI
values (generare_id.nextval, 'Straton','Maria', '0734335498');
insert into PROFESORI_INSOTITORI
values (generare_id.nextval, 'Popa','Ana', '0743873687');
insert into PROFESORI_INSOTITORI
values (generare_id.nextval, 'Pruteanu','Ion', '0332056784');

select * 
from PROFESORI_INSOTITORI;

drop sequence generare_id;
create  sequence generare_id
start with 1
increment by 1
maxvalue 100000
nocycle
nocache;

select probe.*, locatii.oras_id, cazari.cazare_id
from probe,locatii,cazari
where probe.locatie_id=locatii.locatie_id
    and cazari.locatie_id=locatii.locatie_id;

insert into LOTURI
values (generare_id.nextval, 4, 4, 2, 2020);
insert into LOTURI
values (generare_id.nextval, 2, 2, 3, 2020);
insert into LOTURI
values (generare_id.nextval, 4,4,4,2020);
insert into LOTURI
values (generare_id.nextval, 1,1,5,2018);
insert into LOTURI
values (generare_id.nextval, 1,3,5,2018);

select * 
from LOTURI;

select elevi.elev_id, loturi.lot_id
from loturi, elevi
where elevi.oras_id=loturi.oras_id;

insert into APARTINE
values (1,9);
insert into APARTINE
values (1,10);
insert into APARTINE
values (2,7);
insert into APARTINE
values (3,6);
insert into APARTINE
values (3, 8);
insert into APARTINE
values (4,8);
insert into APARTINE
values (4,10);

select * 
from apartine;

////////


/////////
insert into INSOTESTE
values (1,7);
insert into INSOTESTE
values (2,6);
insert into INSOTESTE
values (3,10);
insert into INSOTESTE
values (4,8);
insert into INSOTESTE
values (5,9);
insert into INSOTESTE
values (1,6);
insert into INSOTESTE
values (2,7);
insert into INSOTESTE
values (3,8);
insert into INSOTESTE
values (4,9);
insert into INSOTESTE
values (5, 10);



CREATE OR REPLACE PROCEDURE Ex6 
        (nume_elev elevi.nume%TYPE) 
    IS 
        TYPE tablou_imbricat IS TABLE OF NUMBER; 
        locatii_ids tablou_imbricat := tablou_imbricat();
        
        TYPE tablou_indexat IS TABLE OF NUMBER INDEX BY PLS_INTEGER; 
        frecventa tablou_indexat;
        
        v_oras_id    locatii.oras_id%type;
        v_nume_oras  orase.nume_oras%type;
        
    BEGIN 
        
        select pr.locatie_id bulk collect into locatii_ids
        from elevi e, participa p, probe pr
        where e.nume=nume_elev and e.elev_id=p.elev_id and p.proba_id=pr.proba_id;
    
        for i in locatii_ids.first..locatii_ids.last loop
        
            select oras_id
            into v_oras_id
            from locatii l
            where l.locatie_id=locatii_ids(i);
            
            if frecventa.exists(v_oras_id) then
                frecventa(v_oras_id):=frecventa(v_oras_id)+1;
            else 
                frecventa(v_oras_id):=1;
            end if;
            
        end loop;
        
        for i in frecventa.first..frecventa.last loop
            if frecventa.exists(i) then
                select nume_oras into v_nume_oras
                from orase o
                where o.oras_id=i;
                
                DBMS_OUTPUT.PUT_LINE(v_nume_oras || ' ' || frecventa(i) ); 
            end if;
        end loop;
        
    END Ex6;
/

Begin
    Ex6('Iacob');
End;
/



CREATE OR REPLACE PROCEDURE Ex7
        (v_nume_materie materii.nume_materie%TYPE) 
    IS 
        CURSOR cursor_probe (parametru materii.materie_id%type) IS
        select proba_id
        from probe
        where materie_id=parametru;
        
        v_materie_id  number(4);
        
    BEGIN 
        
        select materie_id into v_materie_id
        from materii
        where initcap(nume_materie)=v_nume_materie;
        
        for i in cursor_probe(v_materie_id) loop
            DBMS_OUTPUT.PUT_LINE('Proba ID: ' || i.proba_id );
            for j in (  select nume,prenume 
                        from participa p, elevi e
                        where p.proba_id=i.proba_id and p.elev_id=e.elev_id)
            loop
                DBMS_OUTPUT.PUT_LINE(j.nume ||' '||j.prenume);
            end loop;
            DBMS_OUTPUT.PUT_LINE('--------------');
        end loop;
        
    END Ex7;
/

Begin
    Ex7('Romana');
End;
/




CREATE OR REPLACE PROCEDURE Ex9 (v_nume_elev elevi.nume%type)
    IS 
        type rec is record (elev_id elevi.elev_id%type,
                            nume elevi.nume%type, 
                            prenume elevi.prenume%type, 
                            materie materii.nume_materie%type, 
                            prof_n profesori_indrumatori.nume%type, 
                            prof_p profesori_indrumatori.prenume%type, 
                            an preda.an%type );
        type rezultate is table of rec;
        rez rezultate:=rezultate();
        v_record rec;
        AN_LIPSA EXCEPTION;
       
    BEGIN 
                       
        select elevi.elev_id,elevi.nume, elevi.prenume, materii.nume_materie, profesori_indrumatori.nume, profesori_indrumatori.prenume, preda.an  into v_record
        from materii, elevi, preda, profesori_indrumatori
        where elevi.nume=v_nume_elev  and elevi.elev_id in (select elev_id
                                                            from apartine
                                                            where lot_id = (select a.lot_id 
                                                                            from apartine a, loturi l
                                                                            where a.lot_id=l.lot_id
                                                                            group by l.lot_id
                                                                            having count(*)=(
                                                                                               select max(count(*)) 
                                                                                               from apartine a, loturi l
                                                                                               where l.lot_id=a.lot_id
                                                                                               group by a.lot_id))
                                                            )
              and preda.elev_id=elevi.elev_id
              and preda.materie_id=materii.materie_id
              and preda.profesor_id=profesori_indrumatori.profesor_id;
       
        if v_record.an is null then
            raise AN_LIPSA;
        end if;
        
        DBMS_OUTPUT.PUT_LINE('Elevul cu id-ul ' ||  v_record.elev_id || ' si numele ' ||
                             v_record.nume || ' ' || 
                             v_record.prenume || ' a participat la ' || 
                             v_record.materie);
        DBMS_OUTPUT.PUT_LINE(', avand drept profesor indrumator pe ' ||  
                             v_record.prof_n || ' ' || 
                             v_record.prof_p || ' in anul ' ||
                             v_record.an);
    
    EXCEPTION 
        when no_data_found then 
            raise_application_error(-20000, 'Nu exista elevul in lotul cu numar maxim de elevi'); 
        when too_many_rows then 
            raise_application_error(-20001, 'Elevul are mai multe participari la olimpiada'); 
        when AN_LIPSA then
             raise_application_error(-20002, 'Anul nu este inregistrat in sistem'); 
        when others then 
            raise_application_error(-20003,'Exista mai multe loturi cu numar maxim de elevi');
    
    END Ex9;
/

Begin
    Ex9('Sandu');
End;
/

select * from elevi;

select elev_id,materie_id from participa, probe
where probe.proba_id= participa.proba_id;

insert into participa values(5,4,1,2,'Mentiune');
insert into participa values(5,5,1,1,'Mentiune');


CREATE OR REPLACE FUNCTION Ex8 (v_nume_elev IN elevi.nume%type, v_nume_materie IN materii.nume_materie%type)
    return date
    IS 
        v_elev_id elevi.elev_id%type;
        v_data_proba  date;
        
    BEGIN 
                       
        select elevi.elev_id into v_elev_id
        from elevi
        where elevi.nume=v_nume_elev;
        
        select probe.data_proba into v_data_proba
        from probe 
        where probe.data_proba=(select probe.data_proba
                                from probe, participa, materii
                                where participa.elev_id=v_elev_id and probe.proba_id=participa.proba_id and 
                                      materii.materie_id=probe.materie_id and materii.nume_materie=v_nume_materie);
        
        return v_data_proba;
    EXCEPTION 
        when no_data_found then 
            raise_application_error(-20000, 'Nu exista elevul'); 
        when too_many_rows then 
            raise_application_error(-20001, 'Sunt mai multi elevi cu acest nume'); 
        when others then 
            raise_application_error(-20003,'Elevul a participat in mai multi ani la aceasta materie');
    
    END Ex8;
/


Declare
    data_proba date;
Begin
    data_proba:=Ex8('Costache', 'Romana');
    DBMS_OUTPUT.PUT_LINE(data_proba);
End;
/

CREATE OR REPLACE TRIGGER Ex11
    AFTER INSERT ON camere
    FOR EACH ROW
DECLARE
    capacitate_noua NUMBER:=0;
BEGIN
    select cazari.capacitate into capacitate_noua 
    from cazari 
    where cazari.cazare_id=:new.cazare_id;
    
    capacitate_noua:=:new.capacitate+capacitate_noua;
    
    update cazari
    set capacitate=capacitate_noua
    where cazare_id=:new.cazare_id;
    
    DBMS_OUTPUT.PUT_LINE('A fost actualizata si capacitatea cazarii');

END;
/
--declansare trigger
INSERT INTO camere 
VALUES(4,1,2);
--stergere trigger
DROP TRIGGER Ex11;


CREATE OR REPLACE TRIGGER Ex10
    BEFORE INSERT ON preda
DECLARE
    nr_nule NUMBER;
BEGIN
    nr_nule:=0;
    select count(*) into nr_nule
    from preda
    where an is null;
    
    if nr_nule>0 then
        RAISE_APPLICATION_ERROR(-20000,'Completeaza anii de predare necompletati inainte de a insera');
    end if;

END;
/
--declansare trigger
INSERT INTO preda 
VALUES(4, 2, 2, 2012);
--stergere trigger
DROP TRIGGER trigger_ex10;



CREATE OR REPLACE TRIGGER Ex12
    BEFORE CREATE OR DROP OR ALTER ON SCHEMA
BEGIN
    IF USER != UPPER('sys') THEN
        RAISE_APPLICATION_ERROR(-20000,'Schimbati userul');
    END IF;
    
END;
/
-- Declansare trigger
ALTER TABLE preda DROP COLUMN an;
DROP TRIGGER Ex12;
ROLLBACK;
/




CREATE OR REPLACE PACKAGE Ex13 AS
    PROCEDURE Ex6(nume_elev elevi.nume%TYPE);
    PROCEDURE Ex7(v_nume_materie materii.nume_materie%TYPE);
    FUNCTION Ex8 (v_nume_elev IN elevi.nume%type, v_nume_materie IN materii.nume_materie%type)
    return date;
    PROCEDURE Ex9 (v_nume_elev elevi.nume%type);
   
END Ex13;
/

CREATE OR REPLACE PACKAGE BODY Ex13 AS
    PROCEDURE Ex6 
        (nume_elev elevi.nume%TYPE) 
    IS 
        TYPE tablou_imbricat IS TABLE OF NUMBER; 
        locatii_ids tablou_imbricat := tablou_imbricat();
        
        TYPE tablou_indexat IS TABLE OF NUMBER INDEX BY PLS_INTEGER; 
        frecventa tablou_indexat;
        
        v_oras_id    locatii.oras_id%type;
        v_nume_oras  orase.nume_oras%type;
        
    BEGIN 
        
        select pr.locatie_id bulk collect into locatii_ids
        from elevi e, participa p, probe pr
        where e.nume=nume_elev and e.elev_id=p.elev_id and p.proba_id=pr.proba_id;
    
        for i in locatii_ids.first..locatii_ids.last loop
        
            select oras_id
            into v_oras_id
            from locatii l
            where l.locatie_id=locatii_ids(i);
            
            if frecventa.exists(v_oras_id) then
                frecventa(v_oras_id):=frecventa(v_oras_id)+1;
            else 
                frecventa(v_oras_id):=1;
            end if;
            
        end loop;
        
        for i in frecventa.first..frecventa.last loop
            if frecventa.exists(i) then
                select nume_oras into v_nume_oras
                from orase o
                where o.oras_id=i;
                
                DBMS_OUTPUT.PUT_LINE(v_nume_oras || ' ' || frecventa(i) ); 
            end if;
        end loop;
        
    END Ex6;


    PROCEDURE Ex7
        (v_nume_materie materii.nume_materie%TYPE) 
    IS 
        CURSOR cursor_probe (parametru materii.materie_id%type) IS
        select proba_id
        from probe
        where materie_id=parametru;
        
        v_materie_id  number(4);
        
    BEGIN 
        
        select materie_id into v_materie_id
        from materii
        where initcap(nume_materie)=v_nume_materie;
        
        for i in cursor_probe(v_materie_id) loop
            DBMS_OUTPUT.PUT_LINE('Proba ID: ' || i.proba_id );
            for j in (  select nume,prenume 
                        from participa p, elevi e
                        where p.proba_id=i.proba_id and p.elev_id=e.elev_id)
            loop
                DBMS_OUTPUT.PUT_LINE(j.nume ||' '||j.prenume);
            end loop;
            DBMS_OUTPUT.PUT_LINE('--------------');
        end loop;
        
    END Ex7;
    
    FUNCTION Ex8 (v_nume_elev IN elevi.nume%type, v_nume_materie IN materii.nume_materie%type)
    return date
    IS 
        v_elev_id elevi.elev_id%type;
        v_data_proba  date;
        
    BEGIN 
                       
        select elevi.elev_id into v_elev_id
        from elevi
        where elevi.nume=v_nume_elev;
        
        select probe.data_proba into v_data_proba
        from probe 
        where probe.data_proba=(select probe.data_proba
                                from probe, participa, materii
                                where participa.elev_id=v_elev_id and probe.proba_id=participa.proba_id and 
                                      materii.materie_id=probe.materie_id and materii.nume_materie=v_nume_materie);
        
        return v_data_proba;
    EXCEPTION 
        when no_data_found then 
            raise_application_error(-20000, 'Nu exista elevul'); 
        when too_many_rows then 
            raise_application_error(-20001, 'Sunt mai multi elevi cu acest nume'); 
        when others then 
            raise_application_error(-20003,'Elevul a participat in mai multi ani la aceasta materie');
    
    END Ex8;
    
    PROCEDURE Ex9 (v_nume_elev elevi.nume%type)
    IS 
        type rec is record (elev_id elevi.elev_id%type,
                            nume elevi.nume%type, 
                            prenume elevi.prenume%type, 
                            materie materii.nume_materie%type, 
                            prof_n profesori_indrumatori.nume%type, 
                            prof_p profesori_indrumatori.prenume%type, 
                            an preda.an%type );
        type rezultate is table of rec;
        rez rezultate:=rezultate();
        v_record rec;
        AN_LIPSA EXCEPTION;
   
    BEGIN 
                       
        select elevi.elev_id,elevi.nume, elevi.prenume, materii.nume_materie, profesori_indrumatori.nume, profesori_indrumatori.prenume, preda.an  into v_record
        from materii, elevi, preda, profesori_indrumatori
        where elevi.nume=v_nume_elev  and elevi.elev_id in (select elev_id
                                                            from apartine
                                                            where lot_id = (select a.lot_id 
                                                                            from apartine a, loturi l
                                                                            where a.lot_id=l.lot_id
                                                                            group by l.lot_id
                                                                            having count(*)=(
                                                                                               select max(count(*)) 
                                                                                               from apartine a, loturi l
                                                                                               where l.lot_id=a.lot_id
                                                                                               group by a.lot_id))
                                                            )
              and preda.elev_id=elevi.elev_id
              and preda.materie_id=materii.materie_id
              and preda.profesor_id=profesori_indrumatori.profesor_id;
       
        if v_record.an is null then
            raise AN_LIPSA;
        end if;
        
        DBMS_OUTPUT.PUT_LINE('Elevul cu id-ul ' ||  v_record.elev_id || ' si numele ' ||
                             v_record.nume || ' ' || 
                             v_record.prenume || ' a participat la ' || 
                             v_record.materie);
        DBMS_OUTPUT.PUT_LINE(', avand drept profesor indrumator pe ' ||  
                             v_record.prof_n || ' ' || 
                             v_record.prof_p || ' in anul ' ||
                             v_record.an);
    
    EXCEPTION 
        when no_data_found then 
            raise_application_error(-20000, 'Nu exista elevul in lotul cu numar maxim de elevi'); 
        when too_many_rows then 
            raise_application_error(-20001, 'Elevul are mai multe participari la olimpiada'); 
        when AN_LIPSA then
             raise_application_error(-20002, 'Anul nu este inregistrat in sistem'); 
        when others then 
            raise_application_error(-20003,'Exista mai multe loturi cu numar maxim de elevi');
    
    END Ex9;

END Ex13;
/

--apel pt ex 7

BEGIN
    Ex13.Ex6('Iacob');
END;
/

Declare
    data_proba date;
Begin
    data_proba:=Ex13.Ex8('Costache', 'Romana');
    DBMS_OUTPUT.PUT_LINE(data_proba);
End;
/

select * from loturi;

CREATE OR REPLACE PACKAGE Ex14 AS
    PROCEDURE main_p;
    FUNCTION max_lot RETURN loturi.lot_id%type;
    FUNCTION data_participare (v_elev_id IN elevi.elev_id%type, v_nume_materie IN materii.nume_materie%type) RETURN date;
    PROCEDURE orasee(v_elev_id IN elevi.elev_id%type);
    
END Ex14;
/

CREATE OR REPLACE PACKAGE BODY Ex14 AS
    PROCEDURE main_p 
    IS 
        type lista_ids is table of number;
        lista_elevi_id lista_ids:=lista_ids();
        
        v_lot_id loturi.lot_id%type;
        
        type elev is record(id elevi.elev_id%type,
                            materie materii.nume_materie%type,
                            data_p date);
        type tabel is table of elev index by pls_integer;
        tabel_elevi tabel:=tabel();
        j number :=0;
    BEGIN 
        v_lot_id:=max_lot();
        select elev_id bulk collect into lista_elevi_id
        from apartine
        where lot_id = v_lot_id;
        
       
        for i in lista_elevi_id.first..lista_elevi_id.last loop
            if mod(lista_elevi_id(i),2) = 0 then
            j:=lista_elevi_id(i);
            tabel_elevi(j).id:=lista_elevi_id(i);
            
            select materii.nume_materie  into  tabel_elevi(j).materie
            from participa, elevi, probe, materii
            where elevi.elev_id=tabel_elevi(j).id 
            and participa.elev_id=elevi.elev_id
            and participa.proba_id=probe.proba_id
            and materii.materie_id=probe.proba_id;
    
            tabel_elevi(j).data_p:=data_participare(tabel_elevi(j).id, tabel_elevi(j).materie);
            DBMS_OUTPUT.PUT_LINE('Elevul cu id-ul ' || tabel_elevi(j).id || ' a participat la '|| tabel_elevi(j).materie || ' in data de ' || tabel_elevi(j).data_p|| ', acesta participand in orasele: ');
            orasee(j);
            
        end if;
       end loop;

       
    END main_p;
    
    FUNCTION max_lot RETURN loturi.lot_id%type
    IS 
         v_id loturi.lot_id%type;
    BEGIN
        select a.lot_id into v_id
        from apartine a, loturi l
        where a.lot_id=l.lot_id
        group by l.lot_id
        having count(*)=(
                   select max(count(*)) 
                   from apartine a, loturi l
                   where l.lot_id=a.lot_id
                   group by a.lot_id);
        return v_id;
    
    END max_lot;
        
    FUNCTION data_participare (v_elev_id IN elevi.elev_id%type, v_nume_materie IN materii.nume_materie%type) RETURN date
    IS 
        v_data_proba  date;
        
    BEGIN 
        select probe.data_proba into v_data_proba
        from probe 
        where probe.data_proba=(select probe.data_proba
                                from probe, participa, materii
                                where participa.elev_id=v_elev_id and probe.proba_id=participa.proba_id and 
                                      materii.materie_id=probe.materie_id );
        
        return v_data_proba;
    EXCEPTION 
        when no_data_found then 
            raise_application_error(-20000, 'Nu exista elevul'); 
        when too_many_rows then 
            raise_application_error(-20001, 'Sunt mai multi elevi cu acest nume'); 
        when others then 
            raise_application_error(-20003,'Elevul a participat in mai multi ani la aceasta materie');
    
    END data_participare;
    
    PROCEDURE orasee 
        (v_elev_id elevi.elev_id%TYPE) 
    IS 
        TYPE tablou_imbricat IS TABLE OF NUMBER; 
        locatii_ids tablou_imbricat := tablou_imbricat();
        
        TYPE tablou_indexat IS TABLE OF NUMBER INDEX BY PLS_INTEGER; 
        frecventa tablou_indexat;
        
        v_oras_id    locatii.oras_id%type;
        v_nume_oras  orase.nume_oras%type;
        
    BEGIN 
        
        select pr.locatie_id bulk collect into locatii_ids
        from participa p, probe pr
        where v_elev_id=p.elev_id and p.proba_id=pr.proba_id;
    
        for i in locatii_ids.first..locatii_ids.last loop
        
            select oras_id
            into v_oras_id
            from locatii l
            where l.locatie_id=locatii_ids(i);
            
            if frecventa.exists(v_oras_id) then
                frecventa(v_oras_id):=frecventa(v_oras_id)+1;
            else 
                frecventa(v_oras_id):=1;
            end if;
            
        end loop;
        
        for i in frecventa.first..frecventa.last loop
            if frecventa.exists(i) then
                select nume_oras into v_nume_oras
                from orase o
                where o.oras_id=i;
                
                DBMS_OUTPUT.PUT_LINE(v_nume_oras || ' de ' || frecventa(i) ||' ori' ); 
            end if;
        end loop;
        
    END orasee;

END Ex14;
/

BEGIN
Ex14.main_p();
END;


/



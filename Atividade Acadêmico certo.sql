/* laboratório 3*/
create database if not exists academico_2023;
use academico_2023;

create table if not exists curso
(idCurso        char(3)      not null,
 nome           varchar(30)  not null,
 coordenador    Varchar(20)  not null,
 primary key(idCurso));


create table if not exists aluno
(prontuario     char(8)      not null,
 nome           varchar(30)  not null,
 endereco       Varchar(30)  not null,
 RG             char(11)     not null,
 idCurso        char(3)      not null,
 primary key(prontuario),
 foreign key (idCurso) references curso(idCurso));


create table if not exists disciplina
(idDisciplina   integer      not null,
 idCurso        char(3)      not null,
 nomeDis        varchar(30)  not null,
 numCreditos    integer      not null,
 primary key(idDisciplina),
 foreign key (idCurso) references curso(idCurso));

create table if not exists boletim
(idDisciplina   integer      not null,
 prontuario     char(8)      not null,
 nota           decimal(4,2)  not null,
 primary key (idDisciplina,prontuario),
 foreign key(idDisciplina) references disciplina(idDisciplina),
 foreign key(prontuario) references aluno(prontuario));
 
insert into CURSO
values ('ADS', 'Analise de Sistemas','Antonio'),
       ('MSI','Informatica','Rubens');

/* inserir dados na tabela aluno*/
insert into ALUNO
values ('12345678','Maria das Dores','Rua das Flores,100','010101','ADS'),
       ('12345677','Joao do Pulo','Rua das Flores,200','02020202','MSI'),
       ('12345688','Almerinda de Jesus','Rua das Orquideas,500','303030','ADS');

/* inserir dados na tabela disciplina*/
insert into DISCIPLINA
values (1,'ADS','Banco de Dados',5),
       (2,'ADS','Lógica de Programação',5),
       (3,'ADS','Informática',3),
       (4,'ADS','Engenharia de Software',5);

/* inserir dados na tabela boletim*/
insert into BOLETIM
values (1,'12345678',6.0),
       (1,'12345677',8.0),
       (1,'12345688',2.3),
       (2,'12345678',5.0),
       (2,'12345677',10.0),
       (3,'12345688',2.3);
       
#1.Listar todos os alunos cadastrados na tabela ALUNO
select * from ALUNO;

#2.Listar da tabela CURSO, o idCurso e o nome
select IDCURSO, NOME from CURSO;

#3.Selecionar todos os alunos com prontuário diferente de 12345678
select * from ALUNO where PRONTUARIO != 12345678; #é usado != ou <>

#4.Selecionar todos os alunos com nota>6 da disciplina banco de dados.
select * from ALUNO, BOLETIM where nota > 6 order by 1;
#select * from BOLETIM where nota > 6 and IDDISCIPLINA = 1

#5.Verificar o que acontece se tentar inserir um aluno com os seguintes dados. O que deve ser feito para efetivar esta inclusão. Prontuario = 232323 Nome= Marcos Santos RG=66666 Endereço =null 
alter table ALUNO modify ENDERECO varchar (30) null;
insert into ALUNO values (232323, 'Marcos Santos', null, 66666, 'msi');

#6.Selecionar os alunos cujo nomes comecem com “M”. 
select * from ALUNO where nome like "M%";

#7.Inserir dados no boletim para o aluno Marcos Santos sendo: Para a disciplina banco de dados = 8.5 Para a disciplina lógica =7.3 
insert into BOLETIM values (1, 232323, 8.5), (2, 232323,7.3);

#8.Mostrar os alunos cujas notas sejam maiores que 4 e menores que 6
select * from BOLETIM where nota > 4 and nota < 6;

#9.Selecionar os alunos cujos nomes não comecem com M 
select * from ALUNO where nome not like "M%";

#10.Exibir os alunos com endereço nulo
select * from ALUNO where ENDERECO is null;

#11.Calcular a média das notas de todos os alunos que frequentaram a disciplina de Lógica. Exibir o título da coluna como ‘média notas’ e usar a nota com 1 casa decimal. 
select format (avg(NOTA), 1) as 'MEDIA NOTAS' from BOLETIM;

#12.Contar quantos alunos estão cadastrados.
select count(*) from ALUNO;

#13.Exibir a nota média por disciplina;
select IDDISCIPLINA, format (avg(NOTA), 1) as 'MEDIA NOTAS' from BOLETIM group by IDDISCIPLINA;

#14. Exibir a nota média por prontuário de aluno; 
select PRONTUARIO, format (avg(NOTA), 1) as 'médias notas' from BOLETIM group by PRONTUARIO;

#15. Mostrar quantos alunos tem nota maior que 6.
select count(*) from BOLETIM where nota > 6;

#16. Mostrar por disciplina cuja média seja maior que 6 ( Visualizar iddisciplina, média da nota). 
select IDDISCIPLINA, avg(NOTA) as 'média da nota' from BOLETIM group by IDDISCIPLINA having avg(NOTA) > 6 order by 1;

#17. Para cada prontuário mostrar somente os dados cujas médias sejam maiores que 7 (Exibir prontuário, média da nota). Exibir por ordem decrescente de nota. 
select PRONTUARIO, format (avg(NOTA), 1) as 'médias notas' from BOLETIM group by PRONTUARIO having avg(NOTA) > 7 order by 2 desc;

#18. Exibir a maior nota registrada no boletim. 
select max(NOTA) from BOLETIM;

#19. Exibir o prontuário, a identificação da disciplina e a nota para a menor nota registrada no boletim. 
select PRONTUARIO, IDDISCIPLINA, NOTA as 'menor nota' from BOLETIM order by 3 limit 1; #o limit 1 limita 1 exibição 

#20. Exibir o prontuário, a identificação da disciplina e a nota das 2 maiores notas registradas no boletim. 
select PRONTUARIO, IDDISCIPLINA, NOTA from BOLETIM order by 3 desc limit 2;

#21. Analisar o erro da inserção do seguinte registro na tabela aluno. O que deveria ser feito para corrigir. 
insert into CURSO values ('MAT', 'Matemática', 'Alguém');
insert into ALUNO values (234, 'Ana Maria Braga', 'Av das Nações Unidas, 100', 121212, 'mat'), 
(12345679, 'Carolina', 'Rua D. Aguirre, 300', 123456, 'mat');
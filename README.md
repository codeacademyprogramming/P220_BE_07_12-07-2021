 # SQL group by,order,union, sql view, stored procedure
 
 - https://www.dotnettricks.com/learn/sqlserver/difference-between-stored-procedure-and-function-in-sql-server#:~:text=The%20function%20must%20return%20a,be%20called%20from%20a%20Function.
- https://haktanakda.medium.com/mssql-de-function-kullan%C4%B1m%C4%B1-40816fadaf12#:~:text=Fonksiyonlar%20tamamen%20i%C5%9Fimizi%20kolayla%C5%9Ft%C4%B1rmak%20ad%C4%B1na,sorgu%20tekrarlamama%20gibi%20imkanlar%C4%B1%20verir.&text=Functionlar%20istenilen%20deger%20tipinde%20d%C3%B6n%C3%BCs%20yapabilir.
- https://www.ismailgursoy.com.tr/union-ve-union-all-fonksiyonlari/
- https://www.w3schools.com/sql/sql_check.asp
- https://www.w3schools.com/sql/sql_groupby.asp
- https://www.w3schools.com/sql/sql_having.asp
- https://www.w3schools.com/sql/sql_union.asp

Asagidaki source-da sql serve basligi altindaki datatypelari oyrenin
- https://www.w3schools.com/sql/sql_datatypes.asp


## Tapşırıq
  
Kitabxana database-i qurursunuz

Books:
 - Id
 - Name - max 100, min 2
 - AuthorId
 - PageCount - min 10

Authors:
 - Id
 - Name
 - Surname

Books ve Authors table-lariniz olsun
 (one to many realtion) Id,Name,PageCount ve
 AuthorFullName columnlarinin valuelarini 
qaytaran bir view yaradin

Gonderilmis axtaris deyirene gore hemin axtaris
 deyeri name ve ya authorFullNamelerinde olan Book-lari
 Id,Name,PageCount,AuthorFullName columnlari seklinde
 gostern procedure yazin

Authors tableinin insert,update ve deleti ucun (her biri ucun ayrica) procedure yaradin

Authors-lari Id,FullName,BooksCount,MaxPageCount seklinde qaytaran view yaradirsiniz
Id-author id-si
FullName - Name ve Surname birlesmesi
BooksCount - Hemin authorun elaqeli oldugu kitablarin sayi
MaxPageCount - hemin authorun elaqeli oldugu kitablarin icerisindeki max pagecount deyeri



 

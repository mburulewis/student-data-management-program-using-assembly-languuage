section .data
lines db'--------------------------------------------------------------------------------- ',10
lenlines equ $-lines
Title db 'Welcome to the students data management system.With this you will be able to create files which in each file will be categorized by class and each file will hold the students information. ' ,10
lenTitle equ $-Title
lines1 db'---------------------------------------------------------------------------------',10
lenlines1 equ $-lines1

Query db 'Please type in the word in the bracket of what you want to do;',10
lenQuery equ $-Query
Options db'1. Create a student file(crt)      2. Open an existing student file to read it(open)  ',10  
lenOptions equ $-Options
Options1 db '3.Delete a  student file(del)',10  
lenOptions1 equ $-Options1

Fname db'Please give the student file you want to create a name(preferably the students name)',10
lenFname equ $-Fname

Info0 db'Write your information:',10
lenInfo0 equ $-Info0
Info1 db'FIRST NAME:',10
lenInfo1 equ $-Info1
Info2 db'LAST NAME/SURNAME:',10
lenInfo2 equ $-Info2
Info3 db'ID NUMBER:',10
lenInfo3 equ $-Info3
Info4 db'SCHOOL ID NUMBER:',10
lenInfo4 equ $-Info4
Info5 db'SEX:',10
lenInfo5 equ $-Info5
Info6 db'DATE OF BIRTH(In format of 25-7-1998):',10
lenInfo6 equ $-Info6
Info7 db'PHONE NUMBER:',10
lenInfo7 equ $-Info7
Info8 db'EMAIL:',10
lenInfo8 equ $-Info8
Info9 db'RESIDENCE:',10
lenInfo9 equ $-Info9
Info10 db'HOME ADDRESS:',10
lenInfo10 equ $-Info10
Info11 db'NAME OF NEXT CONTACT:',10
lenInfo11 equ $-Info11
Info12 db'NUMBER OF NEXT CONTACT:',10
lenInfo12 equ $-Info12
Info13 db'KCSE MARKS:',10
lenInfo13 equ $-Info13


num1 db 'crt',10
lennum1 equ $-num1
num2 db 'open',10
lennum2 equ $-num2
num3 db 'yes',10
lennum3 equ $-num3
num4 db 'no',10
lennum4 equ $-num4
num7 db 'del',10
lennum7 equ $-num7

Oname db'Please give the name of the file you want to open',10
lenOname equ $-Oname
Finfo db'Student information is:',10
lenFinfo equ $-Finfo

Query4 db 'Please input name of file you want to delete: ',10
lenQuery4 equ $-Query4
Query5 db 'Do you want to create another student file: ',10
lenQuery5 equ $-Query5


%macro write_string 2 
mov eax, 4 
mov ebx, 1 
mov ecx, %1 
mov edx, %2 
int 80h 
%endmacro

section .bss
ans resb 5
file_name resb 30
write_opt resb 5

Finame resb 20
Laname resb 20
id_no resb 10
School_id resb 20
sex resb 10
DOB resb 20
phone_number resb 15
email resb 100
residence resb 100
home_add resb 50
name_contact resb 100
no_contact resb 15
KCSE_marks resb 10
del_name resb 30
crt_opt resb 10

fd_out resb 1
fd_in  resb 1
write_opt2 resb 5
info resb  3000
open_name resb 30




section .text
global _start         ;must be declared for using gcc
	
_start:
write_string lines,lenlines
write_string Title,lenTitle 
write_string lines1,lenlines1
write_string Query,lenQuery
write_string Options,lenOptions
write_string Options1,lenOptions1

;Read and strore data input
mov eax,3
mov ebx,0
mov ecx,ans
mov edx,5
int 80h


;Loop for determining choice
mov ecx,[ans]
cmp ecx,[num1]
je L1
cmp ecx,[num2]
je L2
cmp ecx,[num7]
je L3
mov eax,1 ;system call number (sys_exit) 
int 0x80 ;call kernel

;Creating a file
L1:
   write_string Fname,lenFname 
   ;Read and store the user input 
    mov eax, 3 
    mov ebx, 2 
    mov ecx, file_name 
    mov edx, 30 ;30 bytes (numeric, 1 for sign) of that information 
    int 80h 

   ;create the file
   mov  eax, 8
   mov  ebx, file_name
   mov  ecx, 0777        ;read, write and execute by all
   int  0x80             ;call kernel
	
   mov [fd_out], eax

;User prompt
write_string Info0,lenInfo0
write_string Info1,lenInfo1
; write string into the file
   mov	edx,lenInfo1       ;number of bytes
   mov	ecx, Info1        ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel

;Read and store the user input 
mov eax, 3 
mov ebx, 2 
mov ecx, Finame
mov edx, 20 ;20 bytes (numeric, 1 for sign) of that information 
int 80h

; write input into the file
   mov	edx,20         ;number of bytes
   mov	ecx, Finame        ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel

write_string Info2,lenInfo2
; write string into the file
   mov	edx,lenInfo2       ;number of bytes
   mov	ecx, Info2        ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel
;Read and store the user input 
mov eax, 3 
mov ebx, 2 
mov ecx, Laname
mov edx, 20 ;20 bytes (numeric, 1 for sign) of that information 
int 80h

; write  input into the file
   mov	edx,20         ;number of bytes
   mov	ecx, Laname        ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel

write_string Info3,lenInfo3
; write string into the file
   mov	edx,lenInfo3       ;number of bytes
   mov	ecx, Info3        ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel
;Read and store the user input 
mov eax, 3 
mov ebx, 2 
mov ecx, id_no
mov edx, 10 ;10 bytes (numeric, 1 for sign) of that information 
int 80h

; write  input into the file
   mov	edx,10         ;number of bytes
   mov	ecx, id_no       ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel


write_string Info4,lenInfo4
; write string into the file
   mov	edx,lenInfo4       ;number of bytes
   mov	ecx, Info4        ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel
;Read and store the user input 
mov eax, 3 
mov ebx, 2 
mov ecx, School_id
mov edx, 20 ;20 bytes (numeric, 1 for sign) of that information 
int 80h

; write  input into the file
   mov	edx,20         ;number of bytes
   mov	ecx, School_id        ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel

write_string Info5,lenInfo5
; write string into the file
   mov	edx,lenInfo5       ;number of bytes
   mov	ecx, Info5        ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel
;Read and store the user input 
mov eax, 3 
mov ebx, 2 
mov ecx, sex
mov edx, 10 ;10 bytes (numeric, 1 for sign) of that information 
int 80h

; write  input into the file
   mov	edx,10         ;number of bytes
   mov	ecx, sex        ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel

write_string Info6,lenInfo6
; write string into the file
   mov	edx,lenInfo6       ;number of bytes
   mov	ecx, Info6        ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel
;Read and store the user input 
mov eax, 3 
mov ebx, 2 
mov ecx, DOB
mov edx, 20 ;20 bytes (numeric, 1 for sign) of that information 
int 80h

; write  input into the file
   mov	edx,20         ;number of bytes
   mov	ecx, DOB        ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel

write_string Info7,lenInfo7
; write string into the file
   mov	edx,lenInfo7       ;number of bytes
   mov	ecx, Info7        ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel
;Read and store the user input 
mov eax, 3 
mov ebx, 2 
mov ecx, phone_number
mov edx, 15 ;15 bytes (numeric, 1 for sign) of that information 
int 80h

; write  input into the file
   mov	edx,15        ;number of bytes
   mov	ecx, phone_number       ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel


write_string Info8,lenInfo8
; write string into the file
   mov	edx,lenInfo8       ;number of bytes
   mov	ecx, Info8        ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel
;Read and store the user input 
mov eax, 3 
mov ebx, 2 
mov ecx, email
mov edx, 100 ;100 bytes (numeric, 1 for sign) of that information 
int 80h

; write  input into the file
   mov	edx,100         ;number of bytes
   mov	ecx, email        ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel

write_string Info9,lenInfo9
; write string into the file
   mov	edx,lenInfo9       ;number of bytes
   mov	ecx, Info9        ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel
;Read and store the user input 
mov eax, 3 
mov ebx, 2 
mov ecx, residence
mov edx, 100 ;100 bytes (numeric, 1 for sign) of that information 
int 80h

; write  input into the file
   mov	edx,100        ;number of bytes
   mov	ecx, residence        ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel

write_string Info10,lenInfo10
; write string into the file
   mov	edx,lenInfo10       ;number of bytes
   mov	ecx, Info10        ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel
;Read and store the user input 
mov eax, 3 
mov ebx, 2 
mov ecx, home_add
mov edx, 50 ;50 bytes (numeric, 1 for sign) of that information 
int 80h

; write  input into the file
   mov	edx, 50         ;number of bytes
   mov	ecx, home_add      ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel

write_string Info11,lenInfo11
; write string into the file
   mov	edx,lenInfo11       ;number of bytes
   mov	ecx, Info11        ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel
;Read and store the user input 
mov eax, 3 
mov ebx, 2 
mov ecx, name_contact
mov edx, 100 ;100 bytes (numeric, 1 for sign) of that information 
int 80h

; write  input into the file
   mov	edx,100         ;number of bytes
   mov	ecx, name_contact        ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel


write_string Info12,lenInfo12
; write string into the file
   mov	edx,lenInfo12       ;number of bytes
   mov	ecx, Info12        ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel
;Read and store the user input 
mov eax, 3 
mov ebx, 2 
mov ecx, no_contact
mov edx, 100 ;100 bytes (numeric, 1 for sign) of that information 
int 80h

; write  input into the file
   mov	edx,100         ;number of bytes
   mov	ecx, no_contact        ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel

write_string Info13,lenInfo13
; write string into the file
   mov	edx,lenInfo13       ;number of bytes
   mov	ecx, Info13        ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel
;Read and store the user input 
mov eax, 3 
mov ebx, 2 
mov ecx, KCSE_marks
mov edx, 10 ;10 bytes (numeric, 1 for sign) of that information 
int 80h

; write  input into the file
   mov	edx,10         ;number of bytes
   mov	ecx, KCSE_marks       ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel


; close the file
   mov eax, 6
   mov ebx, [fd_out]

mov eax,1 ;system call number (sys_exit) 
int 0x80 ;call kernel

L2:
;Open file for reading

write_string Oname,lenOname
;Read and store the user input 
    mov eax, 3 
    mov ebx, 2 
    mov ecx, open_name
    mov edx, 30 ;5 bytes (numeric, 1 for sign) of that information 
    int 80h

;open the file for reading 
mov eax, 5 
mov ebx, open_name 
mov ecx, 0 ;for read only access 
mov edx, 0777 ;read, write and execute by all 
int 0x80

mov [fd_in], byte eax

write_string Finfo,lenFinfo
;read from file
   mov eax, 3
   mov ebx, [fd_in]
   mov ecx, info
   mov edx, 3000
   int 0x80
;print the info 
   mov eax, 4
   mov ebx, 1
   mov ecx, info
   mov edx, 3000
   int 0x80
    
  ; close the file
   mov eax, 6
   mov ebx, [fd_in]

mov eax,1 ;system call number (sys_exit) 
int 0x80 ;call kernel

L3:;Delete file
    write_string Query4,lenQuery4
;Read and store the user input 
mov eax, 3 
mov ebx, 2 
mov ecx, del_name
mov edx, 10 ;20 bytes (numeric, 1 for sign) of that information 
int 80h    

;Delete file from folder
    mov eax,10
    mov ebx,del_name
    int 80h
write_string Query5,lenQuery5
;Read and store the user input 
mov eax, 3 
mov ebx, 2 
mov ecx, crt_opt
mov edx, 10 ;20 bytes (numeric, 1 for sign) of that information 
int 80h

;Loop for determining choice
mov ecx,[crt_opt]
cmp ecx,[num3]
je L1

mov eax,1 ;system call number (sys_exit) 
int 0x80 ;call kernel      

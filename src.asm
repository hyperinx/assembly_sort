COMMENT @
------------------------------------------------------------------------------------------------------------------------------------------------------------------
  /$$$$$$              /$$     /$$                                 /$$      /$$       /$$      /$$                               /$$                              
 /$$__  $$            | $$    | $$                                | $$$    /$$$      | $$$    /$$$                              |__/                              
| $$  \ $$ /$$   /$$ /$$$$$$  | $$$$$$$   /$$$$$$   /$$$$$$       | $$$$  /$$$$      | $$$$  /$$$$  /$$$$$$   /$$$$$$   /$$$$$$  /$$  /$$$$$$$  /$$$$$$  /$$$$$$$
| $$$$$$$$| $$  | $$|_  $$_/  | $$__  $$ /$$__  $$ /$$__  $$  $$  | $$ $$/$$ $$      | $$ $$/$$ $$ /$$__  $$ /$$__  $$ /$$__  $$| $$ /$$_____/ /$$__  $$| $$__  $$
| $$__  $$| $$  | $$  | $$    | $$  \ $$| $$  \ $$| $$  \__/      | $$  $$$| $$      | $$  $$$| $$| $$  \ $$| $$  \__/| $$  \__/| $$|  $$$$$$ | $$  \ $$| $$  \ $$
| $$  | $$| $$  | $$  | $$ /$$| $$  | $$| $$  | $$| $$            | $$\  $ | $$      | $$\  $ | $$| $$  | $$| $$      | $$      | $$ \____  $$| $$  | $$| $$  | $$
| $$  | $$|  $$$$$$/  |  $$$$/| $$  | $$|  $$$$$$/| $$        $$  | $$ \/  | $$      | $$ \/  | $$|  $$$$$$/| $$      | $$      | $$ /$$$$$$$/|  $$$$$$/| $$  | $$
|__/  |__/ \______/    \___/  |__/  |__/ \______/ |__/            |__/     |__/  $$  |__/     |__/ \______/ |__/      |__/      |__/|_______/  \______/ |__/  |__/
------------------------------------------------------------------------------------------------------------------------------------------------------------------
@     

include irvine32.inc
.data
$message byte 'Podaj 10 liczb <Enter>:', 0
$task dword 2, 5, 3, 1, 4, 7, 6, 10, 8, 9
$numbers dword 2, 5, 3, 1, 4, 7, 6, 10, 8, 9
$mustBe dword 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
$isSwapped byte 0
$i dword 1
$j dword 1
$key dword ?
$min dword ?
$testingIterations byte 2
$carriageReturn byte ' ', 13, 10, 0
$testingOkMessage byte '[OK]', 0
$testingFailedMessage byte '[FAILED]', 0
.code

_displayMessage proc
mov edx, offset $message
call WriteString
call _writeCarriageReturn
ret
_displayMessage endp

_writeCarriageReturn proc
mov edx, offset $carriageReturn
call WriteString
ret
_writeCarriageReturn endp

_inputNumbers proc
mov ecx, lengthof $numbers
mov esi, offset $numbers
mov edi, offset $task
l1 :
call ReadInt
mov [esi], eax
mov [edi], eax
add esi, type $numbers
loop l1
ret
_inputNumbers endp

COMMENT @
    _______  __________  _____    _   ______________   _____ ____  ____  ______
   / ____/ |/ / ____/ / / /   |  / | / / ____/ ____/  / ___// __ \/ __ \/_  __/
  / __/  |   / /   / /_/ / /| | /  |/ / / __/ __/     \__ \/ / / / /_/ / / /   
 / /___ /   / /___/ __  / ___ |/ /|  / /_/ / /___    ___/ / /_/ / _, _/ / /    
/_____//_/|_\____/_/ /_/_/  |_/_/ |_/\____/_____/   /____/\____/_/ |_| /_/     
                                                                              		
@
                                                                                                                            
_exchangeSort proc
mov ecx, lengthof $numbers
mov esi, offset $numbers
mov $i, 1
mov $j, 1

outerLoop :
mov $isSwapped, 0
mov $j, 1

innerLoop :
mov eax, $j
mov bl, 4
mul bl
sub eax, 4
mov edi, eax
mov ebx, [esi + edi]
add edi, 4
mov edx, [esi + edi]
sub edi, 4

cmp ebx, edx;	cmp ebx, edx - rosnaco, cmp edx, ebx - malejaco
jg swap
jmp exitSwap

swap :
mov eax, [esi + edi]
xchg eax, [esi + edi + 4]
mov [esi + edi], eax
mov	$isSwapped, 1
exitSwap :
inc $j
cmp $j, ecx
jb innerLoop
cmp $isSwapped, 0
je exitSort
inc $i
cmp $i, ecx
jb outerLoop

exitSort :
ret
_exchangeSort endp

COMMENT @
    _____   _______ __________  ______________  _   __   _____ ____  ____  ______
   /  _/ | / / ___// ____/ __ \/_  __/  _/ __ \/ | / /  / ___// __ \/ __ \/_  __/
   / //  |/ /\__ \/ __/ / /_/ / / /  / // / / /  |/ /   \__ \/ / / / /_/ / / /   
 _/ // /|  /___/ / /___/ _, _/ / / _/ // /_/ / /|  /   ___/ / /_/ / _, _/ / /    
/___/_/ |_//____/_____/_/ |_| /_/ /___/\____/_/ |_/   /____/\____/_/ |_| /_/     
                                                                                 
@

_insertionSort proc
mov ecx, lengthof $numbers
mov esi, offset $numbers

mov $i, 2 ;						
		
forLoop:
mov eax, $i;			
mov bl, 4
mul bl
sub eax, 4
mov edi, eax
mov ebx, [esi + edi]; arr[i] 
mov $key, ebx
mov eax, $i
mov $j, eax
dec $j

whileLoop:
cmp $j, 0
ja leftCondIsTrue
jmp exitWhileLoop
														
leftCondIsTrue:								
mov eax, $j
mov bl, 4
mul bl
sub eax, 4
mov edi, eax
mov ebx, [esi + edi]; arr[j]

cmp ebx, $key
ja rightCondIsTrue
jmp exitWhileLoop

rightCondIsTrue :

mov eax, $j
mov bl, 4
mul bl
sub eax, 4
mov edi, eax
mov ebx, [esi + edi]; arr[j]
mov [esi + edi + 4], ebx
								
dec $j
jmp whileLoop
					
exitWhileLoop:

mov eax, $j
mov bl, 4
mul bl
mov edi, eax
mov edx, $key
mov [esi + edi], edx; arr[j + 1]
			
inc $i
cmp $i, ecx
jbe forLoop;				
ret
_insertionSort endp

COMMENT @
   _____ ________    __________________________  _   __   _____ ____  ____  ______
  / ___// ____/ /   / ____/ ____/_  __/  _/ __ \/ | / /  / ___// __ \/ __ \/_  __/
  \__ \/ __/ / /   / __/ / /     / /  / // / / /  |/ /   \__ \/ / / / /_/ / / /   
 ___/ / /___/ /___/ /___/ /___  / / _/ // /_/ / /|  /   ___/ / /_/ / _, _/ / /    
/____/_____/_____/_____/\____/ /_/ /___/\____/_/ |_/   /____/\____/_/ |_| /_/     

@                                                                                  

_selectionSort proc

mov ecx, lengthof $numbers
mov esi, offset $numbers
mov $i, 1

outerLoop :
mov eax, $i
mov $min, eax
mov $j, eax
inc $j
				
innerLoop:
mov eax, $min
mov bl, 4
mul bl
sub eax, 4
mov edi, eax
mov edx, [esi + edi]; arr[min]
							
mov eax, $j
mov bl, 4
mul bl
sub eax, 4
mov edi, eax							
							
cmp edx, [esi + edi] ;arr[j]
jg setMin
jmp omitSetMin
setMin:
mov eax, $j
mov $min, eax
omitSetMin:
																
inc $j
cmp $j, ecx
jbe innerLoop

mov eax, $min
cmp eax, $i
jne swap
jmp omitSwap
swap :

mov eax, $i
mov bl, 4
mul bl
sub eax, 4
mov edi, eax
push edi
mov edx, [esi + edi]

mov eax, $min
mov bl, 4
mul bl
sub eax, 4
mov edi, eax
											
mov eax, edx
xchg eax, [esi + edi]
pop edi
mov [esi + edi], eax
										
omitSwap :

inc $i
cmp $i, ecx
jb outerLoop		
ret
_selectionSort endp

_writeNumbers proc
mov ecx, lengthof $numbers
mov esi, offset $numbers
l1 :
mov eax, [esi]
call WriteInt
add esi, type $numbers
loop l1
ret
_writeNumbers endp

COMMENT @
  ____________________________   ________
 /_  __/ ____/ ___/_  __/  _/ | / / ____/
  / / / __/  \__ \ / /  / //  |/ / / __  
 / / / /___ ___/ // / _/ // /|  / /_/ /  
/_/ /_____//____//_/ /___/_/ |_/\____/   

@

_restoreTask proc
mov ecx, lengthof $task
mov esi, offset $task
mov edi, offset $numbers
l1 :
mov edx, [esi]
mov [edi], edx

add esi, type $numbers
add edi, type $numbers

loop l1
ret
_restoreTask endp

_testModule proc
mov ecx, lengthof $mustBe
mov esi, offset $numbers
mov edi, offset $mustBe
l1 :
mov ebx, [esi]
mov edx, [edi]

cmp ebx, edx
jne failed

add esi, type $numbers
add edi, type $numbers
	
loop l1
mov edx, offset $testingOkMessage
call WriteString
jmp exitOnSuccess
failed:
mov edx, offset $testingFailedMessage
call WriteString
exitOnSuccess:
ret
_testModule endp

_main proc
; call _displayMessage
; call _inputNumbers
l1:
call _exchangeSort
call _writeNumbers
call _testModule
call _restoreTask

call _writeCarriageReturn

call _insertionSort
call _writeNumbers
call _testModule
call _restoreTask

call _writeCarriageReturn
		
call _selectionSort
call _writeNumbers
call _testModule
call _restoreTask

call _writeCarriageReturn

dec $testingIterations
cmp $testingIterations, 0
ja l1

exit
_main endp
end _main

;Andrew Dibble
;Assignment 6
;this program encripts or decripts a given string based on input from the user

            .ORIG       x3000                ;start at x3000
            LD          R1, Address          ;load address x3100 into a register
            LEA         R0, Prompt1          ;prompt the user to enter E for encrypt or D for decrypt and store in x3100
            PUTS
            GETC
            OUT
            STR         R0, R1, #0           ;store in location x3100
            ADD         R1, R1, #1           ;increment address
            
            LEA         R0, Prompt2          ;prompt the user for a value between 1 and 9, store the value in x3101
            PUTS
            GETC
            OUT
            STR         R0, R1, #0           ;store in location x3101
            ADD         R1, R1, #1           ;increment address
            
            LEA         R0, Prompt3          ;prompt the user for a string message, accept the string until the user hits enter, store starting at x3102
            PUTS
            
            
GetLine
            GETC                            ;get input character from keyboard
            OUT                             ;display the character
            ADD     R2, R0, #-10            ;is it an enter character?
            BRz     Main                    ;if yes, get out of loop, and toggle the string        
                                            ;else store and get next character
            STR     R0, R1, #0              ;Store the character in memory at the address specified by R1
            ADD     R1, R1, #1              ;increment address
            BRnzp   GetLine                 ;unconditional branch
                                            ;no validation is necessary for any of these, assume the user will enter 20 characters at max
    
    
Main
            LDI     R3, Address             ;get the character at location x3100 and load it into R3
            LD      R4, E                   ;get the character E in R4
            ADD     R5, R3, R4              ;add R3 and E
            BRz     Encrypt                 ;if E, go to Encrypt
            BRnzp   Decrypt                 ;else go to Decrypt
            
    

Encrypt
            LD      R1, Address3            ;where the string characters are stored
            LD      R6, Address4            ;where the encrypted characters will be stored
            
            
            
            JSR     Toggle                  ;jump to routine and save PC R7
            LD      R4, Number              ;loading -48 into R4
            LDI     R2, Address2            ;loading the key into R2
            ADD     R2,R2,R4                ;the character is in ASCII so getting the decimal value by subtracting 48
            ADD     R3, R3, R2              ;adding the key to the number
            STR     R3, R6, #0              ;storing at the address specified by R6
            LDR     R0, R6, #0
            OUT
            ADD     R6, R6, #1              ;incrementing R6
            LDR     R7, R1, #0
            BRp     #-11
            HALT

Decrypt
            LD      R1, Address3            ;where the string characters are stored
            LD      R6, Address4            ;where the encrypted characters will be stored
            LDR     R3, R1,#0
            
            LD      R4, Number              ;loading -48 into R4
            LDI     R2, Address2            ;loading the key into R2
            ADD     R2,R2,R4                ;the character is in ASCII so getting the decimal value by subtracting 48
            NOT     R2, R2
            ADD     R2, R2, #1              ;getting the twos comp
            ADD     R3, R3, R2              ;subtracting the key from the number
            STR     R3, R1, #0
            JSR     Toggle                  ;jump to routine and save PC R7
            STR     R3, R6, #0              ;storing at the address specified by R6
            LDR     R0, R6, #0
            OUT
            ADD     R6, R6, #1              ;incrementing R6
            LDR     R7, R1, #0
            LDR     R3, R1,#0
            BRp     #-15
            
            HALT
    
Toggle                                      ;routine that flips the lowest order bit
            LDR     R3, R1,#0
            AND     R4,R3,#1                ;get the lowest order bit
            BRz     #2                      ;if its a 0 make it a 1, else make it a 0
            ADD     R3, R3, #-1             ;changing 1 to 0
            BRnzp   #1
            ADD     R3,R3, #1               ;changing 0 to 1
            ADD     R1, R1, #1              ;increment address
            RET
            
        
        
Prompt1     .STRINGZ  "Enter either E for encrypt of D for decrypt: "
Prompt2     .STRINGZ  "\nEnter a value between 1 and 9: "
Prompt3     .STRINGZ  "\nEnter a string of characters (maximum 20): "
Address     .FILL     x3100         
Address2    .FILL     x3101         		;the key
Address3    .FILL     x3102         		;the string characters will be stored starting at this address
Address4    .FILL     x3120         		;where the encrypted characters are stored
E           .FILL     #-69
Make0       .FILL     #254          		;the binary number 1111 1110         
Number      .FILL     #-48

			.END
        
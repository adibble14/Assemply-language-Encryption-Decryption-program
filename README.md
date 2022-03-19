# Assemply-language-Encryption-Decryption-program
Your program should prompt the user for three separate inputs from the keyboard
1.The prompt: Type (E)ncrypt/(D)ecrypt : 
2.The prompt: Enter encryption key (1-9): 
3. The prompt: Enter message:  

Encryption Algorithm:
1. The low order bit of the code will be toggled. That is, if it is a 1, it will be replaced by 
a 0; if it is a 0, it will be replaced by a 1. 
2. The key will be added to the result of step 1 above. 

The decryption algorithm is the reverse. 
1. Subtract the encryption key from the ASCII code. 
2. Toggle the low order bit of the result of step 1. 

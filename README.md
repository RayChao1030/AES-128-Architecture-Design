# AES-128-Architecture-Design
Used verilog to practice AES-128 algorithm into circuit on Modelsim, optimized the functions of sub_byte() and
mix_column() as we can , and used tsmc90 to synthesize to obtain a significant reduction in circuit area. With the low-area architecture and pipeline architecture that we have achieved, the longest path is reduced by less than one tenth of the original, and the area is 5.62 times.
Below is low area AES Architecture.
![image](https://github.com/RayChao1030/AES-128-Architecture-Design/assets/76627328/b7b34777-850e-4d04-b58d-dc53c7cf1611)
Below is 10 stage pipeline AES Architecture besed on low area Architecture.
![image](https://github.com/RayChao1030/AES-128-Architecture-Design/assets/76627328/84a256aa-9a64-4a44-ab8f-df086df44a56)
Below is Pipeline Architecture of AES-128 Rounds 1-9 Details.
![image](https://github.com/RayChao1030/AES-128-Architecture-Design/assets/76627328/cfbaf3b6-cc3e-4312-8d28-0e6e70e15754)
Below is Pipeline Architecture of AES-128 first and 10th Rounds Details.
![image](https://github.com/RayChao1030/AES-128-Architecture-Design/assets/76627328/bc4809ac-ca29-43c5-91de-63dcb83d709a)
Below is our Encryption and Decryption result Demo. Further GrayscaleProcessed photos to Encrypt and Decrypt the photos on the pipeline model.
![image](https://github.com/RayChao1030/AES-128-Architecture-Design/assets/76627328/7fa166f6-535a-44d8-939f-625b25ac433b)

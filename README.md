# AES-128-Architecture-Design
Used verilog to practice AES-128 algorithm into circuit on Modelsim, optimized the functions of sub_byte() and
mix_column() as we can , and used tsmc90 to synthesize to obtain a significant reduction in circuit area. With the low-area architecture and pipeline architecture that we have achieved, the longest path is reduced by less than one tenth of the original, and the area is 5.62 times.Below is our Encryption and Decryption result Demo. Further GrayscaleProcessed photos to Encrypt and Decrypt the photos on the pipeline model.
![image](https://github.com/RayChao1030/AES-128-Architecture-Design/assets/76627328/7fa166f6-535a-44d8-939f-625b25ac433b)

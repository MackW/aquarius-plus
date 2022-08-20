module colorram(
    input  wire       clk,

    // input  wire [9:0] addr1,
    // output reg  [7:0] rddata1,
    // input  wire [7:0] wrdata1,
    // input  wire       wren1,

    input  wire [9:0] addr2,
    output reg  [7:0] rddata2);

    reg [7:0] ram [1023:0];

 initial begin
        ram[   0] = 8'h8F; ram[   1] = 8'h8F; ram[   2] = 8'h8F; ram[   3] = 8'h8F;
        ram[   4] = 8'h8F; ram[   5] = 8'h8F; ram[   6] = 8'h8F; ram[   7] = 8'h8F;
        ram[   8] = 8'h8F; ram[   9] = 8'h8F; ram[  10] = 8'h8F; ram[  11] = 8'h8F;
        ram[  12] = 8'h8F; ram[  13] = 8'h8F; ram[  14] = 8'h8F; ram[  15] = 8'h8F;
        ram[  16] = 8'h8F; ram[  17] = 8'h8F; ram[  18] = 8'h8F; ram[  19] = 8'h8F;
        ram[  20] = 8'h8F; ram[  21] = 8'h8F; ram[  22] = 8'h8F; ram[  23] = 8'h8F;
        ram[  24] = 8'h8F; ram[  25] = 8'h8F; ram[  26] = 8'h8F; ram[  27] = 8'h8F;
        ram[  28] = 8'h8F; ram[  29] = 8'h8F; ram[  30] = 8'h8F; ram[  31] = 8'h8F;
        ram[  32] = 8'h8F; ram[  33] = 8'h8F; ram[  34] = 8'h8F; ram[  35] = 8'h8F;
        ram[  36] = 8'h8F; ram[  37] = 8'h8F; ram[  38] = 8'h8F; ram[  39] = 8'h8F;
        ram[  40] = 8'h6F; ram[  41] = 8'h6F; ram[  42] = 8'h6F; ram[  43] = 8'h6F;
        ram[  44] = 8'h6F; ram[  45] = 8'h6F; ram[  46] = 8'h6F; ram[  47] = 8'h6F;
        ram[  48] = 8'h8F; ram[  49] = 8'h1F; ram[  50] = 8'h3F; ram[  51] = 8'h2F;
        ram[  52] = 8'h4F; ram[  53] = 8'hAF; ram[  54] = 8'h8F; ram[  55] = 8'h6F;
        ram[  56] = 8'h6F; ram[  57] = 8'h6F; ram[  58] = 8'h6F; ram[  59] = 8'h6F;
        ram[  60] = 8'h6F; ram[  61] = 8'h8F; ram[  62] = 8'h8F; ram[  63] = 8'h8F;
        ram[  64] = 8'h8F; ram[  65] = 8'h8F; ram[  66] = 8'h8F; ram[  67] = 8'h8F;
        ram[  68] = 8'h8F; ram[  69] = 8'h8F; ram[  70] = 8'h8F; ram[  71] = 8'h8F;
        ram[  72] = 8'h8F; ram[  73] = 8'h8F; ram[  74] = 8'h8F; ram[  75] = 8'h8F;
        ram[  76] = 8'h8F; ram[  77] = 8'h8F; ram[  78] = 8'h8F; ram[  79] = 8'h8F;
        ram[  80] = 8'hF4; ram[  81] = 8'hF4; ram[  82] = 8'hF4; ram[  83] = 8'hF4;
        ram[  84] = 8'hF4; ram[  85] = 8'hF4; ram[  86] = 8'hF4; ram[  87] = 8'hF4;
        ram[  88] = 8'hF4; ram[  89] = 8'hF4; ram[  90] = 8'hF4; ram[  91] = 8'hF4;
        ram[  92] = 8'hF4; ram[  93] = 8'hF4; ram[  94] = 8'hF4; ram[  95] = 8'hF4;
        ram[  96] = 8'hF4; ram[  97] = 8'hF4; ram[  98] = 8'hF4; ram[  99] = 8'hF4;
        ram[ 100] = 8'hF4; ram[ 101] = 8'h8F; ram[ 102] = 8'h8F; ram[ 103] = 8'h8F;
        ram[ 104] = 8'h8F; ram[ 105] = 8'h8F; ram[ 106] = 8'h8F; ram[ 107] = 8'h8F;
        ram[ 108] = 8'h8F; ram[ 109] = 8'h8F; ram[ 110] = 8'h8F; ram[ 111] = 8'h8F;
        ram[ 112] = 8'h8F; ram[ 113] = 8'h8F; ram[ 114] = 8'h8F; ram[ 115] = 8'h8F;
        ram[ 116] = 8'h8F; ram[ 117] = 8'h8F; ram[ 118] = 8'h8F; ram[ 119] = 8'h8F;
        ram[ 120] = 8'h8F; ram[ 121] = 8'h8F; ram[ 122] = 8'h8F; ram[ 123] = 8'h8F;
        ram[ 124] = 8'h8F; ram[ 125] = 8'h8F; ram[ 126] = 8'h8F; ram[ 127] = 8'h8F;
        ram[ 128] = 8'h8F; ram[ 129] = 8'h8F; ram[ 130] = 8'h8F; ram[ 131] = 8'h8F;
        ram[ 132] = 8'h8F; ram[ 133] = 8'h8F; ram[ 134] = 8'h8F; ram[ 135] = 8'h8F;
        ram[ 136] = 8'h8F; ram[ 137] = 8'h8F; ram[ 138] = 8'h8F; ram[ 139] = 8'h8F;
        ram[ 140] = 8'h8F; ram[ 141] = 8'h8F; ram[ 142] = 8'h8F; ram[ 143] = 8'h8F;
        ram[ 144] = 8'h8F; ram[ 145] = 8'h8F; ram[ 146] = 8'h8F; ram[ 147] = 8'h8F;
        ram[ 148] = 8'h8F; ram[ 149] = 8'h8F; ram[ 150] = 8'h8F; ram[ 151] = 8'h8F;
        ram[ 152] = 8'h8F; ram[ 153] = 8'h8F; ram[ 154] = 8'h8F; ram[ 155] = 8'h8F;
        ram[ 156] = 8'h8F; ram[ 157] = 8'h8F; ram[ 158] = 8'h8F; ram[ 159] = 8'h8F;
        ram[ 160] = 8'h8F; ram[ 161] = 8'h8F; ram[ 162] = 8'h8F; ram[ 163] = 8'h8F;
        ram[ 164] = 8'h8F; ram[ 165] = 8'h8F; ram[ 166] = 8'h8F; ram[ 167] = 8'h8F;
        ram[ 168] = 8'h8F; ram[ 169] = 8'h8F; ram[ 170] = 8'h8F; ram[ 171] = 8'h8F;
        ram[ 172] = 8'h8F; ram[ 173] = 8'h8F; ram[ 174] = 8'h8F; ram[ 175] = 8'h8F;
        ram[ 176] = 8'h8F; ram[ 177] = 8'h8F; ram[ 178] = 8'h8F; ram[ 179] = 8'h8F;
        ram[ 180] = 8'h8F; ram[ 181] = 8'h8F; ram[ 182] = 8'h8F; ram[ 183] = 8'h0F;
        ram[ 184] = 8'h0F; ram[ 185] = 8'h0F; ram[ 186] = 8'h0F; ram[ 187] = 8'h0F;
        ram[ 188] = 8'h0F; ram[ 189] = 8'h0F; ram[ 190] = 8'h0F; ram[ 191] = 8'h0F;
        ram[ 192] = 8'h0F; ram[ 193] = 8'h0F; ram[ 194] = 8'h0F; ram[ 195] = 8'h0F;
        ram[ 196] = 8'h0F; ram[ 197] = 8'h0F; ram[ 198] = 8'h0F; ram[ 199] = 8'h8F;
        ram[ 200] = 8'h8F; ram[ 201] = 8'h8F; ram[ 202] = 8'h8F; ram[ 203] = 8'h8F;
        ram[ 204] = 8'h8F; ram[ 205] = 8'h8F; ram[ 206] = 8'h8F; ram[ 207] = 8'h8F;
        ram[ 208] = 8'h8F; ram[ 209] = 8'h8F; ram[ 210] = 8'h8F; ram[ 211] = 8'h8F;
        ram[ 212] = 8'h8F; ram[ 213] = 8'h8F; ram[ 214] = 8'h8F; ram[ 215] = 8'h8F;
        ram[ 216] = 8'h8F; ram[ 217] = 8'h8F; ram[ 218] = 8'h8F; ram[ 219] = 8'h8F;
        ram[ 220] = 8'h8F; ram[ 221] = 8'h8F; ram[ 222] = 8'h8F; ram[ 223] = 8'h00;
        ram[ 224] = 8'h8F; ram[ 225] = 8'hEE; ram[ 226] = 8'h11; ram[ 227] = 8'h33;
        ram[ 228] = 8'hCC; ram[ 229] = 8'h22; ram[ 230] = 8'hDD; ram[ 231] = 8'h99;
        ram[ 232] = 8'h66; ram[ 233] = 8'h44; ram[ 234] = 8'hBB; ram[ 235] = 8'hAA;
        ram[ 236] = 8'h55; ram[ 237] = 8'h88; ram[ 238] = 8'h77; ram[ 239] = 8'h0F;
        ram[ 240] = 8'h8F; ram[ 241] = 8'h8F; ram[ 242] = 8'h8F; ram[ 243] = 8'h8F;
        ram[ 244] = 8'h8F; ram[ 245] = 8'h8F; ram[ 246] = 8'h8F; ram[ 247] = 8'h8F;
        ram[ 248] = 8'h8F; ram[ 249] = 8'h8F; ram[ 250] = 8'h8F; ram[ 251] = 8'h8F;
        ram[ 252] = 8'h8F; ram[ 253] = 8'h8F; ram[ 254] = 8'h8F; ram[ 255] = 8'h8F;
        ram[ 256] = 8'h8F; ram[ 257] = 8'h8F; ram[ 258] = 8'h8F; ram[ 259] = 8'h8F;
        ram[ 260] = 8'h8F; ram[ 261] = 8'h8F; ram[ 262] = 8'h8F; ram[ 263] = 8'h00;
        ram[ 264] = 8'h8F; ram[ 265] = 8'hEE; ram[ 266] = 8'h11; ram[ 267] = 8'h33;
        ram[ 268] = 8'hCC; ram[ 269] = 8'h22; ram[ 270] = 8'hDD; ram[ 271] = 8'h99;
        ram[ 272] = 8'h66; ram[ 273] = 8'h44; ram[ 274] = 8'hBB; ram[ 275] = 8'hAA;
        ram[ 276] = 8'h55; ram[ 277] = 8'h88; ram[ 278] = 8'h77; ram[ 279] = 8'h0F;
        ram[ 280] = 8'h8F; ram[ 281] = 8'h8F; ram[ 282] = 8'h8F; ram[ 283] = 8'h8F;
        ram[ 284] = 8'h8F; ram[ 285] = 8'h8F; ram[ 286] = 8'h8F; ram[ 287] = 8'h8F;
        ram[ 288] = 8'h8F; ram[ 289] = 8'h8F; ram[ 290] = 8'h8F; ram[ 291] = 8'h8F;
        ram[ 292] = 8'h8F; ram[ 293] = 8'h8F; ram[ 294] = 8'h8F; ram[ 295] = 8'h8F;
        ram[ 296] = 8'h8F; ram[ 297] = 8'h8F; ram[ 298] = 8'h8F; ram[ 299] = 8'h8F;
        ram[ 300] = 8'h8F; ram[ 301] = 8'h8F; ram[ 302] = 8'h8F; ram[ 303] = 8'hF0;
        ram[ 304] = 8'h0F; ram[ 305] = 8'h0E; ram[ 306] = 8'h01; ram[ 307] = 8'h03;
        ram[ 308] = 8'h0C; ram[ 309] = 8'h02; ram[ 310] = 8'h0D; ram[ 311] = 8'h09;
        ram[ 312] = 8'h06; ram[ 313] = 8'h04; ram[ 314] = 8'h0B; ram[ 315] = 8'h0A;
        ram[ 316] = 8'h05; ram[ 317] = 8'h08; ram[ 318] = 8'h07; ram[ 319] = 8'h0F;
        ram[ 320] = 8'h8F; ram[ 321] = 8'h8F; ram[ 322] = 8'h8F; ram[ 323] = 8'h8F;
        ram[ 324] = 8'h8F; ram[ 325] = 8'h8F; ram[ 326] = 8'h8F; ram[ 327] = 8'h8F;
        ram[ 328] = 8'h8F; ram[ 329] = 8'h8F; ram[ 330] = 8'h8F; ram[ 331] = 8'h8F;
        ram[ 332] = 8'h8F; ram[ 333] = 8'h8F; ram[ 334] = 8'h8F; ram[ 335] = 8'h8F;
        ram[ 336] = 8'h8F; ram[ 337] = 8'h8F; ram[ 338] = 8'h8F; ram[ 339] = 8'hF0;
        ram[ 340] = 8'h00; ram[ 341] = 8'h00; ram[ 342] = 8'h0F; ram[ 343] = 8'hF0;
        ram[ 344] = 8'h0F; ram[ 345] = 8'h0E; ram[ 346] = 8'h01; ram[ 347] = 8'h03;
        ram[ 348] = 8'h0C; ram[ 349] = 8'h02; ram[ 350] = 8'h0D; ram[ 351] = 8'h09;
        ram[ 352] = 8'h06; ram[ 353] = 8'h04; ram[ 354] = 8'h0B; ram[ 355] = 8'h0A;
        ram[ 356] = 8'h05; ram[ 357] = 8'h08; ram[ 358] = 8'h07; ram[ 359] = 8'h0F;
        ram[ 360] = 8'h8F; ram[ 361] = 8'h8F; ram[ 362] = 8'h8F; ram[ 363] = 8'h8F;
        ram[ 364] = 8'h8F; ram[ 365] = 8'h8F; ram[ 366] = 8'h8F; ram[ 367] = 8'h8F;
        ram[ 368] = 8'h8F; ram[ 369] = 8'h8F; ram[ 370] = 8'h8F; ram[ 371] = 8'h8F;
        ram[ 372] = 8'h8F; ram[ 373] = 8'h8F; ram[ 374] = 8'h8F; ram[ 375] = 8'h8F;
        ram[ 376] = 8'h8F; ram[ 377] = 8'h8F; ram[ 378] = 8'h8F; ram[ 379] = 8'hF0;
        ram[ 380] = 8'h8F; ram[ 381] = 8'h8F; ram[ 382] = 8'hF0; ram[ 383] = 8'hF0;
        ram[ 384] = 8'h0F; ram[ 385] = 8'hFE; ram[ 386] = 8'hF1; ram[ 387] = 8'hF3;
        ram[ 388] = 8'hFC; ram[ 389] = 8'hF2; ram[ 390] = 8'hFD; ram[ 391] = 8'hF9;
        ram[ 392] = 8'hF6; ram[ 393] = 8'hF4; ram[ 394] = 8'hFB; ram[ 395] = 8'hFA;
        ram[ 396] = 8'hF5; ram[ 397] = 8'hF8; ram[ 398] = 8'hF7; ram[ 399] = 8'h0F;
        ram[ 400] = 8'h8F; ram[ 401] = 8'h0F; ram[ 402] = 8'h0F; ram[ 403] = 8'h0F;
        ram[ 404] = 8'h0F; ram[ 405] = 8'h0F; ram[ 406] = 8'h0F; ram[ 407] = 8'h0F;
        ram[ 408] = 8'h8F; ram[ 409] = 8'h8F; ram[ 410] = 8'h8F; ram[ 411] = 8'h8F;
        ram[ 412] = 8'h8F; ram[ 413] = 8'h8F; ram[ 414] = 8'h8F; ram[ 415] = 8'h8F;
        ram[ 416] = 8'h8F; ram[ 417] = 8'h8F; ram[ 418] = 8'h8F; ram[ 419] = 8'hF0;
        ram[ 420] = 8'hEE; ram[ 421] = 8'hEE; ram[ 422] = 8'hE0; ram[ 423] = 8'hE0;
        ram[ 424] = 8'hEF; ram[ 425] = 8'hFE; ram[ 426] = 8'hE1; ram[ 427] = 8'hE3;
        ram[ 428] = 8'hEC; ram[ 429] = 8'hE2; ram[ 430] = 8'hED; ram[ 431] = 8'hE9;
        ram[ 432] = 8'hE6; ram[ 433] = 8'hE4; ram[ 434] = 8'hEB; ram[ 435] = 8'hEA;
        ram[ 436] = 8'hE5; ram[ 437] = 8'hE8; ram[ 438] = 8'hE7; ram[ 439] = 8'h0F;
        ram[ 440] = 8'hF0; ram[ 441] = 8'h00; ram[ 442] = 8'h0F; ram[ 443] = 8'h8F;
        ram[ 444] = 8'hF8; ram[ 445] = 8'h88; ram[ 446] = 8'h87; ram[ 447] = 8'h77;
        ram[ 448] = 8'h0F; ram[ 449] = 8'h8F; ram[ 450] = 8'h8F; ram[ 451] = 8'h8F;
        ram[ 452] = 8'h8F; ram[ 453] = 8'h8F; ram[ 454] = 8'h8F; ram[ 455] = 8'h8F;
        ram[ 456] = 8'h8F; ram[ 457] = 8'h8F; ram[ 458] = 8'h8F; ram[ 459] = 8'hF0;
        ram[ 460] = 8'h11; ram[ 461] = 8'h11; ram[ 462] = 8'h10; ram[ 463] = 8'h10;
        ram[ 464] = 8'h1F; ram[ 465] = 8'h1E; ram[ 466] = 8'hF1; ram[ 467] = 8'h13;
        ram[ 468] = 8'h1C; ram[ 469] = 8'h12; ram[ 470] = 8'h1D; ram[ 471] = 8'h19;
        ram[ 472] = 8'h16; ram[ 473] = 8'h14; ram[ 474] = 8'h1B; ram[ 475] = 8'h1A;
        ram[ 476] = 8'h15; ram[ 477] = 8'h18; ram[ 478] = 8'h17; ram[ 479] = 8'h0F;
        ram[ 480] = 8'h8F; ram[ 481] = 8'hF0; ram[ 482] = 8'hF0; ram[ 483] = 8'hF0;
        ram[ 484] = 8'hF0; ram[ 485] = 8'hF0; ram[ 486] = 8'hF0; ram[ 487] = 8'hF0;
        ram[ 488] = 8'h8F; ram[ 489] = 8'h8F; ram[ 490] = 8'h8F; ram[ 491] = 8'h8F;
        ram[ 492] = 8'h8F; ram[ 493] = 8'h8F; ram[ 494] = 8'h8F; ram[ 495] = 8'h8F;
        ram[ 496] = 8'h8F; ram[ 497] = 8'h8F; ram[ 498] = 8'h8F; ram[ 499] = 8'hF0;
        ram[ 500] = 8'h33; ram[ 501] = 8'h33; ram[ 502] = 8'h30; ram[ 503] = 8'h30;
        ram[ 504] = 8'h3F; ram[ 505] = 8'h3E; ram[ 506] = 8'h31; ram[ 507] = 8'hF3;
        ram[ 508] = 8'h3C; ram[ 509] = 8'h32; ram[ 510] = 8'h3D; ram[ 511] = 8'h39;
        ram[ 512] = 8'h36; ram[ 513] = 8'h34; ram[ 514] = 8'h3B; ram[ 515] = 8'h3A;
        ram[ 516] = 8'h35; ram[ 517] = 8'h38; ram[ 518] = 8'h37; ram[ 519] = 8'h0F;
        ram[ 520] = 8'h8F; ram[ 521] = 8'h8F; ram[ 522] = 8'h8F; ram[ 523] = 8'h8F;
        ram[ 524] = 8'h8F; ram[ 525] = 8'h8F; ram[ 526] = 8'h8F; ram[ 527] = 8'h8F;
        ram[ 528] = 8'h8F; ram[ 529] = 8'h8F; ram[ 530] = 8'h8F; ram[ 531] = 8'h8F;
        ram[ 532] = 8'h8F; ram[ 533] = 8'h8F; ram[ 534] = 8'h8F; ram[ 535] = 8'h8F;
        ram[ 536] = 8'h8F; ram[ 537] = 8'h8F; ram[ 538] = 8'h8F; ram[ 539] = 8'hF0;
        ram[ 540] = 8'hCC; ram[ 541] = 8'hCC; ram[ 542] = 8'hC0; ram[ 543] = 8'hC0;
        ram[ 544] = 8'hCF; ram[ 545] = 8'hCE; ram[ 546] = 8'hC1; ram[ 547] = 8'hC3;
        ram[ 548] = 8'hFC; ram[ 549] = 8'hC2; ram[ 550] = 8'hCD; ram[ 551] = 8'hC9;
        ram[ 552] = 8'hC6; ram[ 553] = 8'hC4; ram[ 554] = 8'hCB; ram[ 555] = 8'hCA;
        ram[ 556] = 8'hC5; ram[ 557] = 8'hC8; ram[ 558] = 8'hC7; ram[ 559] = 8'h0F;
        ram[ 560] = 8'h8F; ram[ 561] = 8'h8F; ram[ 562] = 8'h8F; ram[ 563] = 8'h8F;
        ram[ 564] = 8'h8F; ram[ 565] = 8'h8F; ram[ 566] = 8'h8F; ram[ 567] = 8'h8F;
        ram[ 568] = 8'h8F; ram[ 569] = 8'h8F; ram[ 570] = 8'h8F; ram[ 571] = 8'h8F;
        ram[ 572] = 8'h8F; ram[ 573] = 8'h8F; ram[ 574] = 8'h8F; ram[ 575] = 8'h8F;
        ram[ 576] = 8'h8F; ram[ 577] = 8'h8F; ram[ 578] = 8'h8F; ram[ 579] = 8'hF0;
        ram[ 580] = 8'h22; ram[ 581] = 8'h22; ram[ 582] = 8'h20; ram[ 583] = 8'h20;
        ram[ 584] = 8'h2F; ram[ 585] = 8'h2E; ram[ 586] = 8'h21; ram[ 587] = 8'h23;
        ram[ 588] = 8'h2C; ram[ 589] = 8'hF2; ram[ 590] = 8'h2D; ram[ 591] = 8'h29;
        ram[ 592] = 8'h26; ram[ 593] = 8'h24; ram[ 594] = 8'h2B; ram[ 595] = 8'h2A;
        ram[ 596] = 8'h25; ram[ 597] = 8'h28; ram[ 598] = 8'h27; ram[ 599] = 8'h0F;
        ram[ 600] = 8'h8F; ram[ 601] = 8'h8F; ram[ 602] = 8'h8F; ram[ 603] = 8'h8F;
        ram[ 604] = 8'h8F; ram[ 605] = 8'h8F; ram[ 606] = 8'h8F; ram[ 607] = 8'h8F;
        ram[ 608] = 8'h8F; ram[ 609] = 8'h8F; ram[ 610] = 8'h8F; ram[ 611] = 8'h8F;
        ram[ 612] = 8'h8F; ram[ 613] = 8'h8F; ram[ 614] = 8'h8F; ram[ 615] = 8'h8F;
        ram[ 616] = 8'h8F; ram[ 617] = 8'h8F; ram[ 618] = 8'h8F; ram[ 619] = 8'hF0;
        ram[ 620] = 8'hDD; ram[ 621] = 8'hDD; ram[ 622] = 8'hD0; ram[ 623] = 8'hD0;
        ram[ 624] = 8'hDF; ram[ 625] = 8'hDE; ram[ 626] = 8'hD1; ram[ 627] = 8'hD3;
        ram[ 628] = 8'hDC; ram[ 629] = 8'hD2; ram[ 630] = 8'hFD; ram[ 631] = 8'hD9;
        ram[ 632] = 8'hD6; ram[ 633] = 8'hD4; ram[ 634] = 8'hDB; ram[ 635] = 8'hDA;
        ram[ 636] = 8'hD5; ram[ 637] = 8'hD8; ram[ 638] = 8'hD7; ram[ 639] = 8'h0F;
        ram[ 640] = 8'h8F; ram[ 641] = 8'h8F; ram[ 642] = 8'h8F; ram[ 643] = 8'h8F;
        ram[ 644] = 8'h8F; ram[ 645] = 8'h8F; ram[ 646] = 8'h8F; ram[ 647] = 8'h8F;
        ram[ 648] = 8'h8F; ram[ 649] = 8'h8F; ram[ 650] = 8'h8F; ram[ 651] = 8'h8F;
        ram[ 652] = 8'h8F; ram[ 653] = 8'h8F; ram[ 654] = 8'h8F; ram[ 655] = 8'h8F;
        ram[ 656] = 8'h8F; ram[ 657] = 8'h8F; ram[ 658] = 8'h8F; ram[ 659] = 8'hF0;
        ram[ 660] = 8'h99; ram[ 661] = 8'h99; ram[ 662] = 8'h90; ram[ 663] = 8'h90;
        ram[ 664] = 8'h9F; ram[ 665] = 8'h9E; ram[ 666] = 8'h91; ram[ 667] = 8'h93;
        ram[ 668] = 8'h9C; ram[ 669] = 8'h92; ram[ 670] = 8'h9D; ram[ 671] = 8'hF9;
        ram[ 672] = 8'h96; ram[ 673] = 8'h94; ram[ 674] = 8'h9B; ram[ 675] = 8'h9A;
        ram[ 676] = 8'h95; ram[ 677] = 8'h98; ram[ 678] = 8'h97; ram[ 679] = 8'h0F;
        ram[ 680] = 8'h8F; ram[ 681] = 8'h8F; ram[ 682] = 8'h8F; ram[ 683] = 8'h8F;
        ram[ 684] = 8'h8F; ram[ 685] = 8'h8F; ram[ 686] = 8'h8F; ram[ 687] = 8'h8F;
        ram[ 688] = 8'h8F; ram[ 689] = 8'h8F; ram[ 690] = 8'h8F; ram[ 691] = 8'h8F;
        ram[ 692] = 8'h8F; ram[ 693] = 8'h8F; ram[ 694] = 8'h8F; ram[ 695] = 8'h8F;
        ram[ 696] = 8'h8F; ram[ 697] = 8'h8F; ram[ 698] = 8'h8F; ram[ 699] = 8'hF0;
        ram[ 700] = 8'h66; ram[ 701] = 8'h66; ram[ 702] = 8'h60; ram[ 703] = 8'h60;
        ram[ 704] = 8'h6F; ram[ 705] = 8'h6E; ram[ 706] = 8'h61; ram[ 707] = 8'h63;
        ram[ 708] = 8'h6C; ram[ 709] = 8'h62; ram[ 710] = 8'h6D; ram[ 711] = 8'h69;
        ram[ 712] = 8'hF6; ram[ 713] = 8'h64; ram[ 714] = 8'h6B; ram[ 715] = 8'h6A;
        ram[ 716] = 8'h65; ram[ 717] = 8'h68; ram[ 718] = 8'h67; ram[ 719] = 8'h0F;
        ram[ 720] = 8'h8F; ram[ 721] = 8'h8F; ram[ 722] = 8'h8F; ram[ 723] = 8'h8F;
        ram[ 724] = 8'h8F; ram[ 725] = 8'h8F; ram[ 726] = 8'h8F; ram[ 727] = 8'h8F;
        ram[ 728] = 8'h8F; ram[ 729] = 8'h8F; ram[ 730] = 8'h8F; ram[ 731] = 8'h8F;
        ram[ 732] = 8'h8F; ram[ 733] = 8'h8F; ram[ 734] = 8'h8F; ram[ 735] = 8'h8F;
        ram[ 736] = 8'h8F; ram[ 737] = 8'h8F; ram[ 738] = 8'h8F; ram[ 739] = 8'hF0;
        ram[ 740] = 8'h44; ram[ 741] = 8'h44; ram[ 742] = 8'h40; ram[ 743] = 8'h40;
        ram[ 744] = 8'h4F; ram[ 745] = 8'h4E; ram[ 746] = 8'h41; ram[ 747] = 8'h43;
        ram[ 748] = 8'h4C; ram[ 749] = 8'h42; ram[ 750] = 8'h4D; ram[ 751] = 8'h49;
        ram[ 752] = 8'h46; ram[ 753] = 8'hF4; ram[ 754] = 8'h4B; ram[ 755] = 8'h4A;
        ram[ 756] = 8'h45; ram[ 757] = 8'h48; ram[ 758] = 8'h47; ram[ 759] = 8'h0F;
        ram[ 760] = 8'h8F; ram[ 761] = 8'h8F; ram[ 762] = 8'h8F; ram[ 763] = 8'h8F;
        ram[ 764] = 8'h8F; ram[ 765] = 8'h8F; ram[ 766] = 8'h8F; ram[ 767] = 8'h8F;
        ram[ 768] = 8'h8F; ram[ 769] = 8'h8F; ram[ 770] = 8'h8F; ram[ 771] = 8'h8F;
        ram[ 772] = 8'h8F; ram[ 773] = 8'h8F; ram[ 774] = 8'h8F; ram[ 775] = 8'h8F;
        ram[ 776] = 8'h8F; ram[ 777] = 8'h8F; ram[ 778] = 8'h8F; ram[ 779] = 8'hF0;
        ram[ 780] = 8'hBB; ram[ 781] = 8'hBB; ram[ 782] = 8'hB0; ram[ 783] = 8'hB0;
        ram[ 784] = 8'hBF; ram[ 785] = 8'hBE; ram[ 786] = 8'hB1; ram[ 787] = 8'hB3;
        ram[ 788] = 8'hBC; ram[ 789] = 8'hB2; ram[ 790] = 8'hBD; ram[ 791] = 8'hB9;
        ram[ 792] = 8'hB6; ram[ 793] = 8'hB4; ram[ 794] = 8'hFB; ram[ 795] = 8'hBA;
        ram[ 796] = 8'hB5; ram[ 797] = 8'hB8; ram[ 798] = 8'hB7; ram[ 799] = 8'h0F;
        ram[ 800] = 8'h8F; ram[ 801] = 8'h0F; ram[ 802] = 8'h0F; ram[ 803] = 8'h0F;
        ram[ 804] = 8'h0F; ram[ 805] = 8'h0F; ram[ 806] = 8'h0F; ram[ 807] = 8'h0F;
        ram[ 808] = 8'h0F; ram[ 809] = 8'h0F; ram[ 810] = 8'h0F; ram[ 811] = 8'h0F;
        ram[ 812] = 8'h0F; ram[ 813] = 8'h0F; ram[ 814] = 8'h0F; ram[ 815] = 8'h0F;
        ram[ 816] = 8'h0F; ram[ 817] = 8'h8F; ram[ 818] = 8'h8F; ram[ 819] = 8'hF0;
        ram[ 820] = 8'hAA; ram[ 821] = 8'hAA; ram[ 822] = 8'hA0; ram[ 823] = 8'hA0;
        ram[ 824] = 8'hAF; ram[ 825] = 8'hAE; ram[ 826] = 8'hA1; ram[ 827] = 8'hA3;
        ram[ 828] = 8'hAC; ram[ 829] = 8'hA2; ram[ 830] = 8'hAD; ram[ 831] = 8'hA9;
        ram[ 832] = 8'hA6; ram[ 833] = 8'hA4; ram[ 834] = 8'hAB; ram[ 835] = 8'hFA;
        ram[ 836] = 8'hA5; ram[ 837] = 8'hA8; ram[ 838] = 8'hA7; ram[ 839] = 8'h0F;
        ram[ 840] = 8'hF0; ram[ 841] = 8'h00; ram[ 842] = 8'hF0; ram[ 843] = 8'hF0;
        ram[ 844] = 8'h0F; ram[ 845] = 8'h0F; ram[ 846] = 8'h8F; ram[ 847] = 8'h8F;
        ram[ 848] = 8'h8F; ram[ 849] = 8'hF8; ram[ 850] = 8'hF8; ram[ 851] = 8'h88;
        ram[ 852] = 8'h78; ram[ 853] = 8'h78; ram[ 854] = 8'h87; ram[ 855] = 8'h87;
        ram[ 856] = 8'h77; ram[ 857] = 8'h0F; ram[ 858] = 8'h8F; ram[ 859] = 8'hF0;
        ram[ 860] = 8'h55; ram[ 861] = 8'h55; ram[ 862] = 8'h50; ram[ 863] = 8'h50;
        ram[ 864] = 8'h5F; ram[ 865] = 8'h5E; ram[ 866] = 8'h51; ram[ 867] = 8'h53;
        ram[ 868] = 8'h5C; ram[ 869] = 8'h52; ram[ 870] = 8'h5D; ram[ 871] = 8'h59;
        ram[ 872] = 8'h56; ram[ 873] = 8'h54; ram[ 874] = 8'h5B; ram[ 875] = 8'h5A;
        ram[ 876] = 8'hF5; ram[ 877] = 8'h58; ram[ 878] = 8'h57; ram[ 879] = 8'h0F;
        ram[ 880] = 8'h8F; ram[ 881] = 8'hF0; ram[ 882] = 8'hF0; ram[ 883] = 8'hF0;
        ram[ 884] = 8'hF0; ram[ 885] = 8'hF0; ram[ 886] = 8'hF0; ram[ 887] = 8'hF0;
        ram[ 888] = 8'hF0; ram[ 889] = 8'hF0; ram[ 890] = 8'hF0; ram[ 891] = 8'hF0;
        ram[ 892] = 8'hF0; ram[ 893] = 8'hF0; ram[ 894] = 8'hF0; ram[ 895] = 8'hF0;
        ram[ 896] = 8'hF0; ram[ 897] = 8'h8F; ram[ 898] = 8'h8F; ram[ 899] = 8'hF0;
        ram[ 900] = 8'h88; ram[ 901] = 8'h88; ram[ 902] = 8'h80; ram[ 903] = 8'h80;
        ram[ 904] = 8'h8F; ram[ 905] = 8'h8E; ram[ 906] = 8'h81; ram[ 907] = 8'h83;
        ram[ 908] = 8'h8C; ram[ 909] = 8'h82; ram[ 910] = 8'h8D; ram[ 911] = 8'h89;
        ram[ 912] = 8'h86; ram[ 913] = 8'h84; ram[ 914] = 8'h8B; ram[ 915] = 8'h8A;
        ram[ 916] = 8'h85; ram[ 917] = 8'hF8; ram[ 918] = 8'h87; ram[ 919] = 8'h0F;
        ram[ 920] = 8'h8F; ram[ 921] = 8'h8F; ram[ 922] = 8'h8F; ram[ 923] = 8'h8F;
        ram[ 924] = 8'h8F; ram[ 925] = 8'h8F; ram[ 926] = 8'h8F; ram[ 927] = 8'h8F;
        ram[ 928] = 8'h8F; ram[ 929] = 8'h8F; ram[ 930] = 8'h8F; ram[ 931] = 8'h8F;
        ram[ 932] = 8'h8F; ram[ 933] = 8'h8F; ram[ 934] = 8'h8F; ram[ 935] = 8'h8F;
        ram[ 936] = 8'h8F; ram[ 937] = 8'h8F; ram[ 938] = 8'h8F; ram[ 939] = 8'hF0;
        ram[ 940] = 8'h77; ram[ 941] = 8'h77; ram[ 942] = 8'h70; ram[ 943] = 8'h70;
        ram[ 944] = 8'h7F; ram[ 945] = 8'h7E; ram[ 946] = 8'h71; ram[ 947] = 8'h73;
        ram[ 948] = 8'h7C; ram[ 949] = 8'h72; ram[ 950] = 8'h7D; ram[ 951] = 8'h79;
        ram[ 952] = 8'h76; ram[ 953] = 8'h74; ram[ 954] = 8'h7B; ram[ 955] = 8'h7A;
        ram[ 956] = 8'h75; ram[ 957] = 8'h78; ram[ 958] = 8'hF7; ram[ 959] = 8'h0F;
        ram[ 960] = 8'h8F; ram[ 961] = 8'h8F; ram[ 962] = 8'h8F; ram[ 963] = 8'h8F;
        ram[ 964] = 8'h8F; ram[ 965] = 8'h8F; ram[ 966] = 8'h8F; ram[ 967] = 8'h8F;
        ram[ 968] = 8'h8F; ram[ 969] = 8'h8F; ram[ 970] = 8'h8F; ram[ 971] = 8'h8F;
        ram[ 972] = 8'h8F; ram[ 973] = 8'h8F; ram[ 974] = 8'h8F; ram[ 975] = 8'h8F;
        ram[ 976] = 8'h8F; ram[ 977] = 8'h8F; ram[ 978] = 8'h8F; ram[ 979] = 8'h8F;
        ram[ 980] = 8'hF0; ram[ 981] = 8'hF0; ram[ 982] = 8'hF0; ram[ 983] = 8'hF0;
        ram[ 984] = 8'hF0; ram[ 985] = 8'hF0; ram[ 986] = 8'hF0; ram[ 987] = 8'hF0;
        ram[ 988] = 8'hF0; ram[ 989] = 8'hF0; ram[ 990] = 8'hF0; ram[ 991] = 8'hF0;
        ram[ 992] = 8'hF0; ram[ 993] = 8'hF0; ram[ 994] = 8'hF0; ram[ 995] = 8'hF0;
        ram[ 996] = 8'hF0; ram[ 997] = 8'hF0; ram[ 998] = 8'hF0; ram[ 999] = 8'h8F;
        ram[1000] = 8'h00; ram[1001] = 8'h00; ram[1002] = 8'h00; ram[1003] = 8'h00;
        ram[1004] = 8'h00; ram[1005] = 8'h00; ram[1006] = 8'h00; ram[1007] = 8'h00;
        ram[1008] = 8'h00; ram[1009] = 8'h00; ram[1010] = 8'h00; ram[1011] = 8'h00;
        ram[1012] = 8'h00; ram[1013] = 8'h00; ram[1014] = 8'h00; ram[1015] = 8'h00;
        ram[1016] = 8'h00; ram[1017] = 8'h00; ram[1018] = 8'h00; ram[1019] = 8'h00;
        ram[1020] = 8'h00; ram[1021] = 8'h00; ram[1022] = 8'h00; ram[1023] = 8'h00;
    end
    
    // always @(posedge clk)
    // begin
    //     if (wren1) ram[addr1] = wrdata1;
    //     rddata1 <= ram[addr1];
    // end

    always @(posedge clk)
    begin
        rddata2 <= ram[addr2];
    end

endmodule

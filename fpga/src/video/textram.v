module textram(
    input  wire       clk,

    // input  wire [9:0] addr1,
    // output reg  [7:0] rddata1,
    // input  wire [7:0] wrdata1,
    // input  wire       wren1,

    input  wire [9:0] addr2,
    output reg  [7:0] rddata2);

    reg [7:0] ram [1023:0];

    initial begin
        ram[   0] = 8'h20; ram[   1] = 8'h20; ram[   2] = 8'h20; ram[   3] = 8'h20;
        ram[   4] = 8'h20; ram[   5] = 8'h20; ram[   6] = 8'h20; ram[   7] = 8'h20;
        ram[   8] = 8'h20; ram[   9] = 8'h20; ram[  10] = 8'h20; ram[  11] = 8'h20;
        ram[  12] = 8'h20; ram[  13] = 8'h20; ram[  14] = 8'h20; ram[  15] = 8'h20;
        ram[  16] = 8'h20; ram[  17] = 8'h20; ram[  18] = 8'h20; ram[  19] = 8'h20;
        ram[  20] = 8'h20; ram[  21] = 8'h20; ram[  22] = 8'h20; ram[  23] = 8'h20;
        ram[  24] = 8'h20; ram[  25] = 8'h20; ram[  26] = 8'h20; ram[  27] = 8'h20;
        ram[  28] = 8'h20; ram[  29] = 8'h20; ram[  30] = 8'h20; ram[  31] = 8'h20;
        ram[  32] = 8'h20; ram[  33] = 8'h20; ram[  34] = 8'h20; ram[  35] = 8'h20;
        ram[  36] = 8'h20; ram[  37] = 8'h20; ram[  38] = 8'h20; ram[  39] = 8'h20;
        ram[  40] = 8'h41; ram[  41] = 8'h71; ram[  42] = 8'h75; ram[  43] = 8'h61;
        ram[  44] = 8'h72; ram[  45] = 8'h69; ram[  46] = 8'h75; ram[  47] = 8'h73;
        ram[  48] = 8'h20; ram[  49] = 8'h43; ram[  50] = 8'h6F; ram[  51] = 8'h6C;
        ram[  52] = 8'h6F; ram[  53] = 8'h72; ram[  54] = 8'h20; ram[  55] = 8'h54;
        ram[  56] = 8'h68; ram[  57] = 8'h65; ram[  58] = 8'h6F; ram[  59] = 8'h72;
        ram[  60] = 8'h79; ram[  61] = 8'h20; ram[  62] = 8'h20; ram[  63] = 8'h20;
        ram[  64] = 8'h20; ram[  65] = 8'h20; ram[  66] = 8'h20; ram[  67] = 8'h20;
        ram[  68] = 8'h20; ram[  69] = 8'h20; ram[  70] = 8'h20; ram[  71] = 8'h20;
        ram[  72] = 8'h20; ram[  73] = 8'h20; ram[  74] = 8'h20; ram[  75] = 8'h20;
        ram[  76] = 8'h20; ram[  77] = 8'h20; ram[  78] = 8'h20; ram[  79] = 8'h20;
        ram[  80] = 8'h80; ram[  81] = 8'h80; ram[  82] = 8'h80; ram[  83] = 8'h80;
        ram[  84] = 8'h80; ram[  85] = 8'h80; ram[  86] = 8'h80; ram[  87] = 8'h80;
        ram[  88] = 8'h80; ram[  89] = 8'h80; ram[  90] = 8'h80; ram[  91] = 8'h80;
        ram[  92] = 8'h80; ram[  93] = 8'h80; ram[  94] = 8'h80; ram[  95] = 8'h80;
        ram[  96] = 8'h80; ram[  97] = 8'h80; ram[  98] = 8'h80; ram[  99] = 8'h80;
        ram[ 100] = 8'h80; ram[ 101] = 8'h20; ram[ 102] = 8'h20; ram[ 103] = 8'h20;
        ram[ 104] = 8'h20; ram[ 105] = 8'h20; ram[ 106] = 8'h20; ram[ 107] = 8'h20;
        ram[ 108] = 8'h20; ram[ 109] = 8'h20; ram[ 110] = 8'h20; ram[ 111] = 8'h20;
        ram[ 112] = 8'h20; ram[ 113] = 8'h20; ram[ 114] = 8'h20; ram[ 115] = 8'h20;
        ram[ 116] = 8'h20; ram[ 117] = 8'h20; ram[ 118] = 8'h20; ram[ 119] = 8'h20;
        ram[ 120] = 8'h20; ram[ 121] = 8'h20; ram[ 122] = 8'h20; ram[ 123] = 8'h20;
        ram[ 124] = 8'h20; ram[ 125] = 8'h20; ram[ 126] = 8'h20; ram[ 127] = 8'h20;
        ram[ 128] = 8'h20; ram[ 129] = 8'h20; ram[ 130] = 8'h20; ram[ 131] = 8'h20;
        ram[ 132] = 8'h20; ram[ 133] = 8'h20; ram[ 134] = 8'h20; ram[ 135] = 8'h20;
        ram[ 136] = 8'h20; ram[ 137] = 8'h20; ram[ 138] = 8'h20; ram[ 139] = 8'h20;
        ram[ 140] = 8'h20; ram[ 141] = 8'h20; ram[ 142] = 8'h20; ram[ 143] = 8'h20;
        ram[ 144] = 8'h20; ram[ 145] = 8'h20; ram[ 146] = 8'h42; ram[ 147] = 8'h61;
        ram[ 148] = 8'h63; ram[ 149] = 8'h6B; ram[ 150] = 8'h67; ram[ 151] = 8'h72;
        ram[ 152] = 8'h6F; ram[ 153] = 8'h75; ram[ 154] = 8'h6E; ram[ 155] = 8'h64;
        ram[ 156] = 8'h20; ram[ 157] = 8'h20; ram[ 158] = 8'h20; ram[ 159] = 8'h20;
        ram[ 160] = 8'h20; ram[ 161] = 8'h45; ram[ 162] = 8'h78; ram[ 163] = 8'h61;
        ram[ 164] = 8'h6D; ram[ 165] = 8'h70; ram[ 166] = 8'h6C; ram[ 167] = 8'h65;
        ram[ 168] = 8'h20; ram[ 169] = 8'h6F; ram[ 170] = 8'h66; ram[ 171] = 8'h20;
        ram[ 172] = 8'h63; ram[ 173] = 8'h6F; ram[ 174] = 8'h6C; ram[ 175] = 8'h6F;
        ram[ 176] = 8'h72; ram[ 177] = 8'h20; ram[ 178] = 8'h20; ram[ 179] = 8'h20;
        ram[ 180] = 8'h20; ram[ 181] = 8'h20; ram[ 182] = 8'h20; ram[ 183] = 8'h90;
        ram[ 184] = 8'h90; ram[ 185] = 8'h90; ram[ 186] = 8'h90; ram[ 187] = 8'h90;
        ram[ 188] = 8'h90; ram[ 189] = 8'h90; ram[ 190] = 8'h90; ram[ 191] = 8'h90;
        ram[ 192] = 8'h90; ram[ 193] = 8'h90; ram[ 194] = 8'h90; ram[ 195] = 8'h90;
        ram[ 196] = 8'h90; ram[ 197] = 8'h90; ram[ 198] = 8'h90; ram[ 199] = 8'h20;
        ram[ 200] = 8'h20; ram[ 201] = 8'h6D; ram[ 202] = 8'h69; ram[ 203] = 8'h78;
        ram[ 204] = 8'h69; ram[ 205] = 8'h6E; ram[ 206] = 8'h67; ram[ 207] = 8'h20;
        ram[ 208] = 8'h75; ram[ 209] = 8'h73; ram[ 210] = 8'h69; ram[ 211] = 8'h6E;
        ram[ 212] = 8'h67; ram[ 213] = 8'h20; ram[ 214] = 8'h74; ram[ 215] = 8'h68;
        ram[ 216] = 8'h65; ram[ 217] = 8'h20; ram[ 218] = 8'h20; ram[ 219] = 8'h20;
        ram[ 220] = 8'h20; ram[ 221] = 8'h20; ram[ 222] = 8'h20; ram[ 223] = 8'h86;
        ram[ 224] = 8'h20; ram[ 225] = 8'h86; ram[ 226] = 8'h86; ram[ 227] = 8'h86;
        ram[ 228] = 8'h86; ram[ 229] = 8'h86; ram[ 230] = 8'h86; ram[ 231] = 8'h86;
        ram[ 232] = 8'h86; ram[ 233] = 8'h86; ram[ 234] = 8'h86; ram[ 235] = 8'h86;
        ram[ 236] = 8'h86; ram[ 237] = 8'h86; ram[ 238] = 8'h86; ram[ 239] = 8'h81;
        ram[ 240] = 8'h20; ram[ 241] = 8'h41; ram[ 242] = 8'h71; ram[ 243] = 8'h75;
        ram[ 244] = 8'h61; ram[ 245] = 8'h72; ram[ 246] = 8'h69; ram[ 247] = 8'h75;
        ram[ 248] = 8'h73; ram[ 249] = 8'h20; ram[ 250] = 8'h63; ram[ 251] = 8'h6F;
        ram[ 252] = 8'h6C; ram[ 253] = 8'h6F; ram[ 254] = 8'h72; ram[ 255] = 8'h20;
        ram[ 256] = 8'h20; ram[ 257] = 8'h20; ram[ 258] = 8'h20; ram[ 259] = 8'h20;
        ram[ 260] = 8'h20; ram[ 261] = 8'h20; ram[ 262] = 8'h20; ram[ 263] = 8'h86;
        ram[ 264] = 8'h20; ram[ 265] = 8'h86; ram[ 266] = 8'h86; ram[ 267] = 8'h86;
        ram[ 268] = 8'h86; ram[ 269] = 8'h86; ram[ 270] = 8'h86; ram[ 271] = 8'h86;
        ram[ 272] = 8'h86; ram[ 273] = 8'h86; ram[ 274] = 8'h86; ram[ 275] = 8'h86;
        ram[ 276] = 8'h86; ram[ 277] = 8'h86; ram[ 278] = 8'h86; ram[ 279] = 8'h81;
        ram[ 280] = 8'h20; ram[ 281] = 8'h70; ram[ 282] = 8'h61; ram[ 283] = 8'h6C;
        ram[ 284] = 8'h65; ram[ 285] = 8'h74; ram[ 286] = 8'h74; ram[ 287] = 8'h65;
        ram[ 288] = 8'h20; ram[ 289] = 8'h61; ram[ 290] = 8'h6E; ram[ 291] = 8'h64;
        ram[ 292] = 8'h20; ram[ 293] = 8'h74; ram[ 294] = 8'h68; ram[ 295] = 8'h65;
        ram[ 296] = 8'h20; ram[ 297] = 8'h20; ram[ 298] = 8'h20; ram[ 299] = 8'h20;
        ram[ 300] = 8'h20; ram[ 301] = 8'h20; ram[ 302] = 8'h20; ram[ 303] = 8'h90;
        ram[ 304] = 8'h90; ram[ 305] = 8'h90; ram[ 306] = 8'h90; ram[ 307] = 8'h90;
        ram[ 308] = 8'h90; ram[ 309] = 8'h90; ram[ 310] = 8'h90; ram[ 311] = 8'h90;
        ram[ 312] = 8'h90; ram[ 313] = 8'h90; ram[ 314] = 8'h90; ram[ 315] = 8'h90;
        ram[ 316] = 8'h90; ram[ 317] = 8'h90; ram[ 318] = 8'h90; ram[ 319] = 8'h81;
        ram[ 320] = 8'h20; ram[ 321] = 8'h35; ram[ 322] = 8'h30; ram[ 323] = 8'h25;
        ram[ 324] = 8'h20; ram[ 325] = 8'h68; ram[ 326] = 8'h61; ram[ 327] = 8'h6C;
        ram[ 328] = 8'h66; ram[ 329] = 8'h74; ram[ 330] = 8'h6F; ram[ 331] = 8'h6E;
        ram[ 332] = 8'h65; ram[ 333] = 8'h20; ram[ 334] = 8'h20; ram[ 335] = 8'h20;
        ram[ 336] = 8'h20; ram[ 337] = 8'h20; ram[ 338] = 8'h20; ram[ 339] = 8'h91;
        ram[ 340] = 8'h86; ram[ 341] = 8'h86; ram[ 342] = 8'h91; ram[ 343] = 8'hDA;
        ram[ 344] = 8'h86; ram[ 345] = 8'h86; ram[ 346] = 8'h86; ram[ 347] = 8'h86;
        ram[ 348] = 8'h86; ram[ 349] = 8'h86; ram[ 350] = 8'h86; ram[ 351] = 8'h86;
        ram[ 352] = 8'h86; ram[ 353] = 8'h86; ram[ 354] = 8'h86; ram[ 355] = 8'h86;
        ram[ 356] = 8'h86; ram[ 357] = 8'h86; ram[ 358] = 8'h86; ram[ 359] = 8'h81;
        ram[ 360] = 8'h20; ram[ 361] = 8'h63; ram[ 362] = 8'h68; ram[ 363] = 8'h61;
        ram[ 364] = 8'h72; ram[ 365] = 8'h61; ram[ 366] = 8'h63; ram[ 367] = 8'h74;
        ram[ 368] = 8'h65; ram[ 369] = 8'h72; ram[ 370] = 8'h2E; ram[ 371] = 8'h2E;
        ram[ 372] = 8'h2E; ram[ 373] = 8'h20; ram[ 374] = 8'h20; ram[ 375] = 8'h20;
        ram[ 376] = 8'h20; ram[ 377] = 8'h20; ram[ 378] = 8'h20; ram[ 379] = 8'h91;
        ram[ 380] = 8'h20; ram[ 381] = 8'h20; ram[ 382] = 8'h91; ram[ 383] = 8'h86;
        ram[ 384] = 8'hDA; ram[ 385] = 8'h86; ram[ 386] = 8'h86; ram[ 387] = 8'h86;
        ram[ 388] = 8'h86; ram[ 389] = 8'h86; ram[ 390] = 8'h86; ram[ 391] = 8'h86;
        ram[ 392] = 8'h86; ram[ 393] = 8'h86; ram[ 394] = 8'h86; ram[ 395] = 8'h86;
        ram[ 396] = 8'h86; ram[ 397] = 8'h86; ram[ 398] = 8'h86; ram[ 399] = 8'h81;
        ram[ 400] = 8'h20; ram[ 401] = 8'h90; ram[ 402] = 8'h90; ram[ 403] = 8'h90;
        ram[ 404] = 8'h90; ram[ 405] = 8'h90; ram[ 406] = 8'h90; ram[ 407] = 8'h90;
        ram[ 408] = 8'h20; ram[ 409] = 8'h20; ram[ 410] = 8'h20; ram[ 411] = 8'h20;
        ram[ 412] = 8'h20; ram[ 413] = 8'h20; ram[ 414] = 8'h20; ram[ 415] = 8'h20;
        ram[ 416] = 8'h20; ram[ 417] = 8'h20; ram[ 418] = 8'h20; ram[ 419] = 8'h91;
        ram[ 420] = 8'h86; ram[ 421] = 8'h86; ram[ 422] = 8'h91; ram[ 423] = 8'h86;
        ram[ 424] = 8'h86; ram[ 425] = 8'hDA; ram[ 426] = 8'h86; ram[ 427] = 8'h86;
        ram[ 428] = 8'h86; ram[ 429] = 8'h86; ram[ 430] = 8'h86; ram[ 431] = 8'h86;
        ram[ 432] = 8'h86; ram[ 433] = 8'h86; ram[ 434] = 8'h86; ram[ 435] = 8'h86;
        ram[ 436] = 8'h86; ram[ 437] = 8'h86; ram[ 438] = 8'h86; ram[ 439] = 8'h81;
        ram[ 440] = 8'h91; ram[ 441] = 8'h86; ram[ 442] = 8'h86; ram[ 443] = 8'h20;
        ram[ 444] = 8'h86; ram[ 445] = 8'h86; ram[ 446] = 8'h86; ram[ 447] = 8'h86;
        ram[ 448] = 8'h81; ram[ 449] = 8'h20; ram[ 450] = 8'h20; ram[ 451] = 8'h20;
        ram[ 452] = 8'h20; ram[ 453] = 8'h20; ram[ 454] = 8'h20; ram[ 455] = 8'h20;
        ram[ 456] = 8'h20; ram[ 457] = 8'h20; ram[ 458] = 8'h46; ram[ 459] = 8'h91;
        ram[ 460] = 8'h86; ram[ 461] = 8'h86; ram[ 462] = 8'h91; ram[ 463] = 8'h86;
        ram[ 464] = 8'h86; ram[ 465] = 8'h86; ram[ 466] = 8'hDA; ram[ 467] = 8'h86;
        ram[ 468] = 8'h86; ram[ 469] = 8'h86; ram[ 470] = 8'h86; ram[ 471] = 8'h86;
        ram[ 472] = 8'h86; ram[ 473] = 8'h86; ram[ 474] = 8'h86; ram[ 475] = 8'h86;
        ram[ 476] = 8'h86; ram[ 477] = 8'h86; ram[ 478] = 8'h86; ram[ 479] = 8'h81;
        ram[ 480] = 8'h20; ram[ 481] = 8'h80; ram[ 482] = 8'h80; ram[ 483] = 8'h80;
        ram[ 484] = 8'h80; ram[ 485] = 8'h80; ram[ 486] = 8'h80; ram[ 487] = 8'h80;
        ram[ 488] = 8'h20; ram[ 489] = 8'h20; ram[ 490] = 8'h20; ram[ 491] = 8'h20;
        ram[ 492] = 8'h20; ram[ 493] = 8'h20; ram[ 494] = 8'h20; ram[ 495] = 8'h20;
        ram[ 496] = 8'h20; ram[ 497] = 8'h20; ram[ 498] = 8'h6F; ram[ 499] = 8'h91;
        ram[ 500] = 8'h86; ram[ 501] = 8'h86; ram[ 502] = 8'h91; ram[ 503] = 8'h86;
        ram[ 504] = 8'h86; ram[ 505] = 8'h86; ram[ 506] = 8'h86; ram[ 507] = 8'hDA;
        ram[ 508] = 8'h86; ram[ 509] = 8'h86; ram[ 510] = 8'h86; ram[ 511] = 8'h86;
        ram[ 512] = 8'h86; ram[ 513] = 8'h86; ram[ 514] = 8'h86; ram[ 515] = 8'h86;
        ram[ 516] = 8'h86; ram[ 517] = 8'h86; ram[ 518] = 8'h86; ram[ 519] = 8'h81;
        ram[ 520] = 8'h20; ram[ 521] = 8'h20; ram[ 522] = 8'h20; ram[ 523] = 8'h20;
        ram[ 524] = 8'h20; ram[ 525] = 8'h20; ram[ 526] = 8'h20; ram[ 527] = 8'h20;
        ram[ 528] = 8'h20; ram[ 529] = 8'h20; ram[ 530] = 8'h20; ram[ 531] = 8'h20;
        ram[ 532] = 8'h20; ram[ 533] = 8'h20; ram[ 534] = 8'h20; ram[ 535] = 8'h20;
        ram[ 536] = 8'h20; ram[ 537] = 8'h20; ram[ 538] = 8'h72; ram[ 539] = 8'h91;
        ram[ 540] = 8'h86; ram[ 541] = 8'h86; ram[ 542] = 8'h91; ram[ 543] = 8'h86;
        ram[ 544] = 8'h86; ram[ 545] = 8'h86; ram[ 546] = 8'h86; ram[ 547] = 8'h86;
        ram[ 548] = 8'hDA; ram[ 549] = 8'h86; ram[ 550] = 8'h86; ram[ 551] = 8'h86;
        ram[ 552] = 8'h86; ram[ 553] = 8'h86; ram[ 554] = 8'h86; ram[ 555] = 8'h86;
        ram[ 556] = 8'h86; ram[ 557] = 8'h86; ram[ 558] = 8'h86; ram[ 559] = 8'h81;
        ram[ 560] = 8'h20; ram[ 561] = 8'h53; ram[ 562] = 8'h75; ram[ 563] = 8'h62;
        ram[ 564] = 8'h74; ram[ 565] = 8'h6C; ram[ 566] = 8'h65; ram[ 567] = 8'h20;
        ram[ 568] = 8'h63; ram[ 569] = 8'h6F; ram[ 570] = 8'h6C; ram[ 571] = 8'h6F;
        ram[ 572] = 8'h72; ram[ 573] = 8'h20; ram[ 574] = 8'h20; ram[ 575] = 8'h20;
        ram[ 576] = 8'h20; ram[ 577] = 8'h20; ram[ 578] = 8'h65; ram[ 579] = 8'h91;
        ram[ 580] = 8'h86; ram[ 581] = 8'h86; ram[ 582] = 8'h91; ram[ 583] = 8'h86;
        ram[ 584] = 8'h86; ram[ 585] = 8'h86; ram[ 586] = 8'h86; ram[ 587] = 8'h86;
        ram[ 588] = 8'h86; ram[ 589] = 8'hDA; ram[ 590] = 8'h86; ram[ 591] = 8'h86;
        ram[ 592] = 8'h86; ram[ 593] = 8'h86; ram[ 594] = 8'h86; ram[ 595] = 8'h86;
        ram[ 596] = 8'h86; ram[ 597] = 8'h86; ram[ 598] = 8'h86; ram[ 599] = 8'h81;
        ram[ 600] = 8'h20; ram[ 601] = 8'h76; ram[ 602] = 8'h61; ram[ 603] = 8'h72;
        ram[ 604] = 8'h69; ram[ 605] = 8'h61; ram[ 606] = 8'h6E; ram[ 607] = 8'h63;
        ram[ 608] = 8'h65; ram[ 609] = 8'h73; ram[ 610] = 8'h20; ram[ 611] = 8'h63;
        ram[ 612] = 8'h61; ram[ 613] = 8'h6E; ram[ 614] = 8'h20; ram[ 615] = 8'h20;
        ram[ 616] = 8'h20; ram[ 617] = 8'h20; ram[ 618] = 8'h67; ram[ 619] = 8'h91;
        ram[ 620] = 8'h86; ram[ 621] = 8'h86; ram[ 622] = 8'h91; ram[ 623] = 8'h86;
        ram[ 624] = 8'h86; ram[ 625] = 8'h86; ram[ 626] = 8'h86; ram[ 627] = 8'h86;
        ram[ 628] = 8'h86; ram[ 629] = 8'h86; ram[ 630] = 8'hDA; ram[ 631] = 8'h86;
        ram[ 632] = 8'h86; ram[ 633] = 8'h86; ram[ 634] = 8'h86; ram[ 635] = 8'h86;
        ram[ 636] = 8'h86; ram[ 637] = 8'h86; ram[ 638] = 8'h86; ram[ 639] = 8'h81;
        ram[ 640] = 8'h20; ram[ 641] = 8'h62; ram[ 642] = 8'h65; ram[ 643] = 8'h20;
        ram[ 644] = 8'h61; ram[ 645] = 8'h63; ram[ 646] = 8'h68; ram[ 647] = 8'h69;
        ram[ 648] = 8'h65; ram[ 649] = 8'h76; ram[ 650] = 8'h65; ram[ 651] = 8'h64;
        ram[ 652] = 8'h20; ram[ 653] = 8'h20; ram[ 654] = 8'h20; ram[ 655] = 8'h20;
        ram[ 656] = 8'h20; ram[ 657] = 8'h20; ram[ 658] = 8'h72; ram[ 659] = 8'h91;
        ram[ 660] = 8'h86; ram[ 661] = 8'h86; ram[ 662] = 8'h91; ram[ 663] = 8'h86;
        ram[ 664] = 8'h86; ram[ 665] = 8'h86; ram[ 666] = 8'h86; ram[ 667] = 8'h86;
        ram[ 668] = 8'h86; ram[ 669] = 8'h86; ram[ 670] = 8'h86; ram[ 671] = 8'hDA;
        ram[ 672] = 8'h86; ram[ 673] = 8'h86; ram[ 674] = 8'h86; ram[ 675] = 8'h86;
        ram[ 676] = 8'h86; ram[ 677] = 8'h86; ram[ 678] = 8'h86; ram[ 679] = 8'h81;
        ram[ 680] = 8'h20; ram[ 681] = 8'h75; ram[ 682] = 8'h73; ram[ 683] = 8'h69;
        ram[ 684] = 8'h6E; ram[ 685] = 8'h67; ram[ 686] = 8'h20; ram[ 687] = 8'h74;
        ram[ 688] = 8'h68; ram[ 689] = 8'h65; ram[ 690] = 8'h20; ram[ 691] = 8'h20;
        ram[ 692] = 8'h20; ram[ 693] = 8'h20; ram[ 694] = 8'h20; ram[ 695] = 8'h20;
        ram[ 696] = 8'h20; ram[ 697] = 8'h20; ram[ 698] = 8'h6F; ram[ 699] = 8'h91;
        ram[ 700] = 8'h86; ram[ 701] = 8'h86; ram[ 702] = 8'h91; ram[ 703] = 8'h86;
        ram[ 704] = 8'h86; ram[ 705] = 8'h86; ram[ 706] = 8'h86; ram[ 707] = 8'h86;
        ram[ 708] = 8'h86; ram[ 709] = 8'h86; ram[ 710] = 8'h86; ram[ 711] = 8'h86;
        ram[ 712] = 8'hDA; ram[ 713] = 8'h86; ram[ 714] = 8'h86; ram[ 715] = 8'h86;
        ram[ 716] = 8'h86; ram[ 717] = 8'h86; ram[ 718] = 8'h86; ram[ 719] = 8'h81;
        ram[ 720] = 8'h20; ram[ 721] = 8'h73; ram[ 722] = 8'h74; ram[ 723] = 8'h6F;
        ram[ 724] = 8'h63; ram[ 725] = 8'h68; ram[ 726] = 8'h61; ram[ 727] = 8'h73;
        ram[ 728] = 8'h74; ram[ 729] = 8'h69; ram[ 730] = 8'h63; ram[ 731] = 8'h20;
        ram[ 732] = 8'h20; ram[ 733] = 8'h20; ram[ 734] = 8'h20; ram[ 735] = 8'h20;
        ram[ 736] = 8'h20; ram[ 737] = 8'h20; ram[ 738] = 8'h75; ram[ 739] = 8'h91;
        ram[ 740] = 8'h86; ram[ 741] = 8'h86; ram[ 742] = 8'h91; ram[ 743] = 8'h86;
        ram[ 744] = 8'h86; ram[ 745] = 8'h86; ram[ 746] = 8'h86; ram[ 747] = 8'h86;
        ram[ 748] = 8'h86; ram[ 749] = 8'h86; ram[ 750] = 8'h86; ram[ 751] = 8'h86;
        ram[ 752] = 8'h86; ram[ 753] = 8'hDA; ram[ 754] = 8'h86; ram[ 755] = 8'h86;
        ram[ 756] = 8'h86; ram[ 757] = 8'h86; ram[ 758] = 8'h86; ram[ 759] = 8'h81;
        ram[ 760] = 8'h20; ram[ 761] = 8'h63; ram[ 762] = 8'h68; ram[ 763] = 8'h61;
        ram[ 764] = 8'h72; ram[ 765] = 8'h61; ram[ 766] = 8'h63; ram[ 767] = 8'h74;
        ram[ 768] = 8'h65; ram[ 769] = 8'h72; ram[ 770] = 8'h73; ram[ 771] = 8'h2E;
        ram[ 772] = 8'h2E; ram[ 773] = 8'h2E; ram[ 774] = 8'h20; ram[ 775] = 8'h20;
        ram[ 776] = 8'h20; ram[ 777] = 8'h20; ram[ 778] = 8'h6E; ram[ 779] = 8'h91;
        ram[ 780] = 8'h86; ram[ 781] = 8'h86; ram[ 782] = 8'h91; ram[ 783] = 8'h86;
        ram[ 784] = 8'h86; ram[ 785] = 8'h86; ram[ 786] = 8'h86; ram[ 787] = 8'h86;
        ram[ 788] = 8'h86; ram[ 789] = 8'h86; ram[ 790] = 8'h86; ram[ 791] = 8'h86;
        ram[ 792] = 8'h86; ram[ 793] = 8'h86; ram[ 794] = 8'hDA; ram[ 795] = 8'h86;
        ram[ 796] = 8'h86; ram[ 797] = 8'h86; ram[ 798] = 8'h86; ram[ 799] = 8'h81;
        ram[ 800] = 8'h20; ram[ 801] = 8'h90; ram[ 802] = 8'h90; ram[ 803] = 8'h90;
        ram[ 804] = 8'h90; ram[ 805] = 8'h90; ram[ 806] = 8'h90; ram[ 807] = 8'h90;
        ram[ 808] = 8'h90; ram[ 809] = 8'h90; ram[ 810] = 8'h90; ram[ 811] = 8'h90;
        ram[ 812] = 8'h90; ram[ 813] = 8'h90; ram[ 814] = 8'h90; ram[ 815] = 8'h90;
        ram[ 816] = 8'h90; ram[ 817] = 8'h20; ram[ 818] = 8'h64; ram[ 819] = 8'h91;
        ram[ 820] = 8'h86; ram[ 821] = 8'h86; ram[ 822] = 8'h91; ram[ 823] = 8'h86;
        ram[ 824] = 8'h86; ram[ 825] = 8'h86; ram[ 826] = 8'h86; ram[ 827] = 8'h86;
        ram[ 828] = 8'h86; ram[ 829] = 8'h86; ram[ 830] = 8'h86; ram[ 831] = 8'h86;
        ram[ 832] = 8'h86; ram[ 833] = 8'h86; ram[ 834] = 8'h86; ram[ 835] = 8'hDA;
        ram[ 836] = 8'h86; ram[ 837] = 8'h86; ram[ 838] = 8'h86; ram[ 839] = 8'h81;
        ram[ 840] = 8'h91; ram[ 841] = 8'hD0; ram[ 842] = 8'hD0; ram[ 843] = 8'hD1;
        ram[ 844] = 8'hD1; ram[ 845] = 8'hD0; ram[ 846] = 8'h20; ram[ 847] = 8'hD0;
        ram[ 848] = 8'hD1; ram[ 849] = 8'hD1; ram[ 850] = 8'hD0; ram[ 851] = 8'h20;
        ram[ 852] = 8'hD0; ram[ 853] = 8'hD1; ram[ 854] = 8'hD1; ram[ 855] = 8'hD0;
        ram[ 856] = 8'h20; ram[ 857] = 8'h81; ram[ 858] = 8'h20; ram[ 859] = 8'h91;
        ram[ 860] = 8'h86; ram[ 861] = 8'h86; ram[ 862] = 8'h91; ram[ 863] = 8'h86;
        ram[ 864] = 8'h86; ram[ 865] = 8'h86; ram[ 866] = 8'h86; ram[ 867] = 8'h86;
        ram[ 868] = 8'h86; ram[ 869] = 8'h86; ram[ 870] = 8'h86; ram[ 871] = 8'h86;
        ram[ 872] = 8'h86; ram[ 873] = 8'h86; ram[ 874] = 8'h86; ram[ 875] = 8'h86;
        ram[ 876] = 8'hDA; ram[ 877] = 8'h86; ram[ 878] = 8'h86; ram[ 879] = 8'h81;
        ram[ 880] = 8'h20; ram[ 881] = 8'h80; ram[ 882] = 8'h80; ram[ 883] = 8'h80;
        ram[ 884] = 8'h80; ram[ 885] = 8'h80; ram[ 886] = 8'h80; ram[ 887] = 8'h80;
        ram[ 888] = 8'h80; ram[ 889] = 8'h80; ram[ 890] = 8'h80; ram[ 891] = 8'h80;
        ram[ 892] = 8'h80; ram[ 893] = 8'h80; ram[ 894] = 8'h80; ram[ 895] = 8'h80;
        ram[ 896] = 8'h80; ram[ 897] = 8'h20; ram[ 898] = 8'h20; ram[ 899] = 8'h91;
        ram[ 900] = 8'h86; ram[ 901] = 8'h86; ram[ 902] = 8'h91; ram[ 903] = 8'h86;
        ram[ 904] = 8'h86; ram[ 905] = 8'h86; ram[ 906] = 8'h86; ram[ 907] = 8'h86;
        ram[ 908] = 8'h86; ram[ 909] = 8'h86; ram[ 910] = 8'h86; ram[ 911] = 8'h86;
        ram[ 912] = 8'h86; ram[ 913] = 8'h86; ram[ 914] = 8'h86; ram[ 915] = 8'h86;
        ram[ 916] = 8'h86; ram[ 917] = 8'hDA; ram[ 918] = 8'h86; ram[ 919] = 8'h81;
        ram[ 920] = 8'h20; ram[ 921] = 8'h20; ram[ 922] = 8'h20; ram[ 923] = 8'h20;
        ram[ 924] = 8'h20; ram[ 925] = 8'h20; ram[ 926] = 8'h20; ram[ 927] = 8'h20;
        ram[ 928] = 8'h20; ram[ 929] = 8'h20; ram[ 930] = 8'h20; ram[ 931] = 8'h20;
        ram[ 932] = 8'h20; ram[ 933] = 8'h20; ram[ 934] = 8'h20; ram[ 935] = 8'h20;
        ram[ 936] = 8'h20; ram[ 937] = 8'h20; ram[ 938] = 8'h20; ram[ 939] = 8'h91;
        ram[ 940] = 8'h86; ram[ 941] = 8'h86; ram[ 942] = 8'h91; ram[ 943] = 8'h86;
        ram[ 944] = 8'h86; ram[ 945] = 8'h86; ram[ 946] = 8'h86; ram[ 947] = 8'h86;
        ram[ 948] = 8'h86; ram[ 949] = 8'h86; ram[ 950] = 8'h86; ram[ 951] = 8'h86;
        ram[ 952] = 8'h86; ram[ 953] = 8'h86; ram[ 954] = 8'h86; ram[ 955] = 8'h86;
        ram[ 956] = 8'h86; ram[ 957] = 8'h86; ram[ 958] = 8'hDA; ram[ 959] = 8'h81;
        ram[ 960] = 8'h20; ram[ 961] = 8'h20; ram[ 962] = 8'h20; ram[ 963] = 8'h20;
        ram[ 964] = 8'h20; ram[ 965] = 8'h20; ram[ 966] = 8'h20; ram[ 967] = 8'h20;
        ram[ 968] = 8'h20; ram[ 969] = 8'h20; ram[ 970] = 8'h20; ram[ 971] = 8'h20;
        ram[ 972] = 8'h20; ram[ 973] = 8'h20; ram[ 974] = 8'h20; ram[ 975] = 8'h20;
        ram[ 976] = 8'h20; ram[ 977] = 8'h20; ram[ 978] = 8'h20; ram[ 979] = 8'h20;
        ram[ 980] = 8'h80; ram[ 981] = 8'h80; ram[ 982] = 8'h80; ram[ 983] = 8'h80;
        ram[ 984] = 8'h80; ram[ 985] = 8'h80; ram[ 986] = 8'h80; ram[ 987] = 8'h80;
        ram[ 988] = 8'h80; ram[ 989] = 8'h80; ram[ 990] = 8'h80; ram[ 991] = 8'h80;
        ram[ 992] = 8'h80; ram[ 993] = 8'h80; ram[ 994] = 8'h80; ram[ 995] = 8'h80;
        ram[ 996] = 8'h80; ram[ 997] = 8'h80; ram[ 998] = 8'h80; ram[ 999] = 8'h20;
        ram[1000] = 8'h20; ram[1001] = 8'h20; ram[1002] = 8'h20; ram[1003] = 8'h20;
        ram[1004] = 8'h20; ram[1005] = 8'h20; ram[1006] = 8'h20; ram[1007] = 8'h20;
        ram[1008] = 8'h20; ram[1009] = 8'h20; ram[1010] = 8'h20; ram[1011] = 8'h20;
        ram[1012] = 8'h20; ram[1013] = 8'h20; ram[1014] = 8'h20; ram[1015] = 8'h20;
        ram[1016] = 8'h20; ram[1017] = 8'h20; ram[1018] = 8'h20; ram[1019] = 8'h20;
        ram[1020] = 8'h20; ram[1021] = 8'h20; ram[1022] = 8'h20; ram[1023] = 8'h20;
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

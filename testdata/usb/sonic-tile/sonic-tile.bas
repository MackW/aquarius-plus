������������ SONIC-������������ 9�� AqPlus Tile Scroll Demo A9�� Set starting tile positions M9�X�0:Y�0 q9� Set Tilemap HScroll Registers �9M�225:N�226 �9� Get BANK3 Page and save to A �9$A��(243) �9.� Set BANK3 to Page 20 VRAM �98� 243,20 :B� Load tile data into $C000/-16384 :L� "sonic.til",�16384 H:V� Load palette data into $BFE0/-16416 a:`� "sonic.pal",�16416 x:j� Set palette loop �:t� I�0�31 �:~� Update VPALSEL �:�� 234,I �:�� Update VPALDATA �:�� 235,�(�16416�I) �:�� �:�� Set VCTRL to 64x32 tilemap mode 
;�� 224,2 ;�� Scroll tileset 4;�X�X�1:�X�511�X�0 R;�Q�X�255:R�X�256:�M,Q:�N,R x;�� Uncomment next 2 lines for diag �;�� Y=Y+1:IFY>255THENY=0 �;�� OUT227,Y �; � ��"" � 1220 �;
� Set VCTRL to text mode �;� 224,1 �;� Set BANK3 to original state <(� 243,A  <2�"reset-pal.bas"   
local HOLO_NIGHT_HEADER = [[
     ,O#=>              <=#O.      
   ,WKK@>                <@KKW.    
 ,WWK7`                    `VKWW.  
,UWK7                        VKWQ  
 WKKY                          EKKD 
 WKKE       ホローナイト       EKKW 
 VKKW.                        ,WKKV 
  VKKW.    ______________    ,WKKV  
   `VKKWWWWWWWWWWWWWWWWWWWWWWKKV   
 私  VKKKKKKKWWWWWWWWWWKKKKKKKV  私 
 は   WKKKKKKKKKKKKKKKKKKKKKKW   は 
 確   WKKKKKKKKKKKKKKKKKKKKKKW   確 
 信   WKKKKKKKKKKKKKKKKKKKKKKW   信 
 し   VWKF"""*TKKKKKKF"""*TKW7   し 
 て   IW7      VKKKK7      VWI   て 
 い   IWI      IKKKKI      IWI   い 
 る   `VM.    ,@KKKKM.    ,@7    る 
 か    `VWKKKKKKKKKKKKKkKWV7     か 
   ら      `VKKKKKKKKKKKKKKV`      ら 
]]

return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      enabled = true,
      preset = {
        header = HOLO_NIGHT_HEADER,
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup" },
        },
      },
    },
    picker = {
      enabled = true,
    },
    explorer = {
      enabled = true,
    },
  },
}

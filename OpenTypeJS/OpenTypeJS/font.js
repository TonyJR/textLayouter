var TOFont = {
    fontList : {},
    init : function(fontList,callback){
        this.loadFonts(this,fontList,0,function(error){
                       callback(error);
                       });
    },
    loadFonts : function(toFont,fontList,index,callback){
        if (index < fontList.length){
            var path = fontList[index];
            opentype.load(path,function(error,font){
                if (error){
                    callback(error);
                }else{
                    toFont.fontList[path] = font;
                    toFont.loadFonts(toFont,fontList,index+1,callback);
                }
            });

        }else{
            callback(null);
        }
    },
    readGlyph : function(char){
        for (var item in this.fontList){
            var glyph = item.charToGlyph(char)
            if (glyph.unicode != undefine){
                return glyph;
            }
        }
        return null;
    }
};
var TOParagraph = {
    
};

var TOLine = {
}

function TOFont (fontList,callback) {
    this.fontList = {};
    
    this.loadFonts = function(toFont,fontList,index,callback){
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
    };
    this.readGlyph = function(char){
        for (var item in this.fontList){
            var glyph = this.fontList[item].charToGlyph(char)
            if (glyph.unicode != undefined){
                return glyph;
            }
        }
        return null;
    };
    
    
    this.loadFonts(this,fontList,0,function(error){
                   callback(error);
                   });
    
};
function TOParagraph (str,font,width,fontSize = 14) {
    this.str = str;
    this.font = font;
    this.width = width;
    this.fontSize = fontSize;
    
    this.readLines = function (width){
        var strArr = Array.from(this.str);
        var lines = [];
        var linePaths = [];
        var lineWidth = 0;
        var lineStr = "";
        
        for (i=0;i<strArr.length;i++){
            tempStr = strArr[i];
            glyph = this.font.readGlyph(tempStr);
            
            if (!glyph){
                continue;
            }
            path = glyph.getPath(0, 0, this.fontSize);
            box = path.getBoundingBox();
            if (lineWidth + box.x2 < width){
                lineWidth += box.x2;
                linePaths.push(path);
                lineStr += tempStr;
            }else{
                lines.push(new TOLine(linePaths,lineStr));
                linePaths = [];
                lineWidth = 0;
                lineStr = "";
            }
        }
        if (lineStr.length > 0){
            lines.push(new TOLine(linePaths,lineStr));
        }
        
        return lines;
    }
    this.lines = this.readLines(this.width);
    
    this.getSize = function (){
        var height = 0;
        for (var key in this.lines){
            var line = this.lines[key];
            height += line.getSize().height;
        }
        return {"width":this.width,"height":height};

    }
    
};

function TOLine (paths,str) {
    this.lineStr = str;
    this.paths = paths;
    this.getSize = function (){
        var width = 0,height = 0;
        for (var key in this.paths){
            var path = this.paths[key];
            box = path.getBoundingBox();
            if (box.y2 > height){
                height = box.y2;
            }
            width += box.x2;
        }
        return {"width":width,"height":height};
    }
}

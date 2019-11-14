//
//  AppDelegate.m
//  EmojiFont
//
//  Created by Tony on 19/11/13.
//  Copyright © 2019年 Tony. All rights reserved.
//

#import "AppDelegate.h"
#import "EmojiFont.h"

#define kPageWidth 2000
#define kPageHeight 2000

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    NSMutableString *jsonStr = [NSMutableString string];
    
    NSArray<NSString *> *arr = [EmojiFont allEmojiChar];
    NSDictionary *dic = @{NSFontAttributeName: [NSFont systemFontOfSize:50]};
    
    NSImage *image = [[NSImage alloc] initWithSize:NSMakeSize(kPageWidth, kPageHeight)];
    
    [image lockFocus];
    NSPoint point = NSMakePoint(0, 0);
    float lineHeight = 0;
    for (NSString *c in arr) {
        NSSize size = [c sizeWithAttributes:dic];
        size.width = ceil(size.width);
        size.height = ceil(size.height);

        if (point.x + size.width > kPageWidth) {
            point.y += lineHeight;
            lineHeight = 0;
            point.x = 0;
        }
        if (lineHeight < size.height) {
            lineHeight = size.height;
        }
        //坐标系转换，y轴翻转
        NSPoint imgPoint = NSMakePoint(point.x, kPageHeight - point.y - size.height);
        [c drawAtPoint:imgPoint withAttributes:dic];
//        NSLog(@"%f,%f",point.x,point.y);
        if (jsonStr.length > 0){
            [jsonStr appendString:@","];
        }
        [jsonStr appendFormat:@"'%@':{x:%0.0f,y:%0.0f,w:%0.0f,h:%0.0f}",c,point.x * 2 ,point.y * 2,size.width * 2 ,size.height * 2];
        point.x += size.width;
    }
    [jsonStr insertString:@"var TOEmojiLib = {" atIndex:0];
    [jsonStr appendString:@"}"];


    NSError *error;
    [jsonStr writeToFile:[@"~/Documents/emoji_lib.js" stringByExpandingTildeInPath] atomically:YES encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        NSLog(@"导出失败:%@",error);
    }else{
        NSLog(@"导出成功");
    }
    
    [image unlockFocus];
    [image lockFocus];
    NSBitmapImageRep *bits = [[NSBitmapImageRep alloc] initWithFocusedViewRect:NSMakeRect(0, 0, image.size.width, image.size.height)];
    [image unlockFocus];

    //再设置后面要用到得 props属性
    NSDictionary *imageProps = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:0] forKey:NSImageCompressionFactor];
    
    
    //之后 转化为NSData 以便存到文件中
    NSData *imageData = [bits representationUsingType:NSPNGFileType properties:imageProps];
    
    //设定好文件路径后进行存储就ok了
    BOOL y = [imageData writeToFile:[@"~/Documents/emoji.png" stringByExpandingTildeInPath]atomically:YES];    //保存的文件路径一定要是绝对路径，相对路径不行
    NSLog(@"Save Image: %d", y);
}
    
- (void)formatStr{
    NSMutableString *str = [NSMutableString string];
    NSString *source = @"♻🏧🚮🚰♿🚹🚺🚻🚼🚾⚠🚸⛔🚫🚳🚭🚯🚱🚷🔞💈\
    🙈🙉🙊🐵🐒🐶🐕🐩🐺🐱😺😸😹😻😼😽🙀😿😾🐈🐯🐅🐆🐴🐎🐮🐂🐃🐄🐷🐖🐗🐽🐏🐑🐐🐪🐫🐘🐭🐁🐀🐹🐰🐇🐻🐨🐼🐾🐔🐓🐣🐤🐥🐦🐧🐸🐊🐢🐍🐲🐉🐳🐋🐬🐟🐠🐡🐙🐚🐌🐛🐜🐝🐞🦋\
    💐🌸💮🌹🌺🌻🌼🌷🌱🌲🌳🌴🌵🌾🌿🍀🍁🍂🍃\
    🌍🌎🌏🌐🌑🌒🌓🌔🌕🌖🌗🌘🌙🌚🌛🌜☀🌝🌞⭐🌟🌠☁⛅☔⚡❄🔥💧🌊\
    🍇🍈🍉🍊🍋🍌🍍🍎🍏🍐🍑🍒🍓🍅🍆🌽🍄🌰🍞🍖🍗🍔🍟🍕🍳🍲🍱🍘🍙🍚🍛🍜🍝🍠🍢🍣🍤🍥🍡🍦🍧🍨🍩🍪🎂🍰🍫🍬🍭🍮🍯🍼☕🍵🍶🍷🍸🍹🍺🍻🍴\
    🎪🎭🎨🎰🚣🛀🎫🏆⚽⚾🏀🏈🏉🎾🎱🎳⛳🎣🎽🎿🏂🏄🏇🏊🚴🚵🎯🎮🎲🎷🎸🎺🎻🎬\
    😈👿👹👺💀☠👻👽👾💣\
    🌋🗻🏠🏡🏢🏣🏤🏥🏦🏨🏩🏪🏫🏬🏭🏯🏰💒🗼🗽⛪⛲🌁🌃🌆🌇🌉🌌🎠🎡🎢🚂🚃🚄🚅🚆🚇🚈🚉🚊🚝🚞🚋🚌🚍🚎🚏🚐🚑🚒🚓🚔🚕🚖🚗🚘🚚🚛🚜🚲⛽🚨🚥🚦🚧⚓⛵🚤🚢✈💺🚁🚟🚠🚡🚀🎑🗿🛂🛃🛄🛅\
    💌💎🔪💈🚪🚽🚿🛁⌛⏳⌚⏰🎈🎉🎊🎎🎏🎐🎀🎁📯📻📱📲☎📞📟📠🔋🔌💻💽💾💿📀🎥📺📷📹📼🔍🔎🔬🔭📡💡🔦🏮📔📕📖📗📘📙📚📓📃📜📄📰📑🔖💰💴💵💶💷💸💳✉📧📨📩📤📥📦📫📪📬📭📮✏✒📝📁📂📅📆📇📈📉📊📋📌📍📎📏📐✂🔒🔓🔏🔐🔑🔨🔫🔧🔩🔗💉💊🚬🔮🚩🎌💦💨\
    ♠♥♦♣🀄🎴🔇🔈🔉🔊📢📣💤💢💬💭♨🌀🔔🔕✡✝🔯📛🔰🔱⭕✅☑✔✖❌❎➕➖➗➰➿〽✳✴❇‼⁉❓❔❕❗©®™🎦🔅🔆💯🔠🔡🔢🔣🔤🅰🆎🅱🆑🆒🆓ℹ🆔Ⓜ🆕🆖🅾🆗🅿🆘🆙🆚🈁🈂🈷🈶🈯🉐🈹🈚🈲🉑🈸🈴🈳㊗㊙🈺🈵▪▫◻◼◽◾⬛⬜🔶🔷🔸🔹🔺🔻💠🔲🔳⚪⚫🔴🔵\
    🐁🐂🐅🐇🐉🐍🐎🐐🐒🐓🐕🐖\
    ♈♉♊♋♌♍♎♏♐♑♒♓⛎\
    🕛🕧🕐🕜🕑🕝🕒🕞🕓🕟🕔🕠🕕🕡🕖🕢🕗🕣🕘🕤🕙🕥🕚🕦⌛⏳⌚⏰⏱⏲🕰\
    💘❤💓💔💕💖💗💙💚💛💜💝💞💟❣\
    💐🌸💮🌹🌺🌻🌼🌷🌱🌿🍀\
    🌿🍀🍁🍂🍃\
    🌑🌒🌓🌔🌕🌖🌗🌘🌙🌚🌛🌜🌝\
    🍇🍈🍉🍊🍋🍌🍍🍎🍏🍐🍑🍒🍓\
    💴💵💶💷💰💸💳\
    🚂🚃🚄🚅🚆🚇🚈🚉🚊🚝🚞🚋🚌🚍🚎🚏🚐🚑🚒🚓🚔🚕🚖🚗🚘🚚🚛🚜🚲⛽🚨🚥🚦🚧⚓⛵🚣🚤🚢✈💺🚁🚟🚠🚡🚀\
    🏠🏡🏢🏣🏤🏥🏦🏨🏩🏪🏫🏬🏭🏯🏰💒🗼🗽⛪🌆🌇🌉\
    📱📲☎📞📟📠🔋🔌💻💽💾💿📀🎥📺📷📹📼🔍🔎🔬🔭📡📔📕📖📗📘📙📚📓📃📜📄📰📑🔖💳✉📧📨📩📤📥📦📫📪📬📭📮✏✒📝📁📂📅📆📇📈📉📊📋📌📍📎📏📐✂🔒🔓🔏🔐🔑\
    ⬆↗➡↘⬇↙⬅↖↕↔↩↪⤴⤵🔃🔄🔙🔚🔛🔜🔝";
    
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData *data = [source dataUsingEncoding:enc];
    
    for (int i=0; i<data.length; i+=4) {
        NSData *tmp = [data subdataWithRange:NSMakeRange(i, 4)];
        NSString *tmpStr = [[NSString alloc] initWithData:tmp encoding:enc];
        if ([tmpStr isEqualToString:@"    "]) {
            [str appendFormat:@"\n"];
            
        }else{
            [str appendFormat:@"@\"%@\",",tmpStr];
        }
    }
    NSLog(@"%@",str);
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end

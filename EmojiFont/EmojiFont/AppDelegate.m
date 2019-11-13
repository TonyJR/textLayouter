//
//  AppDelegate.m
//  EmojiFont
//
//  Created by Tony on 19/11/13.
//  Copyright © 2019年 Tony. All rights reserved.
//

#import "AppDelegate.h"
#import "EmojiFont.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    NSArray<NSString *> *arr = [EmojiFont allEmojiChar];
    NSDictionary *dic = @{NSFontAttributeName: [NSFont systemFontOfSize:100]};
    
    NSImage *image = [[NSImage alloc] initWithSize:NSMakeSize(5000, 5000)];
    [image lockFocus];
    NSPoint point = NSMakePoint(0, 0);
    float lineHeight = 0;
    for (NSString *c in arr) {
        NSSize size = [c sizeWithAttributes:dic];
        size.width = ceil(size.width);
        size.height = ceil(size.height);

        if (point.x + size.width > 5000) {
            point.y += lineHeight;
            lineHeight = 0;
            point.x = 0;
        }
        if (lineHeight < size.height) {
            lineHeight = size.height;
        }
        [c drawAtPoint:point withAttributes:dic];
        NSLog(@"%f,%f",point.x,point.y);
        point.x += size.width;
    }
    [image unlockFocus];
    [image lockFocus];
    NSBitmapImageRep *bits = [[NSBitmapImageRep alloc] initWithFocusedViewRect:NSMakeRect(0, 0, 5000, 5000)];
    [image unlockFocus];

    //再设置后面要用到得 props属性
    NSDictionary *imageProps = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:0] forKey:NSImageCompressionFactor];
    
    
    //之后 转化为NSData 以便存到文件中
    NSData *imageData = [bits representationUsingType:NSPNGFileType properties:imageProps];
    
    //设定好文件路径后进行存储就ok了
    BOOL y = [imageData writeToFile:[[NSString stringWithString:@"~/Documents/test1.png"] stringByExpandingTildeInPath]atomically:YES];    //保存的文件路径一定要是绝对路径，相对路径不行
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

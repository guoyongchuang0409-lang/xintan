import '../../domain/models/quiz_type.dart';
import '../../domain/models/quiz_category.dart';
import '../../domain/models/quiz_item.dart';

class CuckoldQuizData {
  CuckoldQuizData._();

  static const String typeId = 'cuckold';

  static final QuizType quizType = QuizType(
    id: typeId,
    name: '绿帽自测',
    description: '探索你对绿帽癖的接受程度和具体偏好，了解自己的心理边界',
    iconPath: 'assets/icons/cuckold.png',
    categories: categories,
  );

  // 第一阶段：心理萌芽
  static final List<QuizItem> _fantasyItems = [
    QuizItem(id: '${typeId}_fantasy_01', name: '幻想老婆被朋友操', categoryId: '${typeId}_fantasy', description: '脑补老婆被你最好的朋友按在床上狠操'),
    QuizItem(id: '${typeId}_fantasy_02', name: '幻想老婆被轮奸', categoryId: '${typeId}_fantasy', description: '想象老婆被一群男人轮流使用到瘫软'),
    QuizItem(id: '${typeId}_fantasy_03', name: '看绿帽视频代入自己', categoryId: '${typeId}_fantasy', description: '看绿帽AV时把女主想象成老婆被操'),
    QuizItem(id: '${typeId}_fantasy_04', name: '幻想老婆和前任的床上姿势', categoryId: '${typeId}_fantasy', description: '脑补老婆被前任用各种姿势操到高潮'),
    QuizItem(id: '${typeId}_fantasy_05', name: '幻想老婆被黑人操', categoryId: '${typeId}_fantasy', description: '想象老婆被大鸡巴黑人操到失禁尖叫'),
    QuizItem(id: '${typeId}_fantasy_06', name: '幻想老婆被上司潜规则', categoryId: '${typeId}_fantasy', description: '脑补老婆为了升职被上司操'),
    QuizItem(id: '${typeId}_fantasy_07', name: '幻想老婆当别人的母狗', categoryId: '${typeId}_fantasy', description: '想象老婆跪在别的男人面前摇尾乞怜'),
    QuizItem(id: '${typeId}_fantasy_08', name: '幻想老婆怀别人的孩子', categoryId: '${typeId}_fantasy', description: '脑补老婆肚子里怀着别人的种'),
    QuizItem(id: '${typeId}_fantasy_09', name: '幻想老婆在你面前被操', categoryId: '${typeId}_fantasy', description: '想象老婆当着你的面被别人操到求饶'),
    QuizItem(id: '${typeId}_fantasy_10', name: '幻想老婆主动勾引别人', categoryId: '${typeId}_fantasy', description: '脑补老婆穿着骚装主动去勾引男人'),
    QuizItem(id: '${typeId}_fantasy_11', name: '幻想老婆被快递员操', categoryId: '${typeId}_fantasy', description: '脑补老婆穿着睡衣开门被快递员按住操'),
    QuizItem(id: '${typeId}_fantasy_12', name: '幻想老婆被邻居操', categoryId: '${typeId}_fantasy', description: '想象老婆趁你上班被隔壁邻居操'),
    QuizItem(id: '${typeId}_fantasy_13', name: '幻想老婆被健身教练操', categoryId: '${typeId}_fantasy', description: '脑补老婆在健身房被肌肉教练操'),
    QuizItem(id: '${typeId}_fantasy_14', name: '幻想老婆双洞齐开', categoryId: '${typeId}_fantasy', description: '想象老婆骚逼和骚屁眼同时被两根鸡巴操'),
    QuizItem(id: '${typeId}_fantasy_15', name: '幻想老婆被操到失禁', categoryId: '${typeId}_fantasy', description: '脑补老婆被大鸡巴操到尿出来'),
  ];

  // 第二阶段：试探怂恿
  static final List<QuizItem> _hintItems = [
    QuizItem(id: '${typeId}_hint_01', name: '送老婆去学跳舞被男教练摸', categoryId: '${typeId}_hint', description: '送老婆学拉丁舞被男教练贴身指导'),
    QuizItem(id: '${typeId}_hint_02', name: '怂恿老婆去做SPA被男技师按', categoryId: '${typeId}_hint', description: '让老婆去做精油SPA被男技师全身按摩'),
    QuizItem(id: '${typeId}_hint_03', name: '带老婆去裸体海滩', categoryId: '${typeId}_hint', description: '带老婆去天体海滩被别人看光'),
    QuizItem(id: '${typeId}_hint_04', name: '让老婆穿透视装去夜店', categoryId: '${typeId}_hint', description: '让老婆穿透视装去夜店被搭讪'),
    QuizItem(id: '${typeId}_hint_05', name: '故意让老婆单独和男同事出差', categoryId: '${typeId}_hint', description: '创造机会让老婆和男同事单独出差'),
    QuizItem(id: '${typeId}_hint_06', name: '让老婆去相亲网站注册', categoryId: '${typeId}_hint', description: '让老婆在交友网站注册看有没有人约'),
    QuizItem(id: '${typeId}_hint_07', name: '假装喝醉让朋友送老婆回家', categoryId: '${typeId}_hint', description: '装醉让单身朋友送老婆回家'),
    QuizItem(id: '${typeId}_hint_08', name: '让老婆去健身房找私教', categoryId: '${typeId}_hint', description: '让老婆找肌肉男私教贴身指导'),
    QuizItem(id: '${typeId}_hint_09', name: '鼓励老婆参加公司酒局', categoryId: '${typeId}_hint', description: '鼓励老婆参加有男领导的酒局'),
    QuizItem(id: '${typeId}_hint_10', name: '让老婆在直播平台露脸', categoryId: '${typeId}_hint', description: '让老婆开直播被网友打赏撩骚'),
    QuizItem(id: '${typeId}_hint_11', name: '让老婆穿超短裙不穿内裤', categoryId: '${typeId}_hint', description: '让老婆真空穿超短裙出门走光'),
    QuizItem(id: '${typeId}_hint_12', name: '让老婆和男同事单独吃饭', categoryId: '${typeId}_hint', description: '鼓励老婆和帅气男同事单独约饭'),
    QuizItem(id: '${typeId}_hint_13', name: '让老婆去酒吧被搭讪', categoryId: '${typeId}_hint', description: '让老婆独自去酒吧等人搭讪'),
    QuizItem(id: '${typeId}_hint_14', name: '让老婆穿情趣内衣拍照', categoryId: '${typeId}_hint', description: '让老婆穿骚内衣拍照发给你看'),
    QuizItem(id: '${typeId}_hint_15', name: '让老婆和前任联系', categoryId: '${typeId}_hint', description: '鼓励老婆和前任重新联系聊天'),
  ];

  // 第三阶段：网络调教
  static final List<QuizItem> _onlineItems = [
    QuizItem(id: '${typeId}_online_01', name: '让老婆和网友文爱', categoryId: '${typeId}_online', description: '让老婆和网友发骚话文字做爱'),
    QuizItem(id: '${typeId}_online_02', name: '让老婆给网友发内衣照', categoryId: '${typeId}_online', description: '让老婆拍内衣照发给网友'),
    QuizItem(id: '${typeId}_online_03', name: '让老婆和网友语音娇喘', categoryId: '${typeId}_online', description: '让老婆和网友语音假装高潮'),
    QuizItem(id: '${typeId}_online_04', name: '让老婆视频给网友看身体', categoryId: '${typeId}_online', description: '让老婆开视频给网友看'),
    QuizItem(id: '${typeId}_online_05', name: '让老婆在网上认主人', categoryId: '${typeId}_online', description: '让老婆在网上认一个主人调教'),
    QuizItem(id: '${typeId}_online_06', name: '让老婆按网友指令自慰', categoryId: '${typeId}_online', description: '让老婆按网友指令自慰直播'),
    QuizItem(id: '${typeId}_online_07', name: '让老婆收网友的红包礼物', categoryId: '${typeId}_online', description: '让老婆收网友打赏当网络情人'),
    QuizItem(id: '${typeId}_online_08', name: '把老婆的骚视频发群里', categoryId: '${typeId}_online', description: '把老婆自慰视频发到绿帽群'),
    QuizItem(id: '${typeId}_online_09', name: '让老婆在约炮软件上挂照片', categoryId: '${typeId}_online', description: '让老婆在探探陌陌上挂骚照'),
    QuizItem(id: '${typeId}_online_10', name: '帮老婆筛选网上的约炮对象', categoryId: '${typeId}_online', description: '帮老婆在网上挑选合适的炮友'),
    QuizItem(id: '${typeId}_online_11', name: '让老婆在绿帽群里发骚', categoryId: '${typeId}_online', description: '让老婆在绿帽群里发骚照勾引群友'),
    QuizItem(id: '${typeId}_online_12', name: '让老婆和网友视频自慰', categoryId: '${typeId}_online', description: '让老婆开视频给网友看她玩骚逼'),
    QuizItem(id: '${typeId}_online_13', name: '让老婆发裸照到网上', categoryId: '${typeId}_online', description: '把老婆的裸照发到论坛让人评论'),
    QuizItem(id: '${typeId}_online_14', name: '让老婆网上约炮', categoryId: '${typeId}_online', description: '让老婆在网上约陌生人线下见面'),
    QuizItem(id: '${typeId}_online_15', name: '让老婆当网络骚货', categoryId: '${typeId}_online', description: '让老婆在网上当骚货被人调教'),
  ];

  // 第四阶段：现场观看
  static final List<QuizItem> _watchItems = [
    QuizItem(id: '${typeId}_watch_01', name: '躲衣柜里看老婆偷情', categoryId: '${typeId}_watch', description: '躲在衣柜里偷看老婆和别人做'),
    QuizItem(id: '${typeId}_watch_02', name: '装睡听老婆和别人打电话骚', categoryId: '${typeId}_watch', description: '假装睡着听老婆和情人电话调情'),
    QuizItem(id: '${typeId}_watch_03', name: '在隔壁房间听老婆被操', categoryId: '${typeId}_watch', description: '在隔壁房间听老婆的叫床声'),
    QuizItem(id: '${typeId}_watch_04', name: '通过监控看老婆在家偷人', categoryId: '${typeId}_watch', description: '在外面通过家里监控看老婆偷情'),
    QuizItem(id: '${typeId}_watch_05', name: '坐在床边看老婆被操', categoryId: '${typeId}_watch', description: '坐在床边近距离看老婆被操'),
    QuizItem(id: '${typeId}_watch_06', name: '拿着手机录老婆被操的表情', categoryId: '${typeId}_watch', description: '用手机拍老婆被操时的骚样'),
    QuizItem(id: '${typeId}_watch_07', name: '看老婆主动爬上别人的床', categoryId: '${typeId}_watch', description: '看老婆主动脱光爬上炮友的床'),
    QuizItem(id: '${typeId}_watch_08', name: '看老婆被操完瘫在床上', categoryId: '${typeId}_watch', description: '看老婆被操完满足地躺着'),
    QuizItem(id: '${typeId}_watch_09', name: '看老婆含着别人的精液笑', categoryId: '${typeId}_watch', description: '看老婆嘴里含着精液对你笑'),
    QuizItem(id: '${typeId}_watch_10', name: '看老婆腿间流出别人的精液', categoryId: '${typeId}_watch', description: '看精液从老婆腿间流出来'),
    QuizItem(id: '${typeId}_watch_11', name: '看老婆给炮友口交', categoryId: '${typeId}_watch', description: '看老婆跪着给炮友吸鸡巴'),
    QuizItem(id: '${typeId}_watch_12', name: '看老婆被后入', categoryId: '${typeId}_watch', description: '看老婆趴着被炮友从后面狠操'),
    QuizItem(id: '${typeId}_watch_13', name: '看老婆骑在炮友身上', categoryId: '${typeId}_watch', description: '看老婆主动骑在炮友鸡巴上扭'),
    QuizItem(id: '${typeId}_watch_14', name: '看老婆被操到高潮', categoryId: '${typeId}_watch', description: '看老婆被炮友操到浪叫高潮'),
    QuizItem(id: '${typeId}_watch_15', name: '看老婆舔炮友的蛋蛋', categoryId: '${typeId}_watch', description: '看老婆跪着舔炮友的蛋蛋'),
  ];

  // 第五阶段：参与服务
  static final List<QuizItem> _serviceItems = [
    QuizItem(id: '${typeId}_service_01', name: '给老婆和炮友开房门', categoryId: '${typeId}_service', description: '亲自给老婆和炮友开酒店房门'),
    QuizItem(id: '${typeId}_service_02', name: '帮老婆把炮友带回家', categoryId: '${typeId}_service', description: '开车把炮友接到家里来'),
    QuizItem(id: '${typeId}_service_03', name: '给老婆和炮友倒酒助兴', categoryId: '${typeId}_service', description: '给他们倒酒看他们调情'),
    QuizItem(id: '${typeId}_service_04', name: '帮老婆脱衣服献给炮友', categoryId: '${typeId}_service', description: '亲手帮老婆脱光送到炮友面前'),
    QuizItem(id: '${typeId}_service_05', name: '用手帮炮友撸硬', categoryId: '${typeId}_service', description: '用手帮炮友把鸡巴撸硬准备操老婆'),
    QuizItem(id: '${typeId}_service_06', name: '扶着炮友的鸡巴对准老婆的骚逼', categoryId: '${typeId}_service', description: '亲手扶着炮友的鸡巴插进老婆骚逼'),
    QuizItem(id: '${typeId}_service_07', name: '在旁边给他们扇扇子', categoryId: '${typeId}_service', description: '他们做的时候在旁边扇风服侍'),
    QuizItem(id: '${typeId}_service_08', name: '递纸巾给炮友擦汗', categoryId: '${typeId}_service', description: '炮友操累了递纸巾给他擦汗'),
    QuizItem(id: '${typeId}_service_09', name: '事后帮老婆清理下体', categoryId: '${typeId}_service', description: '用毛巾帮老婆擦干净下面'),
    QuizItem(id: '${typeId}_service_10', name: '送炮友出门说下次再来', categoryId: '${typeId}_service', description: '恭敬地送炮友出门约下次'),
    QuizItem(id: '${typeId}_service_11', name: '帮老婆预约炮友', categoryId: '${typeId}_service', description: '主动帮老婆联系炮友约时间'),
    QuizItem(id: '${typeId}_service_12', name: '帮老婆买情趣内衣', categoryId: '${typeId}_service', description: '买骚内衣让老婆穿给炮友看'),
    QuizItem(id: '${typeId}_service_13', name: '帮老婆订酒店', categoryId: '${typeId}_service', description: '帮老婆订好酒店等炮友来操'),
    QuizItem(id: '${typeId}_service_14', name: '帮老婆化妆打扮', categoryId: '${typeId}_service', description: '帮老婆化骚妆打扮去见炮友'),
    QuizItem(id: '${typeId}_service_15', name: '帮老婆拍被操的视频', categoryId: '${typeId}_service', description: '拿着手机帮老婆拍被操的视频'),
  ];

  // 第六阶段：羞辱臣服
  static final List<QuizItem> _humiliationItems = [
    QuizItem(id: '${typeId}_humiliation_01', name: '被老婆当面比较鸡巴大小', categoryId: '${typeId}_humiliation', description: '老婆当面说炮友鸡巴比你大多了'),
    QuizItem(id: '${typeId}_humiliation_02', name: '被逼跪着看老婆被操', categoryId: '${typeId}_humiliation', description: '跪在地上看老婆和炮友做'),
    QuizItem(id: '${typeId}_humiliation_03', name: '被逼戴着绿帽子看', categoryId: '${typeId}_humiliation', description: '头上戴着绿帽子看老婆被操'),
    QuizItem(id: '${typeId}_humiliation_04', name: '被逼数炮友抽插的次数', categoryId: '${typeId}_humiliation', description: '大声数炮友操老婆多少下'),
    QuizItem(id: '${typeId}_humiliation_05', name: '被逼给炮友磕头感谢', categoryId: '${typeId}_humiliation', description: '跪下给炮友磕头感谢他操老婆'),
    QuizItem(id: '${typeId}_humiliation_06', name: '被逼叫炮友爸爸', categoryId: '${typeId}_humiliation', description: '叫操老婆的炮友爸爸'),
    QuizItem(id: '${typeId}_humiliation_07', name: '被逼亲炮友的屁股', categoryId: '${typeId}_humiliation', description: '亲吻炮友的屁股表示臣服'),
    QuizItem(id: '${typeId}_humiliation_08', name: '被逼在身上写绿奴', categoryId: '${typeId}_humiliation', description: '让炮友在你身上写绿奴贱货'),
    QuizItem(id: '${typeId}_humiliation_09', name: '被逼发朋友圈承认被绿', categoryId: '${typeId}_humiliation', description: '发朋友圈说自己是绿帽子'),
    QuizItem(id: '${typeId}_humiliation_10', name: '被逼给炮友洗内裤', categoryId: '${typeId}_humiliation', description: '手洗炮友操完老婆后的内裤'),
    QuizItem(id: '${typeId}_humiliation_11', name: '被老婆嘲笑不行', categoryId: '${typeId}_humiliation', description: '老婆当面说你不如炮友能操'),
    QuizItem(id: '${typeId}_humiliation_12', name: '被逼说感谢炮友操老婆', categoryId: '${typeId}_humiliation', description: '大声说感谢炮友帮你操老婆'),
    QuizItem(id: '${typeId}_humiliation_13', name: '被逼承认自己是废物', categoryId: '${typeId}_humiliation', description: '跪着承认自己是个废物绿奴'),
    QuizItem(id: '${typeId}_humiliation_14', name: '被逼看老婆和炮友亲嘴', categoryId: '${typeId}_humiliation', description: '看老婆和炮友深吻你只能看'),
    QuizItem(id: '${typeId}_humiliation_15', name: '被逼听老婆说爱炮友', categoryId: '${typeId}_humiliation', description: '听老婆当面说她爱炮友的大鸡巴'),
  ];

  // 第七阶段：肉体服侍
  static final List<QuizItem> _bodyItems = [
    QuizItem(id: '${typeId}_body_01', name: '用嘴帮炮友戴套', categoryId: '${typeId}_body', description: '用嘴帮炮友把套戴上'),
    QuizItem(id: '${typeId}_body_02', name: '舔干净炮友操完的鸡巴', categoryId: '${typeId}_body', description: '舔干净炮友刚从老婆骚逼里拔出的鸡巴'),
    QuizItem(id: '${typeId}_body_03', name: '舔干净老婆被射满的骚逼', categoryId: '${typeId}_body', description: '用舌头舔干净老婆被灌满精液的骚逼'),
    QuizItem(id: '${typeId}_body_04', name: '把炮友射在老婆身上的精液舔干净', categoryId: '${typeId}_body', description: '舔干净老婆身上的精液'),
    QuizItem(id: '${typeId}_body_05', name: '让炮友射在你嘴里', categoryId: '${typeId}_body', description: '张嘴接住炮友射出的精液'),
    QuizItem(id: '${typeId}_body_06', name: '跪下给炮友舔脚', categoryId: '${typeId}_body', description: '跪着舔炮友的臭脚'),
    QuizItem(id: '${typeId}_body_07', name: '趴下当炮友和老婆的脚垫', categoryId: '${typeId}_body', description: '趴在床边让他们把脚踩在你身上'),
    QuizItem(id: '${typeId}_body_08', name: '让炮友骑在你背上操老婆', categoryId: '${typeId}_body', description: '四肢着地让炮友骑着你操老婆'),
    QuizItem(id: '${typeId}_body_09', name: '让炮友往你脸上撒尿', categoryId: '${typeId}_body', description: '跪着让炮友在你脸上撒尿'),
    QuizItem(id: '${typeId}_body_10', name: '让炮友也操你的屁眼', categoryId: '${typeId}_body', description: '撅起屁股让炮友操你'),
    QuizItem(id: '${typeId}_body_11', name: '给炮友口交', categoryId: '${typeId}_body', description: '跪着给炮友吸鸡巴'),
    QuizItem(id: '${typeId}_body_12', name: '舔老婆和炮友做爱的汗', categoryId: '${typeId}_body', description: '舔干净他们做爱流的汗'),
    QuizItem(id: '${typeId}_body_13', name: '用嘴清理老婆的骚逼', categoryId: '${typeId}_body', description: '用舌头把老婆骚逼里的精液舔干净'),
    QuizItem(id: '${typeId}_body_14', name: '让炮友射在你脸上', categoryId: '${typeId}_body', description: '跪着让炮友把精液射在你脸上'),
    QuizItem(id: '${typeId}_body_15', name: '舔干净炮友的屁眼', categoryId: '${typeId}_body', description: '跪着用舌头舔炮友的屁眼'),
  ];

  // 第八阶段：长期圈养
  static final List<QuizItem> _longTermItems = [
    QuizItem(id: '${typeId}_longterm_01', name: '让炮友搬进家里同住', categoryId: '${typeId}_longterm', description: '让炮友住进来和老婆一起生活'),
    QuizItem(id: '${typeId}_longterm_02', name: '把主卧让给炮友和老婆', categoryId: '${typeId}_longterm', description: '自己睡客房把主卧让出来'),
    QuizItem(id: '${typeId}_longterm_03', name: '每天早上给炮友请安', categoryId: '${typeId}_longterm', description: '每天早上跪着向炮友问好'),
    QuizItem(id: '${typeId}_longterm_04', name: '把工资卡交给炮友管', categoryId: '${typeId}_longterm', description: '工资全部上交给炮友支配'),
    QuizItem(id: '${typeId}_longterm_05', name: '永久戴上贞操锁', categoryId: '${typeId}_longterm', description: '小鸡巴永远锁着钥匙在炮友手里'),
    QuizItem(id: '${typeId}_longterm_06', name: '签订绿奴契约', categoryId: '${typeId}_longterm', description: '签协议承认自己是永久绿奴'),
    QuizItem(id: '${typeId}_longterm_07', name: '在身上纹绿奴标记', categoryId: '${typeId}_longterm', description: '纹身纹上绿奴的标记'),
    QuizItem(id: '${typeId}_longterm_08', name: '每天写绿奴日记', categoryId: '${typeId}_longterm', description: '每天记录被绿的经历和感受'),
    QuizItem(id: '${typeId}_longterm_09', name: '庆祝被绿周年纪念日', categoryId: '${typeId}_longterm', description: '每年庆祝第一次被绿的日子'),
    QuizItem(id: '${typeId}_longterm_10', name: '把老婆被操的照片做成相册', categoryId: '${typeId}_longterm', description: '收集老婆被操的照片做纪念册'),
    QuizItem(id: '${typeId}_longterm_11', name: '让炮友成为家里的主人', categoryId: '${typeId}_longterm', description: '炮友成为家里真正的男主人'),
    QuizItem(id: '${typeId}_longterm_12', name: '每天给炮友做饭', categoryId: '${typeId}_longterm', description: '每天给炮友和老婆做饭伺候'),
    QuizItem(id: '${typeId}_longterm_13', name: '睡地板让炮友睡床', categoryId: '${typeId}_longterm', description: '自己睡地板让炮友和老婆睡床'),
    QuizItem(id: '${typeId}_longterm_14', name: '叫炮友老公', categoryId: '${typeId}_longterm', description: '和老婆一起叫炮友老公'),
    QuizItem(id: '${typeId}_longterm_15', name: '把房产证写炮友名字', categoryId: '${typeId}_longterm', description: '把房子过户给炮友'),
  ];

  // 第九阶段：极限堕落
  static final List<QuizItem> _extremeItems = [
    QuizItem(id: '${typeId}_extreme_01', name: '接受老婆怀炮友的孩子', categoryId: '${typeId}_extreme', description: '让老婆怀上炮友的种'),
    QuizItem(id: '${typeId}_extreme_02', name: '养炮友和老婆生的孩子', categoryId: '${typeId}_extreme', description: '把炮友的孩子当亲生的养'),
    QuizItem(id: '${typeId}_extreme_03', name: '在亲戚面前承认被绿', categoryId: '${typeId}_extreme', description: '当着亲戚面承认老婆有别人'),
    QuizItem(id: '${typeId}_extreme_04', name: '主动把老婆介绍给朋友操', categoryId: '${typeId}_extreme', description: '把老婆介绍给朋友让他们操'),
    QuizItem(id: '${typeId}_extreme_05', name: '组织多人轮流操老婆', categoryId: '${typeId}_extreme', description: '约一群人来轮流操老婆'),
    QuizItem(id: '${typeId}_extreme_06', name: '带老婆去换妻俱乐部', categoryId: '${typeId}_extreme', description: '带老婆去换妻派对被别人操'),
    QuizItem(id: '${typeId}_extreme_07', name: '让老婆在网上卖身', categoryId: '${typeId}_extreme', description: '让老婆在网上接客赚钱'),
    QuizItem(id: '${typeId}_extreme_08', name: '帮老婆接客收钱', categoryId: '${typeId}_extreme', description: '帮老婆联系嫖客收钱'),
    QuizItem(id: '${typeId}_extreme_09', name: '看老婆被一群人轮', categoryId: '${typeId}_extreme', description: '看老婆被一群人轮流使用'),
    QuizItem(id: '${typeId}_extreme_10', name: '发誓这辈子永远当绿奴', categoryId: '${typeId}_extreme', description: '发誓永远当老婆的绿奴'),
    QuizItem(id: '${typeId}_extreme_11', name: '让老婆当公共肉便器', categoryId: '${typeId}_extreme', description: '让老婆成为一群人的公共骚货'),
    QuizItem(id: '${typeId}_extreme_12', name: '让老婆拍AV', categoryId: '${typeId}_extreme', description: '让老婆去拍成人片被陌生人操'),
    QuizItem(id: '${typeId}_extreme_13', name: '让老婆去夜总会上班', categoryId: '${typeId}_extreme', description: '让老婆去夜总会陪客人'),
    QuizItem(id: '${typeId}_extreme_14', name: '让老婆被无套内射', categoryId: '${typeId}_extreme', description: '让炮友不戴套射在老婆骚逼里'),
    QuizItem(id: '${typeId}_extreme_15', name: '让老婆同时伺候多根鸡巴', categoryId: '${typeId}_extreme', description: '让老婆嘴里含一根手里撸两根'),
  ];

  // 调教人群（可接受被谁绿）
  static final List<QuizItem> _trainerItems = [
    QuizItem(id: '${typeId}_trainer_01', name: '被朋友绿', categoryId: '${typeId}_trainer', description: '让老婆被你的朋友操，朋友变炮友'),
    QuizItem(id: '${typeId}_trainer_02', name: '被同事绿', categoryId: '${typeId}_trainer', description: '让老婆被你的同事操，办公室偷情'),
    QuizItem(id: '${typeId}_trainer_03', name: '被陌生人绿', categoryId: '${typeId}_trainer', description: '让老婆被陌生人操，增加未知刺激'),
    QuizItem(id: '${typeId}_trainer_04', name: '被前任绿', categoryId: '${typeId}_trainer', description: '让老婆和前任重新上床'),
    QuizItem(id: '${typeId}_trainer_05', name: '被上司绿', categoryId: '${typeId}_trainer', description: '让老婆被上司潜规则'),
    QuizItem(id: '${typeId}_trainer_06', name: '被多人绿', categoryId: '${typeId}_trainer', description: '让老婆同时被多个男人操'),
    QuizItem(id: '${typeId}_trainer_07', name: '被黑人绿', categoryId: '${typeId}_trainer', description: '让老婆被大鸡巴黑人操'),
    QuizItem(id: '${typeId}_trainer_08', name: '被网友绿', categoryId: '${typeId}_trainer', description: '让老婆约网上认识的炮友'),
    QuizItem(id: '${typeId}_trainer_09', name: '被亲戚绿', categoryId: '${typeId}_trainer', description: '让老婆被你的亲戚操'),
    QuizItem(id: '${typeId}_trainer_10', name: '被长期炮友绿', categoryId: '${typeId}_trainer', description: '让老婆有固定的长期炮友'),
    QuizItem(id: '${typeId}_trainer_11', name: '被短期约炮绿', categoryId: '${typeId}_trainer', description: '让老婆约不同的一夜情对象'),
    QuizItem(id: '${typeId}_trainer_12', name: '被情侣绿', categoryId: '${typeId}_trainer', description: '让老婆被一对情侣一起玩'),
  ];

  static final List<QuizCategory> categories = [
    QuizCategory(
      id: '${typeId}_fantasy',
      name: '心理萌芽',
      quizTypeId: typeId,
      items: _fantasyItems,
    ),
    QuizCategory(
      id: '${typeId}_hint',
      name: '试探怂恿',
      quizTypeId: typeId,
      items: _hintItems,
    ),
    QuizCategory(
      id: '${typeId}_online',
      name: '网络调教',
      quizTypeId: typeId,
      items: _onlineItems,
    ),
    QuizCategory(
      id: '${typeId}_watch',
      name: '现场观看',
      quizTypeId: typeId,
      items: _watchItems,
    ),
    QuizCategory(
      id: '${typeId}_service',
      name: '参与服务',
      quizTypeId: typeId,
      items: _serviceItems,
    ),
    QuizCategory(
      id: '${typeId}_humiliation',
      name: '羞辱臣服',
      quizTypeId: typeId,
      items: _humiliationItems,
    ),
    QuizCategory(
      id: '${typeId}_body',
      name: '肉体服侍',
      quizTypeId: typeId,
      items: _bodyItems,
    ),
    QuizCategory(
      id: '${typeId}_longterm',
      name: '长期圈养',
      quizTypeId: typeId,
      items: _longTermItems,
    ),
    QuizCategory(
      id: '${typeId}_extreme',
      name: '极限堕落',
      quizTypeId: typeId,
      items: _extremeItems,
    ),
    QuizCategory(
      id: '${typeId}_trainer',
      name: '调教人群',
      quizTypeId: typeId,
      items: _trainerItems,
    ),
  ];
}

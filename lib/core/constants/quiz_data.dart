import '../../domain/models/quiz_type.dart';
import '../../domain/models/quiz_category.dart';
import '../../domain/models/quiz_item.dart';

class QuizData {
  QuizData._();

  static List<QuizType> getAllQuizTypes() {
    return [
      femaleDesireQuizType,
      femaleSQuizType,
      maleSQuizType,
      femaleMQuizType,
      maleMQuizType,
      cuckoldQuizType,
    ];
  }

  static QuizType? getQuizTypeById(String id) {
    try {
      return getAllQuizTypes().firstWhere((type) => type.id == id);
    } catch (_) {
      return null;
    }
  }

  // 女生好色测试数据
  static const String _femaleDesireTypeId = 'female_desire';
  
  static final QuizType femaleDesireQuizType = QuizType(
    id: _femaleDesireTypeId,
    name: '女生好色测试',
    description: '探索你的性偏好、幻想对象和开放程度，了解内心深处的欲望和倾向',
    iconPath: 'assets/icons/female_desire.png',
    categories: _femaleDesireCategories,
  );

  static final List<QuizCategory> _femaleDesireCategories = [
    QuizCategory(
      id: '${_femaleDesireTypeId}_content',
      name: '内容偏好',
      quizTypeId: _femaleDesireTypeId,
      items: _femaleDesireContentItems,
    ),
    QuizCategory(
      id: '${_femaleDesireTypeId}_fantasy',
      name: '幻想对象',
      quizTypeId: _femaleDesireTypeId,
      items: _femaleDesireFantasyItems,
    ),
    QuizCategory(
      id: '${_femaleDesireTypeId}_frequency',
      name: '行为频率',
      quizTypeId: _femaleDesireTypeId,
      items: _femaleDesireFrequencyItems,
    ),
    QuizCategory(
      id: '${_femaleDesireTypeId}_scene',
      name: '场景偏好',
      quizTypeId: _femaleDesireTypeId,
      items: _femaleDesireSceneItems,
    ),
    QuizCategory(
      id: '${_femaleDesireTypeId}_toys',
      name: '情趣用品',
      quizTypeId: _femaleDesireTypeId,
      items: _femaleDesireToysItems,
    ),
    QuizCategory(
      id: '${_femaleDesireTypeId}_openness',
      name: '开放程度',
      quizTypeId: _femaleDesireTypeId,
      items: _femaleDesireOpennessItems,
    ),
  ];

  static final List<QuizItem> _femaleDesireContentItems = [
    QuizItem(id: '${_femaleDesireTypeId}_content_01', name: '出轨', categoryId: '${_femaleDesireTypeId}_content', description: '背着老公偷偷让别的男人用粗大的鸡巴狠狠插进骚穴里,享受背叛的极致刺激'),
    QuizItem(id: '${_femaleDesireTypeId}_content_02', name: '乱伦', categoryId: '${_femaleDesireTypeId}_content', description: '幻想被爸爸、哥哥、叔叔的肉棒插入骚穴，享受血缘禁忌带来的变态快感'),
    QuizItem(id: '${_femaleDesireTypeId}_content_03', name: '群交', categoryId: '${_femaleDesireTypeId}_content', description: '同时被一群男人的大鸡巴轮流插入嘴巴、骚穴、肛门,像母狗一样被多根肉棒填满'),
    QuizItem(id: '${_femaleDesireTypeId}_content_04', name: '强奸', categoryId: '${_femaleDesireTypeId}_content', description: '被强行撕开衣服,粗暴地把大鸡巴捅进湿淋淋的骚穴里,在失控的痛苦和快感中高潮'),
    QuizItem(id: '${_femaleDesireTypeId}_content_05', name: '按摩', categoryId: '${_femaleDesireTypeId}_content', description: '躺在按摩床上被按摩师的手指插入骚穴抠弄，最后忍不住被他的肉棒狠狠抽插'),
    QuizItem(id: '${_femaleDesireTypeId}_content_06', name: '师生', categoryId: '${_femaleDesireTypeId}_content', description: '在办公室被老师按在桌上,掀起裙子把硬邦邦的鸡巴插进嫩穴里惩罚性地抽插'),
    QuizItem(id: '${_femaleDesireTypeId}_content_07', name: '医护', categoryId: '${_femaleDesireTypeId}_content', description: '在体检时被医生的手指插进骚穴检查，最后被白大褂下的大肉棒狠狠抽插'),
    QuizItem(id: '${_femaleDesireTypeId}_content_08', name: '制服', categoryId: '${_femaleDesireTypeId}_content', description: '穿着护士装、空姐制服被男人扒下内裤,硬挺的鸡巴直接顶进湿透的骚逼里'),
    QuizItem(id: '${_femaleDesireTypeId}_content_09', name: '野外', categoryId: '${_femaleDesireTypeId}_content', description: '在公园树林里被按倒，裤子被扯下大鸡巴直接插入骚穴，随时可能被人发现'),
    QuizItem(id: '${_femaleDesireTypeId}_content_10', name: '胁迫', categoryId: '${_femaleDesireTypeId}_content', description: '被威胁拍下裸照,只能乖乖张开双腿让粗长的肉棒插进骚穴里狠狠抽插'),
    QuizItem(id: '${_femaleDesireTypeId}_content_11', name: '偷拍', categoryId: '${_femaleDesireTypeId}_content', description: '被偷偷拍下自己被大鸡巴插入嘴巴和骚穴的淫荡样子,留下永久的羞耻证据'),
    QuizItem(id: '${_femaleDesireTypeId}_content_12', name: '迷奸', categoryId: '${_femaleDesireTypeId}_content', description: '喝醉后迷迷糊糊感觉有粗大的肉棒不停插进骚穴，醒来发现骚逼里全是精液'),
    QuizItem(id: '${_femaleDesireTypeId}_content_13', name: 'SM', categoryId: '${_femaleDesireTypeId}_content', description: '被绑起来鞭打奶子和骚逼,然后被主人的大鸡巴狠狠插入,在痛苦中淫叫高潮'),
    QuizItem(id: '${_femaleDesireTypeId}_content_14', name: '绑架', categoryId: '${_femaleDesireTypeId}_content', description: '被绑架后双手被绑，嘴里塞着口球，陌生男人的粗长肉棒一次次插进湿润的骚穴'),
    QuizItem(id: '${_femaleDesireTypeId}_content_15', name: '监禁', categoryId: '${_femaleDesireTypeId}_content', description: '被关在密室里,每天都要被多根大鸡巴轮流插进嘴巴、骚穴、肛门,沦为泄欲工具'),
    QuizItem(id: '${_femaleDesireTypeId}_content_16', name: '轮奸', categoryId: '${_femaleDesireTypeId}_content', description: '被一群男人按住,十几根肉棒轮流插进骚穴里射精,小穴被灌满精液不停流出'),
    QuizItem(id: '${_femaleDesireTypeId}_content_17', name: '调教', categoryId: '${_femaleDesireTypeId}_content', description: '被主人每天用粗大的假阳具和真鸡巴扩张骚穴和肛门,训练成只会求操的母狗'),
    QuizItem(id: '${_femaleDesireTypeId}_content_18', name: '催眠', categoryId: '${_femaleDesireTypeId}_content', description: '被催眠后像发情母狗一样主动张开腿求男人用大鸡巴插进淫水直流的骚逼里'),
    QuizItem(id: '${_femaleDesireTypeId}_content_19', name: '下药', categoryId: '${_femaleDesireTypeId}_content', description: '被下了春药后浑身发烫,小穴淫水泛滥,疯狂地求男人用肉棒插进来解痒'),
    QuizItem(id: '${_femaleDesireTypeId}_content_20', name: '换妻', categoryId: '${_femaleDesireTypeId}_content', description: '当着老公的面被别的男人粗大的鸡巴插进骚穴,感受不同肉棒在体内抽插'),
    QuizItem(id: '${_femaleDesireTypeId}_content_21', name: '3P', categoryId: '${_femaleDesireTypeId}_content', description: '前面的嘴巴含着一根大鸡巴,后面的骚穴被另一根肉棒狠狠捅,两头都被堵满'),
    QuizItem(id: '${_femaleDesireTypeId}_content_22', name: '偷情', categoryId: '${_femaleDesireTypeId}_content', description: '趁老公不在偷偷约情人,在家里的床上被他粗长的肉棒插得淫叫连连'),
    QuizItem(id: '${_femaleDesireTypeId}_content_23', name: '公共场合', categoryId: '${_femaleDesireTypeId}_content', description: '在商场试衣间、电影院被掀起裙子,大鸡巴直接插进湿透的小穴快速抽插'),
    QuizItem(id: '${_femaleDesireTypeId}_content_24', name: '睡奸', categoryId: '${_femaleDesireTypeId}_content', description: '睡着后被人扒光衣服,迷糊中感觉硬邦邦的肉棒插进骚穴里抽插,想醒却醒不来'),
    QuizItem(id: '${_femaleDesireTypeId}_content_25', name: '痴汉', categoryId: '${_femaleDesireTypeId}_content', description: '在拥挤的地铁上被陌生男人隔着裙子摸骚逼,手指直接插进内裤里抠弄湿淋淋的小穴'),
    QuizItem(id: '${_femaleDesireTypeId}_content_26', name: '主仆', categoryId: '${_femaleDesireTypeId}_content', description: '跪在主人面前舔他的大鸡巴,然后像母狗一样被他的肉棒从后面狠狠插进骚穴'),
    QuizItem(id: '${_femaleDesireTypeId}_content_27', name: '年下', categoryId: '${_femaleDesireTypeId}_content', description: '被年轻小鲜肉按倒,他精力旺盛的大肉棒一次次插进成熟骚穴里不停抽插'),
    QuizItem(id: '${_femaleDesireTypeId}_content_28', name: '年上', categoryId: '${_femaleDesireTypeId}_content', description: '被成熟大叔压在身下,他经验丰富的粗大鸡巴精准地顶弄G点让你高潮不断'),
  ];

  static final List<QuizItem> _femaleDesireFantasyItems = [
    QuizItem(id: '${_femaleDesireTypeId}_fantasy_01', name: '幻想男闺蜜', categoryId: '${_femaleDesireTypeId}_fantasy', description: '幻想和男闺蜜单独相处时,让他的大鸡巴插进骚穴里,打破纯洁的友谊关系'),
    QuizItem(id: '${_femaleDesireTypeId}_fantasy_02', name: '幻想朋友老公', categoryId: '${_femaleDesireTypeId}_fantasy', description: '背着闺蜜偷偷勾引她老公,让他的粗大肉棒用力插进我的骚穴抽插'),
    QuizItem(id: '${_femaleDesireTypeId}_fantasy_03', name: '幻想前男友', categoryId: '${_femaleDesireTypeId}_fantasy', description: '想起前男友那根熟悉的大鸡巴再次插进来,重燃激情疯狂乱交'),
    QuizItem(id: '${_femaleDesireTypeId}_fantasy_04', name: '幻想同事', categoryId: '${_femaleDesireTypeId}_fantasy', description: '在办公室被男同事按在桌上,他的硬挺肉棒从后面顶进湿透的骚逼'),
    QuizItem(id: '${_femaleDesireTypeId}_fantasy_05', name: '幻想上司', categoryId: '${_femaleDesireTypeId}_fantasy', description: '被上司叫到办公室,他利用权力强迫我张开腿让他的大鸡巴插进来'),
    QuizItem(id: '${_femaleDesireTypeId}_fantasy_06', name: '幻想快递员', categoryId: '${_femaleDesireTypeId}_fantasy', description: '开门给快递员时被他推倒,陌生男人的肉棒直接插进骚穴猛烈抽插'),
    QuizItem(id: '${_femaleDesireTypeId}_fantasy_07', name: '幻想外卖员', categoryId: '${_femaleDesireTypeId}_fantasy', description: '送外卖的小哥进屋后把我按在沙发上,他年轻的大鸡巴狠狠操进来'),
    QuizItem(id: '${_femaleDesireTypeId}_fantasy_08', name: '幻想健身教练', categoryId: '${_femaleDesireTypeId}_fantasy', description: '在健身房被教练的健美肉体压倒,他粗壮的肉棒顶进湿淋淋的骚穴里'),
    QuizItem(id: '${_femaleDesireTypeId}_fantasy_09', name: '幻想医生', categoryId: '${_femaleDesireTypeId}_fantasy', description: '在诊室被医生检查身体,他的手指和大鸡巴都插进我的骚穴里操弄'),
    QuizItem(id: '${_femaleDesireTypeId}_fantasy_10', name: '幻想按摩师', categoryId: '${_femaleDesireTypeId}_fantasy', description: '躺在按摩床上被按摩师的手指插入骚穴,最后被他的大肉棒狠狠抽操'),
    QuizItem(id: '${_femaleDesireTypeId}_fantasy_11', name: '幻想黑人', categoryId: '${_femaleDesireTypeId}_fantasy', description: '幻想被黑人那根超级粗大的巨鸡巴操得骚穴被撑开,满足被大肉棒填满的快感'),
    QuizItem(id: '${_femaleDesireTypeId}_fantasy_12', name: '幻想肌肉男', categoryId: '${_femaleDesireTypeId}_fantasy', description: '被强壮的肌肉男按倒,他有力的大鸡巴狠狠插进骚穴里疯狂抽插'),
    QuizItem(id: '${_femaleDesireTypeId}_fantasy_13', name: '幻想斯文男', categoryId: '${_femaleDesireTypeId}_fantasy', description: '被知识分子在书房里按倒,他斯文外表下的大肉棒用力操入骚逼'),
    QuizItem(id: '${_femaleDesireTypeId}_fantasy_14', name: '幻想成熟大叔', categoryId: '${_femaleDesireTypeId}_fantasy', description: '被成熟大叔压在身下,他经验丰富的粗大鸡巴操得我高潮连连淫叫不断'),
    QuizItem(id: '${_femaleDesireTypeId}_fantasy_15', name: '幻想陌生人', categoryId: '${_femaleDesireTypeId}_fantasy', description: '和不认识的陌生男人在酒店一夜情,被他的大鸡巴整晚操个不停'),
    QuizItem(id: '${_femaleDesireTypeId}_fantasy_16', name: '幻想老师', categoryId: '${_femaleDesireTypeId}_fantasy', description: '放学后被留下,老师把我按在讲台上,他的硬挺肉棒插进嫩穴里惩罚性抽插'),
    QuizItem(id: '${_femaleDesireTypeId}_fantasy_17', name: '幻想邻居', categoryId: '${_femaleDesireTypeId}_fantasy', description: '隔壁邻居敲门进来把我按倒,他的大鸡巴直接插进湿透的骚穴狠狠抽操'),
    QuizItem(id: '${_femaleDesireTypeId}_fantasy_18', name: '幻想网友', categoryId: '${_femaleDesireTypeId}_fantasy', description: '和网友线下见面,第一次见面就被他按倒,粗长的肉棒插进来疯狂操弄'),
    QuizItem(id: '${_femaleDesireTypeId}_fantasy_19', name: '幻想爸爸', categoryId: '${_femaleDesireTypeId}_fantasy', description: '被亲生爸爸压在床上,他粗大的鸡巴插进女儿的骚穴里狠狠操弄'),
    QuizItem(id: '${_femaleDesireTypeId}_fantasy_20', name: '幻想叔叔', categoryId: '${_femaleDesireTypeId}_fantasy', description: '被叔叔在家里按倒,他成熟的大肉棒插进侄女的嫩穴里乱伦操弄'),
    QuizItem(id: '${_femaleDesireTypeId}_fantasy_21', name: '幻想哥哥', categoryId: '${_femaleDesireTypeId}_fantasy', description: '深夜被哥哥摸进房间,他年轻的硬鸡巴插进妹妹的骚穴里秘密乱伦'),
    QuizItem(id: '${_femaleDesireTypeId}_fantasy_22', name: '幻想弟弟', categoryId: '${_femaleDesireTypeId}_fantasy', description: '教导年幼弟弟性知识,让他的嫩鸡巴插进姐姐成熟的骚穴里学习操逼'),
    QuizItem(id: '${_femaleDesireTypeId}_fantasy_23', name: '幻想表哥', categoryId: '${_femaleDesireTypeId}_fantasy', description: '和表哥在家族聚会时偷偷干,他的肉棒插进表妹的骚穴里乱伦交合'),
    QuizItem(id: '${_femaleDesireTypeId}_fantasy_24', name: '幻想农民工', categoryId: '${_femaleDesireTypeId}_fantasy', description: '被汗淋淋的农民工按在工地上,他粗糙的大肉棒插进娇嫩的骚逼里'),
    QuizItem(id: '${_femaleDesireTypeId}_fantasy_25', name: '幻想乞丐', categoryId: '${_femaleDesireTypeId}_fantasy', description: '被脏兮兮的乞丐按倒强奸,他臭烘烘的大鸡巴插进我的骚穴里用力操弄'),
    QuizItem(id: '${_femaleDesireTypeId}_fantasy_26', name: '幻想保安', categoryId: '${_femaleDesireTypeId}_fantasy', description: '深夜被保安小哥带到值班室,他穿着制服的硬鸡巴插进我的骚穴里'),
    QuizItem(id: '${_femaleDesireTypeId}_fantasy_27', name: '幻想司机', categoryId: '${_femaleDesireTypeId}_fantasy', description: '在车里被司机从后座翻到前座,他的大肉棒插进骚穴里在车内狠狠操'),
    QuizItem(id: '${_femaleDesireTypeId}_fantasy_28', name: '幻想维修工', categoryId: '${_femaleDesireTypeId}_fantasy', description: '上门维修的工人把我按在沙发上,他有力的大鸡巴直接插进来操'),
    QuizItem(id: '${_femaleDesireTypeId}_fantasy_29', name: '幻想军人', categoryId: '${_femaleDesireTypeId}_fantasy', description: '被威武的军人小哥按倒强干,他粗壮的肉棒像武器一样插进骚穴里'),
    QuizItem(id: '${_femaleDesireTypeId}_fantasy_30', name: '幻想警察', categoryId: '${_femaleDesireTypeId}_fantasy', description: '被警察带到审讯室,他利用权力强迫我张开腿让他的大鸡巴插进来'),
    QuizItem(id: '${_femaleDesireTypeId}_fantasy_31', name: '幻想明星', categoryId: '${_femaleDesireTypeId}_fantasy', description: '偶遇喜欢的男明星,被他带到酒店,他的大肉棒插进粉丝的骚穴里疯狂操弄'),
    QuizItem(id: '${_femaleDesireTypeId}_fantasy_32', name: '幻想同学', categoryId: '${_femaleDesireTypeId}_fantasy', description: '和校园里的男同学在教室偷偷干,他青涩的大鸡巴插进我的嫩穴里'),
    QuizItem(id: '${_femaleDesireTypeId}_fantasy_33', name: '幻想宿敌', categoryId: '${_femaleDesireTypeId}_fantasy', description: '被竞争对手压在身下强干,他的粗大肉棒插进骚穴里用操来征服我'),
    QuizItem(id: '${_femaleDesireTypeId}_fantasy_34', name: '幻想同性朋友', categoryId: '${_femaleDesireTypeId}_fantasy', description: '和闺蜜用双头龙假阳具同时插入对方的骚穴,一起高潮淫叫'),
    QuizItem(id: '${_femaleDesireTypeId}_fantasy_35', name: '幻想双胞胎', categoryId: '${_femaleDesireTypeId}_fantasy', description: '同时被双胞胎兄弟前后夹攻,两根一模一样的大鸡巴插进嘴巴和骚穴里'),
  ];

  static final List<QuizItem> _femaleDesireFrequencyItems = [
    QuizItem(id: '${_femaleDesireTypeId}_frequency_01', name: '每天自慰一次及以上', categoryId: '${_femaleDesireTypeId}_frequency', description: '经常用手指或玩具插进骚穴自慰,让自己高潮'),
    QuizItem(id: '${_femaleDesireTypeId}_frequency_06', name: '经常看色情内容', categoryId: '${_femaleDesireTypeId}_frequency', description: '喜欢浏览淫荡的性爱视频和图片,看着就会湿'),
    QuizItem(id: '${_femaleDesireTypeId}_frequency_08', name: '有性幻想每天', categoryId: '${_femaleDesireTypeId}_frequency', description: '几乎每天都会幻想被大鸡巴插进骚穴里疯狂抽插'),
    QuizItem(id: '${_femaleDesireTypeId}_frequency_09', name: '白天也会想色色的事', categoryId: '${_femaleDesireTypeId}_frequency', description: '白天也无法控制地想象被男人的肉棒插进来操'),
    QuizItem(id: '${_femaleDesireTypeId}_frequency_10', name: '工作时也会有性幻想', categoryId: '${_femaleDesireTypeId}_frequency', description: '工作中也会突然闪现被同事按倒用大鸡巴操的画面'),
    QuizItem(id: '${_femaleDesireTypeId}_frequency_11', name: '早上醒来就想要', categoryId: '${_femaleDesireTypeId}_frequency', description: '清晨醒来就感到骚穴湿淋淋的,渴望被肉棒插进来填满'),
    QuizItem(id: '${_femaleDesireTypeId}_frequency_12', name: '晚上睡前必须释放', categoryId: '${_femaleDesireTypeId}_frequency', description: '睡前不用手指摸逼高潮一次就难以入睡'),
    QuizItem(id: '${_femaleDesireTypeId}_frequency_13', name: '洗澡时经常自慰', categoryId: '${_femaleDesireTypeId}_frequency', description: '洗澡时总忍不住用花洒头冲阴蒂,用手指插进骚穴摸逼'),
    QuizItem(id: '${_femaleDesireTypeId}_frequency_14', name: '一个人就想自慰', categoryId: '${_femaleDesireTypeId}_frequency', description: '只要独处就容易发情,想把假鸡巴插进湿淋淋的骚穴里'),
    QuizItem(id: '${_femaleDesireTypeId}_frequency_15', name: '经期前特别想要', categoryId: '${_femaleDesireTypeId}_frequency', description: '月经前性欲明显增强,骚穴湿透渴望被大肉棒填满'),
    QuizItem(id: '${_femaleDesireTypeId}_frequency_16', name: '排卵期性欲旺盛', categoryId: '${_femaleDesireTypeId}_frequency', description: '排卵期小穴淫水直流,疯狂渴望被男人的鸡巴插进来操'),
    QuizItem(id: '${_femaleDesireTypeId}_frequency_17', name: '看到帅男就想入非非', categoryId: '${_femaleDesireTypeId}_frequency', description: '遇到吸引人的男性就会幻想他的大鸡巴插进我的骚穴'),
    QuizItem(id: '${_femaleDesireTypeId}_frequency_18', name: '聊天时容易性兴奋', categoryId: '${_femaleDesireTypeId}_frequency', description: '和异性聊天就会小穴发烫,想象被他的肉棒插进来'),
    QuizItem(id: '${_femaleDesireTypeId}_frequency_19', name: '每次高潮后还想要', categoryId: '${_femaleDesireTypeId}_frequency', description: '一次高潮不够,骚穴还想继续被大鸡巴插进来操'),
    QuizItem(id: '${_femaleDesireTypeId}_frequency_20', name: '在公共场所也会发情', categoryId: '${_femaleDesireTypeId}_frequency', description: '即使在外面也会突然骚逼湿透,渴望被男人按倒操'),
  ];

  static final List<QuizItem> _femaleDesireSceneItems = [
    QuizItem(id: '${_femaleDesireTypeId}_scene_01', name: '喜欢在卧室床上', categoryId: '${_femaleDesireTypeId}_scene', description: '在床上被男人压在身下,大鸡巴插进骚穴里疯狂操弄'),
    QuizItem(id: '${_femaleDesireTypeId}_scene_02', name: '喜欢在浴室洗澡时', categoryId: '${_femaleDesireTypeId}_scene', description: '在浴室被按在墙上,湿漉漉的肉棒从后面插进骚逼里'),
    QuizItem(id: '${_femaleDesireTypeId}_scene_03', name: '喜欢在沙发上', categoryId: '${_femaleDesireTypeId}_scene', description: '在沙发上被按倒,裙子被掀起大鸡巴直接插进来狠狠操'),
    QuizItem(id: '${_femaleDesireTypeId}_scene_04', name: '喜欢在车里', categoryId: '${_femaleDesireTypeId}_scene', description: '在狭小的车内被男人按在座位上,肉棒插进骚穴里操'),
    QuizItem(id: '${_femaleDesireTypeId}_scene_05', name: '喜欢在办公室', categoryId: '${_femaleDesireTypeId}_scene', description: '在办公桌上被同事按倒,他的大鸡巴插进骚穴里疯狂抽插'),
    QuizItem(id: '${_femaleDesireTypeId}_scene_06', name: '喜欢在野外', categoryId: '${_femaleDesireTypeId}_scene', description: '在户外被按倒在草地上,大肉棒插进骚逼里原始操弄'),
    QuizItem(id: '${_femaleDesireTypeId}_scene_07', name: '喜欢在森林里', categoryId: '${_femaleDesireTypeId}_scene', description: '在树林深处被按在树上,粗大的鸡巴从后面插进来操'),
    QuizItem(id: '${_femaleDesireTypeId}_scene_08', name: '喜欢在海滩上', categoryId: '${_femaleDesireTypeId}_scene', description: '在海边沙滩被按倒,听着海浪声被大肉棒插进骚穴里操'),
    QuizItem(id: '${_femaleDesireTypeId}_scene_09', name: '喜欢在山上', categoryId: '${_femaleDesireTypeId}_scene', description: '在山顶被男人按倒,他的鸡巴插进骚穴里征服般狠狠操'),
    QuizItem(id: '${_femaleDesireTypeId}_scene_10', name: '喜欢在公园里', categoryId: '${_femaleDesireTypeId}_scene', description: '在公园隐蔽角落被按倒,大鸡巴插进骚逼里刺激地操'),
    QuizItem(id: '${_femaleDesireTypeId}_scene_11', name: '喜欢在田野里', categoryId: '${_femaleDesireTypeId}_scene', description: '在开阔的田野被按倒,肉棒插进骚穴里自由地抽操'),
    QuizItem(id: '${_femaleDesireTypeId}_scene_12', name: '喜欢在湖边', categoryId: '${_femaleDesireTypeId}_scene', description: '在湖边草地被按倒,大鸡巴插进湿淋淋的骚穴里操'),
    QuizItem(id: '${_femaleDesireTypeId}_scene_13', name: '喜欢在酒店', categoryId: '${_femaleDesireTypeId}_scene', description: '在酒店房间被陌生男人按倒,他的肉棒插进来疯狂操弄'),
    QuizItem(id: '${_femaleDesireTypeId}_scene_14', name: '喜欢在试衣间', categoryId: '${_femaleDesireTypeId}_scene', description: '在商场试衣间被按在墙上,大鸡巴快速插进骚逼里操'),
    QuizItem(id: '${_femaleDesireTypeId}_scene_15', name: '喜欢看着镜子', categoryId: '${_femaleDesireTypeId}_scene', description: '对着镜子被从后面插入,看着自己被大肉棒操的淫荡样子'),
    QuizItem(id: '${_femaleDesireTypeId}_scene_16', name: '喜欢开着窗帘', categoryId: '${_femaleDesireTypeId}_scene', description: '开着窗帘被操,可能被外面的人看到被鸡巴插进骚穴里'),
    QuizItem(id: '${_femaleDesireTypeId}_scene_17', name: '喜欢有被发现的风险', categoryId: '${_femaleDesireTypeId}_scene', description: '在可能被人发现的地方被操,大鸡巴插进骚逼里紧张地抽插'),
    QuizItem(id: '${_femaleDesireTypeId}_scene_18', name: '喜欢听着音乐', categoryId: '${_femaleDesireTypeId}_scene', description: '听着音乐被肉棒插进骚穴里,随着节奏被疯狂抽操'),
    QuizItem(id: '${_femaleDesireTypeId}_scene_19', name: '喜欢看着视频', categoryId: '${_femaleDesireTypeId}_scene', description: '边看色情片边被大鸡巴插进骚穴里操,模仿视频里的淫荡姿势'),
    QuizItem(id: '${_femaleDesireTypeId}_scene_20', name: '喜欢电话中进行', categoryId: '${_femaleDesireTypeId}_scene', description: '打电话时被男人从后面插入,骚穴被肉棒填满却要忍住不叫'),
    QuizItem(id: '${_femaleDesireTypeId}_scene_21', name: '喜欢视频通话时', categoryId: '${_femaleDesireTypeId}_scene', description: '视频通话时被大鸡巴插进来操,展示给对方看自己被操的淫样'),
    QuizItem(id: '${_femaleDesireTypeId}_scene_22', name: '喜欢在电梯里', categoryId: '${_femaleDesireTypeId}_scene', description: '在电梯里被按在墙上,肉棒快速插进骚穴里抽操几下'),
    QuizItem(id: '${_femaleDesireTypeId}_scene_23', name: '喜欢在楼梯间', categoryId: '${_femaleDesireTypeId}_scene', description: '在楼梯间被按在栏杆上,大鸡巴从后面插进骚逼里操'),
    QuizItem(id: '${_femaleDesireTypeId}_scene_24', name: '喜欢在厨房', categoryId: '${_femaleDesireTypeId}_scene', description: '在厨房料理台上被按倒,粗大的肉棒插进骚穴里狠狠操'),
    QuizItem(id: '${_femaleDesireTypeId}_scene_25', name: '喜欢在阳台', categoryId: '${_femaleDesireTypeId}_scene', description: '在阳台被按在栏杆上,大鸡巴插进骚穴里大胆地操'),
    QuizItem(id: '${_femaleDesireTypeId}_scene_26', name: '喜欢在电影院', categoryId: '${_femaleDesireTypeId}_scene', description: '在黑暗的电影院被摸骚逼,手指插进骚穴里隐秘地抠弄'),
    QuizItem(id: '${_femaleDesireTypeId}_scene_27', name: '喜欢在KTV包厢', categoryId: '${_femaleDesireTypeId}_scene', description: '在KTV包厢被按在沙发上,音乐声掩盖下被大肉棒插进来操'),
    QuizItem(id: '${_femaleDesireTypeId}_scene_28', name: '喜欢在游泳池', categoryId: '${_femaleDesireTypeId}_scene', description: '在水中被男人抱起,他的鸡巴在水下插进骚穴里抽操'),
  ];

  static final List<QuizItem> _femaleDesireToysItems = [
    QuizItem(id: '${_femaleDesireTypeId}_toys_01', name: '跳蛋', categoryId: '${_femaleDesireTypeId}_toys', description: '小巧的震动玩具塞进骚逼里,刺激阴蒂和阴道口让小穴痒得流水'),
    QuizItem(id: '${_femaleDesireTypeId}_toys_02', name: '按摩棒', categoryId: '${_femaleDesireTypeId}_toys', description: '粗大的电动按摩棒插进骚穴里,强劲震动带来深层快感'),
    QuizItem(id: '${_femaleDesireTypeId}_toys_03', name: '假阳具', categoryId: '${_femaleDesireTypeId}_toys', description: '像真鸡巴一样粗长的假阳具,插进小穴里满足被填满的快感'),
    QuizItem(id: '${_femaleDesireTypeId}_toys_04', name: 'G点震动棒', categoryId: '${_femaleDesireTypeId}_toys', description: '弯曲设计的震动棒插进骚穴,专门顶弄G点让你疯狂高潮'),
    QuizItem(id: '${_femaleDesireTypeId}_toys_05', name: '双头震动棒', categoryId: '${_femaleDesireTypeId}_toys', description: '双头设计同时插进骚穴和肛门,两个小穴都被填满震动'),
    QuizItem(id: '${_femaleDesireTypeId}_toys_06', name: '吮吸震动器', categoryId: '${_femaleDesireTypeId}_toys', description: '像口交一样吮吸阴蒂,强烈的吮吸感让你疯狂高潮'),
    QuizItem(id: '${_femaleDesireTypeId}_toys_07', name: '遥控跳蛋', categoryId: '${_femaleDesireTypeId}_toys', description: '塞进骚穴里穿着外出,被遥控震动在公众场合高潮'),
    QuizItem(id: '${_femaleDesireTypeId}_toys_08', name: 'AV棒', categoryId: '${_femaleDesireTypeId}_toys', description: '超强震动的大力棒插进骚逼里,几分钟就能让你喷水高潮'),
    QuizItem(id: '${_femaleDesireTypeId}_toys_09', name: '肛塞', categoryId: '${_femaleDesireTypeId}_toys', description: '塞子插进肛门里扩张后穴,长时间佩戴感受被占有'),
    QuizItem(id: '${_femaleDesireTypeId}_toys_10', name: '肛门拉珠', categoryId: '${_femaleDesireTypeId}_toys', description: '一串珠子插进肛门里,拉出时后穴被刺激带来高潮'),
    QuizItem(id: '${_femaleDesireTypeId}_toys_11', name: '阴道拉珠', categoryId: '${_femaleDesireTypeId}_toys', description: '珠子插入骚穴里,拉动时阴道口被层层刺激'),
    QuizItem(id: '${_femaleDesireTypeId}_toys_12', name: '缩阴球', categoryId: '${_femaleDesireTypeId}_toys', description: '球形玉具塞进骚穴里锻炼,增强夹紧鸡巴的能力'),
    QuizItem(id: '${_femaleDesireTypeId}_toys_13', name: '穿戴式震动器', categoryId: '${_femaleDesireTypeId}_toys', description: '固定在骚逼上的震动器,解放双手持续刺激小穴'),
    QuizItem(id: '${_femaleDesireTypeId}_toys_14', name: '乳夹', categoryId: '${_femaleDesireTypeId}_toys', description: '夹住乳头旋转拉扯,痛感和快感让奶子更敏感'),
    QuizItem(id: '${_femaleDesireTypeId}_toys_15', name: '震动内裤', categoryId: '${_femaleDesireTypeId}_toys', description: '内置震动器的内裤穿着外出,骚逼被不停震动刺激'),
    QuizItem(id: '${_femaleDesireTypeId}_toys_16', name: '扩张器', categoryId: '${_femaleDesireTypeId}_toys', description: '插进骚穴或肛门后打开,小穴被撑开展示内壁'),
    QuizItem(id: '${_femaleDesireTypeId}_toys_17', name: '手铐脚铐', categoryId: '${_femaleDesireTypeId}_toys', description: '手脚被铐住无法动弹,只能被动等待被男人操'),
    QuizItem(id: '${_femaleDesireTypeId}_toys_18', name: '口球', categoryId: '${_femaleDesireTypeId}_toys', description: '嘴里塞着口球无法说话,只能呻吟着被大鸡巴操'),
    QuizItem(id: '${_femaleDesireTypeId}_toys_19', name: '眼罩', categoryId: '${_femaleDesireTypeId}_toys', description: '眼睛被蒙住看不见,其他感官变敏感,被摸骚逼更刺激'),
    QuizItem(id: '${_femaleDesireTypeId}_toys_20', name: '皮鞭', categoryId: '${_femaleDesireTypeId}_toys', description: '皮鞭抽打屁股和奶子,痛感让骚逼流更多淫水'),
    QuizItem(id: '${_femaleDesireTypeId}_toys_21', name: '调教拍', categoryId: '${_femaleDesireTypeId}_toys', description: '板状道具拍打臀部,屁股被打红后被操更刺激'),
    QuizItem(id: '${_femaleDesireTypeId}_toys_22', name: '滴蜡蜡烛', categoryId: '${_femaleDesireTypeId}_toys', description: '热蜡滴在奶子和骚逼上,烫痛刺激让你淫叫连连'),
    QuizItem(id: '${_femaleDesireTypeId}_toys_23', name: '羽毛挑逗棒', categoryId: '${_femaleDesireTypeId}_toys', description: '轻柔羽毛拂过阴蒂和骚逼,痒痒的撩拨让你湿透'),
    QuizItem(id: '${_femaleDesireTypeId}_toys_24', name: '电击棒', categoryId: '${_femaleDesireTypeId}_toys', description: '低压电流电击阴蒂和乳头,麻痹刺激感让你颤抖'),
    QuizItem(id: '${_femaleDesireTypeId}_toys_25', name: '加热震动棒', categoryId: '${_femaleDesireTypeId}_toys', description: '可加热的震动棒插进骚穴,像真鸡巴一样温热的肉棒'),
    QuizItem(id: '${_femaleDesireTypeId}_toys_26', name: '喷水假阳具', categoryId: '${_femaleDesireTypeId}_toys', description: '能喷出液体的假鸡巴,插在骚穴里模仿射精的快感'),
    QuizItem(id: '${_femaleDesireTypeId}_toys_27', name: '穿戴式假阳具', categoryId: '${_femaleDesireTypeId}_toys', description: '绑在身上的假鸡巴,和闺蜜互相插入对方骚穴'),
    QuizItem(id: '${_femaleDesireTypeId}_toys_28', name: '真空吸引器', categoryId: '${_femaleDesireTypeId}_toys', description: '吸附在阴蒂上吮吸,小肉豆被吸得肿胀敏感'),
    QuizItem(id: '${_femaleDesireTypeId}_toys_29', name: '情趣丝袜', categoryId: '${_femaleDesireTypeId}_toys', description: '性感的开裆丝袜,露出湿淋淋的骚逼方便被操'),
    QuizItem(id: '${_femaleDesireTypeId}_toys_30', name: '情趣内衣', categoryId: '${_femaleDesireTypeId}_toys', description: '透明蕾丝内衣,露出奶子和骚逼诱惑男人操'),
    QuizItem(id: '${_femaleDesireTypeId}_toys_31', name: '角色扮演服装', categoryId: '${_femaleDesireTypeId}_toys', description: '护士、女仆、学生装,穿着制服被男人操更淫荡'),
    QuizItem(id: '${_femaleDesireTypeId}_toys_32', name: 'SM项圈', categoryId: '${_femaleDesireTypeId}_toys', description: '脖子上戴着项圈,象征自己是主人的性奴母狗'),
    QuizItem(id: '${_femaleDesireTypeId}_toys_33', name: '尾巴肛塞', categoryId: '${_femaleDesireTypeId}_toys', description: '带尾巴的肛塞插进肛门,像母狗一样摇尾巴求操'),
    QuizItem(id: '${_femaleDesireTypeId}_toys_34', name: '润滑液', categoryId: '${_femaleDesireTypeId}_toys', description: '润滑液润滑骚穴和肛门,大鸡巴更顺滑地插进来'),
    QuizItem(id: '${_femaleDesireTypeId}_toys_35', name: '情趣骰子', categoryId: '${_femaleDesireTypeId}_toys', description: '掷出什么姿势就怎么被操,增加游戏的淫荡乐趣'),
    QuizItem(id: '${_femaleDesireTypeId}_toys_36', name: '性爱秋千', categoryId: '${_femaleDesireTypeId}_toys', description: '悬挂式秋千上被操,各种姿势让鸡巴插得更深'),
    QuizItem(id: '${_femaleDesireTypeId}_toys_37', name: '体位枕', categoryId: '${_femaleDesireTypeId}_toys', description: '专用枕头垫在屁股下,骚穴翘得更高方便被插'),
    QuizItem(id: '${_femaleDesireTypeId}_toys_38', name: '冰火拉珠', categoryId: '${_femaleDesireTypeId}_toys', description: '冰凉或烫热的拉珠插进骚穴,温度刺激带来特殊快感'),
    QuizItem(id: '${_femaleDesireTypeId}_toys_39', name: '水晶拉珠', categoryId: '${_femaleDesireTypeId}_toys', description: '玻璃材质的拉珠插进小穴,光滑坚硬刺激阴道内壁'),
    QuizItem(id: '${_femaleDesireTypeId}_toys_40', name: '震动拉珠', categoryId: '${_femaleDesireTypeId}_toys', description: '带震动的拉珠插进骚穴,双重刺激让你疯狂高潮'),
  ];

  static final List<QuizItem> _femaleDesireOpennessItems = [
    QuizItem(id: '${_femaleDesireTypeId}_openness_01', name: '和朋友讨论性话题', categoryId: '${_femaleDesireTypeId}_openness', description: '乐于和闺蜜分享被大鸡巴操的经验,讨论哪种姿势被插得更深'),
    QuizItem(id: '${_femaleDesireTypeId}_openness_02', name: '主动约炮', categoryId: '${_femaleDesireTypeId}_openness', description: '主动寻找粗大的鸡巴来填满骚穴,满足被操的需求'),
    QuizItem(id: '${_femaleDesireTypeId}_openness_03', name: '接受绿帽癖老公', categoryId: '${_femaleDesireTypeId}_openness', description: '愿意当着老公的面被别的男人用大肉棒狠狠操'),
    QuizItem(id: '${_femaleDesireTypeId}_openness_04', name: '接受多人运动', categoryId: '${_femaleDesireTypeId}_openness', description: '愿意同时被多根大鸡巴轮流插入嘴巴、骚穴、肛门'),
    QuizItem(id: '${_femaleDesireTypeId}_openness_05', name: '接受开放关系', categoryId: '${_femaleDesireTypeId}_openness', description: '可以同时和多个男人做爱,让不同的肉棒插进骚逼'),
    QuizItem(id: '${_femaleDesireTypeId}_openness_06', name: '喜欢被调教', categoryId: '${_femaleDesireTypeId}_openness', description: '享受被主人用大鸡巴训练,变成只会求操的母狗'),
    QuizItem(id: '${_femaleDesireTypeId}_openness_07', name: '喜欢调教别人', categoryId: '${_femaleDesireTypeId}_openness', description: '享受支配男人,用假鸡巴插进他的肛门里调教'),
    QuizItem(id: '${_femaleDesireTypeId}_openness_08', name: '接受角色扮演', categoryId: '${_femaleDesireTypeId}_openness', description: '愿意穿各种制服,扮演护士女仆被男人操'),
    QuizItem(id: '${_femaleDesireTypeId}_openness_09', name: '喜欢公共场合刺激', categoryId: '${_femaleDesireTypeId}_openness', description: '享受在公众场所被摸骚逼,大鸡巴隐秘地插进来'),
    QuizItem(id: '${_femaleDesireTypeId}_openness_10', name: '有露出癖倾向', categoryId: '${_femaleDesireTypeId}_openness', description: '想要在他人面前暴露奶子和骚逼,展示被操的淫样'),
    QuizItem(id: '${_femaleDesireTypeId}_openness_11', name: '喜欢拍照记录', categoryId: '${_femaleDesireTypeId}_openness', description: '愿意拍下被大鸡巴插进骚穴的照片,留下淫荡证据'),
    QuizItem(id: '${_femaleDesireTypeId}_openness_12', name: '喜欢录视频', categoryId: '${_femaleDesireTypeId}_openness', description: '享受拍摄自己被肉棒狠狠抽插的视频,反复观看'),
    QuizItem(id: '${_femaleDesireTypeId}_openness_13', name: '尝试肛门刺激', categoryId: '${_femaleDesireTypeId}_openness', description: '愿意尝试被大鸡巴插进肛门里,体验肛交的刺激'),
    QuizItem(id: '${_femaleDesireTypeId}_openness_14', name: '尝试双重刺激', categoryId: '${_femaleDesireTypeId}_openness', description: '同时被插入骚穴和肛门,两个小穴都被大肉棒填满'),
    QuizItem(id: '${_femaleDesireTypeId}_openness_15', name: '接受SM调教', categoryId: '${_femaleDesireTypeId}_openness', description: '愿意被绑起来鞭打,然后被大鸡巴在痛苦中操到高潮'),
    QuizItem(id: '${_femaleDesireTypeId}_openness_16', name: '接受束缚play', categoryId: '${_femaleDesireTypeId}_openness', description: '享受被绑缚无法动弹,只能被动等待被肉棒插进来'),
    QuizItem(id: '${_femaleDesireTypeId}_openness_17', name: '接受滴蜡play', categoryId: '${_femaleDesireTypeId}_openness', description: '体验热蜡滴在奶子和骚逼上,痛苦中被大鸡巴操'),
    QuizItem(id: '${_femaleDesireTypeId}_openness_18', name: '接受电击刺激', categoryId: '${_femaleDesireTypeId}_openness', description: '尝试电流电击阴蒂和乳头,麻痹刺激中被操高潮'),
    QuizItem(id: '${_femaleDesireTypeId}_openness_19', name: '接受异族性爱', categoryId: '${_femaleDesireTypeId}_openness', description: '对黑人、白人的大鸡巴都很开放,想被不同肉棒操'),
    QuizItem(id: '${_femaleDesireTypeId}_openness_20', name: '接受年龄差距', categoryId: '${_femaleDesireTypeId}_openness', description: '不介意被年轻小帅或成熟大叔的鸡巴插进骚穴'),
    QuizItem(id: '${_femaleDesireTypeId}_openness_21', name: '尝试同性体验', categoryId: '${_femaleDesireTypeId}_openness', description: '愿意和闺蜜互相摸骚逼,用假鸡巴插入对方小穴'),
    QuizItem(id: '${_femaleDesireTypeId}_openness_22', name: '接受3P体验', categoryId: '${_femaleDesireTypeId}_openness', description: '愿意尝试三人性爱,前后都被大鸡巴同时插入'),
    QuizItem(id: '${_femaleDesireTypeId}_openness_23', name: '接受性爱派对', categoryId: '${_femaleDesireTypeId}_openness', description: '对多人性聚会有兴趣,被一群男人轮流用肉棒操'),
    QuizItem(id: '${_femaleDesireTypeId}_openness_24', name: '分享性爱视频', categoryId: '${_femaleDesireTypeId}_openness', description: '愿意分享自己被大鸡巴操的视频,让别人看淫样'),
    QuizItem(id: '${_femaleDesireTypeId}_openness_25', name: '接受性爱直播', categoryId: '${_femaleDesireTypeId}_openness', description: '愿意在线直播被男人操,让观众看骚穴被肉棒插入'),
  ];

  // 女M自测数据
  static const String _femaleMTypeId = 'female_m';
  
  static final QuizType femaleMQuizType = QuizType(
    id: _femaleMTypeId,
    name: '女M自测',
    description: '探索你内心深处的服从倾向，了解自己在D/s关系中的偏好和边界',
    iconPath: 'assets/icons/female_m.png',
    categories: _femaleMCategories,
  );

  static final List<QuizCategory> _femaleMCategories = [
    QuizCategory(
      id: '${_femaleMTypeId}_xingnv',
      name: '性奴',
      quizTypeId: _femaleMTypeId,
      items: _xingnvItems,
    ),
    QuizCategory(
      id: '${_femaleMTypeId}_quannv',
      name: '犬奴',
      quizTypeId: _femaleMTypeId,
      items: _quannvItems,
    ),
    QuizCategory(
      id: '${_femaleMTypeId}_wanounv',
      name: '玩偶奴',
      quizTypeId: _femaleMTypeId,
      items: _wanounvItems,
    ),
    QuizCategory(
      id: '${_femaleMTypeId}_yenv',
      name: '野奴',
      quizTypeId: _femaleMTypeId,
      items: _yenvItems,
    ),
    QuizCategory(
      id: '${_femaleMTypeId}_rounv',
      name: '肉奴',
      quizTypeId: _femaleMTypeId,
      items: _rounvItems,
    ),
  ];

  static final List<QuizItem> _xingnvItems = [
    QuizItem(
      id: '${_femaleMTypeId}_xingnv_01', 
      name: '喜欢被绑起来', 
      categoryId: '${_femaleMTypeId}_xingnv',
      description: '双手被绳子绑在背后,双腿被绑带固定张开,整个身体都失去自由只能任由主人摆弄,骚穴被玩弄得淫水直流',

    ),



    QuizItem(
      id: '${_femaleMTypeId}_xingnv_02', 
      name: '喜欢被蒙眼', 
      categoryId: '${_femaleMTypeId}_xingnv',
      description: '眼睛被黑色眼罩蒙住什么都看不见,不知道主人会对自己的身体做什么,奶子和骚穴被摸被玩弄时更加敏感刺激',

    ),



    QuizItem(
      id: '${_femaleMTypeId}_xingnv_03', 
      name: '喜欢被堵嘴', 
      categoryId: '${_femaleMTypeId}_xingnv',
      description: '嘴巴被口球堵住说不出话只能发出呜呜声,想求饶也说不出来,只能用骚叫声和扭动的身体表达被操得有多爽',

    ),



    QuizItem(
      id: '${_femaleMTypeId}_xingnv_04', 
      name: '愿意被鞭打', 
      categoryId: '${_femaleMTypeId}_xingnv',
      description: '屁股和奶子被皮鞭狠狠抽打,留下一道道红痕,痛得叫出声来但骚穴却越打越湿,在疼痛中体验被主人惩罚的快感',

    ),



    QuizItem(
      id: '${_femaleMTypeId}_xingnv_05', 
      name: '喜欢被命令跪下', 
      categoryId: '${_femaleMTypeId}_xingnv',
      description: '听到命令立刻跪在主人面前,张开嘴伸出舌头等着被使用,跪着的姿势让骚穴更加暴露在主人面前任由玩弄',

    ),



    QuizItem(
      id: '${_femaleMTypeId}_xingnv_06', 
      name: '接受高潮控制', 
      categoryId: '${_femaleMTypeId}_xingnv',
      description: '骚穴被玩弄得快要高潮时必须憋住不能高潮,只有主人同意才能爽,不然就要接受惩罚,高潮的权利完全被主人控制',

    ),



    QuizItem(
      id: '${_femaleMTypeId}_xingnv_07', 
      name: '喜欢被禁止说话', 
      categoryId: '${_femaleMTypeId}_xingnv',
      description: '被鸡巴插进骚穴里狠狠操也不能发出声音,只能咬着嘴唇忍受,一旦叫出来就会被惩罚,说话的权利都被剥夺',

    ),



    QuizItem(
      id: '${_femaleMTypeId}_xingnv_08', 
      name: '接受身体检查', 
      categoryId: '${_femaleMTypeId}_xingnv',
      description: '双腿被掰开让主人仔细检查骚穴里面,手指伸进去摸索,连最羞耻的部位都被看得一清二楚,在羞耻中被完全占有',

    ),



    QuizItem(
      id: '${_femaleMTypeId}_xingnv_09', 
      name: '愿意被展示', 
      categoryId: '${_femaleMTypeId}_xingnv',
      description: '在主人面前脱光衣服展示身体,奶子和骚穴都暴露出来任人观看,在被注视的羞耻感中体验服从带来的快感',

    ),



    QuizItem(
      id: '${_femaleMTypeId}_xingnv_10', 
      name: '喜欢被固定', 
      categoryId: '${_femaleMTypeId}_xingnv',
      description: '手脚被固定在床上或椅子上动弹不得,身体完全失去控制,骚穴被玩具插着不停震动,只能被动承受主人的调教',

    ),



    QuizItem(
      id: '${_femaleMTypeId}_xingnv_11', 
      name: '接受乳头调教', 
      categoryId: '${_femaleMTypeId}_xingnv',
      description: '奶子上的乳头被夹子夹住,被手指用力捏住拉扯,又痛又爽的感觉让骚穴流出更多淫水,在痛感中服从主人',

    ),



    QuizItem(
      id: '${_femaleMTypeId}_xingnv_12', 
      name: '喜欢被羞辱', 
      categoryId: '${_femaleMTypeId}_xingnv',
      description: '被骂成淫荡的骚货、下贱的母狗,被吐口水践踏尊严,越是被羞辱骚穴越湿,在被贬低中反而感到兴奋和快感',

    ),



    QuizItem(
      id: '${_femaleMTypeId}_xingnv_13', 
      name: '愿意穿戴项圈', 
      categoryId: '${_femaleMTypeId}_xingnv',
      description: '脖子上戴着刻有主人名字的项圈,时刻提醒自己是主人的性奴,是专门用来被操的骚母狗,完全属于主人所有',

    ),



    QuizItem(
      id: '${_femaleMTypeId}_xingnv_14', 
      name: '接受禁止高潮惩罚', 
      categoryId: '${_femaleMTypeId}_xingnv',
      description: '骚穴被玩弄了很久却不让高潮,憋得难受想要被操但不被允许,只能在欲求不满中忍受,体验主人对身体的绝对控制',

    ),



    QuizItem(
      id: '${_femaleMTypeId}_xingnv_15', 
      name: '喜欢被拍照记录', 
      categoryId: '${_femaleMTypeId}_xingnv',
      description: '被鸡巴插入骚穴时的淫荡表情被拍下来,跪着舔主人的照片被录下来,留下自己下贱服从的证据让羞耻感更强烈',


  ),

  ];

  static final List<QuizItem> _quannvItems = [
    QuizItem(
      id: '${_femaleMTypeId}_quannv_01', 
      name: '愿意爬行', 
      categoryId: '${_femaleMTypeId}_quannv',
      description: '像母狗一样四肢着地爬行,奶子摆动着屁股翘起,在爬行中体验作为主人宠物的服从和羞耻',

    ),



    QuizItem(
      id: '${_femaleMTypeId}_quannv_02', 
      name: '愿意用狗碗吃饭', 
      categoryId: '${_femaleMTypeId}_quannv',
      description: '跪在地上把脸埋在狗碗里,像母狗那样不用手只用嘴巴舔着吃喝,跪着的姿势让骚穴暴露在空中无比下贱',

    ),



    QuizItem(
      id: '${_femaleMTypeId}_quannv_03', 
      name: '愿意学狗叫', 
      categoryId: '${_femaleMTypeId}_quannv',
      description: '被命令说话就发出汪汪汪的狗叫声,失去人类语言能力只会像发情的母狗那样叫,在完全的宠物化中体验羞耻',

    ),



    QuizItem(
      id: '${_femaleMTypeId}_quannv_04', 
      name: '接受戴狗尾巴', 
      categoryId: '${_femaleMTypeId}_quannv',
      description: '粗大的肛塞尾巴被插进肛门里,尾巴在身后摇摆,让自己从外观上完全变成一只淫荡的母狗',

    ),



    QuizItem(
      id: '${_femaleMTypeId}_quannv_05', 
      name: '愿意被牵绳遛', 
      categoryId: '${_femaleMTypeId}_quannv',
      description: '脖子上的项圈被绳子牵着,像真正的母狗那样爬行跟在主人身后,在别人眼里就是一只下贱的宠物',

    ),



    QuizItem(
      id: '${_femaleMTypeId}_quannv_06', 
      name: '喜欢被抚摸', 
      categoryId: '${_femaleMTypeId}_quannv',
      description: '像抚摸宠物狗那样被主人轻轻摸头,爬到主人腿边蹭主人的手,在温柔的抚摸中感受作为母狗的幸福',

    ),



    QuizItem(
      id: '${_femaleMTypeId}_quannv_07', 
      name: '愿意舔主人', 
      categoryId: '${_femaleMTypeId}_quannv',
      description: '像母狗那样伸出舌头舔主人的脚趾、脚心甚至鸡巴,用舌头清洁和娱乐主人,表达母狗对主人的忠诚',

    ),



    QuizItem(
      id: '${_femaleMTypeId}_quannv_08', 
      name: '接受关笼子', 
      categoryId: '${_femaleMTypeId}_quannv',
      description: '不听话的时候被关进狭小的笼子里,身体蜷缩在里面动弹不得,只能像真正的母狗那样反省并乖乖等待主人放出来',

    ),



    QuizItem(
      id: '${_femaleMTypeId}_quannv_09', 
      name: '愿意摇尾乞求', 
      categoryId: '${_femaleMTypeId}_quannv',
      description: '跪在地上用力摇摆屁股上的尾巴,用汪汪声向主人乞求食物和奖励,完全进入母狗的角色表演出下贱的样子',

    ),



    QuizItem(
      id: '${_femaleMTypeId}_quannv_10', 
      name: '喜欢趴在脚边', 
      categoryId: '${_femaleMTypeId}_quannv',
      description: '像忠诚的母狗一样跪在主人脚边安静陪伴,头靠着主人的腿,等待主人的抚摸或命令,享受守候的幸福感',
  ),

  ];

  static final List<QuizItem> _wanounvItems = [
    QuizItem(
      id: '${_femaleMTypeId}_wanounv_01', 
      name: '完全服从命令', 
      categoryId: '${_femaleMTypeId}_wanounv',
      description: '主人说什么就做什么,命令张开腿就把骚穴显露出来,命令跪下就张开嘴等着含住鸡巴,不提任何异议完全听话',

    ),



    QuizItem(
      id: '${_femaleMTypeId}_wanounv_02', 
      name: '任由摆弄', 
      categoryId: '${_femaleMTypeId}_wanounv',
      description: '身体被主人摆成各种姿势,跪趴、掰开腿、翻身趴下,像玩偶一样不主动反应,任由鸡巴插入骚穴被使用',

    ),



    QuizItem(
      id: '${_femaleMTypeId}_wanounv_03', 
      name: '保持静止', 
      categoryId: '${_femaleMTypeId}_wanounv',
      description: '长时间保持跪姿不动,或者张开腿像个等待被操的玩偶,成为主人的装饰品和性玩具放在房间里',

    ),



    QuizItem(
      id: '${_femaleMTypeId}_wanounv_04', 
      name: '没有表情', 
      categoryId: '${_femaleMTypeId}_wanounv',
      description: '被鸡巴插入骚穴也不能有表情,被操得再爽也要忍住不能叫,像无生命的玩偶那样面无表情承受一切',

    ),



    QuizItem(
      id: '${_femaleMTypeId}_wanounv_05', 
      name: '接受穿衣打扮', 
      categoryId: '${_femaleMTypeId}_wanounv',
      description: '像换装娃娃一样被主人打扮,穿上性感的情趣内衣或者女仆服装,成为主人的性爱玩具任意装扮',

    ),



    QuizItem(
      id: '${_femaleMTypeId}_wanounv_06', 
      name: '无条件顺从', 
      categoryId: '${_femaleMTypeId}_wanounv',
      description: '对主人的任何要求都无条件接受,要求舔鸡巴就舔,要求跪着被操就跪着,没有自己的意见只是主人的玩具',

    ),



    QuizItem(
      id: '${_femaleMTypeId}_wanounv_07', 
      name: '被动接受调教', 
      categoryId: '${_femaleMTypeId}_wanounv',
      description: '骚穴被鸡巴插入时保持完全被动,不扭动屁股不主动迎合,像玩偶一样躺着任由主人使用身体',

    ),



    QuizItem(
      id: '${_femaleMTypeId}_wanounv_08', 
      name: '失去自主权', 
      categoryId: '${_femaleMTypeId}_wanounv',
      description: '将所有自主权交给主人,从行动到思想都由主人决定,想要被操还是想要高潮都要听主人的,成为完美的性爱玩偶',
  ),

  ];

  static final List<QuizItem> _yenvItems = [
    QuizItem(
      id: '${_femaleMTypeId}_yenv_01', 
      name: '野外羞耻play', 
      categoryId: '${_femaleMTypeId}_yenv',
      description: '在野外或户外被绑着操,骚穴被鸡巴插入却要忍着不能叫出声,在开放空间被调教时随时可能被人发现的紧张刺激',

    ),



    QuizItem(
      id: '${_femaleMTypeId}_yenv_02', 
      name: '公共场合刺激', 
      categoryId: '${_femaleMTypeId}_yenv',
      description: '在公共场合骚穴里塞着遥控跳蛋,主人随时打开开关让骚穴震动,要忍着不能叫出声不能被人看出来,体验被发现的恐惧和兴奋',

    ),



    QuizItem(
      id: '${_femaleMTypeId}_yenv_03', 
      name: '户外露出', 
      categoryId: '${_femaleMTypeId}_yenv',
      description: '在户外被要求露出奶子或脱下内裤露出骚穴,在可能被人看到的环境中暴露身体感受刺激和羞耻',

    ),



    QuizItem(
      id: '${_femaleMTypeId}_yenv_04', 
      name: '车内调教', 
      categoryId: '${_femaleMTypeId}_yenv',
      description: '在行驶的车内被主人用手指插入骚穴或被鸡巴插入,在移动的半公开空间中承受调教体验兴奋和不安',

    ),



    QuizItem(
      id: '${_femaleMTypeId}_yenv_05', 
      name: '试衣间play', 
      categoryId: '${_femaleMTypeId}_yenv',
      description: '在商场试衣间被主人插入鸡巴快速操几下,或者被要求脱光展示身体,外面有人等候随时可能被发现的刺激',

    ),



    QuizItem(
      id: '${_femaleMTypeId}_yenv_06', 
      name: '遥控玩具外出', 
      categoryId: '${_femaleMTypeId}_yenv',
      description: '在外出时骚穴里塞着遥控振动棒或跳蛋,主人拿着遥控器随时控制开关,在公众场合忍受骚穴被刺激的感觉',

    ),



    QuizItem(
      id: '${_femaleMTypeId}_yenv_07', 
      name: '楼梯间调教', 
      categoryId: '${_femaleMTypeId}_yenv',
      description: '在楼梯间被主人推倒墙上抽插几下,或者在电梯里骚穴被手指插入,在半开放空间随时可能被打断的紧张中承受调教',

    ),



    QuizItem(
      id: '${_femaleMTypeId}_yenv_08', 
      name: '公园隐蔽角落', 
      categoryId: '${_femaleMTypeId}_yenv',
      description: '在公园的隐蔽角落被主人插入鸡巴操弄,或者跪下给主人口交,在自然环境中进行性爱感受原始刺激',

    ),



    QuizItem(
      id: '${_femaleMTypeId}_yenv_09', 
      name: '酒店走廊露出', 
      categoryId: '${_femaleMTypeId}_yenv',
      description: '在酒店走廊被主人要求脱光衣服露出奶子和骚穴,或者跪下被操,在公共区域进行调教体验被发现的恐惧和兴奋',

    ),



    QuizItem(
      id: '${_femaleMTypeId}_yenv_10', 
      name: '电影院刺激', 
      categoryId: '${_femaleMTypeId}_yenv',
      description: '在黑暗的电影院中骚穴被主人用手指插入玩弄,或者跪在座位下给主人口交,在人群中保持安静不能发出声音',


  ),

  ];

  static final List<QuizItem> _rounvItems = [
    QuizItem(
      id: '${_femaleMTypeId}_rounv_01', 
      name: '接受身体改造', 
      categoryId: '${_femaleMTypeId}_rounv',
      description: '愿意在身体上穿刺、纹身或烙印,奶子上被穿刺乳环、阴唇上被穿上环,甚至在骚穴旁纹上主人的名字留下永久标记',

    ),



    QuizItem(
      id: '${_femaleMTypeId}_rounv_02', 
      name: '完全物化', 
      categoryId: '${_femaleMTypeId}_rounv',
      description: '被当作一块肉、一个性爱工具对待,失去人格只是一个供主人用来发泄性欲的肉体工具,骚穴随时被鸡巴插入使用',

    ),



    QuizItem(
      id: '${_femaleMTypeId}_rounv_03', 
      name: '接受身体标记', 
      categoryId: '${_femaleMTypeId}_rounv',
      description: '在身体上用记号笔写上“性奴”“骚货”等文字,或者用纹身在屁股、奶子、骚穴旁留下主人的标记,宣示所有权关系',

    ),



    QuizItem(
      id: '${_femaleMTypeId}_rounv_04', 
      name: '被当作家具', 
      categoryId: '${_femaleMTypeId}_rounv',
      description: '身体被当作桌子或椅子使用,跪在地上背上放东西,或者跪着让主人坐在身上,完全物化失去人的尊严',

    ),



    QuizItem(
      id: '${_femaleMTypeId}_rounv_05', 
      name: '接受极限扩张', 
      categoryId: '${_femaleMTypeId}_rounv',
      description: '骚穴和肛门被用越来越粗的鸡巴或玩具扩张,接受对身体孔洞的极限扩张训练,突破身体极限为主人服务',

    ),



    QuizItem(
      id: '${_femaleMTypeId}_rounv_06', 
      name: '长期佩戴玩具', 
      categoryId: '${_femaleMTypeId}_rounv',
      description: '骚穴里长时间塞着振动棒或者肛塞,肛门里也被插入玩具,持续感受被占有和填满的状态',

    ),



    QuizItem(
      id: '${_femaleMTypeId}_rounv_07', 
      name: '接受多人使用', 
      categoryId: '${_femaleMTypeId}_rounv',
      description: '在主人许可下骚穴被多个鸡巴轮流插入,像工具一样被多人轮流占有使用,骚穴被操得流出淫水和精液',

    ),



    QuizItem(
      id: '${_femaleMTypeId}_rounv_08', 
      name: '成为泄欲工具', 
      categoryId: '${_femaleMTypeId}_rounv',
      description: '纯粹作为主人泄欲的工具存在,主人想操就把鸡巴插进骚穴,不考虑自己的感受和需求只为了让主人爽',

    ),



    QuizItem(
      id: '${_femaleMTypeId}_rounv_09', 
      name: '接受极限调教', 
      categoryId: '${_femaleMTypeId}_rounv',
      description: '愿意接受突破身心极限的调教,骚穴被多个鸡巴同时插入,或者被鸡巴插着同时被鞭打,在痛苦和快感的边缘体验极致服从',

    ),



    QuizItem(
      id: '${_femaleMTypeId}_rounv_10', 
      name: '永久性改变', 
      categoryId: '${_femaleMTypeId}_rounv',
      description: '接受对身体进行永久性改变,如在阴唇、乳头穿刺永久性环,在身体上纹上永久标记,甚至接受器官改造,彻底成为主人的所有物',


  ),

  ];

  // 男M自测数据
  static const String _maleMTypeId = 'male_m';
  
  static final QuizType maleMQuizType = QuizType(
    id: _maleMTypeId,
    name: '男M自测',
    description: '探索你内心深处的服从倾向，了解自己在D/s关系中的偏好和边界',
    iconPath: 'assets/icons/male_m.png',
    categories: _maleMCategories,
  );

  static final List<QuizCategory> _maleMCategories = [
    QuizCategory(
      id: '${_maleMTypeId}_base',
      name: '基础M性',
      quizTypeId: _maleMTypeId,
      items: _maleMBaseItems,
    ),
    QuizCategory(
      id: '${_maleMTypeId}_submission',
      name: '服从倾向',
      quizTypeId: _maleMTypeId,
      items: _maleMSubmissionItems,
    ),
    QuizCategory(
      id: '${_maleMTypeId}_worship',
      name: '崇拜服侍',
      quizTypeId: _maleMTypeId,
      items: _maleMWorshipItems,
    ),
    QuizCategory(
      id: '${_maleMTypeId}_humiliation',
      name: '羞辱训练',
      quizTypeId: _maleMTypeId,
      items: _maleMHumiliationItems,
    ),
    QuizCategory(
      id: '${_maleMTypeId}_control',
      name: '控制与约束',
      quizTypeId: _maleMTypeId,
      items: _maleMControlItems,
    ),
    QuizCategory(
      id: '${_maleMTypeId}_pain',
      name: '痛感体验',
      quizTypeId: _maleMTypeId,
      items: _maleMPainItems,
    ),
    QuizCategory(
      id: '${_maleMTypeId}_chastity',
      name: '贞操管理',
      quizTypeId: _maleMTypeId,
      items: _maleMChastityItems,
    ),
    QuizCategory(
      id: '${_maleMTypeId}_extreme',
      name: '极限训练',
      quizTypeId: _maleMTypeId,
      items: _maleMExtremeItems,
    ),
  ];

  static final List<QuizItem> _maleMBaseItems = [
    QuizItem(
      id: '${_maleMTypeId}_base_01', 
      name: '喜欢被支配', 
      categoryId: '${_maleMTypeId}_base',
      description: '享受被女主人支配和控制,听从女主人命令跪下就立刻跪下,被要求舔脚就伸出舌头,鸡巴在服从中硬得发胀体验臣服快感',

    ),



    QuizItem(
      id: '${_maleMTypeId}_base_02', 
      name: '喜欢被命令', 
      categoryId: '${_maleMTypeId}_base',
      description: '喜欢接受女主人的命令,被命令脱光衣服就立刻脱光,被命令张开嘴就张开等着,按照她的要求行动在服从中获得满足',

    ),



    QuizItem(
      id: '${_maleMTypeId}_base_03', 
      name: '愿意跪下服务', 
      categoryId: '${_maleMTypeId}_base',
      description: '听到命令立刻跪在女主人面前服务,低着头等待指示,用嘴舔她的脚趾或者骚穴,在低姿态中体验服从和臣服',

    ),



    QuizItem(
      id: '${_maleMTypeId}_base_04', 
      name: '享受被呼来唤去', 
      categoryId: '${_maleMTypeId}_base',
      description: '喜欢被女主人随意呼唤差遣,叫一声就立刻跑过去,让干什么就干什么,在被需要中感受作为奴隶的价值',

    ),



    QuizItem(
      id: '${_maleMTypeId}_base_05', 
      name: '愿意放弃主导权', 
      categoryId: '${_maleMTypeId}_base',
      description: '主动放弃主导地位把控制权交给女主人,让她决定什么时候能硬什么时候能射,享受被领导和被掌控的感觉',

    ),



    QuizItem(
      id: '${_maleMTypeId}_base_06', 
      name: '喜欢被教训', 
      categoryId: '${_maleMTypeId}_base',
      description: '接受女主人的教训和规训,做错事就跪下挨骂挨打,鸡巴却在被教训中硬起来,在被纠正中体验服从快感',

    ),



    QuizItem(
      id: '${_maleMTypeId}_base_07', 
      name: '享受服从快感', 
      categoryId: '${_maleMTypeId}_base',
      description: '从服从和听话中获得真正快感,被女主人命令做什么就做什么,不需要自己思考和主导反而感到轻松满足',

    ),



    QuizItem(
      id: '${_maleMTypeId}_base_08', 
      name: '接受女性领导', 
      categoryId: '${_maleMTypeId}_base',
      description: '愿意在关系中接受女主人的领导,认可她的权威和决定,把她当成主人崇拜和服从,鸡巴只为她硬',


  ),

  ];

  static final List<QuizItem> _maleMSubmissionItems = [
    QuizItem(
      id: '${_maleMTypeId}_submission_01',
      name: '愿意称呼女王/主人',
      categoryId: '${_maleMTypeId}_submission',
      description: '接受用尊称称呼女主人,称呼她为女王、主人、主母,跪下低着头呼喊女王主人,明确主仆关系和自己的奴隶身份',

    ),



    QuizItem(
      id: '${_maleMTypeId}_submission_02',
      name: '听从一切命令',
      categoryId: '${_maleMTypeId}_submission',
      description: '愿意无条件服从女主人的所有命令,让跪下就跪下,让舔就舔,让脱就脱,不质疑不反抗完全听话',

    ),



    QuizItem(
      id: '${_maleMTypeId}_submission_03',
      name: '接受地位降格',
      categoryId: '${_maleMTypeId}_submission',
      description: '接受在关系中的低下地位,乐于成为女主人的仆人或奴隶,跪在她脚下服侍,被当成狗对待也感到兴奋',

    ),



    QuizItem(
      id: '${_maleMTypeId}_submission_04',
      name: '主动请求调教',
      categoryId: '${_maleMTypeId}_submission',
      description: '主动向女主人请求调教和管教,跪下乞求女王调教自己,希望被鞭打被羞辱,表达服从的愿望和渴望',

    ),



    QuizItem(
      id: '${_maleMTypeId}_submission_05',
      name: '乐于承担家务',
      categoryId: '${_maleMTypeId}_submission',
      description: '愿意承担所有家务和杂事,做饭洗衣拖地洗厕所,通过服务表达服从,在为女主人干活中体验奴隶的价值',

    ),



    QuizItem(
      id: '${_maleMTypeId}_submission_06',
      name: '接受心理控制',
      categoryId: '${_maleMTypeId}_submission',
      description: '愿意接受女主人对自己的心理和精神控制,在思想上也服从,把自己的一切都交给女主人掌控',

    ),



    QuizItem(
      id: '${_maleMTypeId}_submission_07',
      name: '愿意放弃决定权',
      categoryId: '${_maleMTypeId}_submission',
      description: '将大小事情的决定权都交给女主人,完全依赖她的判断,什么时候能射什么时候不能射都由她决定',

    ),



    QuizItem(
      id: '${_maleMTypeId}_submission_08',
      name: '享受被支配感',
      categoryId: '${_maleMTypeId}_submission',
      description: '从被女主人完全支配和控制中获得深刻快感,被她掌控鸡巴是否能硬能射,在被支配中找到安全感',

    ),



    QuizItem(
      id: '${_maleMTypeId}_submission_09',
      name: '接受规则约束',
      categoryId: '${_maleMTypeId}_submission',
      description: '愿意遵守女主人制定的各种规则,什么能做什么不能做都听她的,在约束和规则中找到归属感',

    ),



    QuizItem(
      id: '${_maleMTypeId}_submission_10',
      name: '乐于汇报行踪',
      categoryId: '${_maleMTypeId}_submission',
      description: '主动向女主人汇报自己的行踪和活动,接受她的监督,让她知道自己每时每刻在哪里干什么',


  ),

  ];

  static final List<QuizItem> _maleMWorshipItems = [
    QuizItem(
      id: '${_maleMTypeId}_worship_01',
      name: '崇拜女性身体',
      categoryId: '${_maleMTypeId}_worship',
      description: '对女主人的身体抱有崇拜的态度,愿意用各种方式服侍和取悦,用舌头舔她的身体,用鸡巴让她爽',

    ),



    QuizItem(
      id: '${_maleMTypeId}_worship_02',
      name: '愿意舔脚跪拜',
      categoryId: '${_maleMTypeId}_worship',
      description: '跪在地上低着头亲吻女主人的脚,伸出舌头舔她的脚趾和脚心,用嘴唇亲吸她的脚趾,表达崇敬和服从',

    ),



    QuizItem(
      id: '${_maleMTypeId}_worship_03',
      name: '乐于口交服务',
      categoryId: '${_maleMTypeId}_worship',
      description: '享受用口舌为女主人提供快感,跪在她腿间伸出舌头舔她的骚穴,用舌头刺激她的阴蒂,从服侍中获得满足',

    ),



    QuizItem(
      id: '${_maleMTypeId}_worship_04',
      name: '崇拜女性权威',
      categoryId: '${_maleMTypeId}_worship',
      description: '内心真正崇拜女主人的权威和地位,愿意为她付出一切,把她当成女王和神明一样崇拜服从',

    ),



    QuizItem(
      id: '${_maleMTypeId}_worship_05',
      name: '愿意洗脚按摩',
      categoryId: '${_maleMTypeId}_worship',
      description: '主动跪在地上为女主人洗脚按摩,用手轻轻揉她的脚,然后低头亲吻她的脚趾,通过细致服务表达崇敬',

    ),



    QuizItem(
      id: '${_maleMTypeId}_worship_06',
      name: '舔阴服侍',
      categoryId: '${_maleMTypeId}_worship',
      description: '跪在女主人腿间伸出舌头舔她的骚穴,用舌头舔她的阴蒂和阴道,长时间服侍直到她满意高潮',

    ),



    QuizItem(
      id: '${_maleMTypeId}_worship_07',
      name: '崇拜女性高潮',
      categoryId: '${_maleMTypeId}_worship',
      description: '以使女主人达到高潮为最高目标,把她的快感放在首位,用舌头用鸡巴让她爽到高潮就是自己最大的荣耀',

    ),



    QuizItem(
      id: '${_maleMTypeId}_worship_08',
      name: '为女性洗澡',
      categoryId: '${_maleMTypeId}_worship',
      description: '跪在浴室里用双手为女主人洗澡,用手仔细清洁她身体的每一处,轻轻揉奶子和清洗骚穴,享受服侍女王的感觉',

    ),



    QuizItem(
      id: '${_maleMTypeId}_worship_09',
      name: '亲吻女性身体',
      categoryId: '${_maleMTypeId}_worship',
      description: '享受亲吻和爱抚女主人身体的每一处,亲吻她的脚趾、大腿、奶子、骚穴,用舌头舔她的身体,表达崇敬和渴望',

    ),



    QuizItem(
      id: '${_maleMTypeId}_worship_10',
      name: '崇拜跨坐',
      categoryId: '${_maleMTypeId}_worship',
      description: '享受女主人坐在自己脸上,用骚穴压着自己的脸,伸出舌头舔她的骚穴,用口舌为她服务直到高潮',


  ),
  ];




  static final List<QuizItem> _maleMHumiliationItems = [
    QuizItem(
      id: '${_maleMTypeId}_humiliation_01',
      name: '接受言语羞辱',
      categoryId: '${_maleMTypeId}_humiliation',
      description: '从女主人的言语羞辱中获得兴奋,被骂成废物、小鸡鸡、下贱的狗,享受被贬低的感觉,鸡巴却在羞辱中硬起来',

    ),



    QuizItem(
      id: '${_maleMTypeId}_humiliation_02',
      name: '接受小鸡鸡羞辱',
      categoryId: '${_maleMTypeId}_humiliation',
      description: '接受女主人对自己鸡巴尺寸的嘲笑和羞辱,被骂小鸡鸡、小鸡巴、根本不够看,从被嘲笑中感受兴奋',

    ),



    QuizItem(
      id: '${_maleMTypeId}_humiliation_03',
      name: '被当众羞辱',
      categoryId: '${_maleMTypeId}_humiliation',
      description: '愿意在他人面前被女主人羞辱,当众被骂成废物和狗,当众跪下被踩在脚下,体验更强烈的羞耻和兴奋',

    ),



    QuizItem(
      id: '${_maleMTypeId}_humiliation_04',
      name: '穿女性内衣',
      categoryId: '${_maleMTypeId}_humiliation',
      description: '接受穿上女性内衣或丝袜,穿着女人的内裤和胸罩被嘲笑,在类女性装扮中体验羞耻和兴奋',

    ),



    QuizItem(
      id: '${_maleMTypeId}_humiliation_05',
      name: '被嘲笑早泄',
      categoryId: '${_maleMTypeId}_humiliation',
      description: '接受女主人对自己持久力的嘲笑,被骂早泄男、一分钟男人、根本没用的废物,从羞辱中获得刺激',

    ),



    QuizItem(
      id: '${_maleMTypeId}_humiliation_06',
      name: '被当作奴隶',
      categoryId: '${_maleMTypeId}_humiliation',
      description: '享受被女主人当作奴隶对待,失去男性尊严,跪在她脚下被当成狗一样踩踏,从被奴役中感到兴奋',

    ),



    QuizItem(
      id: '${_maleMTypeId}_humiliation_07',
      name: '被迫自慰',
      categoryId: '${_maleMTypeId}_humiliation',
      description: '在女主人命令下当着她的面自慰,跪在她面前撸自己的鸡巴,在被监视的羞耻中释放射出来',

    ),



    QuizItem(
      id: '${_maleMTypeId}_humiliation_08',
      name: '被比较尺寸',
      categoryId: '${_maleMTypeId}_humiliation',
      description: '接受被女主人拿来与其他男性比较,鸡巴被比较尺寸被嘲笑太小,持久力被比较被嘲笑,在比较中被贬低反而兴奋',

    ),



    QuizItem(
      id: '${_maleMTypeId}_humiliation_09',
      name: '被嘲笑无用',
      categoryId: '${_maleMTypeId}_humiliation',
      description: '从女主人对自己性能力的嘲笑中获得兴奋,被骂没用的废物、不行的男人、小鸡鸡,从被嘲笑中感到刺激',

    ),



    QuizItem(
      id: '${_maleMTypeId}_humiliation_10',
      name: '被拍照留证',
      categoryId: '${_maleMTypeId}_humiliation',
      description: '接受羞辱过程被拍照或录像,被骂的样子被拍下来,跪着自慰的画面被录下来,增加羞耻和被控制感',


  ),
  ];




  static final List<QuizItem> _maleMControlItems = [
    QuizItem(
      id: '${_maleMTypeId}_control_01',
      name: '被绑缚束缚',
      categoryId: '${_maleMTypeId}_control',
      description: '享受被绳索绑缚失去行动自由,双手被绑在背后双脚被绑开,鸡巴在失去控制中硬起来,在被束缚中体验服从快感',

    ),



    QuizItem(
      id: '${_maleMTypeId}_control_02',
      name: '被蒙眼遮蔽',
      categoryId: '${_maleMTypeId}_control',
      description: '接受被黑色眼罩蒙住眼睛,在视觉被剥夺中不知道女主人会对自己做什么,其他感官变得更加敏感刺激',

    ),



    QuizItem(
      id: '${_maleMTypeId}_control_03',
      name: '被堵嘴禁言',
      categoryId: '${_maleMTypeId}_control',
      description: '嘴巴被口球堵住说不出话只能发出呜呜声,想求饶也说不出来,失去说话能力完全被女主人掌控',

    ),



    QuizItem(
      id: '${_maleMTypeId}_control_04',
      name: '被锁项圈',
      categoryId: '${_maleMTypeId}_control',
      description: '脖子上被锁上项圈和锁链,像狗一样被牵着在地上爬,象征性地表达自己属于女主人的归属和服从',

    ),



    QuizItem(
      id: '${_maleMTypeId}_control_05',
      name: '被固定姿势',
      categoryId: '${_maleMTypeId}_control',
      description: '被固定在特定姿势,跪着或趴着长时间保持不动,身体酸痛也不能动,完全听从女主人的安排',

    ),



    QuizItem(
      id: '${_maleMTypeId}_control_06',
      name: '接受手铐脚铐',
      categoryId: '${_maleMTypeId}_control',
      description: '享受双手被手铐锁住双脚被脚铐锁住,完全失去行动能力,只能跪在地上等待女主人的摆弄',

    ),



    QuizItem(
      id: '${_maleMTypeId}_control_07',
      name: '被关笼子',
      categoryId: '${_maleMTypeId}_control',
      description: '接受被关进狭小的笼子里作为惩罚,像狗一样蜷缩在笼子里,体验被囚禁和被控制的感觉',

    ),



    QuizItem(
      id: '${_maleMTypeId}_control_08',
      name: '被牵绳引导',
      categoryId: '${_maleMTypeId}_control',
      description: '脖子上的项圈被绳子牵着,像宠物狗一样跪着跟在女主人身后,被绳索牵引行走被女主人控制',

    ),



    QuizItem(
      id: '${_maleMTypeId}_control_09',
      name: '接受感官剥夺',
      categoryId: '${_maleMTypeId}_control',
      description: '享受被蒙眼、堵嘴、堵耳朵多种感官同时被剥夺,完全依赖女主人的引导,不知道她会对自己做什么',

    ),



    QuizItem(
      id: '${_maleMTypeId}_control_10',
      name: '被限制自由',
      categoryId: '${_maleMTypeId}_control',
      description: '接受日常生活中的各种限制,什么时候能硬什么时候能射都由女主人决定,在被控制中找到安全感',


  ),
  ];




  static final List<QuizItem> _maleMPainItems = [
    QuizItem(
      id: '${_maleMTypeId}_pain_01',
      name: '接受鞭打惩罚',
      categoryId: '${_maleMTypeId}_pain',
      description: '愿意接受皮鞭、拍子狠狠抽打屁股和身体,留下一道道红痕,鸡巴却在痛感中硬起来,在疼痛中体验快感',

    ),



    QuizItem(
      id: '${_maleMTypeId}_pain_02',
      name: '乳头夹刺激',
      categoryId: '${_maleMTypeId}_pain',
      description: '乳头上被夹上乳夹被用力夹紧,又痛又刺激,鸡巴却在乳头被虐待中硬起来,从痛感中获得特殊刺激',

    ),



    QuizItem(
      id: '${_maleMTypeId}_pain_03',
      name: '被抓揪拍打',
      categoryId: '${_maleMTypeId}_pain',
      description: '享受被女主人用指甲抓身体、揪拉乳头、拍打鸡巴,在被虐待的痛感中感到兴奋和刺激',


  ),
  ];




  static final List<QuizItem> _maleMChastityItems = [
    QuizItem(
      id: '${_maleMTypeId}_chastity_01',
      name: '佩戴贞操锁',
      categoryId: '${_maleMTypeId}_chastity',
      description: '鸡巴被锁上贞操锁完全不能硬不能射,将性权利和鸡巴的控制权完全交给女主人掌控',

    ),



    QuizItem(
      id: '${_maleMTypeId}_chastity_02',
      name: '长期禁欲',
      categoryId: '${_maleMTypeId}_chastity',
      description: '接受长时间被禁止高潮和释放,鸡巴想硬也被锁住,想射也射不出来,在欲求不满中体验被女主人掌控',

    ),



    QuizItem(
      id: '${_maleMTypeId}_chastity_03',
      name: '只有女性可解锁',
      categoryId: '${_maleMTypeId}_chastity',
      description: '贞操锁的钥匙交给女主人保管,只有她才能解锁,鸡巴能不能硬能不能射完全依赖她的决定',

    ),



    QuizItem(
      id: '${_maleMTypeId}_chastity_04',
      name: '被禁止自慰',
      categoryId: '${_maleMTypeId}_chastity',
      description: '接受被完全禁止自慰,鸡巴想硬也不能硬,想射也不能射,只能通过用舌头服侍女主人获得快感',

    ),



    QuizItem(
      id: '${_maleMTypeId}_chastity_05',
      name: '高潮需请示',
      categoryId: '${_maleMTypeId}_chastity',
      description: '鸡巴快要射的时候必须跪下向女主人请示获得许可,不然就要被惩罚,高潮的权利完全被她掌控',

    ),



    QuizItem(
      id: '${_maleMTypeId}_chastity_06',
      name: '接受摧欲游戏',
      categoryId: '${_maleMTypeId}_chastity',
      description: '享受被女主人刺激鸡巴到快要射的边缘后停止,反复折磨不让释放,鸡巴硬得难受却不能射',

    ),



    QuizItem(
      id: '${_maleMTypeId}_chastity_07',
      name: '被控制勃起',
      categoryId: '${_maleMTypeId}_chastity',
      description: '接受女主人对自己勃起的完全控制,她决定什么时候鸡巴可以硬,不让硬就不能硬',

    ),



    QuizItem(
      id: '${_maleMTypeId}_chastity_08',
      name: '接受射精控制',
      categoryId: '${_maleMTypeId}_chastity',
      description: '射精的权利完全交给女主人,她决定什么时候鸡巴可以释放射出来,不让射就只能憋着',

    ),



    QuizItem(
      id: '${_maleMTypeId}_chastity_09',
      name: '禁欲后更顺从',
      categoryId: '${_maleMTypeId}_chastity',
      description: '鸡巴长期被禁欲后自己变得更加顺从和听话,为了能射出来什么都愿意做',

    ),



    QuizItem(
      id: '${_maleMTypeId}_chastity_10',
      name: '享受被掌控感',
      categoryId: '${_maleMTypeId}_chastity',
      description: '从性欲和鸡巴被女主人完全掌控中获得深刻快感,在被掌控中找到安全感和归属感',


  ),
  ];




  static final List<QuizItem> _maleMExtremeItems = [
    QuizItem(
      id: '${_maleMTypeId}_extreme_01',
      name: '被当作宠物',
      categoryId: '${_maleMTypeId}_extreme',
      description: '愿意被完全当作宠物对待,脖子上佩戴项圈跪着用狗碗进食,像狗一样爬行和生活',

    ),



    QuizItem(
      id: '${_maleMTypeId}_extreme_02',
      name: '被迫舔阴',
      categoryId: '${_maleMTypeId}_extreme',
      description: '在命令下跪在女主人腿间伸出舌头舔她的骚穴,用舌头为她提供长时间口交服务直到她高潮',

    ),



    QuizItem(
      id: '${_maleMTypeId}_extreme_03',
      name: '接受肛道训练',
      categoryId: '${_maleMTypeId}_extreme',
      description: '愿意接受女主人用假阳具或手指插入肛门,肛门被侵犯被开发,体验被女人操的感觉',

    ),



    QuizItem(
      id: '${_maleMTypeId}_extreme_04',
      name: '被当作家具',
      categoryId: '${_maleMTypeId}_extreme',
      description: '接受被当作人体家具使用,跪在地上当脚凳或桌子,失去人格尊严只是女主人的工具',

    ),



    QuizItem(
      id: '${_maleMTypeId}_extreme_05',
      name: '接受极限羞辱',
      categoryId: '${_maleMTypeId}_extreme',
      description: '愿意接受极端的羞辱和降格,被当众骂成废物和狗,被吐口水踩踏,完全失去尊严反而兴奋',

    ),



    QuizItem(
      id: '${_maleMTypeId}_extreme_06',
      name: '长期贞操锁',
      categoryId: '${_maleMTypeId}_extreme',
      description: '接受鸡巴长期甚至永久被锁在贞操锁中,永远不能硬不能射,失去性自由只能服侍女主人',

    ),



    QuizItem(
      id: '${_maleMTypeId}_extreme_07',
      name: '被当众调教',
      categoryId: '${_maleMTypeId}_extreme',
      description: '愿意在他人面前被调教和羞辱,当众跪下舔女主人的脚,当众被骂被踩,暴露奴隶身份',

    ),



    QuizItem(
      id: '${_maleMTypeId}_extreme_08',
      name: '接受身体标记',
      categoryId: '${_maleMTypeId}_extreme',
      description: '愿意在身体上留下永久标记,在臀部、鸡巴上纹上女主人的名字,或者穿刺乳环,永远属于她',

    ),



    QuizItem(
      id: '${_maleMTypeId}_extreme_09',
      name: '完全物化',
      categoryId: '${_maleMTypeId}_extreme',
      description: '接受被当作物品或工具对待,失去人格和尊严,成为女主人的性奴隶和玩具,鸡巴只为她存在',

    ),



    QuizItem(
      id: '${_maleMTypeId}_extreme_10',
      name: '终身服从',
      categoryId: '${_maleMTypeId}_extreme',
      description: '愿意签订终身契约永远成为女主人的奴隶,成为她的所有物和玩具,鸡巴和身体都永远属于她',


  ),

  ];


  // 绿帽自测数据
  static const String _cuckoldTypeId = 'cuckold';
  
  static final QuizType cuckoldQuizType = QuizType(
    id: _cuckoldTypeId,
    name: '绿帽自测',
    description: '探索你对绿帽癖的接受程度和具体偏好，了解自己的心理边界',
    iconPath: 'assets/icons/cuckold.png',
    categories: _cuckoldCategories,
  );

  static final List<QuizCategory> _cuckoldCategories = [
    QuizCategory(
      id: '${_cuckoldTypeId}_fantasy',
      name: '幻想入门',
      quizTypeId: _cuckoldTypeId,
      items: _cuckoldFantasyItems,
    ),
    QuizCategory(
      id: '${_cuckoldTypeId}_observe',
      name: '观看体验',
      quizTypeId: _cuckoldTypeId,
      items: _cuckoldObserveItems,
    ),
    QuizCategory(
      id: '${_cuckoldTypeId}_participate',
      name: '参与互动',
      quizTypeId: _cuckoldTypeId,
      items: _cuckoldParticipateItems,
    ),
    QuizCategory(
      id: '${_cuckoldTypeId}_humiliation',
      name: '羞辱深化',
      quizTypeId: _cuckoldTypeId,
      items: _cuckoldHumiliationItems,
    ),
    QuizCategory(
      id: '${_cuckoldTypeId}_service',
      name: '服务侍奉',
      quizTypeId: _cuckoldTypeId,
      items: _cuckoldServiceItems,
    ),
    QuizCategory(
      id: '${_cuckoldTypeId}_extreme',
      name: '极限沉浸',
      quizTypeId: _cuckoldTypeId,
      items: _cuckoldExtremeItems,
    ),
  ];

  // 幻想入门
  static final List<QuizItem> _cuckoldFantasyItems = [
    QuizItem(
      id: '${_cuckoldTypeId}_fantasy_01', 
      name: '幻想伴侣和别人亲吻', 
      categoryId: '${_cuckoldTypeId}_fantasy',
      description: '脑海中浮现老婆和其他男人深情拥吻的画面,他们舌头纠缠嘴唇相贴,鸡巴在这种想象中硬起来',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_fantasy_02', 
      name: '想象伴侣被他人抚摸', 
      categoryId: '${_cuckoldTypeId}_fantasy',
      description: '幻想老婆的奶子被别人摸揉,骚穴被其他男人的手指插入摸索,鸡巴从这种想象中获得特殊快感',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_fantasy_03', 
      name: '喜欢听伴侣讲述过往', 
      categoryId: '${_cuckoldTypeId}_fantasy',
      description: '喜欢听老婆讲述她和前任做爱的经历,听她描述被别人鸡巴插入的感觉,从这些故事中感受到兴奋刺激',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_fantasy_04', 
      name: '幻想伴侣出轨场景', 
      categoryId: '${_cuckoldTypeId}_fantasy',
      description: '偶尔会幻想老婆在外面被别人插进骚穴狠狠操,她被操得叫床的场景,从中感受到紧张和兴奋',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_fantasy_05', 
      name: '对伴侣被注视感兴奋', 
      categoryId: '${_cuckoldTypeId}_fantasy',
      description: '当其他男性猥亵地注视老婆的奶子和身体时,内心产生一种特殊的兴奋感,鸡巴不由自主地硬起来',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_fantasy_06', 
      name: '幻想伴侣穿着暴露', 
      categoryId: '${_cuckoldTypeId}_fantasy',
      description: '想象老婆穿着超短裙、低胸装露出奶子和大腿出现在其他男人面前,她的身体被人欣赏,从中获得刺激',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_fantasy_07', 
      name: '询问伴侣对他人看法', 
      categoryId: '${_cuckoldTypeId}_fantasy',
      description: '会问老婆觉得某个男人鸡巴大不大,想不想被他操,从她的回答中寻找刺激感',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_fantasy_08', 
      name: '想象伴侣被夸赞身材', 
      categoryId: '${_cuckoldTypeId}_fantasy',
      description: '幻想其他男人夸赞老婆身材好、奶子大、骚穴紧,她听到这些话时兴奋的样子,从这种想象中感受到兴奋',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_fantasy_09', 
      name: '看伴侣照片自慰', 
      categoryId: '${_cuckoldTypeId}_fantasy',
      description: '看着老婆性感的照片,一边想象她骚穴被其他男人的大鸡巴插入操着,一边撸鸡巴自慰射精',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_fantasy_10', 
      name: '幻想伴侣社交暧昧', 
      categoryId: '${_cuckoldTypeId}_fantasy',
      description: '想象伴侣在社交场合和其他男性有暧昧互动,从中感受微妙的刺激',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_fantasy_11', 
      name: '幻想伴侣被搭讪', 
      categoryId: '${_cuckoldTypeId}_fantasy',
      description: '想象在公共场合有陌生男人主动搭讪老婆,她对他表现出兴趣和好感,甚至留下微信',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_fantasy_12', 
      name: '看色情片想象是伴侣', 
      categoryId: '${_cuckoldTypeId}_fantasy',
      description: '看色情片时会不自觉地将被操的女人想象成自己的老婆,想象她骚穴被大鸡巴插入,代入绿帽情节自慰',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_fantasy_13', 
      name: '幻想伴侣和朋友', 
      categoryId: '${_cuckoldTypeId}_fantasy',
      description: '有时会幻想老婆和自己的朋友或熟人做爱,骚穴被他们的鸡巴插入操着,从被朋友绿的刺激中感受到兴奋',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_fantasy_14', 
      name: '想象伴侣在外偷吃', 
      categoryId: '${_cuckoldTypeId}_fantasy',
      description: '幻想老婆在你不在的时候和别人在家里做爱,她骚穴被别人鸡巴插进去操,做背着你的事',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_fantasy_15', 
      name: '幻想伴侣主动勾引', 
      categoryId: '${_cuckoldTypeId}_fantasy',
      description: '想象老婆主动勾引其他男人,主动脱衣服张开腿诱惑他们,展现出你从未见过的主动和淫荡',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_fantasy_16', 
      name: '幻想伴侣醉酒被占便宜', 
      categoryId: '${_cuckoldTypeId}_fantasy',
      description: '想象老婆喝醉后被其他男人脱光衣服,骚穴被趁机插入占便宜,她半推半就地被操着',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_fantasy_17', 
      name: '幻想伴侣出差外遇', 
      categoryId: '${_cuckoldTypeId}_fantasy',
      description: '想象老婆出差时在酒店和陌生人一夜情,骚穴被陌生男人插入狠狠操,没人知道的偷情',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_fantasy_18', 
      name: '幻想伴侣健身房艳遇', 
      categoryId: '${_cuckoldTypeId}_fantasy',
      description: '想象老婆在健身房被身材健硕的教练勾引,她骚穴被教练的大鸡巴插入操着,在器械上做爱',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_fantasy_19', 
      name: '幻想伴侣聚会被灌醉', 
      categoryId: '${_cuckoldTypeId}_fantasy',
      description: '想象老婆在聚会中被灌醉后在包厢里被多个男人轮流操,骚穴被不同的鸡巴轮流插入侵犯',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_fantasy_20', 
      name: '幻想伴侣网恋见面', 
      categoryId: '${_cuckoldTypeId}_fantasy',
      description: '想象老婆在网上认识了其他男人,第一次见面就开房被操,骚穴被网友的鸡巴插入做爱',

  ),

  ];


  // 观看体验
  static final List<QuizItem> _cuckoldObserveItems = [
    QuizItem(
      id: '${_cuckoldTypeId}_observe_01', 
      name: '观看伴侣和他人暧昧', 
      categoryId: '${_cuckoldTypeId}_observe',
      description: '真实观看老婆和其他男人暧昧互动调情,看她被摸奶子掰开大腿,从旁观中鸡巴硬起来获得兴奋',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_observe_02', 
      name: '躲在角落偷看', 
      categoryId: '${_cuckoldTypeId}_observe',
      description: '躲在门后或角落偷偷看老婆和他人亲吻摸奶子,骚穴被他人摸着,体验偷窥的刺激鸡巴硬起来',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_observe_03', 
      name: '观看伴侣被抚摸', 
      categoryId: '${_cuckoldTypeId}_observe',
      description: '亲眼看着其他男人摸揉老婆的奶子,手指插入她骚穴里摸索,她在他手中颤抖反应叫床',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_observe_04', 
      name: '看伴侣被脱衣服', 
      categoryId: '${_cuckoldTypeId}_observe',
      description: '观看其他男人一件件脱掉老婆的衣服,内衣被脱下暴露她的奶子和骚穴,让他欣赏她的身体',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_observe_05', 
      name: '观看伴侣被亲吻全身', 
      categoryId: '${_cuckoldTypeId}_observe',
      description: '看着其他男人亲吻摸索老婆身体的每一处,舌头舔她的奶子和骚穴,包括最私密的阴蒂和阴道',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_observe_06', 
      name: '观看伴侣为他人口交', 
      categoryId: '${_cuckoldTypeId}_observe',
      description: '亲眼看着老婆跪在其他男人面前,张开嘴用舌头舔他的鸡巴,用嘴吮他的大鸡巴为他服务',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_observe_07', 
      name: '观看伴侣被插入', 
      categoryId: '${_cuckoldTypeId}_observe',
      description: '看着其他男人的大鸡巴插入老婆的骚穴,狠狠抽插着,她被操得发出的淫叫声和爽的表情',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_observe_08', 
      name: '观看伴侣高潮', 
      categoryId: '${_cuckoldTypeId}_observe',
      description: '看着老婆在其他男人鸡巴的抽插下达到高潮,她失控的样子、扭动的身体让你兴奋',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_observe_09', 
      name: '观看伴侣被内射', 
      categoryId: '${_cuckoldTypeId}_observe',
      description: '看着其他男人的鸡巴在老婆骚穴里射精,白色的精液从她骚穴里流出来,她被内射的样子',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_observe_10', 
      name: '近距离观察细节', 
      categoryId: '${_cuckoldTypeId}_observe',
      description: '近距离观察老婆骚穴和他人鸡巴交合的细节,看清鸡巴插入骚穴的每一个动作和反应',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_observe_11', 
      name: '观看多次交合', 
      categoryId: '${_cuckoldTypeId}_observe',
      description: '完整观看老婆骚穴被他人鸡巴连续插入多次操着,从开始到结束不错过任何细节',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_observe_12', 
      name: '录像记录过程', 
      categoryId: '${_cuckoldTypeId}_observe',
      description: '用摄像机记录老婆骚穴被操的全过程,留下她被别人插入高潮的影像资料反复观看',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_observe_13', 
      name: '观看伴侣吞精', 
      categoryId: '${_cuckoldTypeId}_observe',
      description: '看着老婆顺从地吞下其他男人射出的精液,她张开嘴将精液吞进去表现出满足的样子',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_observe_14', 
      name: '观看不同体位变换', 
      categoryId: '${_cuckoldTypeId}_observe',
      description: '完整观看他们尝试各种体位,看老婆骚穴在正面、后入、骑乘等每个姿势下被操的不同反应',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_observe_15', 
      name: '观看伴侣主动配合', 
      categoryId: '${_cuckoldTypeId}_observe',
      description: '看着老婆主动配合迎合其他男人的抽插,扭动屁股主动让鸡巴插得更深,展现出从未对你有过的热情',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_observe_16', 
      name: '观看伴侣脸上射精', 
      categoryId: '${_cuckoldTypeId}_observe',
      description: '看着其他男人的鸡巴射在老婆的脸上,白色精液糊了她一脸,她闭着眼享受被标记的感觉',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_observe_17', 
      name: '观看伴侣胸部射精', 
      categoryId: '${_cuckoldTypeId}_observe',
      description: '看着精液射在老婆的奶子上,白浊浊的精液流下来,她用手抹开精液涂满全身',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_observe_18', 
      name: '观看激烈的后入式', 
      categoryId: '${_cuckoldTypeId}_observe',
      description: '看着老婆跪在床上被从后面激烈地插入抽插,她趴在床上承受鸡巴的猛烈冲击叫床',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_observe_19', 
      name: '观看伴侣骑乘', 
      categoryId: '${_cuckoldTypeId}_observe',
      description: '看着老婆主动骑在其他男人身上,自己上下跳动控制节奏,让鸡巴插入骚穴追求自己的快感',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_observe_20', 
      name: '观看前后双洞齐插', 
      categoryId: '${_cuckoldTypeId}_observe',
      description: '看着老婆的骚穴和肛门同时被两根鸡巴填满,她在双重刺激中失神疯狂叫床',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_observe_21', 
      name: '观看伴侣潮吹', 
      categoryId: '${_cuckoldTypeId}_observe',
      description: '亲眼看着老婆在其他男人鸡巴的刺激下潮吹,骚穴里的体液喷涌而出流得到处都是',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_observe_22', 
      name: '观看伴侣多次高潮', 
      categoryId: '${_cuckoldTypeId}_observe',
      description: '看着老婆在一次性爱中被操得达到多次高潮,每次高潮都比和你做时更激烈叫得更大声',

  ),

  ];


  // 参与互动
  static final List<QuizItem> _cuckoldParticipateItems = [
    QuizItem(
      id: '${_cuckoldTypeId}_participate_01', 
      name: '帮伴侣脱衣准备', 
      categoryId: '${_cuckoldTypeId}_participate',
      description: '亲手帮老婆脱掉衣服露出奶子和骚穴,为她和别的男人做爱做好准备,看着她裸体等待被操',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_participate_02', 
      name: '为他们准备床铺', 
      categoryId: '${_cuckoldTypeId}_participate',
      description: '整理布置好床铺,为老婆和她的情人操逼营造舒适的环境,想象他们在这床上狠狠做爱',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_participate_03', 
      name: '在一旁观看自慰', 
      categoryId: '${_cuckoldTypeId}_participate',
      description: '看着老婆被别的男人大鸡巴狠狠抽插骚穴,自己在一旁忍不住撸鸡巴射精释放',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_participate_04', 
      name: '听从伴侣指令', 
      categoryId: '${_cuckoldTypeId}_participate',
      description: '在他们做爱过程中听从老婆的指令,按她要求做各种辅助动作配合她被操',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_participate_05', 
      name: '帮忙固定伴侣姿势', 
      categoryId: '${_cuckoldTypeId}_participate',
      description: '帮助固定老婆的身体姿势掰开她的腿,方便其他男人的大鸡巴更深地插入她骚穴狠狠操她',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_participate_06', 
      name: '递送情趣用品', 
      categoryId: '${_cuckoldTypeId}_participate',
      description: '在他们操逼需要时递送各种情趣用品震动棒跳蛋和润滑液,让老婆被玩得更爽',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_participate_07', 
      name: '拍照记录精彩瞬间', 
      categoryId: '${_cuckoldTypeId}_participate',
      description: '在合适的角度拍摄照片,记录老婆被大鸡巴插入骚穴、奶子被揉、被操得高潮的精彩瞬间',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_participate_08', 
      name: '言语鼓励伴侣', 
      categoryId: '${_cuckoldTypeId}_participate',
      description: '用言语鼓励老婆尽情享受被大鸡巴操,告诉她可以更放开叫得更浪一点把骚穴献给别人',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_participate_09', 
      name: '帮忙更换体位', 
      categoryId: '${_cuckoldTypeId}_participate',
      description: '协助他们调整更换后入正面骑乘等各种体位,让老婆的骚穴被鸡巴用更多姿势狠狠操',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_participate_10', 
      name: '送上饮料毛巾', 
      categoryId: '${_cuckoldTypeId}_participate',
      description: '在他们操累了休息时送上饮料和毛巾,提供贴心服务等待他们继续做爱',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_participate_11', 
      name: '在侧面为他们加油', 
      categoryId: '${_cuckoldTypeId}_participate',
      description: '站在一旁用言语为他们加油鼓劲,说“用力操她”“把鸡巴插深点”等挑逗的话刺激气氛',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_participate_12', 
      name: '帮忙整理伴侣头发', 
      categoryId: '${_cuckoldTypeId}_participate',
      description: '在被操过程中帮忙拨开老婆流汗的头发,让她更便于享受大鸡巴狠操骚穴',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_participate_13', 
      name: '帮忙调整灯光气氛', 
      categoryId: '${_cuckoldTypeId}_participate',
      description: '调节房间的灯光和音乐,为他们做爱操逼营造最佳的淫乱气氛',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_participate_14', 
      name: '帮忙散开伴侣腿', 
      categoryId: '${_cuckoldTypeId}_participate',
      description: '用手帮忙将老婆的腿分开更大露出骚穴,方便其他男人的大鸡巴更深入地插入骚穴狠狠抽插',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_participate_15', 
      name: '帮忙抓住伴侣手腕', 
      categoryId: '${_cuckoldTypeId}_participate',
      description: '按照指示抓住老婆的手腕,限制她的动作增加无助感让她被鸡巴狠狠操',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_participate_16', 
      name: '在旁边发出鼓励', 
      categoryId: '${_cuckoldTypeId}_participate',
      description: '在一旁说“好棒”“再用力操她”“把鸡巴插深点”等鼓励的话,配合淫乱气氛',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_participate_17', 
      name: '帮忙散播体香', 
      categoryId: '${_cuckoldTypeId}_participate',
      description: '在房间里喷洒香水或点燃香薰,让空气中充满挑逗气息刺激他们操逼',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_participate_18', 
      name: '递送枕头垫子', 
      categoryId: '${_cuckoldTypeId}_participate',
      description: '在他们做爱需要时递上枕头和垫子,帮助老婆更加放松享受被操',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_participate_19', 
      name: '帮忙擦拭汗水', 
      categoryId: '${_cuckoldTypeId}_participate',
      description: '用毛巾帮他们擦拭身上做爱时出的汗水,让他们保持舒适继续操逼',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_participate_20', 
      name: '帮忙收拾散落衣物', 
      categoryId: '${_cuckoldTypeId}_participate',
      description: '在他们操逼过程中帮忙收拾扔在地上的衣服内衣,保持环境整洁',

  ),

  ];


  // 羞辱深化
  static final List<QuizItem> _cuckoldHumiliationItems = [
    QuizItem(
      id: '${_cuckoldTypeId}_humiliation_01', 
      name: '接受伴侣的嘲笑', 
      categoryId: '${_cuckoldTypeId}_humiliation',
      description: '听老婆在被操过程中嘲笑你鸡巴小不如她情人的大鸡巴,从羞辱中感到兴奋',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_humiliation_02', 
      name: '被要求跪着观看', 
      categoryId: '${_cuckoldTypeId}_humiliation',
      description: '被命令跪在床边观看老婆骚穴被别人大鸡巴狠狠操,体验低下的绿帽奴地位',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_humiliation_03', 
      name: '听伴侣夸其他男人', 
      categoryId: '${_cuckoldTypeId}_humiliation',
      description: '听老婆大声夸赞其他男人鸡巴比你大、更强壮、更持久、操得她更爽',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_humiliation_04', 
      name: '被禁止触碰伴侣', 
      categoryId: '${_cuckoldTypeId}_humiliation',
      description: '被明确禁止触碰老婆的奶子和骚穴,只能眼睁睁看着她被别人鸡巴插入骚穴占有',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_humiliation_05', 
      name: '被关在贞操锁中', 
      categoryId: '${_cuckoldTypeId}_humiliation',
      description: '鸡巴被锁在贞操锁里不能硬不能射,只能憋着看老婆骚穴被别人大鸡巴尽情操享受',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_humiliation_06', 
      name: '被比较尺寸大小', 
      categoryId: '${_cuckoldTypeId}_humiliation',
      description: '老婆和她的情人当面比较你们鸡巴的尺寸,羞辱你的小鸡巴太渺小不够她塞牙缝',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_humiliation_07', 
      name: '被要求穿女性内衣', 
      categoryId: '${_cuckoldTypeId}_humiliation',
      description: '被命令穿上女性内衣内裤观看老婆被操,进一步贬低你的男性地位当娘炮',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_humiliation_08', 
      name: '听伴侣呻吟喊他名字', 
      categoryId: '${_cuckoldTypeId}_humiliation',
      description: '听着老婆被大鸡巴狠操高潮时淫叫着大声喊其他男人的名字,感受被取代的羞辱',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_humiliation_09', 
      name: '被迫感谢情人', 
      categoryId: '${_cuckoldTypeId}_humiliation',
      description: '被要求感谢老婆的情人用大鸡巴操满足了她,承认自己小鸡巴做不到',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_humiliation_10', 
      name: '看伴侣对他更温柔', 
      categoryId: '${_cuckoldTypeId}_humiliation',
      description: '看着老婆对其他男人表现出从未对你有过的温柔和主动,骚穴被鸡巴操着娇喊连连',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_humiliation_11', 
      name: '被命令戴项圈', 
      categoryId: '${_cuckoldTypeId}_humiliation',
      description: '被要求戴上项圈和狗牌,标明你的低下绿帽奴身份跪着看老婆被操',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_humiliation_12', 
      name: '被赶到床下观看', 
      categoryId: '${_cuckoldTypeId}_humiliation',
      description: '被赶到床底下,只能从下方的角度观看大鸡巴狠狠插入老婆骚穴交合抽插',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_humiliation_13', 
      name: '被当面比较生殖器', 
      categoryId: '${_cuckoldTypeId}_humiliation',
      description: '被要求和情人站在一起比较鸡巴大小和硬度,老婆逐一点评你小鸡巴太小太软的不足',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_humiliation_14', 
      name: '被迫睁眼观看', 
      categoryId: '${_cuckoldTypeId}_humiliation',
      description: '被命令睁大眼睛不能移开地看着大鸡巴插入老婆骚穴每一个抽插细节,不准闭眼',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_humiliation_15', 
      name: '被嘲笑太快射', 
      categoryId: '${_cuckoldTypeId}_humiliation',
      description: '被嘲笑你总是鸡巴刚硬就太快射精,不像其他男人能坚持很久狠狠操她',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_humiliation_16', 
      name: '被要求感谢伴侣', 
      categoryId: '${_cuckoldTypeId}_humiliation',
      description: '被要求感谢老婆让你观看她骚穴被大鸡巴操这么精彩的表演',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_humiliation_17', 
      name: '被迫吃伴侣喂给情人的食物', 
      categoryId: '${_cuckoldTypeId}_humiliation',
      description: '看着老婆嘴对嘴喂食给情人,然后要求你吃掉他们吐出来的残渣和口水',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_humiliation_18', 
      name: '勃起后被嘲笑惩罚', 
      categoryId: '${_cuckoldTypeId}_humiliation',
      description: '观看老婆被操时鸡巴如果勃起就会被打手板,被嘲笑你这个废物居然还有脸勃起',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_humiliation_19', 
      name: '被要求叫她老婆大人', 
      categoryId: '${_cuckoldTypeId}_humiliation',
      description: '被要求改称呼老婆为“老婆大人”,强调地位差异让你做奴才能看她被操',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_humiliation_20', 
      name: '听伴侣说他更好', 
      categoryId: '${_cuckoldTypeId}_humiliation',
      description: '听老婆在被大鸡巴操高潮后说“他鸡巴真的比你好太多了”等比较的话',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_humiliation_21', 
      name: '被嘲笑技术差', 
      categoryId: '${_cuckoldTypeId}_humiliation',
      description: '听老婆嘲笑你的小鸡巴和性爱技术差,从来没让她骚穴被操得这么舒服过',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_humiliation_22', 
      name: '被迫下跪承认不如人', 
      categoryId: '${_cuckoldTypeId}_humiliation',
      description: '被要求跪在情人面前磕头,承认自己的小鸡巴、技术、体力都远不如他大鸡巴',

  ),

  ];


  // 服务侍奉
  static final List<QuizItem> _cuckoldServiceItems = [
    QuizItem(
      id: '${_cuckoldTypeId}_service_01', 
      name: '为情人准备饮料', 
      categoryId: '${_cuckoldTypeId}_service',
      description: '为老婆的情人端茶送水,像仆人一样伺候他好让他有力气狠狠操老婆',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_service_02', 
      name: '帮情人脱鞋袜', 
      categoryId: '${_cuckoldTypeId}_service',
      description: '跪下帮老婆的情人脱掉鞋袜,表示你的臣服让他舒服地操老婆骚穴',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_service_03', 
      name: '清理使用后的床铺', 
      categoryId: '${_cuckoldTypeId}_service',
      description: '在他们操完后清理沾满精液淫水体液的床单,收拾他们做爱的残局',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_service_04', 
      name: '舌头清洁伴侣骚穴', 
      categoryId: '${_cuckoldTypeId}_service',
      description: '用舌头舔清洁老婆刚被大鸡巴侵犯过的骚穴,品尝混合的精液淫水和气味',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_service_05', 
      name: '事后按摩伴侣', 
      categoryId: '${_cuckoldTypeId}_service',
      description: '在老婆骚穴被鸡巴操满足后,为她按摩被操酸痛的身体,给予温柔照顾',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_service_06', 
      name: '用舌头清理流出精液', 
      categoryId: '${_cuckoldTypeId}_service',
      description: '老婆骚穴被内射后,跪下用舌头舔光从她骚穴流出的所有精液淫水',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_service_07', 
      name: '送情人离开', 
      categoryId: '${_cuckoldTypeId}_service',
      description: '礼貌地送老婆的情人出门,感谢他用大鸡巴操满足了老婆骚穴',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_service_08', 
      name: '准备事后避孕药', 
      categoryId: '${_cuckoldTypeId}_service',
      description: '在老婆骚穴被大鸡巴内射后,准备好避孕药和水给她服用',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_service_09', 
      name: '陪伴侣回味过程', 
      categoryId: '${_cuckoldTypeId}_service',
      description: '抱着老婆听她回味刚才骚穴被大鸡巴狠操的美好体验,分享她被操的快乐',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_service_10', 
      name: '为下次约会做准备', 
      categoryId: '${_cuckoldTypeId}_service',
      description: '帮老婆安排下次和情人操逼的约会,预定酒店或整理房间为他们做爱做准备',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_service_11', 
      name: '用嘴清洁情人鸡巴', 
      categoryId: '${_cuckoldTypeId}_service',
      description: '在他们操完后,跪下用嘴帮情人清洁大鸡巴,舌头舔掉所有混合的精液淫水',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_service_12', 
      name: '准备伴侣性感内衣', 
      categoryId: '${_cuckoldTypeId}_service',
      description: '为老婆挑选和准备性感的内衣,让她穿上去见情人展示奶子和骚穴被操',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_service_13', 
      name: '帮忙准备安全套', 
      categoryId: '${_cuckoldTypeId}_service',
      description: '为他们操逼准备好安全套放在床头,虽然知道大鸡巴可能不会用直接内射',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_service_14', 
      name: '跪地舔情人鞋底', 
      categoryId: '${_cuckoldTypeId}_service',
      description: '在情人到来时跪下用舌头舔干净他的鞋底,表示你的卑微地位让他去操老婆',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_service_15', 
      name: '帮忙化妆打扮', 
      categoryId: '${_cuckoldTypeId}_service',
      description: '在老婆约会前帮她化妆打扮,让她更美丽地去见情人被大鸡巴操',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_service_16', 
      name: '舔伴侣穿过的内裤', 
      categoryId: '${_cuckoldTypeId}_service',
      description: '用舌头舔干净老婆刚脱下沾满精液的内裤,品尝她的淫水和精液混合',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_service_17', 
      name: '帮忙烘干床单', 
      categoryId: '${_cuckoldTypeId}_service',
      description: '清洗并烘干沾满他们操逼精液淫水体液的床单,第二天再铺好',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_service_18', 
      name: '准备宵夜饮食', 
      categoryId: '${_cuckoldTypeId}_service',
      description: '为他们准备宵夜时吃的食物和饮料,补充体力继续操逼',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_service_19', 
      name: '帮忙调整空调温度', 
      categoryId: '${_cuckoldTypeId}_service',
      description: '根据他们操逼的需要调节房间温度,让他们保持舒适继续做爱',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_service_20', 
      name: '帮忙拍照留念', 
      categoryId: '${_cuckoldTypeId}_service',
      description: '在老婆的要求下帮她和情人拍摄亲密照片,记录她被大鸡巴插入骚穴的留念',

  ),

  ];


  // 极限沉浸
  static final List<QuizItem> _cuckoldExtremeItems = [
    QuizItem(
      id: '${_cuckoldTypeId}_extreme_01', 
      name: '跪地舔被内射骚穴', 
      categoryId: '${_cuckoldTypeId}_extreme',
      description: '跪在床边,当着情人的面用舌头舔吸老婆刚被大鸡巴内射的骚穴,吸出并吞下所有精液淫水',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_extreme_02', 
      name: '舔情人刚抽出的鸡巴', 
      categoryId: '${_cuckoldTypeId}_extreme',
      description: '在老婆要求下,跪下用舌头从龟头到蛋蛋完全舔干净情人刚从她骚穴抽出的大鸡巴',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_extreme_03', 
      name: '用嘴含住情人鸡巴让伴侣骑', 
      categoryId: '${_cuckoldTypeId}_extreme',
      description: '用嘴含住情人的大鸡巴吮吸让它硬起来,然后看着老婆骑上去在你面前摇动骚穴被操',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_extreme_04', 
      name: '被情人当众羞辱', 
      categoryId: '${_cuckoldTypeId}_extreme',
      description: '接受老婆情人的当众羞辱和贬低,承认他大鸡巴的优越和你小鸡巴的废物',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_extreme_05', 
      name: '成为他们的玩物', 
      categoryId: '${_cuckoldTypeId}_extreme',
      description: '完全成为老婆和她情人的玩物,任由他们摆布和使用看他们做爱操逼',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_extreme_06', 
      name: '接受情人的支配', 
      categoryId: '${_cuckoldTypeId}_extreme',
      description: '不仅服从老婆,也接受她情人的命令和支配跪着看他用大鸡巴操老婆',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_extreme_07', 
      name: '长期贞操锁禁欲', 
      categoryId: '${_cuckoldTypeId}_extreme',
      description: '鸡巴被长期锁在贞操锁中,只能看老婆骚穴被别人大鸡巴享受而无法释放',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_extreme_08', 
      name: '接受伴侣怀孕风险', 
      categoryId: '${_cuckoldTypeId}_extreme',
      description: '接受老婆骚穴被大鸡巴内射可能怀上其他男人孩子的风险,愿意抚养',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_extreme_09', 
      name: '允许伴侣公开关系', 
      categoryId: '${_cuckoldTypeId}_extreme',
      description: '允许老婆和她的情人公开他们操逼的关系,自己的绿帽地位被公开',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_extreme_10', 
      name: '接受多个情人同时', 
      categoryId: '${_cuckoldTypeId}_extreme',
      description: '接受老婆同时拥有多个情人,观看她骚穴和嘴被多人的大鸡巴轮流占有操',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_extreme_11', 
      name: '完全放弃性权利', 
      categoryId: '${_cuckoldTypeId}_extreme',
      description: '彻底放弃和老婆发生性关系的权利,她的奶子和骚穴只属于其他男人的大鸡巴',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_extreme_12', 
      name: '建立永久绿帽关系', 
      categoryId: '${_cuckoldTypeId}_extreme',
      description: '建立长期稳定的绿帽关系,老婆拥有固定的情人用大鸡巴操她骚穴',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_extreme_13', 
      name: '接受被完全边缘化', 
      categoryId: '${_cuckoldTypeId}_extreme',
      description: '在老婆的性生活中被完全边缘化,只作为观众和仆人存在看她被操',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_extreme_14', 
      name: '心理认同绿帽身份', 
      categoryId: '${_cuckoldTypeId}_extreme',
      description: '从心理上完全认同并接受自己的绿帽身份,以看老婆被大鸡巴操为乐',

    ),



    QuizItem(
      id: '${_cuckoldTypeId}_extreme_15', 
      name: '主动寻找情人给伴侣', 
      categoryId: '${_cuckoldTypeId}_extreme',
      description: '主动为老婆寻找和筛选大鸡巴优质的情人,安排他们操逼的约会',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_extreme_16', 
      name: '接受伴侣同居情人', 
      categoryId: '${_cuckoldTypeId}_extreme',
      description: '接受老婆的情人和你们住在一起,你成为家里的第三者看他每天用大鸡巴操老婆',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_extreme_17', 
      name: '给情人支付生活费', 
      categoryId: '${_cuckoldTypeId}_extreme',
      description: '用自己的钱支付老婆情人的部分生活开销,让他有钱继续用大鸡巴操老婆',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_extreme_18', 
      name: '用舌头深入清洁体内', 
      categoryId: '${_cuckoldTypeId}_extreme',
      description: '老婆骚穴被多次内射后,跪下将舌头伸入她骚穴深处,舔吸出所有混合的精液和淫水',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_extreme_19', 
      name: '接受伴侣纯粹关系', 
      categoryId: '${_cuckoldTypeId}_extreme',
      description: '接受老婆和情人发展为纯粹的恋爱关系,不仅是大鸡巴操骚穴的性',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_extreme_20', 
      name: '被要求离婚让位', 
      categoryId: '${_cuckoldTypeId}_extreme',
      description: '被要求和老婆离婚,让她和情人在一起,你只做情人看她被大鸡巴操',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_extreme_21', 
      name: '为他们养育孩子', 
      categoryId: '${_cuckoldTypeId}_extreme',
      description: '愿意养育老婆和情人的孩子,当他们的接盘侠继续看老婆被操',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_extreme_22', 
      name: '看伴侣被多人轮流', 
      categoryId: '${_cuckoldTypeId}_extreme',
      description: '观看老婆被多个男人大鸡巴轮流占有,一个接一个地插入她骚穴操她',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_extreme_23', 
      name: '吮吸帮情人勃起再插入伴侣', 
      categoryId: '${_cuckoldTypeId}_extreme',
      description: '在一轮结束后,用嘴吮吸情人的大鸡巴帮他重新勃起,然后亲手将它插入老婆骚穴继续操',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_extreme_24', 
      name: '被插入后庭同时舔他们', 
      categoryId: '${_cuckoldTypeId}_extreme',
      description: '后庭被假阳具插入着,同时跪在地上用舌头舔他们交合的部位,品尝滴落的精液淫水',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_extreme_25', 
      name: '接受公开绿帽身份', 
      categoryId: '${_cuckoldTypeId}_extreme',
      description: '在朋友和亲人面前公开自己的绿帽身份,不再隐藏老婆被别人大鸡巴操',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_extreme_26', 
      name: '被要求穿贞操带', 
      categoryId: '${_cuckoldTypeId}_extreme',
      description: '被要求佩戴男性贞操带锁住鸡巴,完全失去性权利只能看老婆被操',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_extreme_27', 
      name: '看伴侣被当众调教', 
      categoryId: '${_cuckoldTypeId}_extreme',
      description: '在多人面前看着老婆被情人调教,骚穴被大鸡巴操着,其他人也在观看',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_extreme_28', 
      name: '成为他们的人体厕所', 
      categoryId: '${_cuckoldTypeId}_extreme',
      description: '完全成为老婆和情人的人体厕所和性奴隶,接受他们的一切排泄物和精液淫水',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_extreme_29', 
      name: '接受伴侣终身有情人', 
      categoryId: '${_cuckoldTypeId}_extreme',
      description: '接受老婆终身都会有情人用大鸡巴操她骚穴,这将是你们的生活常态',

    ),

    QuizItem(
      id: '${_cuckoldTypeId}_extreme_30', 
      name: '完全放弃男性尊严', 
      categoryId: '${_cuckoldTypeId}_extreme',
      description: '心甘情愿地完全放弃男性尊严,在绿帽关系中看老婆被大鸡巴操找到真正的快乐',


  ),

  ];


  // 男S自测数据（调教女M的内容）
  static const String _maleSTypeId = 'male_s';
  
  static final QuizType maleSQuizType = QuizType(
    id: _maleSTypeId,
    name: '男S自测',
    description: '探索你作为男性支配者的倾向，了解你在调教女M时的偏好和风格',
    iconPath: 'assets/icons/male_s.png',
    categories: _maleSCategories,
  );

  static final List<QuizCategory> _maleSCategories = [
    QuizCategory(
      id: '${_maleSTypeId}_basic_control',
      name: '基础支配',
      quizTypeId: _maleSTypeId,
      items: _maleSBasicControlItems,
    ),
    QuizCategory(
      id: '${_maleSTypeId}_bondage',
      name: '绑缚束缚',
      quizTypeId: _maleSTypeId,
      items: _maleSBondageItems,
    ),
    QuizCategory(
      id: '${_maleSTypeId}_pain_pleasure',
      name: '痛感调教',
      quizTypeId: _maleSTypeId,
      items: _maleSPainPleasureItems,
    ),
    QuizCategory(
      id: '${_maleSTypeId}_humiliation',
      name: '羞辱降格',
      quizTypeId: _maleSTypeId,
      items: _maleSHumiliationItems,
    ),
    QuizCategory(
      id: '${_maleSTypeId}_pet_training',
      name: '宠物调教',
      quizTypeId: _maleSTypeId,
      items: _maleSPetTrainingItems,
    ),
    QuizCategory(
      id: '${_maleSTypeId}_object_training',
      name: '物化调教',
      quizTypeId: _maleSTypeId,
      items: _maleSObjectTrainingItems,
    ),
    QuizCategory(
      id: '${_maleSTypeId}_public_training',
      name: '公开调教',
      quizTypeId: _maleSTypeId,
      items: _maleSPublicTrainingItems,
    ),
    QuizCategory(
      id: '${_maleSTypeId}_sensory',
      name: '感官控制',
      quizTypeId: _maleSTypeId,
      items: _maleSensoryItems,
    ),
    QuizCategory(
      id: '${_maleSTypeId}_psychological',
      name: '心理支配',
      quizTypeId: _maleSTypeId,
      items: _maleSPsychologicalItems,
    ),
    QuizCategory(
      id: '${_maleSTypeId}_extreme',
      name: '极限调教',
      quizTypeId: _maleSTypeId,
      items: _maleSExtremeItems,
    ),
  ];

  // 基础支配
  static final List<QuizItem> _maleSBasicControlItems = [
    QuizItem(
      id: '${_maleSTypeId}_basic_01', 
      name: '要求女M称呼主人', 
      categoryId: '${_maleSTypeId}_basic_control',
      description: '在调教过程中，要求女M必须称呼你为主人、主人大人,建立明确的主仆关系,让她骚穴被你鸡巴操时叫主人',

    ),



    QuizItem(
      id: '${_maleSTypeId}_basic_02', 
      name: '命令女M跪下服侍', 
      categoryId: '${_maleSTypeId}_basic_control',
      description: '命令女M跪在你面前,以跪姿为你提供各种服侍,用嘴吮吸鸡巴口交、舌头舔蛋蛋等行为,彰显你的支配地位',

    ),



    QuizItem(
      id: '${_maleSTypeId}_basic_03', 
      name: '要求女M高潮前请示', 
      categoryId: '${_maleSTypeId}_basic_control',
      description: '控制女M的高潮权利,要求她骚穴被鸡巴操到快要高潮时必须向你请示获得许可,完全掌控她的性快感',

    ),



    QuizItem(
      id: '${_maleSTypeId}_basic_04', 
      name: '控制女M阴道插入', 
      categoryId: '${_maleSTypeId}_basic_control',
      description: '决定何时、如何用鸡巴插入女M的骚穴,控制插入的深度、速度和抽插节奏,让她骚穴完全服从你鸡巴的操干',

    ),



    QuizItem(
      id: '${_maleSTypeId}_basic_05', 
      name: '命令女M露出乳房', 
      categoryId: '${_maleSTypeId}_basic_control',
      description: '命令女M在你面前或指定场合脱掉上衣露出奶子,让她接受你的检阅和用手摸揉奶子玩弄',

    ),



    QuizItem(
      id: '${_maleSTypeId}_basic_06', 
      name: '禁止女M穿内裤', 
      categoryId: '${_maleSTypeId}_basic_control',
      description: '规定女M在特定时间或场合不准穿内裤,让她骚穴时刻感受到你的控制和鸡巴随时可能插入骚穴被侵犯的羞耻感',

    ),



    QuizItem(
      id: '${_maleSTypeId}_basic_07', 
      name: '检查女M下体', 
      categoryId: '${_maleSTypeId}_basic_control',
      description: '定期检查女M的骚穴状态,查看她骚穴是否流淫水湿润、是否按要求不穿内裤等,行使主人的检查权',

    ),



    QuizItem(
      id: '${_maleSTypeId}_basic_08', 
      name: '控制女M自慰频率', 
      categoryId: '${_maleSTypeId}_basic_control',
      description: '规定女M自慰摸骚穴的频率和次数,甚至完全禁止自慰,让她的性快感和高潮完全依赖于你鸡巴操她',

    ),



    QuizItem(
      id: '${_maleSTypeId}_basic_09', 
      name: '要求女M展示骚穴', 
      categoryId: '${_maleSTypeId}_basic_control',
      description: '命令女M主动张开双腿展示自己的骚穴,让她在羞耻中暴露最淫荡的部位供你观赏和用鸡巴插入',

    ),



    QuizItem(
      id: '${_maleSTypeId}_basic_10', 
      name: '玩弄女M阴蒂', 
      categoryId: '${_maleSTypeId}_basic_control',
      description: '用手指、舌头舔或玩具刺激女M的阴蒂,控制她的快感强度,让她在你的玩弄下骚穴流水颤抖高潮',

    ),



    QuizItem(
      id: '${_maleSTypeId}_basic_11', 
      name: '射精在女M身上', 
      categoryId: '${_maleSTypeId}_basic_control',
      description: '将精液射在女M的身体上,如脸部、奶子乳房、腹部等位置,用精液标记她属于你的事实',

    ),



    QuizItem(
      id: '${_maleSTypeId}_basic_12', 
      name: '让女M吞咽精液', 
      categoryId: '${_maleSTypeId}_basic_control',
      description: '鸡巴射精在女M口中后,命令她将精液全部吞咽下去,让她接受并崇拜你的精液',


  ),

  ];


  // 绑缚束缚
  static final List<QuizItem> _maleSBondageItems = [
    QuizItem(
      id: '${_maleSTypeId}_bondage_01', 
      name: '绑缚女M双腿', 
      categoryId: '${_maleSTypeId}_bondage',
      description: '用绳索或束缚带将女M的双腿绑在一起或固定在特定位置,限制她的行动自由,让她处于被动受制的状态等待鸡巴插入骚穴',

    ),



    QuizItem(
      id: '${_maleSTypeId}_bondage_02', 
      name: '束缚后插入阴道', 
      categoryId: '${_maleSTypeId}_bondage',
      description: '在将女M束缚固定后,趁她无法反抗时用鸡巴插入她的骚穴,享受她被束缚状态下的紧张和无助被狠狠操',

    ),



    QuizItem(
      id: '${_maleSTypeId}_bondage_03', 
      name: '绑住乳房', 
      categoryId: '${_maleSTypeId}_bondage',
      description: '用绳索或胶带缠绕绑缚女M的奶子乳房,使奶子乳房充血肿胀,增加敏感度和视觉冲击',

    ),



    QuizItem(
      id: '${_maleSTypeId}_bondage_04', 
      name: '绳缚阴唇', 
      categoryId: '${_maleSTypeId}_bondage',
      description: '用细绳缠绕绑缚女M的阴唇,使其充血肿大,增强触感和刺激,展示骚穴的束缚美感',

    ),



    QuizItem(
      id: '${_maleSTypeId}_bondage_05', 
      name: 'M字开腿绑缚', 
      categoryId: '${_maleSTypeId}_bondage',
      description: '将女M的双腿大幅度分开并固定成M字形状,完全暴露骚穴阴部,让她处于羞耻和脆弱的状态等待鸡巴插入',

    ),



    QuizItem(
      id: '${_maleSTypeId}_bondage_06', 
      name: '蒙眼后玩弄下体', 
      categoryId: '${_maleSTypeId}_bondage',
      description: '用眼罩蒙住女M的眼睛,剥夺视觉后用手指或鸡巴玩弄她的骚穴阴部,让她在未知的恐惧和期待中享受刺激',

    ),



    QuizItem(
      id: '${_maleSTypeId}_bondage_07', 
      name: '口塞后强制高潮', 
      categoryId: '${_maleSTypeId}_bondage',
      description: '用口球或其他物品堵住女M的嘴巴,让她无法呼叫求饶,然后强制用鸡巴或震动棒刺激她达到高潮',

    ),



    QuizItem(
      id: '${_maleSTypeId}_bondage_08', 
      name: '吊缚展示骚穴', 
      categoryId: '${_maleSTypeId}_bondage',
      description: '用绳索将女M悬吊起来,让她的骚穴完全暴露在空中,无法遮掩或闭合,只能任人观看和鸡巴插入',

    ),



    QuizItem(
      id: '${_maleSTypeId}_bondage_09', 
      name: '固定跪趴姿势', 
      categoryId: '${_maleSTypeId}_bondage',
      description: '将女M固定在跪趴的姿势,臀部翘起,骚穴和肛门完全暴露,便于从后方用鸡巴插入进行各种调教',

    ),



    QuizItem(
      id: '${_maleSTypeId}_bondage_10', 
      name: '束缚配合玩具', 
      categoryId: '${_maleSTypeId}_bondage',
      description: '在束缚女M后,使用震动棒、跳蛋等性玩具持续刺激她的骚穴和阴蒂,让她在无法动弹的状态下承受快感折磨',

    ),



    QuizItem(
      id: '${_maleSTypeId}_bondage_11', 
      name: '绑缚乳头夹', 
      categoryId: '${_maleSTypeId}_bondage',
      description: '将女M束缚后,在她的奶头乳头上夹上乳夹,通过束缚增强痛感和快感的混合刺激',

    ),



    QuizItem(
      id: '${_maleSTypeId}_bondage_12', 
      name: '开腿器撑开', 
      categoryId: '${_maleSTypeId}_bondage',
      description: '使用专门的开腿器强制撑开女M的双腿,使她骚穴无法闭合,阴部持续暴露便于鸡巴侵犯插入',


  ),

  ];


  // 痛感调教
  static final List<QuizItem> _maleSPainPleasureItems = [
    QuizItem(
      id: '${_maleSTypeId}_pain_01', 
      name: '鞭打女M臀部', 
      categoryId: '${_maleSTypeId}_pain_pleasure',
      description: '用皮鞭、竹条或手掌抽打女M的臀部,让她在痛感中感受惩罚,臀部留下红艳的印记然后鸡巴插入骚穴',

    ),



    QuizItem(
      id: '${_maleSTypeId}_pain_02', 
      name: '拍打女M乳房', 
      categoryId: '${_maleSTypeId}_pain_pleasure',
      description: '用手掌或工具拍打女M的奶子,让奶子在痛感中颤动,增强敏感度和刺激感',

    ),



    QuizItem(
      id: '${_maleSTypeId}_pain_03', 
      name: '抽打大腿内侧', 
      categoryId: '${_maleSTypeId}_pain_pleasure',
      description: '用细鞭或竹条抽打女M敏感的大腿内侧,让她在痛楚中本能地张开双腿露出骚穴等待被操',

    ),



    QuizItem(
      id: '${_maleSTypeId}_pain_04', 
      name: '滴蜡在乳头上', 
      categoryId: '${_maleSTypeId}_pain_pleasure',
      description: '将融化的热蜡油滴落在女M的奶头乳头上,让她体验热痛与快感交织的极致刺激',

    ),



    QuizItem(
      id: '${_maleSTypeId}_pain_05', 
      name: '滴蜡在阴唇上', 
      categoryId: '${_maleSTypeId}_pain_pleasure',
      description: '将热蜡油滴在女M敏感的阴唇上,让她骚穴在热痛中感受私处的强烈刺激然后鸡巴插入',

    ),



    QuizItem(
      id: '${_maleSTypeId}_pain_06', 
      name: '乳头夹调教', 
      categoryId: '${_maleSTypeId}_pain_pleasure',
      description: '在女M的奶头乳头上夹上乳夹,通过持续的压迫和痛感让奶头乳头变得极度敏感',

    ),



    QuizItem(
      id: '${_maleSTypeId}_pain_07', 
      name: '阴蒂夹刺激', 
      categoryId: '${_maleSTypeId}_pain_pleasure',
      description: '用专用的阴蒂夹夹住女M最敏感的阴蒂,让她在痛楚中体验强烈的快感然后鸡巴插入操她',

    ),



    QuizItem(
      id: '${_maleSTypeId}_pain_08', 
      name: '电击阴部', 
      categoryId: '${_maleSTypeId}_pain_pleasure',
      description: '使用低压电击棒刺激女M的骚穴阴部,让她在电流的麻痹和痛感中颤抖高潮',

    ),



    QuizItem(
      id: '${_maleSTypeId}_pain_09', 
      name: '拍打阴部', 
      categoryId: '${_maleSTypeId}_pain_pleasure',
      description: '用手掌或工具轻轻拍打女M的骚穴阴部,让私处充血敏感,增强后续鸡巴插入刺激的快感',

    ),



    QuizItem(
      id: '${_maleSTypeId}_pain_10', 
      name: '咬乳头', 
      categoryId: '${_maleSTypeId}_pain_pleasure',
      description: '用牙齿轻咬或重咬女M的奶头乳头,在痛感和快感之间控制力度,让她欲罢不能',

    ),



    QuizItem(
      id: '${_maleSTypeId}_pain_11', 
      name: '痛苦中强制高潮', 
      categoryId: '${_maleSTypeId}_pain_pleasure',
      description: '在对女M施加痛楚的同时用鸡巴或玩具刺激她骚穴的敏感部位,让她在痛苦中被强制高潮',

    ),



    QuizItem(
      id: '${_maleSTypeId}_pain_12', 
      name: '连续抽插折磨', 
      categoryId: '${_maleSTypeId}_pain_pleasure',
      description: '长时间大力用鸡巴抽插女M的骚穴阴道,让她在持续的磨擦和强烈刺激中感受痛与快的混合',


  ),

  ];


  // 羞辱降格
  static final List<QuizItem> _maleSHumiliationItems = [
    QuizItem(
      id: '${_maleSTypeId}_humiliation_01', 
      name: '骂女M是淫荡母狗', 
      categoryId: '${_maleSTypeId}_humiliation',
      description: '在调教过程中用淫荡、母狗、贱狗等侮辱性词汇称呼女M,摧毁她的尊严,强化低贱身份让骚穴被鸡巴操',

    ),



    QuizItem(
      id: '${_maleSTypeId}_humiliation_02', 
      name: '称呼骚货贱货', 
      categoryId: '${_maleSTypeId}_humiliation',
      description: '强迫女M接受骚货、贱货、荡妇等低侮称呼,让她在羞耻中承认自己的淫荡本质和骚穴被操',

    ),



    QuizItem(
      id: '${_maleSTypeId}_humiliation_03', 
      name: '当众展示湿透的骚穴', 
      categoryId: '${_maleSTypeId}_humiliation',
      description: '命令女M当众或在特定人面前展示她湿透的骚穴，让她在众目睽睽之下体验羞耻',

    ),



    QuizItem(
      id: '${_maleSTypeId}_humiliation_04', 
      name: '在乳房上写淫语', 
      categoryId: '${_maleSTypeId}_humiliation',
      description: '用马克笔或口红在女M的奶子乳房上写下淫荡、性奴、肉便器等文字,标记她的身份',

    ),



    QuizItem(
      id: '${_maleSTypeId}_humiliation_05', 
      name: '在阴部写肉便器', 
      categoryId: '${_maleSTypeId}_humiliation',
      description: '在女M最私密的骚穴写上肉便器、公用母狗等文字,强化她被物化的羞耻感',

    ),



    QuizItem(
      id: '${_maleSTypeId}_humiliation_06', 
      name: '拍摄流淫水特写', 
      categoryId: '${_maleSTypeId}_humiliation',
      description: '用手机或相机拍摄女M骚穴阴部流淫水的特写镜头,记录她淫荡的证据,增加羞耻感',

    ),



    QuizItem(
      id: '${_maleSTypeId}_humiliation_07', 
      name: '让女M自述淫荡', 
      categoryId: '${_maleSTypeId}_humiliation',
      description: '强迫女M亲口说出自己有多么淫荡、多么骚、多么想被鸡巴插入骚穴被操,让她自我羞辱',

    ),



    QuizItem(
      id: '${_maleSTypeId}_humiliation_08', 
      name: '展示高潮时表情', 
      categoryId: '${_maleSTypeId}_humiliation',
      description: '命令女M在高潮时保持眼睛张开或拍摄她被鸡巴操高潮时的淫荡表情,记录她失控的样子',

    ),



    QuizItem(
      id: '${_maleSTypeId}_humiliation_09', 
      name: '吐口水在阴部', 
      categoryId: '${_maleSTypeId}_humiliation',
      description: '当着女M的面吐口水在她的骚穴阴部上,然后命令她继续接受鸡巴侵犯插入,增强侮辱感',

    ),



    QuizItem(
      id: '${_maleSTypeId}_humiliation_10', 
      name: '当肉便器使用', 
      categoryId: '${_maleSTypeId}_humiliation',
      description: '将女M当作肉便器随意用鸡巴插入骚穴使用,完全忽视她的感受,只将她作为满足欲望的工具',

    ),



    QuizItem(
      id: '${_maleSTypeId}_humiliation_11', 
      name: '射精在脸上', 
      categoryId: '${_maleSTypeId}_humiliation',
      description: '将精液射在女M的脸上,让她带着精液感受羞耻,标记她骚穴属于你鸡巴的事实',

    ),



    QuizItem(
      id: '${_maleSTypeId}_humiliation_12', 
      name: '颜射后拍照', 
      categoryId: '${_maleSTypeId}_humiliation',
      description: '在射精在女M脸上后拍摄照片或视频,记录她被颜射的淫荡样子,加深羞耻感',


  ),

  ];


  // 宠物调教
  static final List<QuizItem> _maleSPetTrainingItems = [
    QuizItem(
      id: '${_maleSTypeId}_pet_01', 
      name: '母狗爬行露阴', 
      categoryId: '${_maleSTypeId}_pet_training',
      description: '命令女M像狗一样四肢着地爬行，在爬行过程中臀部翘起，骚穴完全暴露，强化宠物身份等待鸡巴插入',

    ),



    QuizItem(
      id: '${_maleSTypeId}_pet_02', 
      name: '用狗碗喂食喂水', 
      categoryId: '${_maleSTypeId}_pet_training',
      description: '将食物和水放在狗碗中，让女M跪在地上像狗一样进食，不允许使用手，完全宠物化然后鸡巴插入骚穴操她',

    ),



    QuizItem(
      id: '${_maleSTypeId}_pet_03', 
      name: '戴项圈系肛塞尾巴', 
      categoryId: '${_maleSTypeId}_pet_training',
      description: '给女M戴上宠物项圈，并在肛门插入带尾巴的肛塞，让她完全装扮成母狗的样子等待鸡巴插入骚穴',

    ),



    QuizItem(
      id: '${_maleSTypeId}_pet_04', 
      name: '学母狗叫春发情', 
      categoryId: '${_maleSTypeId}_pet_training',
      description: '要求女M学狗叫，发出母狗发情时的叫声，在羞耻中展现发情渴望鸡巴插入骚穴交配的样子',

    ),



    QuizItem(
      id: '${_maleSTypeId}_pet_05', 
      name: '摇尾乞求插入', 
      categoryId: '${_maleSTypeId}_pet_training',
      description: '让女M摇晃肛塞尾巴，像发情的母狗一样摇尾乞求主人用鸡巴插入骚穴操她，表达性需求',

    ),



    QuizItem(
      id: '${_maleSTypeId}_pet_06', 
      name: '舔脚趾舔鸡巴', 
      categoryId: '${_maleSTypeId}_pet_training',
      description: '命令女M像狗一样用舌头舔你的脚趾和鸡巴，以宠物的方式服侍主人让鸡巴硬起来',

    ),



    QuizItem(
      id: '${_maleSTypeId}_pet_07', 
      name: '用嘴叼安全套', 
      categoryId: '${_maleSTypeId}_pet_training',
      description: '训练女M用嘴叼着安全套爬过来献给主人，像狗狗叼东西一样服从指令等待鸡巴插入',

    ),



    QuizItem(
      id: '${_maleSTypeId}_pet_08', 
      name: '跪下露出阴部', 
      categoryId: '${_maleSTypeId}_pet_training',
      description: '命令女M跪下并抬高臀部，像母狗等待交配一样完全露出骚穴和肛门等待鸡巴插入',

    ),



    QuizItem(
      id: '${_maleSTypeId}_pet_09', 
      name: '穿兽耳猫尾', 
      categoryId: '${_maleSTypeId}_pet_training',
      description: '让女M穿戴兽耳发箍和猫尾（或狗尾）肠塞，装扮成宠物的样子接受鸡巴插入骚穴调教',

    ),



    QuizItem(
      id: '${_maleSTypeId}_pet_10', 
      name: '禁止人语只准叫', 
      categoryId: '${_maleSTypeId}_pet_training',
      description: '规定女M在宠物调教时不准说人话，只能发出狗叫或猫叫声，剥夺人的语言能力等待被操',

    ),



    QuizItem(
      id: '${_maleSTypeId}_pet_11', 
      name: '母狗吃食露阴部', 
      categoryId: '${_maleSTypeId}_pet_training',
      description: '让女M在进食时保持四肢着地、臀部高抬的姿势，骚穴阴部持续暴露展示等待鸡巴插入',

    ),



    QuizItem(
      id: '${_maleSTypeId}_pet_12', 
      name: '牵绳外出遛狗', 
      categoryId: '${_maleSTypeId}_pet_training',
      description: '用狗绳牵着女M外出，像遛宠物一样在公共场合或私密空间散步，强化主宠关系等待被鸡巴操',

    ),



    QuizItem(
      id: '${_maleSTypeId}_pet_13', 
      name: '训练抬腿尿尿', 
      categoryId: '${_maleSTypeId}_pet_training',
      description: '训练女M像狗一样抬起一条腿小便，在羞耻中完成这个极度降格的宠物化行为露出骚穴',

    ),



    QuizItem(
      id: '${_maleSTypeId}_pet_14', 
      name: '母狗交配姿势', 
      categoryId: '${_maleSTypeId}_pet_training',
      description: '要求女M摆出狗狗交配的姿势，跪着臀部高抬露出骚穴，等待主人鸡巴从后面插入操她',

    ),



    QuizItem(
      id: '${_maleSTypeId}_pet_15', 
      name: '在狗窝里睡觉', 
      categoryId: '${_maleSTypeId}_pet_training',
      description: '安排女M在狗窝或笼子里睡觉休息，完全将她作为宠物对待，彻底宠物化等待鸡巴插入',


  ),

  ];


  // 物化调教
  static final List<QuizItem> _maleSObjectTrainingItems = [
    QuizItem(id: '${_maleSTypeId}_object_01', name: '当作泄欲工具', categoryId: '${_maleSTypeId}_object_training', description: '将女M完全当作满足性欲的工具使用，忽视她的情感和需求，只为了用鸡巴插入骚穴操她自己的快乐'),
    QuizItem(id: '${_maleSTypeId}_object_02', name: '当作精液容器', categoryId: '${_maleSTypeId}_object_training', description: '将女M的身体当作承装精液的容器，随意射精在她奶子骚穴上或骚穴肛门体内，将她物化为精液容器'),
    QuizItem(id: '${_maleSTypeId}_object_03', name: '当作肉便器', categoryId: '${_maleSTypeId}_object_training', description: '将女M当作一个肉便器随时使用，完全忽略她的人格和尊严，只将她的嘴、骚穴、肛门作为鸡巴性工具'),
    QuizItem(id: '${_maleSTypeId}_object_04', name: '随意使用三个洞', categoryId: '${_maleSTypeId}_object_training', description: '不经她同意随意用鸡巴使用女M的嘴、骚穴、肛门三个洞，将她当作多功能性工具'),
    QuizItem(id: '${_maleSTypeId}_object_05', name: '任意玩弄乳房阴部', categoryId: '${_maleSTypeId}_object_training', description: '像玩玩具一样随意揉揉摸摸女M的奶子乳房和骚穴阴部，将她的身体部位当作玩物'),
    QuizItem(id: '${_maleSTypeId}_object_06', name: '在阴部打烙印', categoryId: '${_maleSTypeId}_object_training', description: '用烧热的金属在女M的骚穴阴部打上烙印标记，像牲畜一样标记所有权等待被鸡巴操'),
    QuizItem(id: '${_maleSTypeId}_object_07', name: '编号性奴', categoryId: '${_maleSTypeId}_object_training', description: '给女M编上数字号码，用号码称呼她而不是名字，彻底物化她的身份只是鸡巴肉便器'),
    QuizItem(id: '${_maleSTypeId}_object_08', name: '展示湿透阴部', categoryId: '${_maleSTypeId}_object_training', description: '命令女M像展示商品一样展示她湿透的骚穴阴部，将她当作性商品陈列等待鸡巴插入'),
    QuizItem(id: '${_maleSTypeId}_object_09', name: '穿乳环阴环', categoryId: '${_maleSTypeId}_object_training', description: '给女M的奶头乳头和阴唇穿上金属环，像牲畜一样标记她的所有权等待被操'),
    QuizItem(id: '${_maleSTypeId}_object_10', name: '改造成完美性奴', categoryId: '${_maleSTypeId}_object_training', description: '通过长期调教将女M改造培养成完全服从的性奴工具，只知道服从和取悦鸡巴'),
    QuizItem(id: '${_maleSTypeId}_object_11', name: '在乳房纹身', categoryId: '${_maleSTypeId}_object_training', description: '在女M的奶子乳房上刺上纹身，永久性地标记她的性奴身份和属于你的事实'),
    QuizItem(id: '${_maleSTypeId}_object_12', name: '下体永久标记', categoryId: '${_maleSTypeId}_object_training', description: '在女M的骚穴阴部或臀部刺上永久性纹身或烙印，永久标记她的所有权等待鸡巴'),
    QuizItem(id: '${_maleSTypeId}_object_13', name: '当性爱娃娃使用', categoryId: '${_maleSTypeId}_object_training', description: '将女M当作性爱娃娃一样随意摆布姿势使用，完全将她物化为鸡巴性玩具被插入操'),
    QuizItem(id: '${_maleSTypeId}_object_14', name: '随时随地插入', categoryId: '${_maleSTypeId}_object_training', description: '不分时间地点随时随地用鸡巴插入女M骚穴，将她当作随时可用的性工具'),
    QuizItem(id: '${_maleSTypeId}_object_15', name: '作为肉体玩物', categoryId: '${_maleSTypeId}_object_training', description: '将女M完全当作供你玩乐的肉体玩物，忽略她的一切情感和需求用鸡巴操她'),
  ];

  // 公开调教
  static final List<QuizItem> _maleSPublicTrainingItems = [
    QuizItem(id: '${_maleSTypeId}_public_01', name: '野外露出乳房阴部', categoryId: '${_maleSTypeId}_public_training', description: '在野外公园或人迹稀少的地方命令女M露出乳房和阴部，体验被发现的刺激和羞耻'),
    QuizItem(id: '${_maleSTypeId}_public_02', name: '公共场合遥控跳蛋', categoryId: '${_maleSTypeId}_public_training', description: '让女M在公共场合放入遥控跳蛋，由你远程控制震动，让她在人群中忍受刺激'),
    QuizItem(id: '${_maleSTypeId}_public_03', name: '车内指奸到高潮', categoryId: '${_maleSTypeId}_public_training', description: '在行驶的车辆中用手指插入女M的骚穴，刺激她在公共空间到达高潮'),
    QuizItem(id: '${_maleSTypeId}_public_04', name: '电影院手指插入', categoryId: '${_maleSTypeId}_public_training', description: '在电影院黑暗的环境中手指插入女M的骚穴，让她在人群中忍住呻吟'),
    QuizItem(id: '${_maleSTypeId}_public_05', name: '试衣间内做爱', categoryId: '${_maleSTypeId}_public_training', description: '在商场试衣间的狭小空间内进行性行为，体验被发现的紧张和刺激'),
    QuizItem(id: '${_maleSTypeId}_public_06', name: '商场不穿内裤', categoryId: '${_maleSTypeId}_public_training', description: '命令女M在逛商场时不穿内裤，让她在人群中感受随时可能被暴露的羞耻'),
    QuizItem(id: '${_maleSTypeId}_public_07', name: '电梯内抠弄骚穴', categoryId: '${_maleSTypeId}_public_training', description: '在电梯里趁别人不注意时快速抠弄女M的骚穴，让她体验刺激'),
    QuizItem(id: '${_maleSTypeId}_public_08', name: '餐厅桌下自慰', categoryId: '${_maleSTypeId}_public_training', description: '在餐厅就餐时命令女M在桌布遮掩下秘密自慰，体验公开场合的羞耻'),
    QuizItem(id: '${_maleSTypeId}_public_09', name: '街头遥控震动器', categoryId: '${_maleSTypeId}_public_training', description: '让女M在街头行走时体内佩戴遥控震动器，随时开启刺激她'),
    QuizItem(id: '${_maleSTypeId}_public_10', name: '公园内露出调教', categoryId: '${_maleSTypeId}_public_training', description: '在公园的隐蔽角落进行露出调教，让女M体验被发现的恐惧和兴奋'),
    QuizItem(id: '${_maleSTypeId}_public_11', name: '公共厕所做爱', categoryId: '${_maleSTypeId}_public_training', description: '在公共厕所的隔间内进行性行为，体验被听到的羞耻和刺激'),
    QuizItem(id: '${_maleSTypeId}_public_12', name: '地铁上遥控玩具', categoryId: '${_maleSTypeId}_public_training', description: '让女M在拥挤的地铁车厢内使用遥控玩具，在人群中忍受刺激'),
    QuizItem(id: '${_maleSTypeId}_public_13', name: '办公室指奸', categoryId: '${_maleSTypeId}_public_training', description: '在办公室的办公桌下或隔间内用手指插入女M的骚穴，让她体验职场刺激'),
    QuizItem(id: '${_maleSTypeId}_public_14', name: '停车场车震', categoryId: '${_maleSTypeId}_public_training', description: '在停车场的车内进行性行为，让女M体验被旁边车辆发现的刺激'),
    QuizItem(id: '${_maleSTypeId}_public_15', name: '酒店大堂露出', categoryId: '${_maleSTypeId}_public_training', description: '让女M在酒店大堂或走廊穿着超短裙或透明衣物，接近露出状态'),
  ];

  // 感官控制
  static final List<QuizItem> _maleSensoryItems = [
    QuizItem(id: '${_maleSTypeId}_sensory_01', name: '蒙眼后玩弄骚穴', categoryId: '${_maleSTypeId}_sensory', description: '用眼罩遮住女M的视觉，在她看不见的情况下玩弄骚穴，增强感官敏感度'),
    QuizItem(id: '${_maleSTypeId}_sensory_02', name: '蒙眼插入骚穴', categoryId: '${_maleSTypeId}_sensory', description: '蒙住女M的眼睛后用鸡巴插入她的骚穴，让她在黑暗中全神贯注地感受插入刺激'),
    QuizItem(id: '${_maleSTypeId}_sensory_03', name: '轻抚敏感阴蒂', categoryId: '${_maleSTypeId}_sensory', description: '用极轻的触摸和抚摸刺激女M敏感的阴蒂，让她在若有若无的刺激中渴望更多'),
    QuizItem(id: '${_maleSTypeId}_sensory_04', name: '冰块刺激乳头', categoryId: '${_maleSTypeId}_sensory', description: '用冰块在女M的乳头上滚动，让她体验冰凉和热烈交替的感官冲击'),
    QuizItem(id: '${_maleSTypeId}_sensory_05', name: '振动棒刺激阴蒂', categoryId: '${_maleSTypeId}_sensory', description: '用高频振动棒持续刺激女M的阴蒂，通过震动给予强烈的感官刺激'),
    QuizItem(id: '${_maleSTypeId}_sensory_06', name: '羽毛挑逗骚穴', categoryId: '${_maleSTypeId}_sensory', description: '用柔软的羽毛轻轻挑逗女M的骚穴，通过微妙的触感刺激敏感部位'),
    QuizItem(id: '${_maleSTypeId}_sensory_07', name: '窒息式抽插', categoryId: '${_maleSTypeId}_sensory', description: '在抽插时偶尔捂住女M的呼吸，让她在缺氧的窒息中体验强烈感官刺激'),
    QuizItem(id: '${_maleSTypeId}_sensory_08', name: '多点同时刺激', categoryId: '${_maleSTypeId}_sensory', description: '同时刺激女M的乳头、阴蒂、阴道等多个敏感部位，让她感官过载'),
    QuizItem(id: '${_maleSTypeId}_sensory_09', name: '剥夺感官折磨', categoryId: '${_maleSTypeId}_sensory', description: '蒙眼、堵耳、束缚等手段剥夺女M的感官，让她在剩余感官中体验强化刺激'),
    QuizItem(id: '${_maleSTypeId}_sensory_10', name: '边缘控制不让高潮', categoryId: '${_maleSTypeId}_sensory', description: '将女M刺激到高潮边缘后停止，反复折磨不让她释放，增强渴望'),
    QuizItem(id: '${_maleSTypeId}_sensory_11', name: '感官过载刺激', categoryId: '${_maleSTypeId}_sensory', description: '通过多种刺激方式同时作用，让女M的感官系统处于过载状态'),
    QuizItem(id: '${_maleSTypeId}_sensory_12', name: '热蜡滴乳头阴唇', categoryId: '${_maleSTypeId}_sensory', description: '将融化的热蜡滴落在女M的乳头和阴唇上，给予热痛的感官冲击'),
    QuizItem(id: '${_maleSTypeId}_sensory_13', name: '舌头舔遍全身', categoryId: '${_maleSTypeId}_sensory', description: '用舌头舔遍女M全身的敏感部位，通过温热湿润的触感刺激她'),
    QuizItem(id: '${_maleSTypeId}_sensory_14', name: '慢速深入折磨', categoryId: '${_maleSTypeId}_sensory', description: '用鸡巴极缓慢地深入女M的骚穴，让她清晰地感受每一寸插入的刺激'),
    QuizItem(id: '${_maleSTypeId}_sensory_15', name: '高频震动刺激', categoryId: '${_maleSTypeId}_sensory', description: '用高频震动玩具持续刺激女M的敏感部位，让她在震动中高潮'),
  ];

  // 心理支配
  static final List<QuizItem> _maleSPsychologicalItems = [
    QuizItem(id: '${_maleSTypeId}_psych_01', name: '让女M离不开鸡巴', categoryId: '${_maleSTypeId}_psychological', description: '通过长期调教让女M在心理上彻底依赖你的鸡巴，无法离开你的插入'),
    QuizItem(id: '${_maleSTypeId}_psych_02', name: '训练渴望被插入', categoryId: '${_maleSTypeId}_psychological', description: '培养女M对被插入的渴望，让她时刻想要被你的鸡巴填满'),
    QuizItem(id: '${_maleSTypeId}_psych_03', name: '培养对精液崇拜', categoryId: '${_maleSTypeId}_psychological', description: '通过心理暗示让女M崇拜和渴望你的精液，将精液视为奖赏'),
    QuizItem(id: '${_maleSTypeId}_psych_04', name: '暗示只能靠主人高潮', categoryId: '${_maleSTypeId}_psychological', description: '心理暗示女M只有被你调教才能高潮，其他方式都无法满足她'),
    QuizItem(id: '${_maleSTypeId}_psych_05', name: '听到命令就湿透', categoryId: '${_maleSTypeId}_psychological', description: '训练女M形成条件反射，听到你的命令或特定词语就会自动湿透'),
    QuizItem(id: '${_maleSTypeId}_psych_06', name: '否定其性价值', categoryId: '${_maleSTypeId}_psychological', description: '通过语言和行为否定女M的性价值，打击她的自信，让她更加依附你'),
    QuizItem(id: '${_maleSTypeId}_psych_07', name: '制造性愧疚感', categoryId: '${_maleSTypeId}_psychological', description: '让女M对自己的欲望产生愧疚感，只有在你的许可下才能释放'),
    QuizItem(id: '${_maleSTypeId}_psych_08', name: '性奖励性惩罚', categoryId: '${_maleSTypeId}_psychological', description: '通过性奖励和性惩罚的手段训练女M的行为，建立心理控制'),
    QuizItem(id: '${_maleSTypeId}_psych_09', name: '时而宠爱时而冷落', categoryId: '${_maleSTypeId}_psychological', description: '时而温柔时而冷漠，让女M在不确定中更加渴望你的关注和宠爱'),
    QuizItem(id: '${_maleSTypeId}_psych_10', name: '精神性控制', categoryId: '${_maleSTypeId}_psychological', description: '通过长期调教实现对女M的精神和心理全面控制'),
    QuizItem(id: '${_maleSTypeId}_psych_11', name: '建立性依赖', categoryId: '${_maleSTypeId}_psychological', description: '让女M在性上彻底依赖你，离开你就无法获得满足'),
    QuizItem(id: '${_maleSTypeId}_psych_12', name: '强化性奴意识', categoryId: '${_maleSTypeId}_psychological', description: '不断强化女M作为性奴的身份认同，让她接受并享受这个角色'),
    QuizItem(id: '${_maleSTypeId}_psych_13', name: '洗脑成淫娃', categoryId: '${_maleSTypeId}_psychological', description: '通过长期的心理暗示和调教将女M改造成只知道满足欲望的淫娃'),
    QuizItem(id: '${_maleSTypeId}_psych_14', name: '条件反射训练', categoryId: '${_maleSTypeId}_psychological', description: '训练女M形成特定的条件反射，听到或看到特定刺激就会产生性反应'),
    QuizItem(id: '${_maleSTypeId}_psych_15', name: '性心理操控', categoryId: '${_maleSTypeId}_psychological', description: '掌握女M的性心理，通过操控她的性欲望和满足来控制她'),
  ];

  // 极限调教
  static final List<QuizItem> _maleSExtremeItems = [
    QuizItem(id: '${_maleSTypeId}_extreme_01', name: '连续数小时抽插', categoryId: '${_maleSTypeId}_extreme', description: '连续数小时不间断地抽插女M，让她在超长时间的激烈刺激中虚脱'),
    QuizItem(id: '${_maleSTypeId}_extreme_02', name: '忍受极限扩张', categoryId: '${_maleSTypeId}_extreme', description: '用巨大的玩具或多重插入极限扩张女M的阴道或肛门，让她忍受极限刺激'),
    QuizItem(id: '${_maleSTypeId}_extreme_03', name: '多男轮流调教', categoryId: '${_maleSTypeId}_extreme', description: '安排多个男性轮流使用女M，让她被多人连续侵犯直到虚脱'),
    QuizItem(id: '${_maleSTypeId}_extreme_04', name: '强制连续高潮', categoryId: '${_maleSTypeId}_extreme', description: '不断刺激女M连续高潮不停歇，让她在过度快感中失去控制'),
    QuizItem(id: '${_maleSTypeId}_extreme_05', name: '长期禁止高潮', categoryId: '${_maleSTypeId}_extreme', description: '长时间禁止女M高潮，让她在持续的欲求不满中痛苦挣扎'),
    QuizItem(id: '${_maleSTypeId}_extreme_06', name: '贞操带锁阴部', categoryId: '${_maleSTypeId}_extreme', description: '给女M佩戴贞操带锁住阴部，完全掌控她的性权利，只有你才能解锁'),
    QuizItem(id: '${_maleSTypeId}_extreme_07', name: '24小时随时使用', categoryId: '${_maleSTypeId}_extreme', description: '全天候随时使用女M，不分白天黑夜，让她时刻准备着被侵犯'),
    QuizItem(id: '${_maleSTypeId}_extreme_08', name: '完全性奴隶化', categoryId: '${_maleSTypeId}_extreme', description: '将女M彻底改造成完全的性奴，失去自我意志，只知服从'),
    QuizItem(id: '${_maleSTypeId}_extreme_09', name: '公开性羞辱', categoryId: '${_maleSTypeId}_extreme', description: '在公开场合或当众对女M进行性羞辱，让她被更多人知道她的身份'),
    QuizItem(id: '${_maleSTypeId}_extreme_10', name: '身心彻底成为性奴', categoryId: '${_maleSTypeId}_extreme', description: '通过长期极限调教，让女M在身心上彻底成为你的性奴'),
    QuizItem(id: '${_maleSTypeId}_extreme_11', name: '三洞同时使用', categoryId: '${_maleSTypeId}_extreme', description: '同时使用女M的嘴、阴道、肛门三个洞，让她被完全填满'),
    QuizItem(id: '${_maleSTypeId}_extreme_12', name: '拳交扩张训练', categoryId: '${_maleSTypeId}_extreme', description: '用拳头或巨大物体插入女M的阴道或肛门，进行极限扩张训练'),
    QuizItem(id: '${_maleSTypeId}_extreme_13', name: '榨干到虚脱', categoryId: '${_maleSTypeId}_extreme', description: '持续刺激榨取女M直到她完全虚脱无力，失去意识'),
    QuizItem(id: '${_maleSTypeId}_extreme_14', name: '永久性改造', categoryId: '${_maleSTypeId}_extreme', description: '通过穿刺、纹身、整形等手段对女M进行永久性的身体改造'),
    QuizItem(id: '${_maleSTypeId}_extreme_15', name: '终身性契约', categoryId: '${_maleSTypeId}_extreme', description: '签订终身性契约，让女M永远成为你的性奴，无法解脱'),
  ];

  // 女S自测数据（调教男M的内容）
  static const String _femaleSTypeId = 'female_s';
  
  static final QuizType femaleSQuizType = QuizType(
    id: _femaleSTypeId,
    name: '女S自测',
    description: '探索你作为女性支配者的倾向，了解你在调教男M时的偏好和风格',
    iconPath: 'assets/icons/female_s.png',
    categories: _femaleSCategories,
  );

  static final List<QuizCategory> _femaleSCategories = [
    QuizCategory(
      id: '${_femaleSTypeId}_basic_dominance',
      name: '基础支配',
      quizTypeId: _femaleSTypeId,
      items: _femaleSBasicItems,
    ),
    QuizCategory(
      id: '${_femaleSTypeId}_verbal',
      name: '言语支配',
      quizTypeId: _femaleSTypeId,
      items: _femaleSVerbalItems,
    ),
    QuizCategory(
      id: '${_femaleSTypeId}_physical_control',
      name: '身体掌控',
      quizTypeId: _femaleSTypeId,
      items: _femaleSPhysicalControlItems,
    ),
    QuizCategory(
      id: '${_femaleSTypeId}_degradation',
      name: '羞辱降格',
      quizTypeId: _femaleSTypeId,
      items: _femaleSDegradationItems,
    ),
    QuizCategory(
      id: '${_femaleSTypeId}_service_demand',
      name: '服侍要求',
      quizTypeId: _femaleSTypeId,
      items: _femaleSServiceDemandItems,
    ),
    QuizCategory(
      id: '${_femaleSTypeId}_punishment',
      name: '惩罚手段',
      quizTypeId: _femaleSTypeId,
      items: _femaleSPunishmentItems,
    ),
    QuizCategory(
      id: '${_femaleSTypeId}_femdom',
      name: '女王调教',
      quizTypeId: _femaleSTypeId,
      items: _femaleSFemdomItems,
    ),
    QuizCategory(
      id: '${_femaleSTypeId}_psychological',
      name: '心理支配',
      quizTypeId: _femaleSTypeId,
      items: _femaleSPsychologicalItems,
    ),
    QuizCategory(
      id: '${_femaleSTypeId}_extreme',
      name: '极限支配',
      quizTypeId: _femaleSTypeId,
      items: _femaleSExtremeItems,
    ),
  ];

  // 基础支配
  static final List<QuizItem> _femaleSBasicItems = [
    QuizItem(
      id: '${_femaleSTypeId}_basic_01', 
      name: '要求男M称呼主人/女王', 
      categoryId: '${_femaleSTypeId}_basic_dominance',
      description: '在调教过程中要求男M必须称呼你为主人、女王、主母等尊称，建立明确的女王与奴仆的权力关系',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_basic_02', 
      name: '掌控男M勃起', 
      categoryId: '${_femaleSTypeId}_basic_dominance',
      description: '通过命令、触摸或心理暗示完全掌控男M的鸡巴勃起，决定他何时可以硬起来，何时必须软下去',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_basic_03', 
      name: '控制男M射精', 
      categoryId: '${_femaleSTypeId}_basic_dominance',
      description: '完全控制男M的射精权利，他必须在得到你的许可后才能射精液，违反则受到惩罚',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_basic_04', 
      name: '检查男M鸡巴', 
      categoryId: '${_femaleSTypeId}_basic_dominance',
      description: '定期检查男M的骚鸡巴状态，查看是否擅自硬起来或射精液，确保他完全服从你的管理',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_basic_05', 
      name: '玩弄男M蛋蛋', 
      categoryId: '${_femaleSTypeId}_basic_dominance',
      description: '随意玩弄抚摸男M的睾丸，掌握他最脆弱敏感的部位，让他在你手中颤抖',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_basic_06', 
      name: '决定男M射精位置', 
      categoryId: '${_femaleSTypeId}_basic_dominance',
      description: '决定男M必须将精液射在哪里，是你的脚上、地板上还是他自己身上，完全由你掌控他的淫精',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_basic_07', 
      name: '要求射精前请示', 
      categoryId: '${_femaleSTypeId}_basic_dominance',
      description: '规定男M在即将射精液前必须向你请示汇报，等待你的许可，否则将受到严厉惩罚',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_basic_08', 
      name: '用脚踩鸡巴', 
      categoryId: '${_femaleSTypeId}_basic_dominance',
      description: '用你的脚踩踏男M的骚鸡巴，让他感受到被你踩在脚下的屈辱和刺激',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_basic_09', 
      name: '让男M展示勃起', 
      categoryId: '${_femaleSTypeId}_basic_dominance',
      description: '命令男M当着你的面硬起来并展示他的骚鸡巴，检阅你的性奴工具',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_basic_10', 
      name: '禁止男M自慰', 
      categoryId: '${_femaleSTypeId}_basic_dominance',
      description: '严格禁止男M自己抚摸骚鸡巴自慰，他的鸡巴只属于你，只有你才能决定如何使用',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_basic_11', 
      name: '监督射精频率', 
      categoryId: '${_femaleSTypeId}_basic_dominance',
      description: '监控记录男M的射精次数和频率，决定他何时可以释放，完全掌控他的性快感',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_basic_12', 
      name: '掐握龟头掌控', 
      categoryId: '${_femaleSTypeId}_basic_dominance',
      description: '用手指掐握男M最敏感的龟头，通过痛感和快感的掌控让他臣服于你',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_basic_13', 
      name: '命令露出鸡巴', 
      categoryId: '${_femaleSTypeId}_basic_dominance',
      description: '随时命令男M脱下裤子露出鸡巴，让他时刻准备着展示他的性器供你查验',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_basic_14', 
      name: '掌控精液处理', 
      categoryId: '${_femaleSTypeId}_basic_dominance',
      description: '决定男M射出的精液如何处理，是让他自己吃掉、涂在身上还是射在地上舔干净',


 ),

  ];


 // 言语支配
  static final List<QuizItem> _femaleSVerbalItems = [
    QuizItem(
      id: '${_femaleSTypeId}_verbal_01', 
      name: '羞辱鸡巴太小', 
      categoryId: '${_femaleSTypeId}_verbal',
      description: '嘲笑羞辱男M的鸡巴太小太短，不够粗不够长，打击他的男性自信',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_verbal_02', 
      name: '嘲笑早泄', 
      categoryId: '${_femaleSTypeId}_verbal',
      description: '嘲笑男M射精太快，是个早泄的废物，完全不能让女人满足',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_verbal_03', 
      name: '骂垃圾公狗', 
      categoryId: '${_femaleSTypeId}_verbal',
      description: '用垃圾公狗、废物公狗、下贱公狗等侮辱性词汇称呼男M，摧毁他的尊严',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_verbal_04', 
      name: '称呼肉棒工具', 
      categoryId: '${_femaleSTypeId}_verbal',
      description: '将男M物化为肉棒工具、精液工具，不把他当人看，只是供你使用的性工具',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_verbal_05', 
      name: '否定男M性能力', 
      categoryId: '${_femaleSTypeId}_verbal',
      description: '否定贬低男M的性能力，说他不行、太软、没用，完全打击他的男性自尊',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_verbal_06', 
      name: '强制承认是母狗', 
      categoryId: '${_femaleSTypeId}_verbal',
      description: '强迫男M承认自己是贱母狗、发情的母狗，用语言彻底羞辱他的性别',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_verbal_07', 
      name: '命令报告勃起状态', 
      categoryId: '${_femaleSTypeId}_verbal',
      description: '命令男M随时汇报他的鸡巴是否勃起，硬度如何，让他羞耻地描述自己的性器状态',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_verbal_08', 
      name: '让男M重复淫语', 
      categoryId: '${_femaleSTypeId}_verbal',
      description: '强迫男M重复说出下贱的淫语，如"我是发情的公狗""我的鸡巴属于主人"等',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_verbal_09', 
      name: '强迫乞求射精', 
      categoryId: '${_femaleSTypeId}_verbal',
      description: '让男M用卑微下贱的语言乞求你允许他射精，享受他的恳求和臣服',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_verbal_10', 
      name: '言语否定存在价值', 
      categoryId: '${_femaleSTypeId}_verbal',
      description: '用语言否定男M的存在价值，告诉他除了鸡巴和精液外毫无用处',


  ),

  ];


  // 身体掌控
  static final List<QuizItem> _femaleSPhysicalControlItems = [
    QuizItem(
      id: '${_femaleSTypeId}_physical_01', 
      name: '用鞭子抽打鸡巴', 
      categoryId: '${_femaleSTypeId}_physical_control',
      description: '用皮鞭或竹鞭抽打男M的鸡巴，让他在痛楚中体验你的支配权',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_physical_02', 
      name: '脚踩踏蛋蛋', 
      categoryId: '${_femaleSTypeId}_physical_control',
      description: '用脚踩踏男M脆弱的睾丸，掌控他最敏感的要害部位',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_physical_03', 
      name: '拍打睾丸', 
      categoryId: '${_femaleSTypeId}_physical_control',
      description: '用手掌拍打男M的睾丸，让他在痛感中臣服',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_physical_04', 
      name: '指甲抓挠龟头', 
      categoryId: '${_femaleSTypeId}_physical_control',
      description: '用指甲在男M敏感的龟头上抓挠，给予痛痒交加的刺激',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_physical_05', 
      name: '夹龟头调教', 
      categoryId: '${_femaleSTypeId}_physical_control',
      description: '用专门的夹子夹住男M的龟头，通过持续的压迫和痛感进行调教',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_physical_06', 
      name: '绑缚鸡巴蛋蛋', 
      categoryId: '${_femaleSTypeId}_physical_control',
      description: '用绳子或皮带将男M的鸡巴和蛋蛋绑缚起来，限制他的性器',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_physical_07', 
      name: '滴蜡在龟头上', 
      categoryId: '${_femaleSTypeId}_physical_control',
      description: '将热蜡油滴在男M最敏感的龟头上，让他体验热痛的刺激',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_physical_08', 
      name: '冰火刺激鸡巴', 
      categoryId: '${_femaleSTypeId}_physical_control',
      description: '交替使用冰块和热蜡刺激男M的鸡巴，给予冷热交替的感官冲击',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_physical_09', 
      name: '后庭开发肛交', 
      categoryId: '${_femaleSTypeId}_physical_control',
      description: '用手指或假阳具开发男M的后庭，进行肛门调教和插入',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_physical_10', 
      name: '假阳具插肛门', 
      categoryId: '${_femaleSTypeId}_physical_control',
      description: '用假阳具插入男M的肛门，让他体验被插入的感觉',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_physical_11', 
      name: '电击鸡巴蛋蛋', 
      categoryId: '${_femaleSTypeId}_physical_control',
      description: '使用低压电击设备刺激男M的鸡巴和蛋蛋，让他在电流中颤抖',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_physical_12', 
      name: '痛苦训练耐受', 
      categoryId: '${_femaleSTypeId}_physical_control',
      description: '通过持续的痛感训练提高男M的痛苦耐受力，让他逐渐适应你的调教',


  ),

  ];


  // 羞辱降格
  static final List<QuizItem> _femaleSDegradationItems = [
    QuizItem(
      id: '${_femaleSTypeId}_degrade_01', 
      name: '让男M学公狗叫', 
      categoryId: '${_femaleSTypeId}_degradation',
      description: '强迫男M学狗叫，用公狗的叫声表达他的渴望和顺从',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_degrade_02', 
      name: '命令勃起爬行', 
      categoryId: '${_femaleSTypeId}_degradation',
      description: '命令男M在勃起状态下像狗一样爬行，鸡巴摆动着在地上擦过，充满羞辱感',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_degrade_03', 
      name: '让男M舔鞋舔脚趾', 
      categoryId: '${_femaleSTypeId}_degradation',
      description: '命令男M跪下舔你的鞋底和脚趾，展示他的卑微和你的高贵',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_degrade_04', 
      name: '吐口水在鸡巴上', 
      categoryId: '${_femaleSTypeId}_degradation',
      description: '吐口水在男M的鸡巴和脸上，用这种侮辱行为彰显你的轻蔑',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_degrade_05', 
      name: '让男M穿女装露鸡巴', 
      categoryId: '${_femaleSTypeId}_degradation',
      description: '强迫男M穿上女性内衣或连衣裙，但露出鸡巴，羞辱他的男性气质',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_degrade_06', 
      name: '给鸡巴涂口红', 
      categoryId: '${_femaleSTypeId}_degradation',
      description: '在男M的鸡巴上涂抹口红或彩妆，把他的性器女性化和低俗化',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_degrade_07', 
      name: '当众展示鸡巴', 
      categoryId: '${_femaleSTypeId}_degradation',
      description: '命令男M在特定人面前或公开场合露出展示他的鸡巴，体验羞耻',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_degrade_08', 
      name: '当人肉震动棒', 
      categoryId: '${_femaleSTypeId}_degradation',
      description: '将男M完全当作一根人肉震动棒使用，只关注他的鸡巴，忽略他的人格',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_degrade_09', 
      name: '羞耻射精姿势', 
      categoryId: '${_femaleSTypeId}_degradation',
      description: '命令男M以特定羞耻的姿势射精，如跪着、爬着或分开腿',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_degrade_10', 
      name: '拍摄射精视频', 
      categoryId: '${_femaleSTypeId}_degradation',
      description: '拍摄男M射精的视频或照片，用作控制和羞辱他的手段',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_degrade_11', 
      name: '物化成精液工具', 
      categoryId: '${_femaleSTypeId}_degradation',
      description: '将男M完全物化为生产精液的工具，他的价值只在于他的精液',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_degrade_12', 
      name: '在鸡巴上写下贱', 
      categoryId: '${_femaleSTypeId}_degradation',
      description: '用马克笔在男M的鸡巴上写下"下贱""小鸡巴""废物"等侮辱性文字',


  ),

  ];


  // 服侍要求
  static final List<QuizItem> _femaleSServiceDemandItems = [
    QuizItem(
      id: '${_femaleSTypeId}_service_01', 
      name: '舔脚服侍', 
      categoryId: '${_femaleSTypeId}_service_demand',
      description: '命令男M跪下用舌头舔你的脚趾和脚心，用嘴服侍你的双脚',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_service_02', 
      name: '用舌头服侍阴道', 
      categoryId: '${_femaleSTypeId}_service_demand',
      description: '要求男M用舌头舔舐服侍你的阴道和阴蒂，让他专注于取悦你',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_service_03', 
      name: '骑乘脸部磨蛋蛋', 
      categoryId: '${_femaleSTypeId}_service_demand',
      description: '骑坐在男M的脸上，用你的阴道磨擦他的脸，同时玩弄他的蛋蛋',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_service_04', 
      name: '用鸡巴按摩', 
      categoryId: '${_femaleSTypeId}_service_demand',
      description: '让男M用他勃起的鸡巴为你按摩身体，将他的性器当作按摩工具',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_service_05', 
      name: '精液按摩全身', 
      categoryId: '${_femaleSTypeId}_service_demand',
      description: '让男M射出精液后，用他的精液为你全身按摩',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_service_06', 
      name: '洗澡时服侍', 
      categoryId: '${_femaleSTypeId}_service_demand',
      description: '在洗澡时命令男M跪下用舌头舔舐服侍你的身体',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_service_07', 
      name: '用鸡巴随时服侍', 
      categoryId: '${_femaleSTypeId}_service_demand',
      description: '规定男M的鸡巴必须随时准备着服侍你的任何需求',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_service_08', 
      name: '吐精液服侍', 
      categoryId: '${_femaleSTypeId}_service_demand',
      description: '让男M射在自己嘴里再吐出来为你服侍，如涂抹在你脚上然后舔干净',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_service_09', 
      name: '吞食自己精液', 
      categoryId: '${_femaleSTypeId}_service_demand',
      description: '命令男M射精后必须自己吃掉所有精液，不允许浪费',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_service_10', 
      name: '用蛋蛋服侍', 
      categoryId: '${_femaleSTypeId}_service_demand',
      description: '要求男M用他的睾丸轻轻磨擦你的身体，用最脆弱的部位服侍你',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_service_11', 
      name: '勃起服侍', 
      categoryId: '${_femaleSTypeId}_service_demand',
      description: '要求男M必须保持勃起状态随时服侍你，不得软下',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_service_12', 
      name: '精液清洁服侍', 
      categoryId: '${_femaleSTypeId}_service_demand',
      description: '让男M用他的精液为你清洁身体或物品，将精液当作清洁剂',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_service_13', 
      name: '鸡巴插入服侍', 
      categoryId: '${_femaleSTypeId}_service_demand',
      description: '命令男M用鸡巴插入服侍你，完全按你的指示抽插',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_service_14', 
      name: '射精后清理', 
      categoryId: '${_femaleSTypeId}_service_demand',
      description: '要求男M在射精后立即清理干净所有精液，用舌头舔或纸巾擦',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_service_15', 
      name: '用龟头服侍', 
      categoryId: '${_femaleSTypeId}_service_demand',
      description: '让男M用他敏感的龟头轻轻按摩你的身体，用最敏感的部位服侍你',


  ),

  ];

  static final List<QuizItem> _femaleSPunishmentItems = [
    QuizItem(
      id: '${_femaleSTypeId}_punishment_01', 
      name: '禁止射精', 
      categoryId: '${_femaleSTypeId}_punishment',
      description: '在一定时间内完全禁止男M射精，让他在欲求不满中痛苦挣扎',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_punishment_02', 
      name: '绑鸡巴跪搓衣板', 
      categoryId: '${_femaleSTypeId}_punishment',
      description: '将男M的鸡巴绑缚起来，然后让他跪在搓衣板上反省，同时承受鸡巴的束缚痛苦',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_punishment_03', 
      name: '勃起面壁思过', 
      categoryId: '${_femaleSTypeId}_punishment',
      description: '命令男M在勃起状态下面对墙壁站立思过，不得触碰鸡巴，直至自然软下',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_punishment_04', 
      name: '绑缚鸡巴蛋蛋', 
      categoryId: '${_femaleSTypeId}_punishment',
      description: '用绳子紧紧绑缚男M的鸡巴和蛋蛋，让他在束缚中感受痛苦和惩罚',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_punishment_05', 
      name: '强制观看绿帽', 
      categoryId: '${_femaleSTypeId}_punishment',
      description: '惩罚性地强迫男M观看你和其他男人的亲密场景，给予心理痛苦',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_punishment_06', 
      name: '禁止碰鸡巴', 
      categoryId: '${_femaleSTypeId}_punishment',
      description: '严格禁止男M触碰他自己的鸡巴，即使勃起也不能缓解',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_punishment_07', 
      name: '当众鸡巴惩罚', 
      categoryId: '${_femaleSTypeId}_punishment',
      description: '在特定人面前惩罚男M的鸡巴，让他在众目睽睽下体验羞辱和痛苦',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_punishment_08', 
      name: '冷落不让勃起', 
      categoryId: '${_femaleSTypeId}_punishment',
      description: '完全忽视冷落男M，不给予任何刺激，让他渴望但无法勃起',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_punishment_09', 
      name: '鸡巴体罚', 
      categoryId: '${_femaleSTypeId}_punishment',
      description: '直接对男M的鸡巴进行体罚，如拍打、弹击、夹击等',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_punishment_10', 
      name: '罚站露鸡巴', 
      categoryId: '${_femaleSTypeId}_punishment',
      description: '命令男M罚站并露出鸡巴，在长时间的站立中体验羞耻和疲惫',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_punishment_11', 
      name: '鸡巴拍打惩罚', 
      categoryId: '${_femaleSTypeId}_punishment',
      description: '用手掌或工具直接拍打男M的鸡巴，让他在痛楚中接受惩罚',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_punishment_12', 
      name: '蛋蛋惩罚', 
      categoryId: '${_femaleSTypeId}_punishment',
      description: '针对男M脆弱的睾丸进行惩罚，轻拍或挤压让他铭记教训',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_punishment_13', 
      name: '禁止勃起', 
      categoryId: '${_femaleSTypeId}_punishment',
      description: '禁止男M勃起，如果勃起就予以惩罚，完全控制他的生理反应',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_punishment_14', 
      name: '射精后继续刺激', 
      categoryId: '${_femaleSTypeId}_punishment',
      description: '在男M射精后继续刺激他超敏感的龟头，让他在痛苦中承受过度刺激',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_punishment_15', 
      name: '精液惩罚', 
      categoryId: '${_femaleSTypeId}_punishment',
      description: '强迫男M将自己的精液涂抹在身上或吃掉，用精液进行羞辱性惩罚',

    ),

  ];

  // 女王调教
  static final List<QuizItem> _femaleSFemdomItems = [
    QuizItem(
      id: '${_femaleSTypeId}_femdom_01', 
      name: '高跟踩鸡巴', 
      categoryId: '${_femaleSTypeId}_femdom',
      description: '穿着高跟鞋用脚踩在男M的鸡巴上，展现女王的威严和支配力',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_femdom_02', 
      name: '用鞋底蹭龟头', 
      categoryId: '${_femaleSTypeId}_femdom',
      description: '用高跟鞋的鞋底轻轻蹭动男M敏感的龟头，给予他羞辱性的刺激',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_femdom_03', 
      name: '丝袜脚交', 
      categoryId: '${_femaleSTypeId}_femdom',
      description: '穿着丝袜用双脚夹住男M的鸡巴进行脚交，让他在丝袜的柔滑中高潮',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_femdom_04', 
      name: '坐姿命令射精', 
      categoryId: '${_femaleSTypeId}_femdom',
      description: '以女王的坐姿坦然地命令男M射精，展现你对他的绝对掌控',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_femdom_05', 
      name: '高跟鞋夹鸡巴', 
      categoryId: '${_femaleSTypeId}_femdom',
      description: '用两只高跟鞋夹住男M的鸡巴，通过鞋跟的硬度给予他痛感和刺激',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_femdom_06', 
      name: '脚趾踩蛋蛋', 
      categoryId: '${_femaleSTypeId}_femdom',
      description: '用脚趾轻轻踩踏男M的蛋蛋，掌控他最脆弱的部位',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_femdom_07', 
      name: '用脚掌掌控勃起', 
      categoryId: '${_femaleSTypeId}_femdom',
      description: '用脚掌摸弄男M的鸡巴，掌控他的勃起和高潮',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_femdom_08', 
      name: '脚心磨龟头', 
      categoryId: '${_femaleSTypeId}_femdom',
      description: '用柔软的脚心磨擦男M敏感的龟头，给予柔和与支配的刺激',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_femdom_09', 
      name: '脚趾控制射精', 
      categoryId: '${_femaleSTypeId}_femdom',
      description: '用脚趾夹住男M的鸡巴，掌控他射精的节奏和时机',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_femdom_10', 
      name: '踩脸用鸡巴舔脚', 
      categoryId: '${_femaleSTypeId}_femdom',
      description: '踩在男M脸上，同时命令他用鸡巴蹭动你的脚，双重羞辱',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_femdom_11', 
      name: '用脚振动鸡巴', 
      categoryId: '${_femaleSTypeId}_femdom',
      description: '用脚快速摩擦男M的鸡巴，像振动器一样刺激他',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_femdom_12', 
      name: '脚趾玩弄蛋蛋', 
      categoryId: '${_femaleSTypeId}_femdom',
      description: '用脚趾夹住男M的蛋蛋轻轻玩弄，通过脚掌控他的要害',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_femdom_13', 
      name: '踩鸡巴命令勃起', 
      categoryId: '${_femaleSTypeId}_femdom',
      description: '踩着男M的鸡巴命令他必须勃起，让他在压迫中勃起',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_femdom_14', 
      name: '用脚夹鸡巴插入', 
      categoryId: '${_femaleSTypeId}_femdom',
      description: '用双脚夹住男M的鸡巴，像脚交一样让他在你的双脚中抽插',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_femdom_15', 
      name: '脚心接受精液', 
      categoryId: '${_femaleSTypeId}_femdom',
      description: '命令男M射精在你的脚心上，然后要求他舔干净',


  ),

  ];


  // 心理支配
  static final List<QuizItem> _femaleSPsychologicalItems = [
    QuizItem(
      id: '${_femaleSTypeId}_psych_01', 
      name: '建立射精依赖', 
      categoryId: '${_femaleSTypeId}_psychological',
      description: '通过长期调教让男M在心理上彻底依赖你的许可才能射精，无法离开你的掌控',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_psych_02', 
      name: '强化鸡巴服从', 
      categoryId: '${_femaleSTypeId}_psychological',
      description: '训练男M的鸡巴完全服从你的命令，听到你的声音就会自动勃起或软下',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_psych_03', 
      name: '培养鸡巴崇拜', 
      categoryId: '${_femaleSTypeId}_psychological',
      description: '让男M从心里崇拜和感激你对他鸡巴的掌控，将你的命令视为恩赐',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_psych_04', 
      name: '暗示只能为主人勃起', 
      categoryId: '${_femaleSTypeId}_psychological',
      description: '心理暗示男M的鸡巴只能为你勃起，对其他人完全无法有反应',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_psych_05', 
      name: '否定鸡巴价值', 
      categoryId: '${_femaleSTypeId}_psychological',
      description: '通过语言和行为否定男M鸡巴的价值，让他觉得只有你才愿意使用',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_psych_06', 
      name: '制造射精愧疚感', 
      categoryId: '${_femaleSTypeId}_psychological',
      description: '让男M对自己的射精产生愧疚感，只有在你的许可下才能无愧地释放',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_psych_07', 
      name: '射精奖励惩罚', 
      categoryId: '${_femaleSTypeId}_psychological',
      description: '通过射精奖励和射精惩罚的手段训练男M的行为，建立心理控制',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_psych_08', 
      name: '对鸡巴冷热交替', 
      categoryId: '${_femaleSTypeId}_psychological',
      description: '时而温柔时而冷漠地对待男M的鸡巴，让他在不确定中更加渴望你的关注',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_psych_09', 
      name: '精神掌控勃起', 
      categoryId: '${_femaleSTypeId}_psychological',
      description: '通过心理暗示和精神掌控，不需要触碰就能让男M勃起或软下',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_psych_10', 
      name: '心理操纵射精', 
      categoryId: '${_femaleSTypeId}_psychological',
      description: '掌握男M的心理，通过语言和氛围控制他的射精时机和强度',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_psych_11', 
      name: '洗脑鸡巴属于主人', 
      categoryId: '${_femaleSTypeId}_psychological',
      description: '通过长期的心理暗示让男M深信他的鸡巴完全属于你，他只是代为保管',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_psych_12', 
      name: '条件反射勃起训练', 
      categoryId: '${_femaleSTypeId}_psychological',
      description: '训练男M形成条件反射，听到特定声音或看到特定画面就会自动勃起',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_psych_13', 
      name: '心理掌控蛋蛋', 
      categoryId: '${_femaleSTypeId}_psychological',
      description: '让男M在心理上认为他的蛋蛋是你的玩物，他自己无权保护',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_psych_14', 
      name: '精神支配精液', 
      categoryId: '${_femaleSTypeId}_psychological',
      description: '让男M相信他的精液只能为你而射，其他时间都是浪费',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_psych_15', 
      name: '心理改造性奴', 
      categoryId: '${_femaleSTypeId}_psychological',
      description: '通过长期的心理调教将男M改造成完全的鸡巴性奴，失去自我意志',


  ),

  ];


  // 极限支配
  static final List<QuizItem> _femaleSExtremeItems = [
    QuizItem(
      id: '${_femaleSTypeId}_extreme_01', 
      name: '贞操锁锁鸡巴', 
      categoryId: '${_femaleSTypeId}_extreme',
      description: '给男M佩戴贞操锁将鸡巴锁住，完全掌控他的性权利，只有你才能解锁',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_extreme_02', 
      name: '24/7禁射支配', 
      categoryId: '${_femaleSTypeId}_extreme',
      description: '全天候禁止男M射精，不分时间地点全面掌控他的射精权',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_extreme_03', 
      name: '完全射精权交换', 
      categoryId: '${_femaleSTypeId}_extreme',
      description: '让男M完全放弃射精自主权，将一切射精权利交给你掌管',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_extreme_04', 
      name: '极限鸡巴羞辱', 
      categoryId: '${_femaleSTypeId}_extreme',
      description: '对男M的鸡巴进行极限的羞辱，如公开展示、当众调教、永久标记等',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_extreme_05', 
      name: '分享鸡巴给别人', 
      categoryId: '${_femaleSTypeId}_extreme',
      description: '将男M的鸡巴分享给其他人使用，让他明白他的鸡巴完全是你的财产',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_extreme_06', 
      name: '强制双性化调教', 
      categoryId: '${_femaleSTypeId}_extreme',
      description: '强制男M接受双性化调教，用假阳具插入他，让他体验被插入的感觉',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_extreme_07', 
      name: '极限鸡巴痛苦', 
      categoryId: '${_femaleSTypeId}_extreme',
      description: '对男M的鸡巴和蛋蛋施加极限痛苦，让他在痛楚中完全臣服',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_extreme_08', 
      name: '终身性契约', 
      categoryId: '${_femaleSTypeId}_extreme',
      description: '签订终身性契约，让男M永远成为你的鸡巴奴隶，无法解脱',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_extreme_09', 
      name: '完全掌控鸡巴蛋蛋', 
      categoryId: '${_femaleSTypeId}_extreme',
      description: '全面彻底地掌控男M的鸡巴和蛋蛋，他的性器完全属于你',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_extreme_10', 
      name: '身心鸡巴彻底臣服', 
      categoryId: '${_femaleSTypeId}_extreme',
      description: '通过极限调教让男M在身心上彻底臣服，他的鸡巴只为你而存在',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_extreme_11', 
      name: '极限榨精训练', 
      categoryId: '${_femaleSTypeId}_extreme',
      description: '连续不断地榨取男M的精液直到他完全虚脱，无法再射',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_extreme_12', 
      name: '长期禁绝射精', 
      categoryId: '${_femaleSTypeId}_extreme',
      description: '长达数周或数月禁止男M射精，让他在极限的欲求不满中挣扎',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_extreme_13', 
      name: '永久性奴标记', 
      categoryId: '${_femaleSTypeId}_extreme',
      description: '在男M的鸡巴上刺上永久性纹身或烙印，永久标记他的所有权',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_extreme_14', 
      name: '强制连续射精', 
      categoryId: '${_femaleSTypeId}_extreme',
      description: '强迫男M连续多次射精不停歇，直到他完全虚脱无力',

    ),



    QuizItem(
      id: '${_femaleSTypeId}_extreme_15', 
      name: '完全鸡巴所有权', 
      categoryId: '${_femaleSTypeId}_extreme',
      description: '宣告对男M鸡巴的完全所有权，他的鸡巴从此只属于你，不再属于他自己',

    ),

  ];
}

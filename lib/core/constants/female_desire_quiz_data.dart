import '../../domain/models/quiz_type.dart';
import '../../domain/models/quiz_category.dart';
import '../../domain/models/quiz_item.dart';


class FemaleDesireQuizData {
  FemaleDesireQuizData._();

  static const String typeId = 'female_desire';
  
  static final QuizType quizType = QuizType(
    id: typeId,
    name: '女生好色测试',
    description: '探索你的性偏好、幻想对象和开放程度，了解内心深处的欲望和倾向',
    iconPath: 'assets/icons/female_desire.png',
    categories: categories,
  );

  static final List<QuizCategory> categories = [
    QuizCategory(
      id: '${typeId}_content',
      name: '视频内容',
      quizTypeId: typeId,
      items: _contentItems,
    ),
    QuizCategory(
      id: '${typeId}_fantasy',
      name: '幻想对象',
      quizTypeId: typeId,
      items: _fantasyItems,
    ),
    QuizCategory(
      id: '${typeId}_frequency',
      name: '欲望程度',
      quizTypeId: typeId,
      items: _frequencyItems,
    ),
    QuizCategory(
      id: '${typeId}_scene',
      name: '场景偏好',
      quizTypeId: typeId,
      items: _sceneItems,
    ),
    QuizCategory(
      id: '${typeId}_toys',
      name: '情趣用品',
      quizTypeId: typeId,
      items: _toysItems,
    ),
    QuizCategory(
      id: '${typeId}_openness',
      name: '开放程度',
      quizTypeId: typeId,
      items: _opennessItems,
    ),
  ];

  // 视频内容任务
  static final List<QuizItem> _contentItems = [
    QuizItem(
      id: '${typeId}_content_1',
      name: '墨镜号按摩',
      categoryId: '${typeId}_content',
      description: '墨镜号被男人裸体按摩，然后被大鸡巴狠狠的操',
    ),
    QuizItem(
      id: '${typeId}_content_2',
      name: '公交车上被痴汉侵犯',
      categoryId: '${typeId}_content',
      description: '拥挤的公交车上，被痴汉从后面掀起裙子插入鸡巴偷偷操骚穴',
    ),
    QuizItem(
      id: '${typeId}_content_3',
      name: '父女乱伦',
      categoryId: '${typeId}_content',
      description: '爸爸趁妈妈不在家，把女儿按在床上用鸡巴插入她嫩嫩的骚穴',
    ),
    QuizItem(
      id: '${typeId}_content_4',
      name: '兄妹乱伦偷情',
      categoryId: '${typeId}_content',
      description: '哥哥和妹妹趁父母不在家，互相脱光衣服让鸡巴插进骚穴里乱伦',
    ),
    QuizItem(
      id: '${typeId}_content_5',
      name: '醉酒女被强奸',
      categoryId: '${typeId}_content',
      description: '喝醉的女人被陌生男人拖到房间，强行扒光插入鸡巴狠操骚穴',
    ),
    QuizItem(
      id: '${typeId}_content_6',
      name: '深夜被尾随强奸',
      categoryId: '${typeId}_content',
      description: '深夜回家被尾随，在楼道或小巷被按住强行插入鸡巴操骚穴',
    ),
    QuizItem(
      id: '${typeId}_content_7',
      name: '多人轮奸',
      categoryId: '${typeId}_content',
      description: '被多个男人按住，轮流把鸡巴插进骚穴和嘴巴里操',
    ),
    QuizItem(
      id: '${typeId}_content_8',
      name: '出轨偷情被发现后3P',
      categoryId: '${typeId}_content',
      description: '妻子偷情被老公抓到，老公让情夫和自己一起轮流操她的骚穴',
    ),
    QuizItem(
      id: '${typeId}_content_9',
      name: '两男一女3P',
      categoryId: '${typeId}_content',
      description: '同时被两个男人操，一根鸡巴插骚穴另一根插嘴巴或屁眼',
    ),
    QuizItem(
      id: '${typeId}_content_10',
      name: '人妻偷情被邻居操',
      categoryId: '${typeId}_content',
      description: '寂寞人妻趁老公上班，偷偷把邻居叫来家里让他的鸡巴插进骚穴',
    ),
    QuizItem(
      id: '${typeId}_content_11',
      name: '女奴被绑起来SM调教',
      categoryId: '${typeId}_content',
      description: '被绑在十字架上，主人用鞭子抽打奶子和屁股后用鸡巴插入骚穴',
    ),
    QuizItem(
      id: '${typeId}_content_12',
      name: '女M被吊起来调教',
      categoryId: '${typeId}_content',
      description: '被绳子吊起来四肢大张，被主人用道具和鸡巴轮流插入骚穴和屁眼',
    ),
    QuizItem(
      id: '${typeId}_content_13',
      name: '按摩师侵犯',
      categoryId: '${typeId}_content',
      description: '去按摩店被男按摩师摩到敏感部位，用手指插入骚穴摸索后直接插入鸡巴',
    ),
    QuizItem(
      id: '${typeId}_content_14',
      name: '商场试衣间露出被操',
      categoryId: '${typeId}_content',
      description: '在商场试衣间脱光，被男人按在镜子上插入鸡巴操骚穴怕被发现',
    ),
    QuizItem(
      id: '${typeId}_content_15',
      name: '户外野战露出',
      categoryId: '${typeId}_content',
      description: '在公园、山上等户外场所脱光，被男人按倒在地上鸡巴插入骚穴野战',
    ),
    QuizItem(
      id: '${typeId}_content_16',
      name: '女奴被主人羞辱调教',
      categoryId: '${typeId}_content',
      description: '被主人命令爬行、舔鞋，然后被按在地上用鸡巴狠狠操骚穴羞辱',
    ),
    QuizItem(
      id: '${typeId}_content_17',
      name: '被强制高潮调教',
      categoryId: '${typeId}_content',
      description: '被绑着无法动弹，被电动棒强制刺激阴蒂和骚穴反复高潮到失禁',
    ),
    QuizItem(
      id: '${typeId}_content_18',
      name: '课堂上被老师侵犯',
      categoryId: '${typeId}_content',
      description: '女学生课后被留下，被老师按在讲台上掀起裙子插入鸡巴操骚穴',
    ),
  ];

  // 人物对象任务
  static final List<QuizItem> _fantasyItems = [
    // 职场关系
    QuizItem(
      id: '${typeId}_fantasy_1',
      name: '上司',
      categoryId: '${typeId}_fantasy',
    ),
    QuizItem(
      id: '${typeId}_fantasy_2',
      name: '同事',
      categoryId: '${typeId}_fantasy',
    ),
    QuizItem(
      id: '${typeId}_fantasy_3',
      name: '老师',
      categoryId: '${typeId}_fantasy',
    ),
    QuizItem(
      id: '${typeId}_fantasy_4',
      name: '医生',
      categoryId: '${typeId}_fantasy',
    ),
    QuizItem(
      id: '${typeId}_fantasy_5',
      name: '健身教练',
      categoryId: '${typeId}_fantasy',
    ),
    // 服务人员
    QuizItem(
      id: '${typeId}_fantasy_6',
      name: '快递小哥',
      categoryId: '${typeId}_fantasy',
    ),
    QuizItem(
      id: '${typeId}_fantasy_7',
      name: '维修工',
      categoryId: '${typeId}_fantasy',
    ),
    QuizItem(
      id: '${typeId}_fantasy_8',
      name: '司机',
      categoryId: '${typeId}_fantasy',
    ),
    QuizItem(
      id: '${typeId}_fantasy_9',
      name: '农民工',
      categoryId: '${typeId}_fantasy',
    ),
    // 社交关系
    QuizItem(
      id: '${typeId}_fantasy_10',
      name: '邻居',
      categoryId: '${typeId}_fantasy',
    ),
    QuizItem(
      id: '${typeId}_fantasy_11',
      name: '闺蜜的男友',
      categoryId: '${typeId}_fantasy',
    ),
    QuizItem(
      id: '${typeId}_fantasy_12',
      name: '老公的朋友',
      categoryId: '${typeId}_fantasy',
    ),
    QuizItem(
      id: '${typeId}_fantasy_13',
      name: '前男友',
      categoryId: '${typeId}_fantasy',
    ),
    // 陌生人
    QuizItem(
      id: '${typeId}_fantasy_14',
      name: '陌生人',
      categoryId: '${typeId}_fantasy',
    ),
    QuizItem(
      id: '${typeId}_fantasy_15',
      name: '黑人',
      categoryId: '${typeId}_fantasy',
    ),
  ];

  // 欲望程度任务
  static final List<QuizItem> _frequencyItems = [
    QuizItem(
      id: '${typeId}_frequency_1',
      name: '每天都会自慰一次',
      categoryId: '${typeId}_frequency',
      description: '每天至少用手指摸骚穴或用道具插入一次直到高潮',
    ),
    QuizItem(
      id: '${typeId}_frequency_2',
      name: '一周至少做爱三次',
      categoryId: '${typeId}_frequency',
      description: '每周需要被鸡巴插入骚穴至少三次才觉得满足',
    ),
    QuizItem(
      id: '${typeId}_frequency_3',
      name: '经常在公共场所想性爱',
      categoryId: '${typeId}_frequency',
      description: '比如在地铁、公交车上经常幻想被男人按在角落插入鸡巴',
    ),
    QuizItem(
      id: '${typeId}_frequency_4',
      name: '看到帅哥就想被他操',
      categoryId: '${typeId}_frequency',
      description: '路上看到长得好看的男人就会想象被他的鸡巴插进骚穴操',
    ),
    QuizItem(
      id: '${typeId}_frequency_5',
      name: '每次洗澡都会摸骚穴和奶子',
      categoryId: '${typeId}_frequency',
      description: '洗澡时总是忍不住用花洒头冲阴蒂或用手指插入骚穴自慰',
    ),
    QuizItem(
      id: '${typeId}_frequency_6',
      name: '睡前必须高潮才能入睡',
      categoryId: '${typeId}_frequency',
      description: '每天晚上不自慰到高潮就无法入睡，必须让骚穴满足才行',
    ),
    QuizItem(
      id: '${typeId}_frequency_7',
      name: '经常半夜被性欲弄醒',
      categoryId: '${typeId}_frequency',
      description: '半夜睡着睡着被情欲弄醒，需要骑在枕头上磨骚穴或插入道具才能再睡',
    ),
    QuizItem(
      id: '${typeId}_frequency_8',
      name: '看小黄片时一定会摸骚穴',
      categoryId: '${typeId}_frequency',
      description: '看成人视频时必然会把手伸进内裤摸骚穴，跟着画面一起高潮',
    ),
    QuizItem(
      id: '${typeId}_frequency_9',
      name: '每次来大姨妈都更性奋',
      categoryId: '${typeId}_frequency',
      description: '月经期间情欲更旺盛，更想被鸡巴插入骚穴操',
    ),
    QuizItem(
      id: '${typeId}_frequency_10',
      name: '上班时偶尔会摸骚穴',
      categoryId: '${typeId}_frequency',
      description: '在办公室工作时偏偏性奋，偏偏就想把手伸进裙底摸骚穴',
    ),
    QuizItem(
      id: '${typeId}_frequency_11',
      name: '穿裙子不穿内裤更兴奋',
      categoryId: '${typeId}_frequency',
      description: '喜欢不穿内裤出门，感受骚穴被空气吹拂得性奋流水',
    ),
    QuizItem(
      id: '${typeId}_frequency_12',
      name: '看小说时骚穴会流水',
      categoryId: '${typeId}_frequency',
      description: '看色情小说时骚穴会流出淫水，必须摸骚穴才能缓解',
    ),
    QuizItem(
      id: '${typeId}_frequency_13',
      name: '穿紧身裤骚穴会发痒',
      categoryId: '${typeId}_frequency',
      description: '穿紧身裤或牛仔裤时，裤衣磨擦阴蒂和骚穴就会发痒流水想被操',
    ),
    QuizItem(
      id: '${typeId}_frequency_14',
      name: '运动出汗后想被操',
      categoryId: '${typeId}_frequency',
      description: '跑步或健身出汗后身体很敏感，想被男人把鸡巴插进湿漉的骚穴',
    ),
    QuizItem(
      id: '${typeId}_frequency_15',
      name: '听到浪叫声就性奋',
      categoryId: '${typeId}_frequency',
      description: '听到墙隔壁或视频里的浪叫声，骚穴就会发痒流水',
    ),
    QuizItem(
      id: '${typeId}_frequency_16',
      name: '喝醉酒后更淫荡',
      categoryId: '${typeId}_frequency',
      description: '喝醉酒后情欲更强烈，会主动勾引男人让鸡巴插进骚穴',
    ),
    QuizItem(
      id: '${typeId}_frequency_17',
      name: '摸奶子就想摸骚穴',
      categoryId: '${typeId}_frequency',
      description: '摸揉奶子或被摸奶子时，骚穴会同步发痒想被插入',
    ),
    QuizItem(
      id: '${typeId}_frequency_18',
      name: '一天不高潮就难受',
      categoryId: '${typeId}_frequency',
      description: '一天不自慰或做爱高潮就浑身难受，必须让骚穴被鸡巴或道具插满足',
    ),
  ];

  // 场景偏好任务
  static final List<QuizItem> _sceneItems = [
    QuizItem(
      id: '${typeId}_scene_1',
      name: '想在电影院被操',
      categoryId: '${typeId}_scene',
    ),
    QuizItem(
      id: '${typeId}_scene_2',
      name: '想在车里被操',
      categoryId: '${typeId}_scene',
    ),
    QuizItem(
      id: '${typeId}_scene_3',
      name: '想在试衣间被操',
      categoryId: '${typeId}_scene',
    ),
    QuizItem(
      id: '${typeId}_scene_4',
      name: '想在公园草丛被操',
      categoryId: '${typeId}_scene',
    ),
    QuizItem(
      id: '${typeId}_scene_5',
      name: '想在楼道被操',
      categoryId: '${typeId}_scene',
    ),
    QuizItem(
      id: '${typeId}_scene_6',
      name: '想在镜子前被操',
      categoryId: '${typeId}_scene',
    ),
    QuizItem(
      id: '${typeId}_scene_7',
      name: '想在酒吧包间被操',
      categoryId: '${typeId}_scene',
    ),
    QuizItem(
      id: '${typeId}_scene_8',
      name: '想在婚房被操',
      categoryId: '${typeId}_scene',
    ),
    QuizItem(
      id: '${typeId}_scene_9',
      name: '想在床上被绑起来操',
      categoryId: '${typeId}_scene',
    ),
    QuizItem(
      id: '${typeId}_scene_10',
      name: '想在卫生间被操',
      categoryId: '${typeId}_scene',
    ),
    QuizItem(
      id: '${typeId}_scene_11',
      name: '想在办公室被操',
      categoryId: '${typeId}_scene',
    ),
    QuizItem(
      id: '${typeId}_scene_12',
      name: '想在电梯里被操',
      categoryId: '${typeId}_scene',
    ),
    QuizItem(
      id: '${typeId}_scene_13',
      name: '想在屋顶被操',
      categoryId: '${typeId}_scene',
    ),
    QuizItem(
      id: '${typeId}_scene_14',
      name: '想在地下车库被操',
      categoryId: '${typeId}_scene',
    ),
    QuizItem(
      id: '${typeId}_scene_15',
      name: '想在图书馆被操',
      categoryId: '${typeId}_scene',
    ),
    QuizItem(
      id: '${typeId}_scene_16',
      name: '想在教室被操',
      categoryId: '${typeId}_scene',
    ),
    QuizItem(
      id: '${typeId}_scene_17',
      name: '想在游泳池被操',
      categoryId: '${typeId}_scene',
    ),
    QuizItem(
      id: '${typeId}_scene_18',
      name: '想在酒店房间被操',
      categoryId: '${typeId}_scene',
    ),
    QuizItem(
      id: '${typeId}_scene_19',
      name: '想在山上被操',
      categoryId: '${typeId}_scene',
    ),
    QuizItem(
      id: '${typeId}_scene_20',
      name: '想在公交车上被操',
      categoryId: '${typeId}_scene',
    ),
    QuizItem(
      id: '${typeId}_scene_21',
      name: '想在家里阳台被操',
      categoryId: '${typeId}_scene',
    ),
    QuizItem(
      id: '${typeId}_scene_22',
      name: '想在健身房被操',
      categoryId: '${typeId}_scene',
    ),
  ];

  // 情趣用品任务
  static final List<QuizItem> _toysItems = [
    // 插入类道具
    QuizItem(
      id: '${typeId}_toys_1',
      name: '振动棒',
      categoryId: '${typeId}_toys',
      description: '插入骚穴或屁眼，调节震动频率和模式刺激G点或后庭',
    ),
    QuizItem(
      id: '${typeId}_toys_2',
      name: '假鸡巴',
      categoryId: '${typeId}_toys',
      description: '选择合适大小，涫上润滑剂后插入骚穴，模拟真实抽插',
    ),
    QuizItem(
      id: '${typeId}_toys_3',
      name: '双头龙',
      categoryId: '${typeId}_toys',
      description: '同时插入骚穴和屁眼，或和伴侣一人一头互相抽插',
    ),
    QuizItem(
      id: '${typeId}_toys_4',
      name: '肛塞',
      categoryId: '${typeId}_toys',
      description: '涂上润滑剂后慢慢塞进屁眼，可以长时间塞在里面撑开后庭',
    ),
    QuizItem(
      id: '${typeId}_toys_5',
      name: '阴道哑铃',
      categoryId: '${typeId}_toys',
      description: '放进骚穴里，走路或运动时哑铃碰撞阴道壁锻炼肌肉',
    ),
    
    // 震动刺激类
    QuizItem(
      id: '${typeId}_toys_6',
      name: '跳蛋',
      categoryId: '${typeId}_toys',
      description: '放进内裤或骚穴里，用遥控器控制震动，可在公共场所使用',
    ),
    QuizItem(
      id: '${typeId}_toys_7',
      name: '阴蒂吸吸器',
      categoryId: '${typeId}_toys',
      description: '罩住阴蒂，用负压吸吸刺激，让阴蒂充血肿胀增强敏感度',
    ),
    
    // 夹类道具
    QuizItem(
      id: '${typeId}_toys_8',
      name: '乳夹',
      categoryId: '${typeId}_toys',
      description: '夹住乳头，调节紧度增强刺激，可配合链条或吊重物使用',
    ),
    QuizItem(
      id: '${typeId}_toys_9',
      name: '阴蒂夹',
      categoryId: '${typeId}_toys',
      description: '用小夹子夹住阴蒂，疼痛和快感混合刺激敏感点',
    ),
    
    // 束缚固定类
    QuizItem(
      id: '${typeId}_toys_10',
      name: '手铐脚铐',
      categoryId: '${typeId}_toys',
      description: '用钢铁或皮质手铐脚铐固定四肢，无法动弹任人操弄',
    ),
    QuizItem(
      id: '${typeId}_toys_11',
      name: '绝股绳',
      categoryId: '${typeId}_toys',
      description: '用麻绳捆绑全身，勒紧奶子和骚穴勒出纹路增强刺激',
    ),
    QuizItem(
      id: '${typeId}_toys_12',
      name: '分腿器',
      categoryId: '${typeId}_toys',
      description: '用钢管或皮带强制把腿分开固定，暴露骚穴任人操弄',
    ),
    
    // 感官控制类
    QuizItem(
      id: '${typeId}_toys_13',
      name: '萌眼罩',
      categoryId: '${typeId}_toys',
      description: '遮住眼睛什么都看不见，失去视觉增强其他感官',
    ),
    QuizItem(
      id: '${typeId}_toys_14',
      name: '口球',
      categoryId: '${typeId}_toys',
      description: '塞进嘴里用皮带固定，不能说话只能流口水呻吟',
    ),
    
    // 调教类
    QuizItem(
      id: '${typeId}_toys_15',
      name: '项圈',
      categoryId: '${typeId}_toys',
      description: '用皮项圈锁住脖子拉着链条，像性奴一样被牵着走',
    ),
    QuizItem(
      id: '${typeId}_toys_16',
      name: '皮鞭',
      categoryId: '${typeId}_toys',
      description: '用皮鞭抽打屁股、奶子或骚穴，让皮肤发红疼痛',
    ),
    
    // 刺激刺痛类
    QuizItem(
      id: '${typeId}_toys_17',
      name: '情趣蜡烛',
      categoryId: '${typeId}_toys',
      description: '点燃低温蜡烛滴在奶子、骚穴或身体上，感受火辣刺痛',
    ),
    QuizItem(
      id: '${typeId}_toys_18',
      name: '电击棒',
      categoryId: '${typeId}_toys',
      description: '用于乳头、阴蒂或骚穴，电流刺激带来麻痹和震颤',
    ),
  ];

  // 开放程度任务
  static final List<QuizItem> _opennessItems = [
    QuizItem(
      id: '${typeId}_openness_1',
      name: '愿意和陌生人一夜情',
      categoryId: '${typeId}_openness',
      description: '接受和刚认识的陌生男人开房，让他的鸡巴插入你的骚穴',
    ),
    QuizItem(
      id: '${typeId}_openness_2',
      name: '愿意尝试3P或多人运动',
      categoryId: '${typeId}_openness',
      description: '愿意和多个人同时做爱，同时被多根鸡巴插入不同的洞',
    ),
    QuizItem(
      id: '${typeId}_openness_3',
      name: '愿意被拍成视频',
      categoryId: '${typeId}_openness',
      description: '接受被拍摄做爱过程，记录下鸡巴抽插骚穴的画面',
    ),
    QuizItem(
      id: '${typeId}_openness_4',
      name: '愿意在半公开场所做爱',
      categoryId: '${typeId}_openness',
      description: '接受在可能被发现的公共场所，被鸡巴插入骚穴操',
    ),
    QuizItem(
      id: '${typeId}_openness_5',
      name: '愿意被SM被绑起来操',
      categoryId: '${typeId}_openness',
      description: '愿意被绑缚、蒙眼、无法动弹地被男人用鸡巴和道具操',
    ),
    QuizItem(
      id: '${typeId}_openness_6',
      name: '愿意给陌生人口交',
      categoryId: '${typeId}_openness',
      description: '接受给刚认识的男人口交，用嘴巴吸他的鸡巴直到射精',
    ),
    QuizItem(
      id: '${typeId}_openness_7',
      name: '愿意被操屁眼',
      categoryId: '${typeId}_openness',
      description: '接受被男人的鸡巴或道具插入屁眼后庭开发',
    ),
    QuizItem(
      id: '${typeId}_openness_8',
      name: '愿意和女性发生关系',
      categoryId: '${typeId}_openness',
      description: '接受和女性互相舔吸奶子、骚穴，或用道具互相插入',
    ),
    QuizItem(
      id: '${typeId}_openness_9',
      name: '愿意被精液射在脸上',
      categoryId: '${typeId}_openness',
      description: '接受男人把精液射在你脸上、嘴里或全身',
    ),
    QuizItem(
      id: '${typeId}_openness_10',
      name: '愿意在网上展示裸照',
      categoryId: '${typeId}_openness',
      description: '接受把自己的裸体照片或性爱视频分享到网络上',
    ),
    QuizItem(
      id: '${typeId}_openness_11',
      name: '愿意被香蕉黄瓜插',
      categoryId: '${typeId}_openness',
      description: '接受用香蕉、黄瓜等食物插入骚穴或屁眼',
    ),
    QuizItem(
      id: '${typeId}_openness_12',
      name: '愿意被打屁股',
      categoryId: '${typeId}_openness',
      description: '接受被男人用手或皮鞭抽打屁股至发红疼痛',
    ),
    QuizItem(
      id: '${typeId}_openness_13',
      name: '愿意被写羞辱文字',
      categoryId: '${typeId}_openness',
      description: '接受被用笔在身体上写骚货、肉便器等羞辱词语',
    ),
    QuizItem(
      id: '${typeId}_openness_14',
      name: '愿意被滴蜡',
      categoryId: '${typeId}_openness',
      description: '接受被滴低温蜡烛在奶子、骚穴等敏感部位',
    ),
    QuizItem(
      id: '${typeId}_openness_15',
      name: '愿意被电击刺激',
      categoryId: '${typeId}_openness',
      description: '接受用电击棒刺激乳头、阴蒂或骚穴',
    ),
    QuizItem(
      id: '${typeId}_openness_16',
      name: '愿意被双洞同时插入',
      categoryId: '${typeId}_openness',
      description: '接受鸡巴和道具同时插入骚穴和屁眼',
    ),
    QuizItem(
      id: '${typeId}_openness_17',
      name: '愿意被口爆',
      categoryId: '${typeId}_openness',
      description: '接受男人用鸡巴插入嘴巴抽插至射精在嘴里',
    ),
    QuizItem(
      id: '${typeId}_openness_18',
      name: '愿意用骚水喂男人喝',
      categoryId: '${typeId}_openness',
      description: '接受用杯子接自己流出的骚水给男人喝掉',
    ),
    QuizItem(
      id: '${typeId}_openness_19',
      name: '愿意在人前被操',
      categoryId: '${typeId}_openness',
      description: '接受在他人面前被男人操骚穴，展示性爱过程',
    ),
    QuizItem(
      id: '${typeId}_openness_20',
      name: '愿意和动物发生关系',
      categoryId: '${typeId}_openness',
      description: '接受被狗或其他动物舔吸骚穴或插入',
    ),
    QuizItem(
      id: '${typeId}_openness_21',
      name: '愿意戴项圈被牵着走',
      categoryId: '${typeId}_openness',
      description: '接受戴上项圈拉着链条，像性奴一样被主人牵着',
    ),
    QuizItem(
      id: '${typeId}_openness_22',
      name: '愿意被多人轮奸',
      categoryId: '${typeId}_openness',
      description: '接受被一群男人排队轮流操骚穴至满足',
    ),
    QuizItem(
      id: '${typeId}_openness_23',
      name: '愿意被乳交',
      categoryId: '${typeId}_openness',
      description: '接受男人把鸡巴夹在奶子中间抽插射精',
    ),
    QuizItem(
      id: '${typeId}_openness_24',
      name: '愿意被尿射全身',
      categoryId: '${typeId}_openness',
      description: '接受被男人撒尿射在身体或嘴里',
    ),
    QuizItem(
      id: '${typeId}_openness_25',
      name: '愿意被拳交',
      categoryId: '${typeId}_openness',
      description: '接受被男人的拳头整个插入骚穴或屁眼',
    ),
    QuizItem(
      id: '${typeId}_openness_26',
      name: '愿意被吊起来操',
      categoryId: '${typeId}_openness',
      description: '接受被绳子吊在半空中，被男人操骚穴和屁眼',
    ),
    QuizItem(
      id: '${typeId}_openness_27',
      name: '愿意被绑在床上操',
      categoryId: '${typeId}_openness',
      description: '接受手脚被绑在床上四肢大张，被男人用鸡巴和道具疯狂操',
    ),
    QuizItem(
      id: '${typeId}_openness_28',
      name: '愿意被强制高潮',
      categoryId: '${typeId}_openness',
      description: '接受被电动道具强制刺激至连续高潮喷水不能停',
    ),
    QuizItem(
      id: '${typeId}_openness_29',
      name: '愿意被扩张阴道',
      categoryId: '${typeId}_openness',
      description: '接受用扩张器把骚穴打开，将阴道内部暴露',
    ),
    QuizItem(
      id: '${typeId}_openness_30',
      name: '愿意被憋尿操',
      categoryId: '${typeId}_openness',
      description: '接受被憋尿憋到快漏时被强行插入鸡巴操',
    ),
    QuizItem(
      id: '${typeId}_openness_31',
      name: '愿意穿情趣内衣出门',
      categoryId: '${typeId}_openness',
      description: '接受穿透明或露出式情趣内衣在公共场所行走',
    ),
    QuizItem(
      id: '${typeId}_openness_32',
      name: '愿意真空上街',
      categoryId: '${typeId}_openness',
      description: '接受不穿内裤外出，裙底或裤裆直接露出骚穴',
    ),
    QuizItem(
      id: '${typeId}_openness_33',
      name: '愿意被塞跳蛋外出',
      categoryId: '${typeId}_openness',
      description: '接受骚穴里塞着遥控跳蛋，在公共场所被控制震动',
    ),
    QuizItem(
      id: '${typeId}_openness_34',
      name: '愿意被当众手淫',
      categoryId: '${typeId}_openness',
      description: '接受在人群面前被男人用手指插入骚穴操',
    ),
    QuizItem(
      id: '${typeId}_openness_35',
      name: '愿意和人妻一起玩',
      categoryId: '${typeId}_openness',
      description: '接受和别人的老婆一起侍候男人，互相舔吸鸡巴',
    ),
  ];
}

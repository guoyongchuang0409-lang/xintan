import '../../domain/models/quiz_type.dart';
import '../../domain/models/quiz_category.dart';
import '../../domain/models/quiz_item.dart';

class FemaleSQuizData {
  FemaleSQuizData._();

  static const String typeId = 'female_s';

  static final QuizType quizType = QuizType(
    id: typeId,
    name: '女S自测',
    description: '探索你作为女性支配者的倾向，了解你在调教男M时的偏好和风格',
    iconPath: 'assets/icons/female_s.png',
    categories: categories,
  );

  // 羞辱调教（25个）- 言语羞辱、精神控制、身份贬低
  static final List<QuizItem> _humiliationItems = [
    QuizItem(id: '${typeId}_humiliation_1', name: '嘲笑他鸡巴小', categoryId: '${typeId}_humiliation', description: '嘲笑他的小鸡巴满足不了你'),
    QuizItem(id: '${typeId}_humiliation_2', name: '让他跪着叫女王', categoryId: '${typeId}_humiliation', description: '让他跪在地上大声叫你女王'),
    QuizItem(id: '${typeId}_humiliation_3', name: '让他舔干净你的脚', categoryId: '${typeId}_humiliation', description: '让他跪下把你的脚趾一个个舔干净'),
    QuizItem(id: '${typeId}_humiliation_4', name: '让他当脚凳踩着', categoryId: '${typeId}_humiliation', description: '让他趴地上当你的脚凳踩着'),
    QuizItem(id: '${typeId}_humiliation_5', name: '让他吃狗粮', categoryId: '${typeId}_humiliation', description: '把食物放狗盆里让他趴着吃'),
    QuizItem(id: '${typeId}_humiliation_6', name: '让他学狗叫爬行', categoryId: '${typeId}_humiliation', description: '让他戴着项圈学狗叫四肢爬行'),
    QuizItem(id: '${typeId}_humiliation_7', name: '让他穿女装出门', categoryId: '${typeId}_humiliation', description: '让他穿上女装丝袜出门'),
    QuizItem(id: '${typeId}_humiliation_8', name: '让他穿丁字裤上班', categoryId: '${typeId}_humiliation', description: '让他穿女式丁字裤去上班'),
    QuizItem(id: '${typeId}_humiliation_9', name: '在他鸡巴上写废物', categoryId: '${typeId}_humiliation', description: '在他的小鸡巴上写上废物二字'),
    QuizItem(id: '${typeId}_humiliation_10', name: '让他给你洗脚', categoryId: '${typeId}_humiliation', description: '让他跪着给你洗脚按摩'),
    QuizItem(id: '${typeId}_humiliation_11', name: '让他喝你的洗脚水', categoryId: '${typeId}_humiliation', description: '让他把你的洗脚水喝下去'),
    QuizItem(id: '${typeId}_humiliation_12', name: '让他舔干净高跟鞋', categoryId: '${typeId}_humiliation', description: '让他用舌头舔干净你的高跟鞋'),
    QuizItem(id: '${typeId}_humiliation_13', name: '用脚踩他的脸', categoryId: '${typeId}_humiliation', description: '用脚踩在他脸上羞辱他'),
    QuizItem(id: '${typeId}_humiliation_14', name: '用脚踩他的鸡巴', categoryId: '${typeId}_humiliation', description: '用脚踩着他的小鸡巴玩弄'),
    QuizItem(id: '${typeId}_humiliation_15', name: '让他跪着给你端茶', categoryId: '${typeId}_humiliation', description: '让他光着跪着给你端茶倒水'),
    QuizItem(id: '${typeId}_humiliation_16', name: '让他爬着迎接你', categoryId: '${typeId}_humiliation', description: '你回家时让他光着爬到门口迎接'),
    QuizItem(id: '${typeId}_humiliation_17', name: '让他背诵奴隶守则', categoryId: '${typeId}_humiliation', description: '让他跪着背诵作为奴隶的守则'),
    QuizItem(id: '${typeId}_humiliation_18', name: '让他自己扇耳光', categoryId: '${typeId}_humiliation', description: '让他自己扇耳光边扇边说我是废物'),
    QuizItem(id: '${typeId}_humiliation_19', name: '让他睡狗窝', categoryId: '${typeId}_humiliation', description: '惩罚他时让他睡在地上的狗窝里'),
    QuizItem(id: '${typeId}_humiliation_20', name: '让他当马骑', categoryId: '${typeId}_humiliation', description: '骑在他背上让他当马爬行'),
    QuizItem(id: '${typeId}_humiliation_21', name: '比较他和前任', categoryId: '${typeId}_humiliation', description: '当面比较他和前任谁的鸡巴大'),
    QuizItem(id: '${typeId}_humiliation_22', name: '让他旁观你偷情', categoryId: '${typeId}_humiliation', description: '让他在旁边看你和别的男人做'),
    QuizItem(id: '${typeId}_humiliation_23', name: '让他清理精液', categoryId: '${typeId}_humiliation', description: '让他用嘴清理你身上别人的精液'),
    QuizItem(id: '${typeId}_humiliation_24', name: '让他戴绿帽子', categoryId: '${typeId}_humiliation', description: '当面告诉他你在外面有人'),
    QuizItem(id: '${typeId}_humiliation_25', name: '让他感谢你出轨', categoryId: '${typeId}_humiliation', description: '让他跪着感谢你赏他绿帽子'),
  ];

  // 道具调教（25个）- 各种SM道具的使用
  static final List<QuizItem> _toysItems = [
    QuizItem(id: '${typeId}_toys_1', name: '给他戴贞操锁', categoryId: '${typeId}_toys', description: '给他的小鸡巴戴上贞操锁钥匙你拿着'),
    QuizItem(id: '${typeId}_toys_2', name: '肛塞塞他屁眼', categoryId: '${typeId}_toys', description: '给他屁眼塞上肛塞让他含着'),
    QuizItem(id: '${typeId}_toys_3', name: '假鸡巴操他屁眼', categoryId: '${typeId}_toys', description: '用假鸡巴插他屁眼调教他'),
    QuizItem(id: '${typeId}_toys_4', name: '项圈牵着他走', categoryId: '${typeId}_toys', description: '给他戴项圈用链子牵着他走'),
    QuizItem(id: '${typeId}_toys_5', name: '夹子夹他奶头', categoryId: '${typeId}_toys', description: '用夹子夹住他的奶头拉扯'),
    QuizItem(id: '${typeId}_toys_6', name: '电击器电他鸡巴', categoryId: '${typeId}_toys', description: '用电击器电他的鸡巴和蛋蛋'),
    QuizItem(id: '${typeId}_toys_7', name: '皮鞭抽他屁股', categoryId: '${typeId}_toys', description: '用皮鞭抽他屁股抽到红肿'),
    QuizItem(id: '${typeId}_toys_8', name: '藤条抽他手心', categoryId: '${typeId}_toys', description: '用藤条抽他手心让他疼'),
    QuizItem(id: '${typeId}_toys_9', name: '蜡烛滴他身上', categoryId: '${typeId}_toys', description: '用蜡烛往他身上滴蜡'),
    QuizItem(id: '${typeId}_toys_10', name: '手铐铐他床头', categoryId: '${typeId}_toys', description: '用手铐把他铐在床头任你玩'),
    QuizItem(id: '${typeId}_toys_11', name: '蒙眼塞耳玩他', categoryId: '${typeId}_toys', description: '蒙住他眼睛塞住耳朵随便玩'),
    QuizItem(id: '${typeId}_toys_12', name: '口球塞他嘴', categoryId: '${typeId}_toys', description: '给他嘴里塞口球让他流口水'),
    QuizItem(id: '${typeId}_toys_13', name: '绳子绑他全身', categoryId: '${typeId}_toys', description: '用绳子把他全身绑起来'),
    QuizItem(id: '${typeId}_toys_14', name: '狗笼关他一晚', categoryId: '${typeId}_toys', description: '把他关进狗笼里过夜'),
    QuizItem(id: '${typeId}_toys_15', name: '前列腺按摩器插他', categoryId: '${typeId}_toys', description: '用前列腺按摩器插他屁眼'),
    QuizItem(id: '${typeId}_toys_16', name: '尿道塞塞他', categoryId: '${typeId}_toys', description: '用尿道塞塞进他的尿道'),
    QuizItem(id: '${typeId}_toys_17', name: '鸡巴环套他鸡巴', categoryId: '${typeId}_toys', description: '给他鸡巴上套环控制他'),
    QuizItem(id: '${typeId}_toys_18', name: '冰块冰他鸡巴', categoryId: '${typeId}_toys', description: '用冰块冰他的鸡巴让他软掉'),
    QuizItem(id: '${typeId}_toys_19', name: '高跟鞋踩他', categoryId: '${typeId}_toys', description: '穿高跟鞋踩他的身体'),
    QuizItem(id: '${typeId}_toys_20', name: '夹子夹他奶头', categoryId: '${typeId}_toys', description: '用夹子夹住他奶头不许掉'),
    QuizItem(id: '${typeId}_toys_21', name: '串珠塞他屁眼', categoryId: '${typeId}_toys', description: '把肛门串珠塞进他屁眼'),
    QuizItem(id: '${typeId}_toys_22', name: '拘束衣穿他身上', categoryId: '${typeId}_toys', description: '让他穿拘束衣动弹不得'),
    QuizItem(id: '${typeId}_toys_23', name: '吊起来抽打', categoryId: '${typeId}_toys', description: '把他吊起来抽打调教'),
    QuizItem(id: '${typeId}_toys_24', name: '坐他脸上窒息', categoryId: '${typeId}_toys', description: '坐在他脸上让他舔你'),
    QuizItem(id: '${typeId}_toys_25', name: '踩他鸡巴撸出来', categoryId: '${typeId}_toys', description: '用脚踩着他鸡巴撸到射'),
  ];

  // 指令任务（15个）- M独自完成的SM调教任务
  static final List<QuizItem> _taskItems = [
    QuizItem(id: '${typeId}_task_1', name: '戴贞操锁禁欲一周', categoryId: '${typeId}_task', description: '戴着贞操锁禁止射精一整周'),
    QuizItem(id: '${typeId}_task_2', name: '塞肛塞上班一天', categoryId: '${typeId}_task', description: '塞着肛塞去上班忍一整天'),
    QuizItem(id: '${typeId}_task_3', name: '穿女式内裤上班', categoryId: '${typeId}_task', description: '穿女式蕾丝内裤去上班'),
    QuizItem(id: '${typeId}_task_4', name: '菊穴扩张训练', categoryId: '${typeId}_task', description: '每天塞更大号肛塞进行扩张'),
    QuizItem(id: '${typeId}_task_5', name: '用假鸡巴自肛调教', categoryId: '${typeId}_task', description: '用假鸡巴自己肛交进行调教'),
    QuizItem(id: '${typeId}_task_6', name: '穿女装在家一天', categoryId: '${typeId}_task', description: '穿女装化妆在家一整天'),
    QuizItem(id: '${typeId}_task_7', name: '在家穿丝袜高跟', categoryId: '${typeId}_task', description: '独自在家时必须穿丝袜高跟'),
    QuizItem(id: '${typeId}_task_8', name: '自扇耳光十下', categoryId: '${typeId}_task', description: '自扇耳光十下作为惩罚'),
    QuizItem(id: '${typeId}_task_9', name: '夹乳夹工作两小时', categoryId: '${typeId}_task', description: '夹着乳夹工作两小时不许摘'),
    QuizItem(id: '${typeId}_task_10', name: '戴贞操锁去健身', categoryId: '${typeId}_task', description: '戴着贞操锁去健身房锻炼'),
    QuizItem(id: '${typeId}_task_11', name: '塞肛塞过夜不拿', categoryId: '${typeId}_task', description: '塞着肛塞睡一整晚不许拿出'),
    QuizItem(id: '${typeId}_task_12', name: '穿丁字裤去上班', categoryId: '${typeId}_task', description: '穿女式丁字裤去上班一整天'),
    QuizItem(id: '${typeId}_task_13', name: '自己抽手心二十下', categoryId: '${typeId}_task', description: '自己用藤条抽手心二十下'),
    QuizItem(id: '${typeId}_task_14', name: '前列腺按摩训练', categoryId: '${typeId}_task', description: '用前列腺按摩器自己训练'),
    QuizItem(id: '${typeId}_task_15', name: '鸡巴上绑绳拉扯', categoryId: '${typeId}_task', description: '在鸡巴上绑绳子自己拉扯调教'),
  ];

  // 露出调教（25个）- 户外露出和公共场所调教
  static final List<QuizItem> _exposureItems = [
    QuizItem(id: '${typeId}_exposure_1', name: '让他穿女装逛街', categoryId: '${typeId}_exposure', description: '让他穿女装和你一起逛街'),
    QuizItem(id: '${typeId}_exposure_2', name: '餐厅里让他跪着', categoryId: '${typeId}_exposure', description: '在餐厅包间里让他跪着伺候'),
    QuizItem(id: '${typeId}_exposure_3', name: '车里让他舔你', categoryId: '${typeId}_exposure', description: '在停车场车里让他舔你'),
    QuizItem(id: '${typeId}_exposure_4', name: '电影院里踩他', categoryId: '${typeId}_exposure', description: '在电影院里用脚踩他的鸡巴'),
    QuizItem(id: '${typeId}_exposure_5', name: '公园里让他跪', categoryId: '${typeId}_exposure', description: '在公园僻静处让他跪下舔脚'),
    QuizItem(id: '${typeId}_exposure_6', name: '试衣间里调教', categoryId: '${typeId}_exposure', description: '在试衣间里让他跪着伺候'),
    QuizItem(id: '${typeId}_exposure_7', name: '酒吧里当众羞辱', categoryId: '${typeId}_exposure', description: '在酒吧当着朋友面羞辱他'),
    QuizItem(id: '${typeId}_exposure_8', name: 'KTV里让他表演', categoryId: '${typeId}_exposure', description: '在KTV让他当众表演节目'),
    QuizItem(id: '${typeId}_exposure_9', name: '让他戴项圈出门', categoryId: '${typeId}_exposure', description: '让他戴着项圈和你出门'),
    QuizItem(id: '${typeId}_exposure_10', name: '让他穿情趣内裤', categoryId: '${typeId}_exposure', description: '让他穿女式情趣内裤出门'),
    QuizItem(id: '${typeId}_exposure_11', name: '商场里让他跪下', categoryId: '${typeId}_exposure', description: '在商场角落让他跪下系鞋带'),
    QuizItem(id: '${typeId}_exposure_12', name: '让他给陌生人道歉', categoryId: '${typeId}_exposure', description: '故意让他给陌生人道歉'),
    QuizItem(id: '${typeId}_exposure_13', name: '让他当众给你拎包', categoryId: '${typeId}_exposure', description: '让他像仆人一样给你拎包'),
    QuizItem(id: '${typeId}_exposure_14', name: '让他朋友面前伺候', categoryId: '${typeId}_exposure', description: '在朋友面前让他伺候你'),
    QuizItem(id: '${typeId}_exposure_15', name: '让他给闺蜜洗脚', categoryId: '${typeId}_exposure', description: '让他当着你面给闺蜜洗脚'),
    QuizItem(id: '${typeId}_exposure_16', name: '让他穿围裙做饭', categoryId: '${typeId}_exposure', description: '来客人时让他穿围裙做饭'),
    QuizItem(id: '${typeId}_exposure_17', name: '让他当众叫你女王', categoryId: '${typeId}_exposure', description: '在朋友面前让他叫你女王'),
    QuizItem(id: '${typeId}_exposure_18', name: '让他塞肛塞见朋友', categoryId: '${typeId}_exposure', description: '让他塞着肛塞和朋友聚会'),
    QuizItem(id: '${typeId}_exposure_19', name: '让他戴贞操锁游泳', categoryId: '${typeId}_exposure', description: '让他戴着贞操锁去游泳'),
    QuizItem(id: '${typeId}_exposure_20', name: '让他穿紧身裤露形', categoryId: '${typeId}_exposure', description: '让他穿紧身裤露出贞操锁形状'),
    QuizItem(id: '${typeId}_exposure_21', name: '让他给朋友按摩', categoryId: '${typeId}_exposure', description: '让他给你的朋友们按摩'),
    QuizItem(id: '${typeId}_exposure_22', name: '让他当众认错', categoryId: '${typeId}_exposure', description: '在朋友面前让他跪下认错'),
    QuizItem(id: '${typeId}_exposure_23', name: '让他戴耳机听指令', categoryId: '${typeId}_exposure', description: '出门时让他戴耳机听你指令'),
    QuizItem(id: '${typeId}_exposure_24', name: '让他健身房露出', categoryId: '${typeId}_exposure', description: '让他在健身房穿暴露衣服'),
    QuizItem(id: '${typeId}_exposure_25', name: '让他当服务员伺候', categoryId: '${typeId}_exposure', description: '聚会时让他当服务员伺候大家'),
  ];

  // 调教人群（可接受调教谁/与谁一起调教）
  static final List<QuizItem> _trainerItems = [
    QuizItem(id: '${typeId}_trainer_1', name: '调教男M', categoryId: '${typeId}_trainer', description: '调教男性服从者，享受支配男性的快感'),
    QuizItem(id: '${typeId}_trainer_2', name: '调教女M', categoryId: '${typeId}_trainer', description: '调教女性服从者，享受支配女性的快感'),
    QuizItem(id: '${typeId}_trainer_3', name: '多主调教', categoryId: '${typeId}_trainer', description: '和其他主人一起调教奴隶，多人支配'),
    QuizItem(id: '${typeId}_trainer_4', name: '情侣主调教', categoryId: '${typeId}_trainer', description: '和伴侣一起调教奴隶，情侣共同支配'),
    QuizItem(id: '${typeId}_trainer_5', name: '公调', categoryId: '${typeId}_trainer', description: '在公开场合调教奴隶，有围观者在场'),
    QuizItem(id: '${typeId}_trainer_6', name: '借给他人', categoryId: '${typeId}_trainer', description: '把奴隶借给朋友或其他主人使用'),
    QuizItem(id: '${typeId}_trainer_7', name: '调教陌生人', categoryId: '${typeId}_trainer', description: '调教陌生的奴隶，增加未知的刺激'),
    QuizItem(id: '${typeId}_trainer_8', name: '长期圈养', categoryId: '${typeId}_trainer', description: '长期圈养奴隶在身边，成为专属主人'),
    QuizItem(id: '${typeId}_trainer_9', name: '短期调教', categoryId: '${typeId}_trainer', description: '进行短期的调教体验，不建立长期关系'),
    QuizItem(id: '${typeId}_trainer_10', name: '网络调教', categoryId: '${typeId}_trainer', description: '通过网络远程调教奴隶'),
  ];

  // 终极调教（25个）- 极限玩法和深度调教
  static final List<QuizItem> _extremeItems = [
    QuizItem(id: '${typeId}_extreme_1', name: '让他看你和别人做', categoryId: '${typeId}_extreme', description: '让他在旁边看你和别的男人做'),
    QuizItem(id: '${typeId}_extreme_2', name: '让他清理别人精液', categoryId: '${typeId}_extreme', description: '让他用嘴清理你身上别人的精液'),
    QuizItem(id: '${typeId}_extreme_3', name: '让他给别人口', categoryId: '${typeId}_extreme', description: '让他给别的男人口交'),
    QuizItem(id: '${typeId}_extreme_4', name: '让他被别人肛', categoryId: '${typeId}_extreme', description: '让别的男人肛他'),
    QuizItem(id: '${typeId}_extreme_5', name: '让他找男人约', categoryId: '${typeId}_extreme', description: '让他去找男人约炮汇报'),
    QuizItem(id: '${typeId}_extreme_6', name: '让他喝你的尿', categoryId: '${typeId}_extreme', description: '在他嘴里撒尿让他喝下去'),
    QuizItem(id: '${typeId}_extreme_7', name: '让他舔马桶', categoryId: '${typeId}_extreme', description: '让他用舌头舔马桶羞辱他'),
    QuizItem(id: '${typeId}_extreme_8', name: '让他吃你排泄物', categoryId: '${typeId}_extreme', description: '让他吃你的排泄物'),
    QuizItem(id: '${typeId}_extreme_9', name: '借给闺蜜玩一晚', categoryId: '${typeId}_extreme', description: '把他借给闺蜜玩一个晚上'),
    QuizItem(id: '${typeId}_extreme_10', name: '让他伺候你和情人', categoryId: '${typeId}_extreme', description: '让他伺候你和你的情人'),
    QuizItem(id: '${typeId}_extreme_11', name: '让他网上卖身', categoryId: '${typeId}_extreme', description: '让他在网上卖自己的服务'),
    QuizItem(id: '${typeId}_extreme_12', name: '让他拍被调教视频', categoryId: '${typeId}_extreme', description: '拍下调教他的视频'),
    QuizItem(id: '${typeId}_extreme_13', name: '让他直播被调教', categoryId: '${typeId}_extreme', description: '让他直播被你调教的过程'),
    QuizItem(id: '${typeId}_extreme_14', name: '让他参加奴隶派对', categoryId: '${typeId}_extreme', description: '带他参加奴隶派对被大家玩'),
    QuizItem(id: '${typeId}_extreme_15', name: '拍卖他一晚使用权', categoryId: '${typeId}_extreme', description: '在闺蜜间拍卖他一晚使用权'),
    QuizItem(id: '${typeId}_extreme_16', name: '让他当人体家具', categoryId: '${typeId}_extreme', description: '让他当人体家具供大家使用'),
    QuizItem(id: '${typeId}_extreme_17', name: '让他永久戴贞操锁', categoryId: '${typeId}_extreme', description: '让他永久戴着贞操锁'),
    QuizItem(id: '${typeId}_extreme_18', name: '让他签奴隶契约', categoryId: '${typeId}_extreme', description: '让他签下奴隶契约归你所有'),
    QuizItem(id: '${typeId}_extreme_19', name: '让他纹上你的名字', categoryId: '${typeId}_extreme', description: '让他在身上纹上你的名字'),
    QuizItem(id: '${typeId}_extreme_20', name: '让他去gay吧被玩', categoryId: '${typeId}_extreme', description: '让他去gay吧被别人玩'),
    QuizItem(id: '${typeId}_extreme_21', name: '让他当公共厕奴', categoryId: '${typeId}_extreme', description: '让他当你和闺蜜的公共厕奴'),
    QuizItem(id: '${typeId}_extreme_22', name: '让他完全女性化', categoryId: '${typeId}_extreme', description: '让他完全女性化生活'),
    QuizItem(id: '${typeId}_extreme_23', name: '让他去做鸭', categoryId: '${typeId}_extreme', description: '让他去当鸭子赚钱给你'),
    QuizItem(id: '${typeId}_extreme_24', name: '让他被多人轮', categoryId: '${typeId}_extreme', description: '让他被多个人轮流使用'),
    QuizItem(id: '${typeId}_extreme_25', name: '让他彻底放弃尊严', categoryId: '${typeId}_extreme', description: '让他彻底放弃尊严成为奴隶'),
  ];

  static final List<QuizCategory> categories = [
    QuizCategory(
      id: '${typeId}_humiliation',
      name: '羞辱调教',
      quizTypeId: typeId,
      items: _humiliationItems,
    ),
    QuizCategory(
      id: '${typeId}_toys',
      name: '道具调教',
      quizTypeId: typeId,
      items: _toysItems,
    ),
    QuizCategory(
      id: '${typeId}_task',
      name: '指令任务',
      quizTypeId: typeId,
      items: _taskItems,
    ),
    QuizCategory(
      id: '${typeId}_exposure',
      name: '露出调教',
      quizTypeId: typeId,
      items: _exposureItems,
    ),
    QuizCategory(
      id: '${typeId}_extreme',
      name: '终极调教',
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

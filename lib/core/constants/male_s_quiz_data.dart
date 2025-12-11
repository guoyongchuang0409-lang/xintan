import '../../domain/models/quiz_type.dart';
import '../../domain/models/quiz_category.dart';
import '../../domain/models/quiz_item.dart';

class MaleSQuizData {
  MaleSQuizData._();

  static const String typeId = 'male_s';

  static QuizType get quizType => QuizType(
    id: typeId,
    name: '男S自测',
    description: '探索你作为男性支配者的倾向，了解你在调教女M时的偏好和风格',
    iconPath: 'assets/icons/male_s.png',
    categories: categories,
  );

  // 性奴（性行为相关）
  static final List<QuizItem> _sexSlaveItems = [
    QuizItem(id: '${typeId}_sex_1', name: '颜射', categoryId: '${typeId}_sex', description: '在她高潮或口交后，将精液射在她的脸上，让她感受被标记的羞耻'),
    QuizItem(id: '${typeId}_sex_2', name: '吞精', categoryId: '${typeId}_sex', description: '命令她将你的精液全部吞下，不许浪费一滴，体现完全的服从'),
    QuizItem(id: '${typeId}_sex_3', name: '口爆', categoryId: '${typeId}_sex', description: '在她嘴里射精，让她含着精液展示给你看后再吞下'),
    QuizItem(id: '${typeId}_sex_4', name: '内射', categoryId: '${typeId}_sex', description: '射在她体内，让她感受被填满和占有的感觉'),
    QuizItem(id: '${typeId}_sex_5', name: '肛交', categoryId: '${typeId}_sex', description: '使用她的后穴进行性交，开发她的后庭快感'),
    QuizItem(id: '${typeId}_sex_6', name: '潮吹失禁', categoryId: '${typeId}_sex', description: '刺激她的G点让她潮吹，体验失禁般的快感和羞耻'),
    QuizItem(id: '${typeId}_sex_7', name: '自慰展示', categoryId: '${typeId}_sex', description: '命令她在你面前自慰，详细展示她如何取悦自己'),
    QuizItem(id: '${typeId}_sex_8', name: '禁止高潮', categoryId: '${typeId}_sex', description: '在她即将高潮时停止刺激，反复边缘控制折磨她'),
    QuizItem(id: '${typeId}_sex_9', name: '扩张骚逼', categoryId: '${typeId}_sex', description: '使用扩张器或多根手指扩张她的骚逼，训练她的容纳能力'),
    QuizItem(id: '${typeId}_sex_10', name: '扩张肛门', categoryId: '${typeId}_sex', description: '使用肛塞从小到大逐步扩张她的肛门，进行后穴训练'),
    QuizItem(id: '${typeId}_sex_11', name: '双穴插入', categoryId: '${typeId}_sex', description: '同时在她的前后两个穴插入道具或阴茎，让她体验被填满'),
    QuizItem(id: '${typeId}_sex_12', name: '三穴填满', categoryId: '${typeId}_sex', description: '同时填满她的嘴、阴道和肛门，让她完全被占有'),
    QuizItem(id: '${typeId}_sex_13', name: '深喉口交', categoryId: '${typeId}_sex', description: '让她练习深喉，将鸡巴完全吞入喉咙深处'),
    QuizItem(id: '${typeId}_sex_14', name: '舔脚服侍', categoryId: '${typeId}_sex', description: '命令她跪下用舌头仔细舔舐你的脚趾和脚底'),
    QuizItem(id: '${typeId}_sex_15', name: '舔肛服侍', categoryId: '${typeId}_sex', description: '让她用舌头舔舐你的肛门，体现极致的服从'),
    QuizItem(id: '${typeId}_sex_16', name: '囚笼关押', categoryId: '${typeId}_sex', description: '将她关在狗笼或囚笼里，像宠物一样圈养'),
    QuizItem(id: '${typeId}_sex_17', name: '项圈锁链', categoryId: '${typeId}_sex', description: '给她戴上项圈用链子牵着，宣示你的所有权'),
    QuizItem(id: '${typeId}_sex_18', name: '拳交', categoryId: '${typeId}_sex', description: '将整个拳头插入她的骚逼或骚屁眼，极限扩张'),
  ];

  // 犬奴（宠物化调教）
  static final List<QuizItem> _petSlaveItems = [
    QuizItem(id: '${typeId}_pet_1', name: '狗盆喂食', categoryId: '${typeId}_pet', description: '把食物放在狗盆里，让她趴在地上像狗一样用嘴吃'),
    QuizItem(id: '${typeId}_pet_2', name: '四肢爬行', categoryId: '${typeId}_pet', description: '禁止她站立行走，只能四肢着地像狗一样爬行'),
    QuizItem(id: '${typeId}_pet_3', name: '静趴等候', categoryId: '${typeId}_pet', description: '命令她保持趴伏姿势一动不动，等待主人的命令'),
    QuizItem(id: '${typeId}_pet_4', name: '跪舔主人', categoryId: '${typeId}_pet', description: '让她跪在地上用舌头舔舐主人的身体任何部位'),
    QuizItem(id: '${typeId}_pet_5', name: '叼物取物', categoryId: '${typeId}_pet', description: '训练她用嘴叼东西，像狗一样把物品叼给主人'),
    QuizItem(id: '${typeId}_pet_6', name: '犬类扮演', categoryId: '${typeId}_pet', description: '让她戴上狗耳朵、尾巴肛塞，完全扮演一只母狗'),
    QuizItem(id: '${typeId}_pet_7', name: '学狗叫', categoryId: '${typeId}_pet', description: '训练她像狗一样汪汪叫，用叫声回应主人'),
    QuizItem(id: '${typeId}_pet_8', name: '摇尾乞怜', categoryId: '${typeId}_pet', description: '让她戴着尾巴肛塞摇屁股，像狗摇尾巴一样讨好主人'),
    QuizItem(id: '${typeId}_pet_9', name: '户外遛狗', categoryId: '${typeId}_pet', description: '给她戴上项圈和牵引绑，在户外像遛狗一样牵着她'),
    QuizItem(id: '${typeId}_pet_10', name: '狗笼过夜', categoryId: '${typeId}_pet', description: '让她睡在狗笼里过夜，体验作为宠物的生活'),
    QuizItem(id: '${typeId}_pet_11', name: '禁止说话', categoryId: '${typeId}_pet', description: '禁止她说人话，只能用叫声或肢体语言交流'),
    QuizItem(id: '${typeId}_pet_12', name: '定点排泄', categoryId: '${typeId}_pet', description: '规定她只能在指定地点排泄，像训练宠物一样'),
  ];

  // 野奴/暴露奴（露出相关）
  static final List<QuizItem> _exposureItems = [
    QuizItem(id: '${typeId}_exposure_1', name: '野外裸露', categoryId: '${typeId}_exposure', description: '在野外树林、草地等地方让她脱光暴露身体'),
    QuizItem(id: '${typeId}_exposure_2', name: '野外调教', categoryId: '${typeId}_exposure', description: '在野外对她进行调教，享受户外的刺激感'),
    QuizItem(id: '${typeId}_exposure_3', name: '野外性爱', categoryId: '${typeId}_exposure', description: '在野外和她做爱，体验被发现的刺激'),
    QuizItem(id: '${typeId}_exposure_4', name: '公共场合暴露', categoryId: '${typeId}_exposure', description: '在商场、公园等公共场合让她暴露身体部位'),
    QuizItem(id: '${typeId}_exposure_5', name: '公共场合玩弄', categoryId: '${typeId}_exposure', description: '在公共场合偷偷玩弄她，让她忍住不出声'),
    QuizItem(id: '${typeId}_exposure_6', name: '不穿内衣出门', categoryId: '${typeId}_exposure', description: '让她不穿内衣内裤出门，在衣服下真空'),
    QuizItem(id: '${typeId}_exposure_7', name: '塞道具出门', categoryId: '${typeId}_exposure', description: '让她塞着跳蛋或肛塞出门，随时遥控她'),
    QuizItem(id: '${typeId}_exposure_8', name: '向朋友露出', categoryId: '${typeId}_exposure', description: '在朋友面前让她暴露身体或进行羞耻行为'),
    QuizItem(id: '${typeId}_exposure_9', name: '向陌生人露出', categoryId: '${typeId}_exposure', description: '让她在陌生人面前暴露，体验被围观的羞耻'),
    QuizItem(id: '${typeId}_exposure_10', name: '戴贞操带出门', categoryId: '${typeId}_exposure', description: '让她戴着贞操带出门，钥匙在你手里'),
    QuizItem(id: '${typeId}_exposure_11', name: '戴项圈出门', categoryId: '${typeId}_exposure', description: '让她戴着项圈出门，藏在衣服里或故意露出'),
    QuizItem(id: '${typeId}_exposure_12', name: '透视装逛街', categoryId: '${typeId}_exposure', description: '让她穿透视装或超短裙在街上行走'),
    QuizItem(id: '${typeId}_exposure_13', name: '电梯露出', categoryId: '${typeId}_exposure', description: '在电梯里让她快速掀起衣服露出身体'),
    QuizItem(id: '${typeId}_exposure_14', name: '试衣间play', categoryId: '${typeId}_exposure', description: '在商场试衣间里和她做羞耻的事情'),
    QuizItem(id: '${typeId}_exposure_15', name: '车内露出', categoryId: '${typeId}_exposure', description: '在车里让她露出身体或进行性行为'),
  ];


  // 刑奴（刑罚道具）
  static final List<QuizItem> _punishmentItems = [
    QuizItem(id: '${typeId}_punish_1', name: '扇耳光', categoryId: '${typeId}_punish', description: '用手掌扇她的脸，让她感受被掌控的屈辱'),
    QuizItem(id: '${typeId}_punish_2', name: '口球塞嘴', categoryId: '${typeId}_punish', description: '用口球塞住她的嘴，让她无法说话只能流口水'),
    QuizItem(id: '${typeId}_punish_3', name: '扯头发', categoryId: '${typeId}_punish', description: '抓住她的头发拉扯控制，展示你的支配力'),
    QuizItem(id: '${typeId}_punish_4', name: '皮鞭抽打', categoryId: '${typeId}_punish', description: '用皮鞭抽打她的身体，在皮肤上留下红痕'),
    QuizItem(id: '${typeId}_punish_5', name: '藤条责打', categoryId: '${typeId}_punish', description: '用藤条抽打她的屁股或大腿，进行惩戒'),
    QuizItem(id: '${typeId}_punish_6', name: '木板打屁股', categoryId: '${typeId}_punish', description: '让她趴好用木板打她的屁股，打到红肿'),
    QuizItem(id: '${typeId}_punish_7', name: '绳缚捆绑', categoryId: '${typeId}_punish', description: '用绳子将她捆绑成各种姿势，限制她的行动'),
    QuizItem(id: '${typeId}_punish_8', name: '吊缚悬空', categoryId: '${typeId}_punish', description: '用绳子把她吊起来悬空，进行空中调教'),
    QuizItem(id: '${typeId}_punish_9', name: '手铐脚镣', categoryId: '${typeId}_punish', description: '用手铐脚镣锁住她，让她无法反抗'),
    QuizItem(id: '${typeId}_punish_10', name: '拘束衣', categoryId: '${typeId}_punish', description: '让她穿上拘束衣，完全限制她的行动自由'),
    QuizItem(id: '${typeId}_punish_11', name: '奶头夹', categoryId: '${typeId}_punish', description: '用夹子夹住她的奶头，带来持续的疼痛刺激'),
    QuizItem(id: '${typeId}_punish_12', name: '奶头夹拉链', categoryId: '${typeId}_punish', description: '用多个夹子连成拉链夹在身上，一拉全掉'),
    QuizItem(id: '${typeId}_punish_13', name: '骚豆夹', categoryId: '${typeId}_punish', description: '用夹子夹住她的骚豆，带来痛苦与快感'),
    QuizItem(id: '${typeId}_punish_14', name: '电击调教', categoryId: '${typeId}_punish', description: '用电击器电击她的敏感部位，让她抽搐颤抖'),
    QuizItem(id: '${typeId}_punish_15', name: '炮机调教', categoryId: '${typeId}_punish', description: '用炮机对准她的穴位持续抽插，操到她求饶'),
    QuizItem(id: '${typeId}_punish_16', name: '针刺', categoryId: '${typeId}_punish', description: '用细针刺入她的皮肤或乳头，带来尖锐痛感'),
    QuizItem(id: '${typeId}_punish_17', name: '穿孔', categoryId: '${typeId}_punish', description: '给她的奶头、骚逼唇等部位穿孔戴环'),
    QuizItem(id: '${typeId}_punish_18', name: '烙印标记', categoryId: '${typeId}_punish', description: '在她身上烙下印记，永久标记你的所有权'),
    QuizItem(id: '${typeId}_punish_19', name: '窒息控制', categoryId: '${typeId}_punish', description: '用手或绳子控制她的呼吸，让她体验窒息快感'),
    QuizItem(id: '${typeId}_punish_20', name: '冰块刺激', categoryId: '${typeId}_punish', description: '用冰块在她身上滑动，刺激她的敏感部位'),
    QuizItem(id: '${typeId}_punish_21', name: '滴蜡', categoryId: '${typeId}_punish', description: '用蜡烛在她身上滴蜡，让她感受灼热的刺激'),
    QuizItem(id: '${typeId}_punish_22', name: '冰火两重天', categoryId: '${typeId}_punish', description: '交替使用冰块和蜡烛，让她体验极端温差'),
    QuizItem(id: '${typeId}_punish_23', name: '木马刑', categoryId: '${typeId}_punish', description: '让她骑在木马上，用体重压迫敏感部位'),
    QuizItem(id: '${typeId}_punish_24', name: '蒙眼', categoryId: '${typeId}_punish', description: '蒙住她的眼睛，剥夺视觉增强其他感官'),
    QuizItem(id: '${typeId}_punish_25', name: '塞耳', categoryId: '${typeId}_punish', description: '塞住她的耳朵，让她在黑暗和寂静中等待'),
  ];


  // 厕奴（羞辱类）
  static final List<QuizItem> _toiletItems = [
    QuizItem(id: '${typeId}_toilet_1', name: '颜尿', categoryId: '${typeId}_toilet', description: '在她脸上撒尿，让她感受极致的羞辱'),
    QuizItem(id: '${typeId}_toilet_2', name: '喝尿', categoryId: '${typeId}_toilet', description: '让她喝下你的尿液，体现完全的臣服'),
    QuizItem(id: '${typeId}_toilet_3', name: '精液食用', categoryId: '${typeId}_toilet', description: '让她把精液当作食物吃下，加在饭菜里或直接吞'),
    QuizItem(id: '${typeId}_toilet_4', name: '吃口水', categoryId: '${typeId}_toilet', description: '往她嘴里吐口水让她吞下，或吐在食物里'),
    QuizItem(id: '${typeId}_toilet_5', name: '舔马桶', categoryId: '${typeId}_toilet', description: '命令她用舌头舔马桶，体验极致的羞辱'),
    QuizItem(id: '${typeId}_toilet_6', name: '舔脚底', categoryId: '${typeId}_toilet', description: '让她跪下舔干净你的脚底，包括脚趾缝'),
    QuizItem(id: '${typeId}_toilet_7', name: '舔鞋子', categoryId: '${typeId}_toilet', description: '让她用舌头舔干净你的鞋子，包括鞋底'),
    QuizItem(id: '${typeId}_toilet_8', name: '灌肠', categoryId: '${typeId}_toilet', description: '给她灌肠清洗，为后续调教做准备'),
    QuizItem(id: '${typeId}_toilet_9', name: '喝洗脚水', categoryId: '${typeId}_toilet', description: '让她喝下你的洗脚水，体现卑微的地位'),
    QuizItem(id: '${typeId}_toilet_10', name: '当厕所', categoryId: '${typeId}_toilet', description: '把她当作人体厕所使用，接受你的排泄'),
  ];

  // 心奴（心理/精神控制）
  static final List<QuizItem> _mentalItems = [
    QuizItem(id: '${typeId}_mental_1', name: '言语羞辱', categoryId: '${typeId}_mental', description: '用下流的语言羞辱她，骂她是骚货贱狗'),
    QuizItem(id: '${typeId}_mental_2', name: '人格贬低', categoryId: '${typeId}_mental', description: '贬低她的人格尊严，让她承认自己是低贱的奴隶'),
    QuizItem(id: '${typeId}_mental_3', name: '思维控制', categoryId: '${typeId}_mental', description: '控制她的思想，让她只想着如何取悦主人'),
    QuizItem(id: '${typeId}_mental_4', name: '羞耻告白', categoryId: '${typeId}_mental', description: '让她说出羞耻的话，承认自己的淫荡本性'),
    QuizItem(id: '${typeId}_mental_5', name: '网络控制', categoryId: '${typeId}_mental', description: '通过网络远程控制她的行为，随时下达命令'),
    QuizItem(id: '${typeId}_mental_6', name: '远程调教', categoryId: '${typeId}_mental', description: '不在身边时通过视频或语音远程调教她'),
    QuizItem(id: '${typeId}_mental_7', name: '规矩训练', categoryId: '${typeId}_mental', description: '制定严格的规矩让她遵守，违反就惩罚'),
    QuizItem(id: '${typeId}_mental_8', name: '圈养调教', categoryId: '${typeId}_mental', description: '将她完全圈养，控制她生活的方方面面'),
    QuizItem(id: '${typeId}_mental_9', name: '公开调教', categoryId: '${typeId}_mental', description: '在网络上公开调教她，让网友围观她的羞态'),
    QuizItem(id: '${typeId}_mental_10', name: '背诵奴规', categoryId: '${typeId}_mental', description: '让她背诵作为奴隶的规矩，每天复述'),
    QuizItem(id: '${typeId}_mental_11', name: '取贱名', categoryId: '${typeId}_mental', description: '给她取一个下贱的名字，让她用这个名字自称'),
  ];


  // 调教人群（可接受调教谁/与谁一起调教）
  static final List<QuizItem> _trainerItems = [
    QuizItem(id: '${typeId}_trainer_1', name: '调教女M', categoryId: '${typeId}_trainer', description: '调教女性服从者，享受支配女性的快感'),
    QuizItem(id: '${typeId}_trainer_2', name: '调教男M', categoryId: '${typeId}_trainer', description: '调教男性服从者，享受支配男性的快感'),
    QuizItem(id: '${typeId}_trainer_3', name: '多主调教', categoryId: '${typeId}_trainer', description: '和其他主人一起调教奴隶，多人支配'),
    QuizItem(id: '${typeId}_trainer_4', name: '情侣主调教', categoryId: '${typeId}_trainer', description: '和伴侣一起调教奴隶，情侣共同支配'),
    QuizItem(id: '${typeId}_trainer_5', name: '公调', categoryId: '${typeId}_trainer', description: '在公开场合调教奴隶，有围观者在场'),
    QuizItem(id: '${typeId}_trainer_6', name: '借给他人', categoryId: '${typeId}_trainer', description: '把奴隶借给朋友或其他主人使用'),
    QuizItem(id: '${typeId}_trainer_7', name: '调教陌生人', categoryId: '${typeId}_trainer', description: '调教陌生的奴隶，增加未知的刺激'),
    QuizItem(id: '${typeId}_trainer_8', name: '长期圈养', categoryId: '${typeId}_trainer', description: '长期圈养奴隶在身边，成为专属主人'),
    QuizItem(id: '${typeId}_trainer_9', name: '短期调教', categoryId: '${typeId}_trainer', description: '进行短期的调教体验，不建立长期关系'),
    QuizItem(id: '${typeId}_trainer_10', name: '网络调教', categoryId: '${typeId}_trainer', description: '通过网络远程调教奴隶'),
  ];

  // 背德项目（背着老公的羞耻调教）
  static final List<QuizItem> _betrayalItems = [
    QuizItem(id: '${typeId}_betrayal_1', name: '戴跳蛋和老公视频', categoryId: '${typeId}_betrayal', description: '让她塞着跳蛋和老公视频聊天，你在旁边遥控，她要忍住不叫不让老公发现'),
    QuizItem(id: '${typeId}_betrayal_2', name: '用精液给老公做饭', categoryId: '${typeId}_betrayal', description: '偷偷把你的精液加进她给老公做的饭菜里，看着老公吃下去'),
    QuizItem(id: '${typeId}_betrayal_3', name: '在婚纱照下被操', categoryId: '${typeId}_betrayal', description: '趁老公不在，在她和老公的婚纱照下把她操到高潮'),
    QuizItem(id: '${typeId}_betrayal_4', name: '边打电话边被操', categoryId: '${typeId}_betrayal', description: '让她给老公打电话时从后面操她，她要装作若无其事'),
    QuizItem(id: '${typeId}_betrayal_5', name: '在婚床上被调教', categoryId: '${typeId}_betrayal', description: '趁老公出差，在她和老公的婚床上捆绑调教她'),
    QuizItem(id: '${typeId}_betrayal_6', name: '穿老公买的内衣被操', categoryId: '${typeId}_betrayal', description: '让她穿着老公送的情趣内衣被你操湿弄脏'),
    QuizItem(id: '${typeId}_betrayal_7', name: '穿婚纱被操', categoryId: '${typeId}_betrayal', description: '让她穿着结婚时的婚纱被你操，玷污神圣的婚姻'),
    QuizItem(id: '${typeId}_betrayal_8', name: '在老公照片前被操', categoryId: '${typeId}_betrayal', description: '对着老公的照片操她，让她看着老公的脸喊你的名字'),
    QuizItem(id: '${typeId}_betrayal_9', name: '塞跳蛋陪老公吃饭', categoryId: '${typeId}_betrayal', description: '让她塞着跳蛋陪老公吃饭，你远程遥控，她要忍住不被发现'),
    QuizItem(id: '${typeId}_betrayal_10', name: '在老公隔壁房被操', categoryId: '${typeId}_betrayal', description: '老公在隔壁房间时偷偷操她，她要忍住不出声'),
    QuizItem(id: '${typeId}_betrayal_11', name: '含精液回家见老公', categoryId: '${typeId}_betrayal', description: '内射她后让她含着精液回家，带着你的精液和老公亲热'),
    QuizItem(id: '${typeId}_betrayal_12', name: '老公出差时住她家', categoryId: '${typeId}_betrayal', description: '老公出差时你住进她家，在婚床上肆意调教她'),
    QuizItem(id: '${typeId}_betrayal_13', name: '撒谎向老公的钱开房', categoryId: '${typeId}_betrayal', description: '让她用老公的钱开房给你操，花老公的钱当你的婊子'),
    QuizItem(id: '${typeId}_betrayal_14', name: '振动内裤和老公约会', categoryId: '${typeId}_betrayal', description: '让她穿着振动内裤和老公约会，你远程遥控让她高潮'),
    QuizItem(id: '${typeId}_betrayal_15', name: '乳夹夹着陪老公吃饭', categoryId: '${typeId}_betrayal', description: '让她戴着乳夹陪老公吃饭，忍着疼痛装作若无其事'),
  ];


  static final List<QuizCategory> categories = [
    QuizCategory(
      id: '${typeId}_sex',
      name: '性奴',
      quizTypeId: typeId,
      items: _sexSlaveItems,
    ),
    QuizCategory(
      id: '${typeId}_pet',
      name: '犬奴',
      quizTypeId: typeId,
      items: _petSlaveItems,
    ),
    QuizCategory(
      id: '${typeId}_exposure',
      name: '野奴/暴露奴',
      quizTypeId: typeId,
      items: _exposureItems,
    ),
    QuizCategory(
      id: '${typeId}_punish',
      name: '刑奴',
      quizTypeId: typeId,
      items: _punishmentItems,
    ),
    QuizCategory(
      id: '${typeId}_toilet',
      name: '厕奴',
      quizTypeId: typeId,
      items: _toiletItems,
    ),
    QuizCategory(
      id: '${typeId}_mental',
      name: '心奴',
      quizTypeId: typeId,
      items: _mentalItems,
    ),
    QuizCategory(
      id: '${typeId}_trainer',
      name: '调教人群',
      quizTypeId: typeId,
      items: _trainerItems,
    ),
    QuizCategory(
      id: '${typeId}_betrayal',
      name: '背德项目',
      quizTypeId: typeId,
      items: _betrayalItems,
    ),
  ];
}

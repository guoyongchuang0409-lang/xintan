import '../../domain/models/quiz_type.dart';
import '../../domain/models/quiz_category.dart';
import '../../domain/models/quiz_item.dart';

class FemaleMQuizData {
  FemaleMQuizData._();

  static const String typeId = 'female_m';

  static QuizType get quizType => QuizType(
    id: typeId,
    name: '女M自测',
    description: '探索你作为女性服从者的倾向，了解你在被调教时的偏好和接受程度',
    iconPath: 'assets/icons/female_m.png',
    categories: categories,
  );

  // 性奴（性行为相关）
  static final List<QuizItem> _sexSlaveItems = [
    QuizItem(id: '${typeId}_sex_1', name: '被颜射', categoryId: '${typeId}_sex', description: '在高潮或口交后，被射在脸上，感受被标记的羞耻'),
    QuizItem(id: '${typeId}_sex_2', name: '吞精', categoryId: '${typeId}_sex', description: '将主人的精液全部吞下，不浪费一滴，体现完全的服从'),
    QuizItem(id: '${typeId}_sex_3', name: '口爆', categoryId: '${typeId}_sex', description: '让主人射在嘴里，含着精液展示后再吞下'),
    QuizItem(id: '${typeId}_sex_4', name: '被内射', categoryId: '${typeId}_sex', description: '被射在体内，感受被填满和占有的感觉'),
    QuizItem(id: '${typeId}_sex_5', name: '被肛交', categoryId: '${typeId}_sex', description: '用后穴服侍主人，开发后庭快感'),
    QuizItem(id: '${typeId}_sex_6', name: '潮吹失禁', categoryId: '${typeId}_sex', description: '被刺激G点潮吹，体验失禁般的快感和羞耻'),
    QuizItem(id: '${typeId}_sex_7', name: '自慰展示', categoryId: '${typeId}_sex', description: '在主人面前自慰，详细展示如何取悦自己'),
    QuizItem(id: '${typeId}_sex_8', name: '禁止高潮', categoryId: '${typeId}_sex', description: '在即将高潮时被停止刺激，反复边缘控制被折磨'),
    QuizItem(id: '${typeId}_sex_9', name: '骚逼扩张', categoryId: '${typeId}_sex', description: '被使用扩张器或多根手指扩张骚逼，训练容纳能力'),
    QuizItem(id: '${typeId}_sex_10', name: '肛门扩张', categoryId: '${typeId}_sex', description: '被使用肛塞从小到大逐步扩张肛门，进行后穴训练'),
    QuizItem(id: '${typeId}_sex_11', name: '双穴插入', categoryId: '${typeId}_sex', description: '前后两个穴同时被插入道具或阴茎，体验被填满'),
    QuizItem(id: '${typeId}_sex_12', name: '三穴填满', categoryId: '${typeId}_sex', description: '嘴、阴道和肛门同时被填满，完全被占有'),
    QuizItem(id: '${typeId}_sex_13', name: '深喉口交', categoryId: '${typeId}_sex', description: '练习深喉，将鸡巴完全吞入喉咙深处服侍主人'),
    QuizItem(id: '${typeId}_sex_14', name: '舔脚服侍', categoryId: '${typeId}_sex', description: '跪下用舌头仔细舔舐主人的脚趾和脚底'),
    QuizItem(id: '${typeId}_sex_15', name: '舔肛服侍', categoryId: '${typeId}_sex', description: '用舌头舔舐主人的肛门，体现极致的服从'),
    QuizItem(id: '${typeId}_sex_16', name: '被囚笼关押', categoryId: '${typeId}_sex', description: '被关在狗笼或囚笼里，像宠物一样被圈养'),
    QuizItem(id: '${typeId}_sex_17', name: '戴项圈锁链', categoryId: '${typeId}_sex', description: '戴上项圈被链子牵着，被宣示所有权'),
    QuizItem(id: '${typeId}_sex_18', name: '被拳交', categoryId: '${typeId}_sex', description: '被整个拳头插入骚逼或骚屁眼，极限扩张'),
  ];

  // 犬奴（宠物化调教）
  static final List<QuizItem> _petSlaveItems = [
    QuizItem(id: '${typeId}_pet_1', name: '狗盆吃饭', categoryId: '${typeId}_pet', description: '趴在地上像狗一样用嘴从狗盆里吃食物'),
    QuizItem(id: '${typeId}_pet_2', name: '四肢爬行', categoryId: '${typeId}_pet', description: '禁止站立行走，只能四肢着地像狗一样爬行'),
    QuizItem(id: '${typeId}_pet_3', name: '静趴等候', categoryId: '${typeId}_pet', description: '保持趴伏姿势一动不动，等待主人的命令'),
    QuizItem(id: '${typeId}_pet_4', name: '跪舔主人', categoryId: '${typeId}_pet', description: '跪在地上用舌头舔舐主人的身体任何部位'),
    QuizItem(id: '${typeId}_pet_5', name: '叼物取物', categoryId: '${typeId}_pet', description: '用嘴叼东西，像狗一样把物品叼给主人'),
    QuizItem(id: '${typeId}_pet_6', name: '犬类扮演', categoryId: '${typeId}_pet', description: '戴上狗耳朵、尾巴肛塞，完全扮演一只母狗'),
    QuizItem(id: '${typeId}_pet_7', name: '学狗叫', categoryId: '${typeId}_pet', description: '像狗一样汪汪叫，用叫声回应主人'),
    QuizItem(id: '${typeId}_pet_8', name: '摇尾乞怜', categoryId: '${typeId}_pet', description: '戴着尾巴肛塞摇屁股，像狗摇尾巴一样讨好主人'),
    QuizItem(id: '${typeId}_pet_9', name: '被户外遛', categoryId: '${typeId}_pet', description: '戴上项圈和牵引绑，在户外像狗一样被牵着走'),
    QuizItem(id: '${typeId}_pet_10', name: '狗笼过夜', categoryId: '${typeId}_pet', description: '睡在狗笼里过夜，体验作为宠物的生活'),
    QuizItem(id: '${typeId}_pet_11', name: '禁止说话', categoryId: '${typeId}_pet', description: '禁止说人话，只能用叫声或肢体语言交流'),
    QuizItem(id: '${typeId}_pet_12', name: '定点排泄', categoryId: '${typeId}_pet', description: '只能在指定地点排泄，像宠物一样被训练'),
  ];

  // 野奴/暴露奴（露出相关）
  static final List<QuizItem> _exposureItems = [
    QuizItem(id: '${typeId}_exposure_1', name: '野外裸露', categoryId: '${typeId}_exposure', description: '在野外树林、草地等地方脱光暴露身体'),
    QuizItem(id: '${typeId}_exposure_2', name: '野外被调教', categoryId: '${typeId}_exposure', description: '在野外被调教，享受户外的刺激感'),
    QuizItem(id: '${typeId}_exposure_3', name: '野外性爱', categoryId: '${typeId}_exposure', description: '在野外和主人做爱，体验被发现的刺激'),
    QuizItem(id: '${typeId}_exposure_4', name: '公共场合暴露', categoryId: '${typeId}_exposure', description: '在商场、公园等公共场合暴露身体部位'),
    QuizItem(id: '${typeId}_exposure_5', name: '公共场合被玩弄', categoryId: '${typeId}_exposure', description: '在公共场合被偷偷玩弄，忍住不出声'),
    QuizItem(id: '${typeId}_exposure_6', name: '不穿内衣出门', categoryId: '${typeId}_exposure', description: '不穿内衣内裤出门，在衣服下真空'),
    QuizItem(id: '${typeId}_exposure_7', name: '塞道具出门', categoryId: '${typeId}_exposure', description: '塞着跳蛋或肛塞出门，被随时遥控'),
    QuizItem(id: '${typeId}_exposure_8', name: '向朋友露出', categoryId: '${typeId}_exposure', description: '在朋友面前暴露身体或进行羞耻行为'),
    QuizItem(id: '${typeId}_exposure_9', name: '向陌生人露出', categoryId: '${typeId}_exposure', description: '在陌生人面前暴露，体验被围观的羞耻'),
    QuizItem(id: '${typeId}_exposure_10', name: '戴贞操带出门', categoryId: '${typeId}_exposure', description: '戴着贞操带出门，钥匙在主人手里'),
    QuizItem(id: '${typeId}_exposure_11', name: '戴项圈出门', categoryId: '${typeId}_exposure', description: '戴着项圈出门，藏在衣服里或故意露出'),
    QuizItem(id: '${typeId}_exposure_12', name: '透视装逛街', categoryId: '${typeId}_exposure', description: '穿透视装或超短裙在街上行走'),
    QuizItem(id: '${typeId}_exposure_13', name: '电梯露出', categoryId: '${typeId}_exposure', description: '在电梯里快速掀起衣服露出身体'),
    QuizItem(id: '${typeId}_exposure_14', name: '试衣间play', categoryId: '${typeId}_exposure', description: '在商场试衣间里和主人做羞耻的事情'),
    QuizItem(id: '${typeId}_exposure_15', name: '车内露出', categoryId: '${typeId}_exposure', description: '在车里露出身体或进行性行为'),
  ];


  // 刑奴（刑罚道具）
  static final List<QuizItem> _punishmentItems = [
    QuizItem(id: '${typeId}_punish_1', name: '被扇耳光', categoryId: '${typeId}_punish', description: '被用手掌扇脸，感受被掌控的屈辱'),
    QuizItem(id: '${typeId}_punish_2', name: '口球塞嘴', categoryId: '${typeId}_punish', description: '被用口球塞住嘴，无法说话只能流口水'),
    QuizItem(id: '${typeId}_punish_3', name: '被扯头发', categoryId: '${typeId}_punish', description: '被抓住头发拉扯控制，感受主人的支配力'),
    QuizItem(id: '${typeId}_punish_4', name: '皮鞭抽打', categoryId: '${typeId}_punish', description: '被用皮鞭抽打身体，在皮肤上留下红痕'),
    QuizItem(id: '${typeId}_punish_5', name: '藤条责打', categoryId: '${typeId}_punish', description: '被用藤条抽打屁股或大腿，接受惩戒'),
    QuizItem(id: '${typeId}_punish_6', name: '木板打屁股', categoryId: '${typeId}_punish', description: '趴好被用木板打屁股，打到红肿'),
    QuizItem(id: '${typeId}_punish_7', name: '绳缚捆绑', categoryId: '${typeId}_punish', description: '被用绳子捆绑成各种姿势，限制行动'),
    QuizItem(id: '${typeId}_punish_8', name: '吊缚悬空', categoryId: '${typeId}_punish', description: '被用绳子吊起来悬空，进行空中调教'),
    QuizItem(id: '${typeId}_punish_9', name: '手铐脚镣', categoryId: '${typeId}_punish', description: '被用手铐脚镣锁住，无法反抗'),
    QuizItem(id: '${typeId}_punish_10', name: '拘束衣', categoryId: '${typeId}_punish', description: '穿上拘束衣，完全限制行动自由'),
    QuizItem(id: '${typeId}_punish_11', name: '奶头夹', categoryId: '${typeId}_punish', description: '被用夹子夹住奶头，带来持续的疼痛刺激'),
    QuizItem(id: '${typeId}_punish_12', name: '奶头夹拉链', categoryId: '${typeId}_punish', description: '被用多个夹子连成拉链夹在身上，一拉全掉'),
    QuizItem(id: '${typeId}_punish_13', name: '骚豆夹', categoryId: '${typeId}_punish', description: '被用夹子夹住骚豆，带来痛苦与快感'),
    QuizItem(id: '${typeId}_punish_14', name: '电击调教', categoryId: '${typeId}_punish', description: '被用电击器电击敏感部位，抽搐颤抖'),
    QuizItem(id: '${typeId}_punish_15', name: '炮机调教', categoryId: '${typeId}_punish', description: '被用炮机对准穴位持续抽插，操到求饶'),
    QuizItem(id: '${typeId}_punish_16', name: '针刺', categoryId: '${typeId}_punish', description: '被用细针刺入皮肤或乳头，带来尖锐痛感'),
    QuizItem(id: '${typeId}_punish_17', name: '穿孔', categoryId: '${typeId}_punish', description: '奶头、骚逼唇等部位被穿孔戴环'),
    QuizItem(id: '${typeId}_punish_18', name: '烙印标记', categoryId: '${typeId}_punish', description: '身上被烙下印记，永久标记主人的所有权'),
    QuizItem(id: '${typeId}_punish_19', name: '窒息控制', categoryId: '${typeId}_punish', description: '被用手或绳子控制呼吸，体验窒息快感'),
    QuizItem(id: '${typeId}_punish_20', name: '冰块刺激', categoryId: '${typeId}_punish', description: '被用冰块在身上滑动，刺激敏感部位'),
    QuizItem(id: '${typeId}_punish_21', name: '滴蜡', categoryId: '${typeId}_punish', description: '被用蜡烛在身上滴蜡，感受灼热的刺激'),
    QuizItem(id: '${typeId}_punish_22', name: '冰火两重天', categoryId: '${typeId}_punish', description: '被交替使用冰块和蜡烛，体验极端温差'),
    QuizItem(id: '${typeId}_punish_23', name: '木马刑', categoryId: '${typeId}_punish', description: '骑在木马上，用体重压迫敏感部位'),
    QuizItem(id: '${typeId}_punish_24', name: '蒙眼', categoryId: '${typeId}_punish', description: '被蒙住眼睛，剥夺视觉增强其他感官'),
    QuizItem(id: '${typeId}_punish_25', name: '塞耳', categoryId: '${typeId}_punish', description: '被塞住耳朵，在黑暗和寂静中等待'),
  ];


  // 厕奴（羞辱类）
  static final List<QuizItem> _toiletItems = [
    QuizItem(id: '${typeId}_toilet_1', name: '被颜尿', categoryId: '${typeId}_toilet', description: '被在脸上撒尿，感受极致的羞辱'),
    QuizItem(id: '${typeId}_toilet_2', name: '喝尿', categoryId: '${typeId}_toilet', description: '喝下主人的尿液，体现完全的臣服'),
    QuizItem(id: '${typeId}_toilet_3', name: '精液食用', categoryId: '${typeId}_toilet', description: '把精液当作食物吃下，加在饭菜里或直接吞'),
    QuizItem(id: '${typeId}_toilet_4', name: '吃口水', categoryId: '${typeId}_toilet', description: '被吐口水在嘴里吞下，或吃有口水的食物'),
    QuizItem(id: '${typeId}_toilet_5', name: '舔马桶', categoryId: '${typeId}_toilet', description: '用舌头舔马桶，体验极致的羞辱'),
    QuizItem(id: '${typeId}_toilet_6', name: '舔脚底', categoryId: '${typeId}_toilet', description: '跪下舔干净主人的脚底，包括脚趾缝'),
    QuizItem(id: '${typeId}_toilet_7', name: '舔鞋子', categoryId: '${typeId}_toilet', description: '用舌头舔干净主人的鞋子，包括鞋底'),
    QuizItem(id: '${typeId}_toilet_8', name: '被灌肠', categoryId: '${typeId}_toilet', description: '被灌肠清洗，为后续调教做准备'),
    QuizItem(id: '${typeId}_toilet_9', name: '喝洗脚水', categoryId: '${typeId}_toilet', description: '喝下主人的洗脚水，体现卑微的地位'),
    QuizItem(id: '${typeId}_toilet_10', name: '当厕所', categoryId: '${typeId}_toilet', description: '被当作人体厕所使用，接受主人的排泄'),
  ];

  // 心奴（心理/精神控制）
  static final List<QuizItem> _mentalItems = [
    QuizItem(id: '${typeId}_mental_1', name: '被言语羞辱', categoryId: '${typeId}_mental', description: '被用下流的语言羞辱，被骂是骚货贱狗'),
    QuizItem(id: '${typeId}_mental_2', name: '人格贬低', categoryId: '${typeId}_mental', description: '被贬低人格尊严，承认自己是低贱的奴隶'),
    QuizItem(id: '${typeId}_mental_3', name: '思维控制', categoryId: '${typeId}_mental', description: '被控制思想，只想着如何取悦主人'),
    QuizItem(id: '${typeId}_mental_4', name: '羞耻告白', categoryId: '${typeId}_mental', description: '说出羞耻的话，承认自己的淫荡本性'),
    QuizItem(id: '${typeId}_mental_5', name: '网络控制', categoryId: '${typeId}_mental', description: '通过网络被远程控制行为，随时接受命令'),
    QuizItem(id: '${typeId}_mental_6', name: '远程调教', categoryId: '${typeId}_mental', description: '主人不在身边时通过视频或语音被远程调教'),
    QuizItem(id: '${typeId}_mental_7', name: '规矩训练', categoryId: '${typeId}_mental', description: '遵守严格的规矩，违反就接受惩罚'),
    QuizItem(id: '${typeId}_mental_8', name: '被圈养', categoryId: '${typeId}_mental', description: '被完全圈养，生活的方方面面被控制'),
    QuizItem(id: '${typeId}_mental_9', name: '公开调教', categoryId: '${typeId}_mental', description: '在网络上被公开调教，让网友围观羞态'),
    QuizItem(id: '${typeId}_mental_10', name: '背诵奴规', categoryId: '${typeId}_mental', description: '背诵作为奴隶的规矩，每天复述'),
    QuizItem(id: '${typeId}_mental_11', name: '用贱名', categoryId: '${typeId}_mental', description: '被取一个下贱的名字，用这个名字自称'),
  ];


  // 调教人群（可接受被谁调教）
  static final List<QuizItem> _trainerItems = [
    QuizItem(id: '${typeId}_trainer_1', name: '男主调教', categoryId: '${typeId}_trainer', description: '被男性主人调教，体验被男性支配'),
    QuizItem(id: '${typeId}_trainer_2', name: '女主调教', categoryId: '${typeId}_trainer', description: '被女主人调教，体验被同性支配'),
    QuizItem(id: '${typeId}_trainer_3', name: '多主调教', categoryId: '${typeId}_trainer', description: '被多个主人一起调教，同时服侍多人'),
    QuizItem(id: '${typeId}_trainer_4', name: '情侣主调教', categoryId: '${typeId}_trainer', description: '被情侣主人一起调教，服侍一对主人'),
    QuizItem(id: '${typeId}_trainer_5', name: '公调', categoryId: '${typeId}_trainer', description: '在公开场合被调教，有围观者在场'),
    QuizItem(id: '${typeId}_trainer_6', name: '被借给他人', categoryId: '${typeId}_trainer', description: '被主人借给朋友或其他主人使用'),
    QuizItem(id: '${typeId}_trainer_7', name: '陌生人调教', categoryId: '${typeId}_trainer', description: '被陌生人调教，增加未知的刺激'),
    QuizItem(id: '${typeId}_trainer_8', name: '长期圈养', categoryId: '${typeId}_trainer', description: '被长期圈养在主人身边，成为专属的奴隶'),
    QuizItem(id: '${typeId}_trainer_9', name: '短期调教', categoryId: '${typeId}_trainer', description: '进行短期的调教体验，不建立长期关系'),
    QuizItem(id: '${typeId}_trainer_10', name: '网络主调教', categoryId: '${typeId}_trainer', description: '通过网络被远程主人调教控制'),
  ];

  // 背德项目（背着老公的羞耻调教）
  static final List<QuizItem> _betrayalItems = [
    QuizItem(id: '${typeId}_betrayal_1', name: '戴跳蛋和老公视频', categoryId: '${typeId}_betrayal', description: '塞着跳蛋和老公视频聊天，被遥控时要忍住不叫不让老公发现'),
    QuizItem(id: '${typeId}_betrayal_2', name: '用精液给老公做饭', categoryId: '${typeId}_betrayal', description: '偷偷把情人的精液加进给老公做的饭菜里，看着老公吃下去'),
    QuizItem(id: '${typeId}_betrayal_3', name: '在婚纱照下被操', categoryId: '${typeId}_betrayal', description: '趁老公不在，在和老公的婚纱照下被操到高潮'),
    QuizItem(id: '${typeId}_betrayal_4', name: '边打电话边被操', categoryId: '${typeId}_betrayal', description: '给老公打电话时从后面被操，要装作若无其事'),
    QuizItem(id: '${typeId}_betrayal_5', name: '在婚床上被调教', categoryId: '${typeId}_betrayal', description: '趁老公出差，在和老公的婚床上被捆绑调教'),
    QuizItem(id: '${typeId}_betrayal_6', name: '穿老公买的内衣被操', categoryId: '${typeId}_betrayal', description: '穿着老公送的情趣内衣被情人操湿弄脏'),
    QuizItem(id: '${typeId}_betrayal_7', name: '穿婚纱被操', categoryId: '${typeId}_betrayal', description: '穿着结婚时的婚纱被情人操，玷污神圣的婚姻'),
    QuizItem(id: '${typeId}_betrayal_8', name: '在老公照片前被操', categoryId: '${typeId}_betrayal', description: '对着老公的照片被操，看着老公的脸喊情人的名字'),
    QuizItem(id: '${typeId}_betrayal_9', name: '塞跳蛋陪老公吃饭', categoryId: '${typeId}_betrayal', description: '塞着跳蛋陪老公吃饭，被远程遥控时要忍住不被发现'),
    QuizItem(id: '${typeId}_betrayal_10', name: '在老公隔壁房被操', categoryId: '${typeId}_betrayal', description: '老公在隔壁房间时偷偷被操，要忍住不出声'),
    QuizItem(id: '${typeId}_betrayal_11', name: '含精液回家见老公', categoryId: '${typeId}_betrayal', description: '被内射后含着精液回家，带着情人的精液和老公亲热'),
    QuizItem(id: '${typeId}_betrayal_12', name: '老公出差时被住家调教', categoryId: '${typeId}_betrayal', description: '老公出差时让情人住进家里，在婚床上被肆意调教'),
    QuizItem(id: '${typeId}_betrayal_13', name: '用老公的钱开房', categoryId: '${typeId}_betrayal', description: '用老公的钱开房给情人操，花老公的钱当情人的婊子'),
    QuizItem(id: '${typeId}_betrayal_14', name: '振动内裤和老公约会', categoryId: '${typeId}_betrayal', description: '穿着振动内裤和老公约会，被情人远程遥控高潮'),
    QuizItem(id: '${typeId}_betrayal_15', name: '乳夹夹着陪老公吃饭', categoryId: '${typeId}_betrayal', description: '戴着乳夹陪老公吃饭，忍着疼痛装作若无其事'),
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

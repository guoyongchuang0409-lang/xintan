import '../../domain/models/quiz_type.dart';
import '../../domain/models/quiz_category.dart';
import '../../domain/models/quiz_item.dart';

class MaleMQuizData {
  MaleMQuizData._();

  static const String typeId = 'male_m';

  static final QuizType quizType = QuizType(
    id: typeId,
    name: '男M自测',
    description: '探索你作为男性服从者的倾向，了解你被女S调教时的偏好和感受',
    iconPath: 'assets/icons/male_m.png',
    categories: categories,
  );

  // K9（犬奴）
  static final List<QuizItem> _k9Items = [
    QuizItem(id: '${typeId}_k9_1', name: '项圈牵溜', categoryId: '${typeId}_k9', description: '戴着项圈被女王用链子牵着走'),
    QuizItem(id: '${typeId}_k9_2', name: '狗笼饲养', categoryId: '${typeId}_k9', description: '被关进狗笼里过夜或长期圈养'),
    QuizItem(id: '${typeId}_k9_3', name: '四肢爬行', categoryId: '${typeId}_k9', description: '禁止站立，只能四肢着地像狗一样爬行'),
    QuizItem(id: '${typeId}_k9_4', name: '束缚肘部爬行', categoryId: '${typeId}_k9', description: '肘部被束缚，只能用膝盖和手肘爬行'),
    QuizItem(id: '${typeId}_k9_5', name: '犬姿训练', categoryId: '${typeId}_k9', description: '训练各种犬类姿势，如坐、趴、站立'),
    QuizItem(id: '${typeId}_k9_6', name: '狗狗装扮', categoryId: '${typeId}_k9', description: '戴上狗耳朵、尾巴肛塞，完全扮演一只狗'),
    QuizItem(id: '${typeId}_k9_7', name: '狗叫', categoryId: '${typeId}_k9', description: '像狗一样汪汪叫，用叫声回应女王'),
    QuizItem(id: '${typeId}_k9_8', name: '撒尿舔食等犬化', categoryId: '${typeId}_k9', description: '像狗一样抬腿撒尿、用嘴吃食物'),
    QuizItem(id: '${typeId}_k9_9', name: '外出遛弯', categoryId: '${typeId}_k9', description: '戴着项圈在户外被遛'),
    QuizItem(id: '${typeId}_k9_10', name: '钻跨', categoryId: '${typeId}_k9', description: '从女王胯下钻过'),
    QuizItem(id: '${typeId}_k9_11', name: '足深喉', categoryId: '${typeId}_k9', description: '用嘴含住女王的脚趾深入口腔'),
  ];

  // 性奴
  static final List<QuizItem> _sexSlaveItems = [
    QuizItem(id: '${typeId}_sex_1', name: '口舌侍奉', categoryId: '${typeId}_sex', description: '用嘴和舌头服侍女王的身体'),
    QuizItem(id: '${typeId}_sex_2', name: '假阳活塞', categoryId: '${typeId}_sex', description: '被女王用假阳具抽插'),
    QuizItem(id: '${typeId}_sex_3', name: '肛口插入', categoryId: '${typeId}_sex', description: '肛门被插入各种道具'),
    QuizItem(id: '${typeId}_sex_4', name: '扩肛', categoryId: '${typeId}_sex', description: '肛门被逐步扩张训练'),
    QuizItem(id: '${typeId}_sex_5', name: '四爽（pegging）', categoryId: '${typeId}_sex', description: '被女王用穿戴式假阳具肛交'),
    QuizItem(id: '${typeId}_sex_6', name: '按到射精', categoryId: '${typeId}_sex', description: '通过前列腺按摩达到射精'),
    QuizItem(id: '${typeId}_sex_7', name: '强制榨精', categoryId: '${typeId}_sex', description: '被强制榨取精液'),
    QuizItem(id: '${typeId}_sex_8', name: '短期佩戴贞操锁', categoryId: '${typeId}_sex', description: '短期佩戴贞操锁禁欲'),
    QuizItem(id: '${typeId}_sex_9', name: '长期佩戴贞操锁', categoryId: '${typeId}_sex', description: '长期佩戴贞操锁，钥匙在女王手里'),
    QuizItem(id: '${typeId}_sex_10', name: '马眼插入', categoryId: '${typeId}_sex', description: '马眼被插入尿道塞'),
    QuizItem(id: '${typeId}_sex_11', name: '自慰表演', categoryId: '${typeId}_sex', description: '在女王面前自慰表演'),
    QuizItem(id: '${typeId}_sex_12', name: '坐脸', categoryId: '${typeId}_sex', description: '女王坐在脸上让你舔'),
    QuizItem(id: '${typeId}_sex_13', name: '磨鸡巴', categoryId: '${typeId}_sex', description: '鸡巴被女王用脚或手磨蹭'),
    QuizItem(id: '${typeId}_sex_14', name: '耳光', categoryId: '${typeId}_sex', description: '被女王扇耳光'),
    QuizItem(id: '${typeId}_sex_15', name: '皮拍掌拍打', categoryId: '${typeId}_sex', description: '被皮拍或手掌拍打身体'),
    QuizItem(id: '${typeId}_sex_16', name: '藤条等鞭打', categoryId: '${typeId}_sex', description: '被藤条或鞭子抽打'),
    QuizItem(id: '${typeId}_sex_17', name: '纹棒等蛋庇鞭打', categoryId: '${typeId}_sex', description: '蛋蛋被鞭打惩罚'),
  ];

  // 刑奴
  static final List<QuizItem> _punishItems = [
    QuizItem(id: '${typeId}_punish_1', name: '口塞', categoryId: '${typeId}_punish', description: '嘴里被塞口球或口塞'),
    QuizItem(id: '${typeId}_punish_2', name: '奶头夹', categoryId: '${typeId}_punish', description: '奶头被夹子夹住'),
    QuizItem(id: '${typeId}_punish_3', name: '奶头拧重', categoryId: '${typeId}_punish', description: '奶头被用力拧捏'),
    QuizItem(id: '${typeId}_punish_4', name: '鸡巴、蛋蛋夹', categoryId: '${typeId}_punish', description: '鸡巴和蛋蛋被夹子夹住'),
    QuizItem(id: '${typeId}_punish_5', name: '皮肤各处上夹子', categoryId: '${typeId}_punish', description: '身体各处皮肤被夹子夹住'),
    QuizItem(id: '${typeId}_punish_6', name: '鞭打鸡巴蛋蛋', categoryId: '${typeId}_punish', description: '鸡巴和蛋蛋被鞭打'),
    QuizItem(id: '${typeId}_punish_7', name: '电击', categoryId: '${typeId}_punish', description: '被电击器电击敏感部位'),
    QuizItem(id: '${typeId}_punish_8', name: '低温蜡烛', categoryId: '${typeId}_punish', description: '被低温蜡烛滴蜡'),
    QuizItem(id: '${typeId}_punish_9', name: '木刑', categoryId: '${typeId}_punish', description: '被木制刑具惩罚'),
    QuizItem(id: '${typeId}_punish_10', name: '窒息', categoryId: '${typeId}_punish', description: '被控制呼吸体验窒息感'),
    QuizItem(id: '${typeId}_punish_11', name: '踩踏鸡巴', categoryId: '${typeId}_punish', description: '鸡巴和身体被女王踩踏'),
  ];

  // 脚奴
  static final List<QuizItem> _footItems = [
    QuizItem(id: '${typeId}_foot_1', name: '嗅脚（无味）', categoryId: '${typeId}_foot', description: '嗅闻女王干净的脚'),
    QuizItem(id: '${typeId}_foot_2', name: '嗅脚（有味）', categoryId: '${typeId}_foot', description: '嗅闻女王有味道的脚'),
    QuizItem(id: '${typeId}_foot_3', name: '舔袜（无味）', categoryId: '${typeId}_foot', description: '舔舐女王干净的袜子'),
    QuizItem(id: '${typeId}_foot_4', name: '舔袜（有味）', categoryId: '${typeId}_foot', description: '舔舐女王有味道的袜子'),
    QuizItem(id: '${typeId}_foot_5', name: '舔鞋（干净）', categoryId: '${typeId}_foot', description: '舔舐女王干净的鞋子'),
    QuizItem(id: '${typeId}_foot_6', name: '舔鞋（外出）', categoryId: '${typeId}_foot', description: '舔舐女王外出穿过的鞋子'),
    QuizItem(id: '${typeId}_foot_7', name: '高跟鞋踩踏', categoryId: '${typeId}_foot', description: '被女王穿高跟鞋踩踏'),
    QuizItem(id: '${typeId}_foot_8', name: '平底鞋踩踏', categoryId: '${typeId}_foot', description: '被女王穿平底鞋踩踏'),
    QuizItem(id: '${typeId}_foot_9', name: '裸足跟踏', categoryId: '${typeId}_foot', description: '被女王赤脚踩踏'),
  ];

  // 玩具化
  static final List<QuizItem> _toyItems = [
    QuizItem(id: '${typeId}_toy_1', name: '奶头穿环', categoryId: '${typeId}_toy', description: '奶头穿环'),
    QuizItem(id: '${typeId}_toy_2', name: '鸡巴穿环', categoryId: '${typeId}_toy', description: '鸡巴或蛋蛋穿环'),
    QuizItem(id: '${typeId}_toy_3', name: '作为性玩具', categoryId: '${typeId}_toy', description: '被当作性玩具使用'),
    QuizItem(id: '${typeId}_toy_4', name: '作为家具', categoryId: '${typeId}_toy', description: '被当作人体家具使用'),
    QuizItem(id: '${typeId}_toy_5', name: '做为脚凳', categoryId: '${typeId}_toy', description: '趴着当女王的脚凳'),
    QuizItem(id: '${typeId}_toy_6', name: '除毛', categoryId: '${typeId}_toy', description: '身体毛发被剃除'),
    QuizItem(id: '${typeId}_toy_7', name: '身上写字', categoryId: '${typeId}_toy', description: '身上被写羞辱性文字'),
    QuizItem(id: '${typeId}_toy_8', name: '刻青', categoryId: '${typeId}_toy', description: '身上被纹上标记'),
    QuizItem(id: '${typeId}_toy_9', name: '异装', categoryId: '${typeId}_toy', description: '穿女装或特殊服装'),
    QuizItem(id: '${typeId}_toy_10', name: '木乃伊', categoryId: '${typeId}_toy', description: '被包裹成木乃伊状态'),
    QuizItem(id: '${typeId}_toy_11', name: '拍照录像（不露脸）', categoryId: '${typeId}_toy', description: '被调教时被拍照录像但不露脸'),
    QuizItem(id: '${typeId}_toy_12', name: '拍照录像（露脸）', categoryId: '${typeId}_toy', description: '被调教时被拍照录像且露脸'),
  ];

  // 厕奴
  static final List<QuizItem> _toiletItems = [
    QuizItem(id: '${typeId}_toilet_1', name: '尿浴', categoryId: '${typeId}_toilet', description: '被女王的尿液淋浴'),
    QuizItem(id: '${typeId}_toilet_2', name: '喝尿', categoryId: '${typeId}_toilet', description: '喝女王的尿液'),
    QuizItem(id: '${typeId}_toilet_3', name: '吃黄金', categoryId: '${typeId}_toilet', description: '吃女王的排泄物'),
    QuizItem(id: '${typeId}_toilet_4', name: '舔经血', categoryId: '${typeId}_toilet', description: '舔舐女王的经血'),
    QuizItem(id: '${typeId}_toilet_5', name: '作为痰盂', categoryId: '${typeId}_toilet', description: '被当作痰盂使用'),
    QuizItem(id: '${typeId}_toilet_6', name: '吞口水', categoryId: '${typeId}_toilet', description: '吞下女王吐的口水'),
    QuizItem(id: '${typeId}_toilet_7', name: '嗅精（自己的）', categoryId: '${typeId}_toilet', description: '嗅闻自己的精液'),
    QuizItem(id: '${typeId}_toilet_8', name: '喝尿（自己的）', categoryId: '${typeId}_toilet', description: '喝自己的尿液'),
  ];

  // 心奴
  static final List<QuizItem> _mentalItems = [
    QuizItem(id: '${typeId}_mental_1', name: '思维控制', categoryId: '${typeId}_mental', description: '被女王控制思想'),
    QuizItem(id: '${typeId}_mental_2', name: '日常控制', categoryId: '${typeId}_mental', description: '日常生活被女王控制'),
    QuizItem(id: '${typeId}_mental_3', name: '网络调教', categoryId: '${typeId}_mental', description: '通过网络被远程调教'),
    QuizItem(id: '${typeId}_mental_4', name: '言语羞辱', categoryId: '${typeId}_mental', description: '被女王用语言羞辱'),
    QuizItem(id: '${typeId}_mental_5', name: '人格羞辱', categoryId: '${typeId}_mental', description: '人格尊严被贬低羞辱'),
  ];

  // 露出
  static final List<QuizItem> _exposureItems = [
    QuizItem(id: '${typeId}_exposure_1', name: '公共场所暴露', categoryId: '${typeId}_exposure', description: '在公共场所暴露身体'),
    QuizItem(id: '${typeId}_exposure_2', name: '公共场所玩弄', categoryId: '${typeId}_exposure', description: '在公共场所被玩弄'),
    QuizItem(id: '${typeId}_exposure_3', name: '公共场所调教', categoryId: '${typeId}_exposure', description: '在公共场所被调教'),
    QuizItem(id: '${typeId}_exposure_4', name: '公共场所器具', categoryId: '${typeId}_exposure', description: '在公共场所佩戴器具'),
    QuizItem(id: '${typeId}_exposure_5', name: '野外暴露', categoryId: '${typeId}_exposure', description: '在野外暴露身体'),
    QuizItem(id: '${typeId}_exposure_6', name: '野外玩弄', categoryId: '${typeId}_exposure', description: '在野外被玩弄'),
    QuizItem(id: '${typeId}_exposure_7', name: '野外拥抱', categoryId: '${typeId}_exposure', description: '在野外被拥抱调教'),
    QuizItem(id: '${typeId}_exposure_8', name: '野外器具', categoryId: '${typeId}_exposure', description: '在野外佩戴器具'),
    QuizItem(id: '${typeId}_exposure_9', name: '网络暴露照片', categoryId: '${typeId}_exposure', description: '在网络上暴露照片'),
    QuizItem(id: '${typeId}_exposure_10', name: '网络暴露视频', categoryId: '${typeId}_exposure', description: '在网络上暴露视频'),
    QuizItem(id: '${typeId}_exposure_11', name: '公调', categoryId: '${typeId}_exposure', description: '在公开场合被调教'),
  ];

  // 束缚
  static final List<QuizItem> _bondageItems = [
    QuizItem(id: '${typeId}_bondage_1', name: '手铐等轻度捆束', categoryId: '${typeId}_bondage', description: '被手铐等轻度束缚'),
    QuizItem(id: '${typeId}_bondage_2', name: '麻绳等中度束缚', categoryId: '${typeId}_bondage', description: '被麻绳中度捆绑'),
    QuizItem(id: '${typeId}_bondage_3', name: '静电胶带等紧缚', categoryId: '${typeId}_bondage', description: '被胶带紧密束缚'),
    QuizItem(id: '${typeId}_bondage_4', name: '全身长时间固定', categoryId: '${typeId}_bondage', description: '全身被长时间固定'),
    QuizItem(id: '${typeId}_bondage_5', name: '密闭空间放置', categoryId: '${typeId}_bondage', description: '被放置在密闭空间'),
    QuizItem(id: '${typeId}_bondage_6', name: '剥夺五官', categoryId: '${typeId}_bondage', description: '被蒙眼塞耳剥夺感官'),
  ];

  // 调教人群（可接受被谁调教）
  static final List<QuizItem> _trainerItems = [
    QuizItem(id: '${typeId}_trainer_1', name: '女主调教', categoryId: '${typeId}_trainer', description: '被女性主人调教，体验被女王支配'),
    QuizItem(id: '${typeId}_trainer_2', name: '男主调教', categoryId: '${typeId}_trainer', description: '被男性主人调教，体验被男性支配'),
    QuizItem(id: '${typeId}_trainer_3', name: '多主调教', categoryId: '${typeId}_trainer', description: '被多个主人一起调教，同时服侍多人'),
    QuizItem(id: '${typeId}_trainer_4', name: '情侣主调教', categoryId: '${typeId}_trainer', description: '被情侣主人一起调教，服侍一对主人'),
    QuizItem(id: '${typeId}_trainer_5', name: '公调', categoryId: '${typeId}_trainer', description: '在公开场合被调教，有围观者在场'),
    QuizItem(id: '${typeId}_trainer_6', name: '被借给他人', categoryId: '${typeId}_trainer', description: '被主人借给朋友或其他主人使用'),
    QuizItem(id: '${typeId}_trainer_7', name: '陌生人调教', categoryId: '${typeId}_trainer', description: '被陌生人调教，增加未知的刺激'),
    QuizItem(id: '${typeId}_trainer_8', name: '长期圈养', categoryId: '${typeId}_trainer', description: '被长期圈养在主人身边，成为专属的奴隶'),
    QuizItem(id: '${typeId}_trainer_9', name: '短期调教', categoryId: '${typeId}_trainer', description: '进行短期的调教体验，不建立长期关系'),
    QuizItem(id: '${typeId}_trainer_10', name: '网络主调教', categoryId: '${typeId}_trainer', description: '通过网络被远程主人调教控制'),
  ];

  static final List<QuizCategory> categories = [
    QuizCategory(
      id: '${typeId}_k9',
      name: 'K9（犬奴）',
      quizTypeId: typeId,
      items: _k9Items,
    ),
    QuizCategory(
      id: '${typeId}_sex',
      name: '性奴',
      quizTypeId: typeId,
      items: _sexSlaveItems,
    ),
    QuizCategory(
      id: '${typeId}_punish',
      name: '刑奴',
      quizTypeId: typeId,
      items: _punishItems,
    ),
    QuizCategory(
      id: '${typeId}_foot',
      name: '脚奴',
      quizTypeId: typeId,
      items: _footItems,
    ),
    QuizCategory(
      id: '${typeId}_toy',
      name: '玩具化',
      quizTypeId: typeId,
      items: _toyItems,
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
      id: '${typeId}_exposure',
      name: '露出',
      quizTypeId: typeId,
      items: _exposureItems,
    ),
    QuizCategory(
      id: '${typeId}_bondage',
      name: '束缚',
      quizTypeId: typeId,
      items: _bondageItems,
    ),
    QuizCategory(
      id: '${typeId}_trainer',
      name: '调教人群',
      quizTypeId: typeId,
      items: _trainerItems,
    ),
  ];
}

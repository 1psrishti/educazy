enum SubjectType { Physics, Chemistry, Mathematics }

extension SubjectExtension on SubjectType {
  String get str {
    switch (this) {
      case SubjectType.Mathematics:
        {
          return "Mathematics";
        }
      case SubjectType.Chemistry:
        {
          return 'Chemistry';
        }
      case SubjectType.Physics:
        {
          return 'Physics';
        }
    }
  }
}

import 'package:testemundowap/core/helpers/exceptions.dart';
import 'package:testemundowap/domain/entity/position.entity.dart';
import 'package:testemundowap/domain/factory/i.repository.factory.dart';
import 'package:testemundowap/domain/repositorys/position/i.position.repository.dart';

class FetchLocationsUsecase {
  late IPositionRepository _positionRepository;

  FetchLocationsUsecase(IRepositoryFactory repositoryFactory) {
    _positionRepository = repositoryFactory.createPositionRepository;
  }

  Future<List<PositionEntity>> execute() async {
    try {
      final locations = await _positionRepository.getPositions();
      return locations;
    } on InternalException {
      rethrow;
    } catch (e) {
      throw FetchLocationsException(
          message: 'Não foi possivel recuperar as localizações salvas');
    }
  }
}

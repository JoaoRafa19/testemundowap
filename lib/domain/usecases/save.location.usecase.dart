import 'package:testemundowap/core/helpers/exceptions.dart';
import 'package:testemundowap/domain/entity/position.entity.dart';
import 'package:testemundowap/domain/factory/i.repository.factory.dart';
import 'package:testemundowap/domain/factory/i.service.factory.dart';
import 'package:testemundowap/domain/repositorys/position/i.position.repository.dart';
import 'package:testemundowap/domain/service/i.geolocation.service.dart';

class SaveLocalizationUsecase {
  late IGeolocationService _geolocationService;
  late IPositionRepository _positionRepository;

  SaveLocalizationUsecase(
      IServiceFactory serviceFactory, IRepositoryFactory repositoryFactory) {
    _geolocationService = serviceFactory.createGeolocationService;
    _positionRepository = repositoryFactory.createPositionRepository;
  }

  Future<PositionEntity> execute() async {
    try {
      final position = await _geolocationService.getLocalization();
      final save = await _positionRepository.setPosition(position);
      if (save == null) {
        throw SaveLocalizationException(
          message: "não foi possivel salvar a localização",
        );
      }
      return position;
    } on InternalException {
      rethrow;
    } catch (e) {
      throw SaveLocalizationException(
        message: "não foi possivel obter ou salvar a localização",
      );
    }
  }
}

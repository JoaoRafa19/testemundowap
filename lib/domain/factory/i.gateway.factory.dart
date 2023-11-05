import 'package:testemundowap/domain/gateway/i.auth.gateway.dart';

abstract class IGatewayFactory {
  IAuthGateway get createAuthGateway;
}

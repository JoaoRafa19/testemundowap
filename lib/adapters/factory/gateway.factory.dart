import 'package:testemundowap/adapters/gateway/traderesult.auth.gateway.dart';
import 'package:testemundowap/domain/factory/i.gateway.factory.dart';
import 'package:testemundowap/domain/gateway/i.auth.gateway.dart';

class GatewayFactory implements IGatewayFactory {
  @override
  IAuthGateway get createAuthGateway =>
      TradeResultAuthGateway("https://api-tr.traderesult.app");
}

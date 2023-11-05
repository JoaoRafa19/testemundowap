import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:testemundowap/adapters/gateway/base.gatewat.dart';
import 'package:testemundowap/core/helpers/exceptions.dart';
import 'package:testemundowap/domain/dto/login/login.request.dto.dart';
import 'package:testemundowap/domain/gateway/i.auth.gateway.dart';

class TradeResultAuthGateway extends BaseGateway implements IAuthGateway {
  TradeResultAuthGateway(super.baseUrl);

  @override
  Future logOut() {
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> login(LoginRequestDTO data) async {
    try {
      final base = client.dio.options;
      final requestData = json.encode(data);
      final response =
          await Dio(base).post("/TestMobile/auth", data: requestData);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw GatewayException(message: 'Erro ao realizar o login');
      }
    } on InternalException {
      rethrow;
    } catch (e) {
      throw GatewayException(message: 'erro ao realizar o login');
    }
  }
}

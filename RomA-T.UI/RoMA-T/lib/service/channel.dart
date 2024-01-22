import 'package:grpc/grpc.dart';

ClientChannel createGrpcChannel(String host, int port) {
  return ClientChannel(
    host,
    port: port,
    options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
  );
}

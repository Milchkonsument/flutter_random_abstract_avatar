#ifndef FLUTTER_PLUGIN_RANDOM_ABSTRACT_AVATAR_PLUGIN_H_
#define FLUTTER_PLUGIN_RANDOM_ABSTRACT_AVATAR_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace random_abstract_avatar {

class RandomAbstractAvatarPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  RandomAbstractAvatarPlugin();

  virtual ~RandomAbstractAvatarPlugin();

  // Disallow copy and assign.
  RandomAbstractAvatarPlugin(const RandomAbstractAvatarPlugin&) = delete;
  RandomAbstractAvatarPlugin& operator=(const RandomAbstractAvatarPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace random_abstract_avatar

#endif  // FLUTTER_PLUGIN_RANDOM_ABSTRACT_AVATAR_PLUGIN_H_

#include "include/random_abstract_avatar/random_abstract_avatar_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "random_abstract_avatar_plugin.h"

void RandomAbstractAvatarPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  random_abstract_avatar::RandomAbstractAvatarPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}

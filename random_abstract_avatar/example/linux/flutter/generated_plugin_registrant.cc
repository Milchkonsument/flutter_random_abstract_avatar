//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <random_abstract_avatar/random_abstract_avatar_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) random_abstract_avatar_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "RandomAbstractAvatarPlugin");
  random_abstract_avatar_plugin_register_with_registrar(random_abstract_avatar_registrar);
}

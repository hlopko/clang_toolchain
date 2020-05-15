def _get_dirs(ctx, lang):
  result = ctx.execute(["/usr/bin/clang", "-E", "-x" + lang, "-", "-v"])
  index1 = result.stderr.find("#include <...>")
  if index1 == -1:
      return []
  index1 = result.stderr.find("\n", index1)
  if index1 == -1:
      return []
  index2 = result.stderr.rfind("\n ")
  if index2 == -1 or index2 < index1:
      return []
  index2 = result.stderr.find("\n", index2 + 1)
  if index2 == -1:
      inc_dirs = result.stderr[index1 + 1:]
  else:
      inc_dirs = result.stderr[index1 + 1:index2].strip()
  return [
      p.strip() for p in inc_dirs.split("\n")
  ]

def _impl(ctx):
  content = 'module "crosstool" [system] {'
  cdirs = _get_dirs(ctx, "c")
  cxxdirs = _get_dirs(ctx, "c++")
  headers = {}
  for dir in cdirs + cxxdirs:
    result = ctx.execute(["find", dir, "-maxdepth", "1", "-type", "f"])
    for header in result.stdout.strip().split("\n"):
      header = ctx.execute(["realpath", header]).stdout.strip()
      if header:
        headers[header] = ""

  for header in headers:
    content += "\n  textual header \"" + header + "\""
  content += "\n}"
  ctx.file("module.modulemap", content)
  ctx.file("BUILD", "exports_files(['module.modulemap'])")


generate_system_module_map = repository_rule(
  implementation = _impl,
  configure = True,
)

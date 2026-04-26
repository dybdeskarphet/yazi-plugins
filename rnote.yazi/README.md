# rnote.yazi

A plugin for previewing all Rnote files.

## Usage

Install the plugin with:

```sh
ya pkg add dybdeskarphet/yazi-plugins:rnote
```

And set it as a previewer in `yazi.toml`:

```toml
[plugin]
prepend_previewers = [
    { url = "*.rnote", run = "rnote" },
]
```

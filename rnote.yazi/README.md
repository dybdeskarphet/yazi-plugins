# rnote.yazi

A plugin for previewing Rnote documents (`.rnote`). For now, it renders all pages as a single continuous document.

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

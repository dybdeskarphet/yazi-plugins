# svgz.yazi

A plugin for previewing `.svgz` files. It only supports one page previews for now.

## Usage

Install the plugin with:

```sh
ya pkg add dybdeskarphet/yazi-plugins:svgz
```

And set it as a previewer in `yazi.toml`:

```toml
[plugin]
prepend_previewers = [
    { url = "*.svgz", run = "svgz" },
]
```

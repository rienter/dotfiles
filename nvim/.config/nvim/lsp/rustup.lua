return {
  cmd = { "rustup", "run", "stable", "rust-analyzer", },
  filetypes = { 'rs' },
  root_markers = { 'Cargo.toml', 'Cargo.lock' },
  offset_encoding = 'utf-8',
}

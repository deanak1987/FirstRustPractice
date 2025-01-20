.PHONY: all install update check clean

# Default target
setup_rust: install_rust update_rust check_rust

# Install Rust and core components
install_rust:
	@echo "Installing Rust..."
	@curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
	@echo "Updating PATH..."
	@echo "export PATH=\"$$HOME/.cargo/bin:$$PATH\"" >> ~/.bashrc
	@export PATH="$$HOME/.cargo/bin:$$PATH" && \
		echo "Installing core components..." && \
		rustup component add rustfmt && \
		rustup component add clippy && \
		rustup component add rust-analyzer && \
		cargo install cargo-edit && \
		cargo install cargo-watch
	@echo "Rust installation complete!"
	@echo "NOTE: Please restart your shell or run: export PATH=\"$$HOME/.cargo/bin:$$PATH\""

# Update Rust and all installed components
update_rust:
	@echo "Updating Rust..."
	@bash -c 'PATH="$$HOME/.cargo/bin:$$PATH" && \
		rustup update && \
		cargo update'
	@echo "Update complete!"

# Check Rust installation
check_rust:
	@echo "Checking Rust installation..."
	@bash -c 'PATH="$$HOME/.cargo/bin:$$PATH" && \
		(rustc --version || echo "rustc not found") && \
		(cargo --version || echo "cargo not found") && \
		(rustup --version || echo "rustup not found")'
	@echo "All checks complete!"

# Clean up Rust installation
clean_rust:
	@echo "Cleaning up Rust installation..."
	@rustup self uninstall -y
	@echo "Cleanup complete!"
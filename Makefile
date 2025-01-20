.PHONY: all install update check clean

# Default target
setup_rust: install_rust check_rust clean_rust

# Install Rust and core components
install_rust:
	@echo "Installing Rust..."
	@curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
	@echo "Updating PATH..."
	@$(SHELL) -c 'source $$HOME/.cargo/env && \
		echo "Installing core components..." && \
		rustup component add rustfmt && \
		rustup component add clippy && \
		rustup component add rust-analyzer && \
		cargo install cargo-edit && \
		cargo install cargo-watch'
	@echo "Rust installation complete!"

# Update Rust and all installed components
update_rust:
	@echo "Updating Rust..."
	@rustup update
	@cargo update
	@echo "Update complete!"

# Check Rust installation
check_rust:
	@echo "Checking Rust installation..."
	@which rustc || echo "rustc not found"
	@which cargo || echo "cargo not found"
	@rustc --version
	@cargo --version
	@rustup --version
	@echo "All checks complete!"

# Clean up Rust installation
clean_rust:
	@echo "Cleaning up Rust installation..."
	@rustup self uninstall -y
	@echo "Cleanup complete!"
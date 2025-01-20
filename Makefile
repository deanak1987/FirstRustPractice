.PHONY: all install update check clean

# Default target
setup_rust: install_rust cargo_tools update_rust check_rust

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

cargo_tools:
	# @echo "Installing cargo tools..."
	# @bash -c 'source $$HOME/.cargo/env && \
	# 	cargo install cargo-edit && \
	# 	cargo install cargo-watch'
	# @echo "Tools installation complete!"
	# # @echo "To use Rust in new terminals, please run:"
	# # @echo "    source \"$$HOME/.cargo/env\""
	# # @echo "Or add this line to your shell's config file"
	# @bash -c source 'PATH="$$HOME/.cargo/env"'

	@echo "Installing cargo tools..."
	@bash -c 'source $$HOME/.cargo/env && \
		cargo install cargo-edit && \
		cargo install cargo-watch'
	@echo "Tools installation complete!"
	@echo "Adding Rust to your shell configuration..."
	@if ! grep -q 'source "$$HOME/.cargo/env"' $$HOME/.bashrc; then \
		echo 'source "$$HOME/.cargo/env"' >> $$HOME/.bashrc && \
		echo "Rust environment added to ~/.bashrc"; \
	else \
		echo "Rust environment already configured in ~/.bashrc"; \
	fi
	@echo "To apply changes, restart your terminal or run:"
	@echo "    source $$HOME/.bashrc"

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
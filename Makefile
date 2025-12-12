# Makefile for executing .NET commands

.PHONY: restore build test e2e

# Restore NuGet packages
restore:
	@echo "Restoring NuGet packages..."
	dotnet restore

# Build the solution
build:
	@echo "Building the solution..."
	dotnet build --no-restore

# Run tests
test:
	@echo "Running .NET tests..."
	dotnet test --no-build

# End-to-end: restore, build, and test
e2e: restore build test
	@echo "End-to-end process completed."

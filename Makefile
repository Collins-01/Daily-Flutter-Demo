.PHONY: build-staging-android build-staging-ios


# Add a new package
# Usage: make add connectivity_plus
add:
	@if [ -z "$(filter-out $@,$(MAKECMDGOALS))" ]; then \
		echo "Error: Package name is required. Usage: make add package_name"; \
		exit 1; \
	fi
	fvm flutter pub add $(filter-out $@,$(MAKECMDGOALS))

# Update application dependencies
get:
	fvm flutter pub get


# Clean build
clean:
	fvm flutter clean


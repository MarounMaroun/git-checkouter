INSTALL_PATH = /usr/local/bin/git-checkouter

.PHONY: install
install:
	@sudo cp -f git-checkouter.sh $(INSTALL_PATH)
	@echo "Done installing!"

.PHONY: uninstall
uninstall:
	@sudo rm -f $(INSTALL_PATH)
	@echo "Done uninstalling!"


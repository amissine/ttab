#
# Copyright 2017 Alec Missine (support@minetats.com) 
#                and the Arbitrage Logistics International (ALI) project
#
# The ALI Project licenses this file to you under the Apache License, version 2.0
# (the "License"); you may not use this file except in compliance with the License.
# You may obtain a copy of the License at:
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed
# under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
# CONDITIONS OF ANY KIND, either express or implied. See the License for the
# specific language governing permissions and limitations under the License.
#
# This makefile configures your box to become part of Cloud Trust Ltd.
#
# See also:
#   https://docs.google.com/document/d/1JPzTa7IXEQL0NZLoO5leCNj40e7yy1dFNMiqTtBNH2o/
#   https://www.gnu.org/software/make/manual/html_node/index.html

# Check if 'make' is run from your home directory and the makefile resides there.
ifneq ($(PWD),$(HOME))
  $(error Please try 'sudo -E make' from $(HOME) directory)
endif
$(if $(findstring /,$(MAKEFILE_LIST)),$(error Please only invoke this makefile from the directory it resides in))

# Run all shell commands with bash.
SHELL := bash

.PHONY: install

install: check_if_root check_node check_git lnet
	@make -f project/lnet/setup/Makefile
	@rm $^

check_if_root:
	@if [ "`id -u`" != "0" ]; then echo " "; echo "=== Please try 'sudo -E make' ==="; echo " "; exit 1; fi
	@which sshd; if [ $$? != '0' ]; then \
		[[ `uname` == 'Darwin' ]] && { echo "Please install SSH server"; exit 1; } \
		|| apt install openssh-server; fi
	@if [ `uname` = 'Linux' ]; then [ -x /usr/local/bin/bash ] || \
		{ mkdir -p /usr/local/bin 2>/dev/null; cd /usr/local/bin; ln -s /bin/bash bash; }; fi
	@echo $@ > $@

check_node:
	@curl --version; if [ $$? != '0' ]; then [ `uname` = 'Linux' ] && apt install curl || \
		{ echo "Please install curl"; exit 1; }; fi
	@node -v || { [ `uname` = 'Darwin' ] && { echo "Please install nodejs"; exit 1; }; \
		curl -sL https://deb.nodesource.com/setup_8.x | bash -; apt install -y nodejs; }
	@if [ `uname` = 'Linux' ]; then apt autoremove; fi
	@echo $@ > $@

check_git:
	@git --version; if [ $$? != '0' ]; then [ `uname` = 'Linux' ] && apt install git || \
		{ echo "Please install git"; exit 1; }; fi
	@if [ `uname` = 'Linux' ]; then apt autoremove; fi
	@echo $@ > $@

lnet: # TODO: Fix this goal recipe. In the meantime, run it manually
	@exe='git clone https://github.com/amissine/lnet.git'; \
		[ -d project/lnet ] || { mkdir project 2>/dev/null; cd project; \
		"$$exe"; cd ../; chown -R $(SUDO_USER) project; }
	@echo $@ > $@

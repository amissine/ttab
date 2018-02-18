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
# This makefile creates the SSH pair of keys for your account.
#
# See also:
#   https://docs.google.com/document/d/1JPzTa7IXEQL0NZLoO5leCNj40e7yy1dFNMiqTtBNH2o/
#   https://www.gnu.org/software/make/manual/html_node/index.html

# Check if 'make' is run from your home directory.
ifneq ($(PWD),$(HOME))
  $(error Please try 'sudo -E make' from $(HOME) directory)
endif

# Run all shell commands with bash.
SHELL := bash

pub_key: .ssh/id_rsa.pub
	@echo " "; 
	@echo '=== Please email your $(HOME)/.ssh/id_rsa.pub to support@minetats.com ==='
	@echo " "; echo $@ > $@

.ssh/id_rsa.pub:
	@ssh-keygen -b 4096 -t rsa -f .ssh/id_rsa
	@echo "Generated new key pair for $$USER"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8F746D0B6;
	Sun, 11 Oct 2026 23:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791761814; cv=none; b=UGcZ8Dc+M4XFr8I6azmSsQtLerepRrQuO/En4TwsccTJX0T1hYqjogVPvXR07yXfx+GstyNuB1dei2+ZM9DARoo2rlGWFsEZduuWUxizZJT/mD6Q8CpE3h/euymb0OHnWnPlLGbBSd50K1T5EbA87LpsfYt22g4Iomgyflei0fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791761814; c=relaxed/simple;
	bh=qG5RLSvQuW6hCjsFTcbv77Bu7xRC6bs+lxrKDpB57Ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gYmSXWOiUPdlL7XBGepb9Uj/azR3KNDHCwpf2XIZlzJD3kVxBCIPUn4P4nLWN6cMaSa9l/7aXE2UdWNFijPsmJ/+zw8VDGAHI4hcwvtM4VOvBvd1CmusN3BjA3+YMlpx/uDpsH7bnqmFjjkKwUk3E5NyI+VquaBgc1dHqUHQQ5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNzZvrYb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNzZvrYb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60ED21F0089B;
	Sun, 11 Oct 2026 23:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791761812;
	bh=Nomay+KukYvB2DlXPc0BJpAo+ihjxoSBJ5DgREK0vlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dNzZvrYbCFvL2iy1RXn9V8m0/0mKJqk0wRrtmw0q9YdOFKGakpRP3f5GxwodozKFO
	 cVhYJkLXUva6voUXB4Y0cnLgjPPQvyZLPGE2Xd+XCMH31auny/6BECvcp6CVn1xip0
	 tm6GlMTlL+bIkjwh7n3WKPj65nPsv18xUmKOEKqvzmqKD1lEnzNgjZl0uX8hlfyz5d
	 OMhhMNS0yeSxHmMPSDdVnlgNJMzxnbVGfsAUk3ven3F2iqA5mvQsgypPGvLe0+3mjv
	 qhiZk9rd6J3q+FHdIkjgpWfv0JkJ4WnEKDU3C9G6BpfzrHMRkRwRAmM9EyBif0LufU
	 ZQgsE+XTzLjRg==
From: Sasha Levin <sashal@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	linux-kbuild@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [RFC PATCH 2/6] kbuild: add "make tools_build" to build userspace tools from tools/
Date: Sun, 11 Oct 2026 19:36:41 -0400
Message-ID: <20261011233647.2454648-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261011233647.2454648-1-sashal@kernel.org>
References: <20261011233647.2454648-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The programs under tools/ have their own build systems and are not built
by "make", so nothing builds them together with the kernel they belong
to, and breakage in them is only noticed when someone happens to build
them by hand, sometimes many stable releases later.

Add a "Build userspace tools from tools/" menu (CONFIG_TOOLS_BUILD) with
an entry for each tool, and a "tools_build" target that builds the
selected ones for the target:

- Each tool is built by its own build system, as it is built
  standalone, into tools-build/ in the object tree. "make clean" removes
  that directory without running the tools' own clean rules.

- The compiler is the one CONFIG_CC_CAN_LINK was tested with: $(CC),
  USERCFLAGS and KBUILD_USERABI, so cross builds, including LLVM=1
  ARCH=<arch> without CROSS_COMPILE, produce target binaries. USERLDFLAGS
  reach the tools as LDFLAGS.

- kbuild's own state (srctree, objtree, VPATH, sub_make_done, ...) and
  the user's CFLAGS/LDFLAGS/O= from the environment or the command line
  are kept away from the tools.

- A tool is rebuilt from scratch when its make arguments change.
  "make -n" shows the build without removing or recording anything.

- On failure, the message names the option that skips the tool.

The menu depends on CC_CAN_LINK, so toolchains without a C library are
unaffected, and is limited to glibc toolchains for x86_64 and arm64,
which is what it has been tested with.

The first entries are the tools that only need a C library: bootconfig,
counter, dma, gpio, hv, iio, spi and usb.

Assisted-by: LLM
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .gitignore            |  5 +++
 Makefile              |  8 ++++-
 lib/Kconfig.debug     |  2 ++
 tools/Kconfig         | 72 +++++++++++++++++++++++++++++++++++++++
 tools/Makefile.kbuild | 79 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 165 insertions(+), 1 deletion(-)
 create mode 100644 tools/Kconfig
 create mode 100644 tools/Makefile.kbuild

diff --git a/.gitignore b/.gitignore
index 9875120ea7bde..6bf05bbd94245 100644
--- a/.gitignore
+++ b/.gitignore
@@ -101,6 +101,11 @@ modules.order
 #
 /tar-install/
 
+#
+# userspace tools (make tools_build)
+#
+/tools-build/
+
 #
 # pacman files (make pacman-pkg)
 #
diff --git a/Makefile b/Makefile
index 8c94aff229b21..af5d0a9d51df9 100644
--- a/Makefile
+++ b/Makefile
@@ -1633,6 +1633,11 @@ tools/%: FORCE
 	$(Q)mkdir -p $(objtree)/tools
 	$(Q)$(MAKE) O=$(abspath $(objtree)) subdir=tools -C $(srctree)/tools/ $*
 
+# The userspace programs selected in tools/Kconfig, built for the target
+PHONY += tools_build
+tools_build: headers
+	$(Q)$(MAKE) -f $(srctree)/tools/Makefile.kbuild
+
 # ---------------------------------------------------------------------------
 # Kernel selftest
 
@@ -1772,7 +1777,7 @@ CLEAN_FILES += vmlinux.symvers modules-only.symvers \
 	       modules.builtin modules.builtin.modinfo modules.nsdeps \
 	       modules.builtin.ranges vmlinux.o.map vmlinux.unstripped \
 	       vmlinux.thinlto-index builtin.order \
-	       compile_commands.json rust/test \
+	       compile_commands.json rust/test tools-build \
 	       rust-project.json .vmlinux.objs .vmlinux.export.c \
 	       .builtin-dtbs-list .builtin-dtbs.S sbom-*.spdx.json
 
@@ -1894,6 +1899,7 @@ help:
 	@echo  '  clang-tidy        - Check with clang-tidy'
 	@echo  ''
 	@echo  'Tools:'
+	@echo  '  tools_build     - Build the userspace tools selected in tools/Kconfig'
 	@echo  '  nsdeps          - Generate missing symbol namespace dependencies'
 	@echo  '  sbom            - Generate Software Bill of Materials'
 	@echo  ''
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 6b24a2c89b84d..16984158977b3 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1913,6 +1913,8 @@ config PROVIDE_OHCI1394_DMA_INIT
 
 source "samples/Kconfig"
 
+source "tools/Kconfig"
+
 config ARCH_HAS_DEVMEM_IS_ALLOWED
 	bool
 
diff --git a/tools/Kconfig b/tools/Kconfig
new file mode 100644
index 0000000000000..bf0643b39b86e
--- /dev/null
+++ b/tools/Kconfig
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config TOOLS_BUILD_ABI
+	def_bool X86_64 || ARM64
+
+config TOOLS_BUILD_GLIBC
+	def_bool $(success,echo '#include <features.h>' | $(CC) $(CLANG_FLAGS) $(USERCFLAGS) -E -dM -x c - | grep -q __GLIBC__)
+
+menuconfig TOOLS_BUILD
+	bool "Build userspace tools from tools/"
+	depends on CC_CAN_LINK && !UML
+	depends on TOOLS_BUILD_ABI && TOOLS_BUILD_GLIBC
+	help
+	  Build the selected programs under tools/ for the target together
+	  with the kernel, as part of "make all", or alone with
+	  "make tools_build". Each program is built by its own build system
+	  into tools-build/ in the object tree. The tools then always match
+	  the kernel they were built with, and a change that breaks one of
+	  them shows up in the same build that compiles the kernel.
+
+	  This needs a compiler that can link glibc programs for the target,
+	  and is currently limited to x86_64 and arm64.
+
+	  If unsure, say N.
+
+if TOOLS_BUILD
+
+config TOOLS_BUILD_BOOTCONFIG
+	bool "bootconfig"
+	help
+	  Build tools/bootconfig, the boot configuration editor, for the
+	  target. This is independent of the host copy that the kernel
+	  build uses for CONFIG_CMDLINE_FROM_BOOTCONFIG.
+
+config TOOLS_BUILD_COUNTER
+	bool "Counter tools"
+	help
+	  Build tools/counter (counter_example, counter_watch_events).
+
+config TOOLS_BUILD_DMA
+	bool "DMA map benchmark"
+	help
+	  Build tools/dma (dma_map_benchmark).
+
+config TOOLS_BUILD_GPIO
+	bool "GPIO tools"
+	help
+	  Build tools/gpio (lsgpio, gpio-hammer, gpio-event-mon,
+	  gpio-watch).
+
+config TOOLS_BUILD_HV
+	bool "Hyper-V guest daemons"
+	help
+	  Build tools/hv (hv_kvp_daemon, hv_vss_daemon and, on x86,
+	  hv_fcopy_uio_daemon).
+
+config TOOLS_BUILD_IIO
+	bool "IIO tools"
+	help
+	  Build tools/iio (lsiio, iio_event_monitor, iio_generic_buffer).
+
+config TOOLS_BUILD_SPI
+	bool "SPI tools"
+	help
+	  Build tools/spi (spidev_test, spidev_fdx).
+
+config TOOLS_BUILD_USB
+	bool "USB tools"
+	help
+	  Build tools/usb (testusb, ffs-test).
+
+endif # TOOLS_BUILD
diff --git a/tools/Makefile.kbuild b/tools/Makefile.kbuild
new file mode 100644
index 0000000000000..820a2d9a3893b
--- /dev/null
+++ b/tools/Makefile.kbuild
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Builds the userspace programs selected in tools/Kconfig for the target.
+# Invoked by "make tools_build", which "make all" runs when CONFIG_TOOLS_BUILD
+# is set. Each program is built by its own build system, the way it is built
+# standalone, into $(objtree)/tools-build/.
+
+PHONY := __tools_build
+__tools_build:
+
+include include/config/auto.conf
+
+abs_srctree := $(realpath $(srctree))
+toolsdir := $(abs_srctree)/tools
+outdir := $(CURDIR)/tools-build
+
+# kbuild's state and the user's compiler flags, from the environment or the
+# command line, would change how these build
+unexport srctree objtree srcroot VPATH building_out_of_srctree sub_make_done
+unexport CLANG_FLAGS INSTALL_HDR_PATH O
+unexport CFLAGS CPPFLAGS LDFLAGS EXTRA_CFLAGS EXTRA_LDFLAGS USERCFLAGS USERLDFLAGS
+space := $(subst ,, )
+overrides := $(subst \$(space),\@space@,$(MAKEOVERRIDES))
+MAKEOVERRIDES := $(subst \@space@,\$(space),$(filter-out O=% CFLAGS=% CPPFLAGS=% \
+	LDFLAGS=% EXTRA_CFLAGS=% EXTRA_LDFLAGS=% USERCFLAGS=% USERLDFLAGS=%,$(overrides)))
+
+# Keep Python's bytecode caches out of the source tree
+export PYTHONDONTWRITEBYTECODE := 1
+
+# The compiler CONFIG_CC_CAN_LINK was tested with. The tools take linker
+# flags from LDFLAGS.
+tools-cc := $(CC) $(USERCFLAGS) $(KBUILD_USERABI)
+ifneq ($(USERLDFLAGS),)
+override LDFLAGS := $(USERLDFLAGS)
+export LDFLAGS
+endif
+
+squote := '
+escsq = $(subst $(squote),'\$(squote)',$1)
+
+# $(call build,<output directory>,<make arguments>,<files to check>,<CONFIG_ symbol>)
+# Builds in an empty directory when the make arguments or LDFLAGS changed, or
+# when one of the files is newer than the last build. "make -n" only shows
+# the build.
+build-key = $(call escsq,$(2) LDFLAGS=$(USERLDFLAGS))
+dry-run := $(findstring n,$(firstword -$(MAKEFLAGS)))
+
+define build
+	+$(Q)$(if $(dry-run),,if [ "$$(cat $(1)/.tools_build 2>/dev/null)" != '$(build-key)' ] $(if $(3),|| \
+	   [ -n "$$(find $(3) -newer $(1)/.tools_build -print -quit 2>/dev/null)" ]); then \
+		rm -rf $(1); \
+	fi;) \
+	mkdir -p $(1) && $(MAKE) $(2) && \
+	$(if $(dry-run),:,printf '%s' '$(build-key)' > $(1)/.tools_build) || \
+	{ echo >&2 "tools_build: $(patsubst $(outdir)/%,%,$(1)) failed to build; set CONFIG_$(4)=n to skip it"; false; }
+endef
+
+# Programs in tools/<name>, which track their own header dependencies
+tools-$(CONFIG_TOOLS_BUILD_BOOTCONFIG)	+= bootconfig
+tools-$(CONFIG_TOOLS_BUILD_COUNTER)	+= counter
+tools-$(CONFIG_TOOLS_BUILD_DMA)		+= dma
+tools-$(CONFIG_TOOLS_BUILD_GPIO)	+= gpio
+tools-$(CONFIG_TOOLS_BUILD_HV)		+= hv
+tools-$(CONFIG_TOOLS_BUILD_IIO)		+= iio
+tools-$(CONFIG_TOOLS_BUILD_SPI)		+= spi
+tools-$(CONFIG_TOOLS_BUILD_USB)		+= usb
+
+tool-targets := $(addprefix tool-,$(tools-y))
+
+__tools_build: $(tool-targets)
+
+PHONY += $(tool-targets)
+$(tool-targets): tool-%: FORCE
+	$(call build,$(outdir)/$*,-C $(toolsdir)/$* O=$(outdir)/$* CC='$(call escsq,$(tools-cc))',,TOOLS_BUILD_$(shell echo $* | tr a-z A-Z))
+
+PHONY += FORCE
+FORCE:
+
+.PHONY: $(PHONY)
-- 
2.53.0


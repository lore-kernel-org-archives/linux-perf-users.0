Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793585581;
	b=T6jFMkwbkGQXR5XTqf7nCnOJ+l9qKKbz2ZiBHrbyqULPs5Q1b5inLlbApIxQnBqu39We
	 2lJu+dRJCGSTgS4IlwuJIMEPxdp2AyfQlF5Qr50WXeSO31MgaBTFXPj2dNZhoeB227OFO
	 cn0kpl4Q/0FPpsl+rIKGshs8t9spCAtewg+mgk0y2otINYOQMeqXt5HIJB82Nd1OM37LG
	 YdCMXL9q/r1WpAyaiFdGBglWX4cEV7cEI0dAHsUWEVYPwpmuaQZKsU6Ff6Mts5SQD7hLC
	 wqVnxK8pZzjD+4Al6JL9vMlfJ6bhO6Sit5SCVJkAb2sCa7F3rBLF4uWOpcvG29e0wRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793585581;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kctdRZ0m54nxWprFxTya5Gicm+yjS9Dn+0OMDub8CF8=;
	b=DtxL/ShfYTuPFmir/rzI7Kxft7gMgKJ9E/dIn/PWaat0P+iS13p62KZyqToHfQ6HkocJ
	 Q1mfBKSSOtJDvF4KvkkJ5UFi83bC+g6xhiCNMWWu9lBu7pHgJfY5A1sob+sdDebaBdRuu
	 FM941kprqhhs6JKnBwb1Ooe9KetrmgTigVB+CEQ+txOfAPKodHl/BG+N3Tr7lptDYMaeh
	 /e9E1MUM0UQt4/7BJLeEK2iPX2H2bjMOyy8yxvfS1YQMAVVo5e3H58hfTof7MXAI+pwSS
	 MFlS0QS6UgJZsVuK0oGdeGOHoC/hO81TVRapac12NInW5UrYMFpAGOCCaFQCgq9S6/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FaP2iBcw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAD660A2601;
	Mon,  2 Nov 2026 02:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FaP2iBcw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132151F00A15;
	Mon,  2 Nov 2026 02:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793585581;
	bh=kctdRZ0m54nxWprFxTya5Gicm+yjS9Dn+0OMDub8CF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FaP2iBcwBYA6Ok1vHY04r5+jYGR5wmPZHb2aZ2BSUSj4hgGeaXHvCRkZbIVDZeV7h
	 P8h1fX21Fw9ngQB2ThegSlQnoe4aERrAnd1nJdQvLY3DdrctVfYS3YZBg3F0YbNAsw
	 v/a7F6xW2CBfO0B+1iWhFOJ/m5riyK5OX7CMSm270ME6jMwxFTQ0BLZWl96Gp5g7Hh
	 t33wNbdZI2TrPUq24wLZsmzVy3h8NY2lDIKxE2pbk0qQuHnqQLnAzNlTOpwPKepnmB
	 m/5R0tt9IDVCHgoFcEJ/cGUmQkvgF3Du2FSXngjFKYG/HZVfcaQJEmyceDbrRZQ4uE
	 DQ0IFMnX2ffKQ==
From: Sasha Levin <sashal@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	linux-kbuild@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/7] kbuild: add "make tools_build" to build userspace tools from tools/
Date: Sun,  1 Nov 2026 21:12:48 -0500
Message-ID: <20261102021253.2545235-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102021253.2545235-1-sashal@kernel.org>
References: <20261102021253.2545235-1-sashal@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
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

- Under UML, ARCH and SRCARCH are set to the architecture UML runs on
  (HEADER_ARCH): a UML kernel runs that architecture's programs, and
  the tools' build systems do not know ARCH=um.

- A tool is rebuilt from scratch when its make arguments change.
  "make -n" shows the build without removing or recording anything.

- On failure, the message names the option that skips the tool.

The menu depends on CC_CAN_LINK, so toolchains without a C library are
unaffected, and is limited to glibc toolchains for x86_64 and arm64,
which is what it has been tested with.

The first entries are the tools that only need a C library: bootconfig,
counter, dma, gpio, hv, iio, spi and usb.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .gitignore            |  5 +++
 Makefile              |  8 +++-
 lib/Kconfig.debug     |  2 +
 tools/Kconfig         | 73 +++++++++++++++++++++++++++++++++++++
 tools/Makefile.kbuild | 85 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 172 insertions(+), 1 deletion(-)
 create mode 100644 tools/Kconfig
 create mode 100644 tools/Makefile.kbuild

diff --git a/.gitignore b/.gitignore
index f3efefe2db77a..f2f0ccc39dd7b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -102,6 +102,11 @@ modules.order
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
index 58bc69b4996e1..7919263484f0a 100644
--- a/Makefile
+++ b/Makefile
@@ -1645,6 +1645,11 @@ tools/%: FORCE
 	$(Q)mkdir -p $(objtree)/tools
 	$(Q)$(MAKE) O=$(abspath $(objtree)) subdir=tools -C $(srctree)/tools/ $*
 
+# The userspace programs selected in tools/Kconfig, built for the target
+PHONY += tools_build
+tools_build: headers
+	$(Q)$(MAKE) -f $(srctree)/tools/Makefile.kbuild
+
 # ---------------------------------------------------------------------------
 # Kernel selftest
 
@@ -1785,7 +1790,7 @@ CLEAN_FILES += vmlinux.symvers modules-only.symvers \
 	       modules.builtin.ranges vmlinux.o.map vmlinux.unstripped \
 	       vmlinux.BTF.inline \
 	       vmlinux.thinlto-index builtin.order \
-	       compile_commands.json rust/test \
+	       compile_commands.json rust/test tools-build \
 	       rust-project.json .vmlinux.objs .vmlinux.export.c \
 	       .builtin-dtbs-list .builtin-dtbs.S sbom-*.spdx.json
 
@@ -1909,6 +1914,7 @@ help:
 	@echo  '  clang-tidy        - Check with clang-tidy'
 	@echo  ''
 	@echo  'Tools:'
+	@echo  '  tools_build     - Build the userspace tools selected in tools/Kconfig'
 	@echo  '  nsdeps          - Generate missing symbol namespace dependencies'
 	@echo  '  sbom            - Generate Software Bill of Materials'
 	@echo  ''
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 2d22638ec13a6..cffc089bdb964 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1945,6 +1945,8 @@ config PROVIDE_OHCI1394_DMA_INIT
 
 source "samples/Kconfig"
 
+source "tools/Kconfig"
+
 config ARCH_HAS_DEVMEM_IS_ALLOWED
 	bool
 
diff --git a/tools/Kconfig b/tools/Kconfig
new file mode 100644
index 0000000000000..2d05c8e593e21
--- /dev/null
+++ b/tools/Kconfig
@@ -0,0 +1,73 @@
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
+	depends on CC_CAN_LINK
+	depends on TOOLS_BUILD_ABI
+	depends on TOOLS_BUILD_GLIBC
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
index 0000000000000..8cfa7f80039cd
--- /dev/null
+++ b/tools/Makefile.kbuild
@@ -0,0 +1,85 @@
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
+	LDFLAGS=% EXTRA_CFLAGS=% EXTRA_LDFLAGS=% USERCFLAGS=% USERLDFLAGS=% \
+	$(if $(CONFIG_UML),ARCH=% SRCARCH=%),$(overrides)))
+
+# A UML kernel runs the programs of the architecture it is built on. The tools
+# are built for that architecture, as they do not know ARCH=um.
+ifdef CONFIG_UML
+override ARCH := $(HEADER_ARCH)
+override SRCARCH := $(HEADER_ARCH)
+export ARCH SRCARCH
+endif
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


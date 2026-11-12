Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794513284;
	b=xpZD5z2QMpGZ87rLPqc8+4mOuvv2A2vGhKIGapR4GZrBiPQ+DOlulFR0XrptWPW5ZUfG
	 zXfQLDIv7VCopQF4KGDZAw/q30g9iaFcq4QDmbA6qSvF/mIva0r9TIv+pFo+kF76yTKLz
	 TvxK3C9eYWORi5eJnvyqAZDAVm6pFIUMhTMIgGWpkM7erFqTmUzn6VX4ll2GuIBpW2K5g
	 1uz4xepTo8WEVfY6XI0KT0E8DGq0O5FbVJF34TayVz+esWcHjx2GX7gdNp17l6EQNWKq5
	 +wV+5xy9Ou1xC9TRKxZsXezTpn6FDn+9zLfT/buv43XuzaYk7RPzUGAZxSpW2SEEIXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513284;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=rwpSTRnCQgZNF5klr0GOYjpJN8v5REa1IxmIUQS36Xs=;
	b=rNEHAdswrlBkfsxnh/PIolSFcms65548nmQgxifRwsOl30XST0Ctt0JzwaBsYgOQFUgd
	 Sk1g6Gr8PJChkYrkLfT/FOZissmVVCuGzAhrRcSOEW2vQxsnMN8+b/dJBQoe5Dm6cJB1c
	 JzsQbKMVyT3g4L1CE592f7xTtx9Ee43ooBOR/Md7AH0rmkLrzVM1KMBXoJIQjMgZxH7cz
	 OBI1Zb2WPuC/XKOaxCpGwwxuBNqq9OvU3ws8/vAR5GeB6pbn78q9fglhNgvu8WQmHVJk/
	 SLyPSyaK5GGGIlxw1hWh5SBW0Vw41ZD/nnffnvlwyzxWxJ3ouj2ZQXWcF5rRjQmtZgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MXlYwIIA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C6F60A380F;
	Thu, 12 Nov 2026 19:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MXlYwIIA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F3E1F000C4;
	Thu, 12 Nov 2026 19:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794513283;
	bh=rwpSTRnCQgZNF5klr0GOYjpJN8v5REa1IxmIUQS36Xs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MXlYwIIATjaMxiTKE0XTko1RchXpHQEGLRWCvlCDDYtoLKB8kQgdGHtAKcWsT8fW/
	 2V4TppQrqwdn5EtOem28VqnFxhQ0mJo4QK2MmdsZENnnC3okMn3qh9Yj2T/oTzXoQ8
	 FPbpDOqsYdSXvgXjvv5llb2z2hCihmQEb90TYyWSgKue3CSAY4CDpno8xnbnxw8ySq
	 lWYMubJslhtjgOGVB6RXwZMef8VVLtjOBQfldux7E4837j4+8hVnE3MgTqaSSMqfXm
	 auuNTd720YahDkqCAO/Q2i/vqG8567wxfuaKrFKYEnSfY/NvUyNJ2jLUJr+i3oGuY/
	 Mo22FJVP2oh8Q==
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
	linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v4 5/7] tools: build kernel selftests in tools_build
Date: Thu, 12 Nov 2026 14:54:25 -0500
Message-ID: <20261112195427.3411746-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112195427.3411746-1-sashal@kernel.org>
References: <20261112195427.3411746-1-sashal@kernel.org>
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

Add a "Kernel selftests" sub-menu with one entry per selftests directory
that builds with only a C library and does not write into the source
tree. Each is built as "make kselftest-all" builds it, with KHDR_INCLUDES
pointing at the UAPI headers installed in the object tree, but by its own
make, so the selected ones build in parallel. Selftests whose Makefile
does not use KHDR_INCLUDES still build against the C library's copy of
the UAPI headers.

As with "make kselftest-all", a selftest that fails to build does not
fail the build unless FORCE_TARGETS is set. kselftest_deps.sh then lists
the libraries the selftest needs that the compiler cannot link with.

The selftests do not track header dependencies, so a selftest is built
again from scratch when its own directory, a header or makefile any
selftest may share, or the kernel sources and headers it includes (the
vDSO test includes the architecture's vDSO code) are newer than its last
build.

Selftests that need libraries beyond the C library, a vmlinux with BTF,
or a sanitizer runtime are left out for now.

Signed-off-by: Sasha Levin <sashal@kernel.org>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/Kconfig         | 253 ++++++++++++++++++++++++++++++++++++++++++
 tools/Makefile.kbuild | 132 +++++++++++++++++++++-
 2 files changed, 381 insertions(+), 4 deletions(-)

diff --git a/tools/Kconfig b/tools/Kconfig
index ab1e15beb9fe3..f97f7efa3c73c 100644
--- a/tools/Kconfig
+++ b/tools/Kconfig
@@ -94,4 +94,257 @@ config TOOLS_BUILD_USB
 	help
 	  Build tools/usb (testusb, ffs-test).
 
+menuconfig TOOLS_BUILD_SELFTESTS
+	bool "Kernel selftests"
+	help
+	  Build the selected targets under tools/testing/selftests, as
+	  "make kselftest-all" would, without running them. As there, a
+	  selftest that fails to build does not fail the build unless
+	  FORCE_TARGETS=1 is passed to make.
+
+if TOOLS_BUILD_SELFTESTS
+
+config TOOLS_BUILD_SELFTESTS_ACCT
+	bool "acct"
+
+config TOOLS_BUILD_SELFTESTS_ALLOC_TAG
+	bool "alloc_tag"
+
+config TOOLS_BUILD_SELFTESTS_BREAKPOINTS
+	bool "breakpoints"
+
+config TOOLS_BUILD_SELFTESTS_CACHESTAT
+	bool "cachestat"
+
+config TOOLS_BUILD_SELFTESTS_CGROUP
+	bool "cgroup"
+
+config TOOLS_BUILD_SELFTESTS_CONNECTOR
+	bool "connector"
+
+config TOOLS_BUILD_SELFTESTS_CORE
+	bool "core"
+
+config TOOLS_BUILD_SELFTESTS_COREDUMP
+	bool "coredump"
+
+config TOOLS_BUILD_SELFTESTS_DAMON
+	bool "damon"
+
+config TOOLS_BUILD_SELFTESTS_DMABUF_HEAPS
+	bool "dmabuf-heaps"
+
+config TOOLS_BUILD_SELFTESTS_DRIVERS_DMA_BUF
+	bool "drivers/dma-buf"
+
+config TOOLS_BUILD_SELFTESTS_DRIVERS_NTSYNC
+	bool "drivers/ntsync"
+
+config TOOLS_BUILD_SELFTESTS_EFIVARFS
+	bool "efivarfs"
+
+config TOOLS_BUILD_SELFTESTS_FILELOCK
+	bool "filelock"
+
+config TOOLS_BUILD_SELFTESTS_FILESYSTEMS_BINDERFS
+	bool "filesystems/binderfs"
+
+config TOOLS_BUILD_SELFTESTS_FILESYSTEMS_CONFIGFS
+	bool "filesystems/configfs"
+
+config TOOLS_BUILD_SELFTESTS_FILESYSTEMS_EPOLL
+	bool "filesystems/epoll"
+
+config TOOLS_BUILD_SELFTESTS_FILESYSTEMS_EVENTFD
+	bool "filesystems/eventfd"
+
+config TOOLS_BUILD_SELFTESTS_FILESYSTEMS_FAILFS
+	bool "filesystems/failfs"
+
+config TOOLS_BUILD_SELFTESTS_FILESYSTEMS_FAT
+	bool "filesystems/fat"
+
+config TOOLS_BUILD_SELFTESTS_FILESYSTEMS_FILE_STRESSOR
+	bool "filesystems/file_stressor"
+
+config TOOLS_BUILD_SELFTESTS_FILESYSTEMS_FREEZE
+	bool "filesystems/freeze"
+
+config TOOLS_BUILD_SELFTESTS_FILESYSTEMS_MNTNS_UNBINDABLE
+	bool "filesystems/mntns_unbindable"
+
+config TOOLS_BUILD_SELFTESTS_FILESYSTEMS_MOUNT_CYCLE
+	bool "filesystems/mount_cycle"
+
+config TOOLS_BUILD_SELFTESTS_FILESYSTEMS_NSFS
+	bool "filesystems/nsfs"
+
+config TOOLS_BUILD_SELFTESTS_FILESYSTEMS_UMOUNT_PROPAGATION
+	bool "filesystems/umount_propagation"
+
+config TOOLS_BUILD_SELFTESTS_FILESYSTEMS_XATTR
+	bool "filesystems/xattr"
+
+config TOOLS_BUILD_SELFTESTS_FIRMWARE
+	bool "firmware"
+
+config TOOLS_BUILD_SELFTESTS_FPU
+	bool "fpu"
+
+config TOOLS_BUILD_SELFTESTS_FTRACE
+	bool "ftrace"
+
+config TOOLS_BUILD_SELFTESTS_GPIO
+	bool "gpio"
+
+config TOOLS_BUILD_SELFTESTS_INTEL_PSTATE
+	bool "intel_pstate"
+	depends on X86
+
+config TOOLS_BUILD_SELFTESTS_IPC
+	bool "ipc"
+
+config TOOLS_BUILD_SELFTESTS_IR
+	bool "ir"
+
+config TOOLS_BUILD_SELFTESTS_KCMP
+	bool "kcmp"
+
+config TOOLS_BUILD_SELFTESTS_KEXEC
+	bool "kexec"
+	depends on X86_64
+
+config TOOLS_BUILD_SELFTESTS_KSELFTEST_HARNESS
+	bool "kselftest_harness"
+
+config TOOLS_BUILD_SELFTESTS_LSM
+	bool "lsm"
+
+config TOOLS_BUILD_SELFTESTS_MEDIA_TESTS
+	bool "media_tests"
+
+config TOOLS_BUILD_SELFTESTS_MEMBARRIER
+	bool "membarrier"
+
+config TOOLS_BUILD_SELFTESTS_MINCORE
+	bool "mincore"
+
+config TOOLS_BUILD_SELFTESTS_MOUNT
+	bool "mount"
+
+config TOOLS_BUILD_SELFTESTS_MOUNT_SETATTR
+	bool "mount_setattr"
+
+config TOOLS_BUILD_SELFTESTS_MOVE_MOUNT_SET_GROUP
+	bool "move_mount_set_group"
+
+config TOOLS_BUILD_SELFTESTS_MSEAL_SYSTEM_MAPPINGS
+	bool "mseal_system_mappings"
+
+config TOOLS_BUILD_SELFTESTS_NCI
+	bool "nci"
+
+config TOOLS_BUILD_SELFTESTS_NET_CAN
+	bool "net/can"
+
+config TOOLS_BUILD_SELFTESTS_NET_FORWARDING
+	bool "net/forwarding"
+
+config TOOLS_BUILD_SELFTESTS_NET_MPTCP
+	bool "net/mptcp"
+
+config TOOLS_BUILD_SELFTESTS_NFSD
+	bool "nfsd"
+
+config TOOLS_BUILD_SELFTESTS_PCI_ENDPOINT
+	bool "pci_endpoint"
+
+config TOOLS_BUILD_SELFTESTS_PERF_EVENTS
+	bool "perf_events"
+
+config TOOLS_BUILD_SELFTESTS_PID_NAMESPACE
+	bool "pid_namespace"
+
+config TOOLS_BUILD_SELFTESTS_PIDFD
+	bool "pidfd"
+
+config TOOLS_BUILD_SELFTESTS_PIPE
+	bool "pipe"
+
+config TOOLS_BUILD_SELFTESTS_PROC
+	bool "proc"
+
+config TOOLS_BUILD_SELFTESTS_PTP
+	bool "ptp"
+
+config TOOLS_BUILD_SELFTESTS_PTRACE
+	bool "ptrace"
+
+config TOOLS_BUILD_SELFTESTS_RESCTRL
+	bool "resctrl"
+	depends on X86
+
+config TOOLS_BUILD_SELFTESTS_RING_BUFFER
+	bool "ring-buffer"
+
+config TOOLS_BUILD_SELFTESTS_RLIMITS
+	bool "rlimits"
+
+config TOOLS_BUILD_SELFTESTS_RSEQ
+	bool "rseq"
+
+config TOOLS_BUILD_SELFTESTS_RTC
+	bool "rtc"
+
+config TOOLS_BUILD_SELFTESTS_SCHED
+	bool "sched"
+
+config TOOLS_BUILD_SELFTESTS_SIGNAL
+	bool "signal"
+
+config TOOLS_BUILD_SELFTESTS_SIZE
+	bool "size"
+
+config TOOLS_BUILD_SELFTESTS_SPLICE
+	bool "splice"
+
+config TOOLS_BUILD_SELFTESTS_SYNC
+	bool "sync"
+
+config TOOLS_BUILD_SELFTESTS_SYSCALL_USER_DISPATCH
+	bool "syscall_user_dispatch"
+
+config TOOLS_BUILD_SELFTESTS_TDX
+	bool "tdx"
+	depends on X86
+
+config TOOLS_BUILD_SELFTESTS_THERMAL_INTEL_POWER_FLOOR
+	bool "thermal/intel/power_floor"
+	depends on X86
+
+config TOOLS_BUILD_SELFTESTS_THERMAL_INTEL_WORKLOAD_HINT
+	bool "thermal/intel/workload_hint"
+	depends on X86
+
+config TOOLS_BUILD_SELFTESTS_TIMENS
+	bool "timens"
+
+config TOOLS_BUILD_SELFTESTS_TMPFS
+	bool "tmpfs"
+
+config TOOLS_BUILD_SELFTESTS_USER_EVENTS
+	bool "user_events"
+
+config TOOLS_BUILD_SELFTESTS_VDSO
+	bool "vDSO"
+
+config TOOLS_BUILD_SELFTESTS_WATCHDOG
+	bool "watchdog"
+
+config TOOLS_BUILD_SELFTESTS_X86
+	bool "x86"
+	depends on X86
+
+endif # TOOLS_BUILD_SELFTESTS
+
 endif # TOOLS_BUILD
diff --git a/tools/Makefile.kbuild b/tools/Makefile.kbuild
index 5cf8441989fac..8fcaef8c147fc 100644
--- a/tools/Makefile.kbuild
+++ b/tools/Makefile.kbuild
@@ -44,21 +44,26 @@ endif
 squote := '
 escsq = $(subst $(squote),'\$(squote)',$1)
 
-# $(call build,<output directory>,<make arguments>,<files to check>,<CONFIG_ symbol>)
+# $(call build,<output directory>,<make arguments>,<files to check>,<CONFIG_ symbol>[,<on failure>])
 # Builds in an empty directory when the make arguments, LDFLAGS or the
 # compiler changed, or when one of the files, or a file in one of the
-# directories, is newer than the last build. "make -n" only shows the build.
+# directories, is newer than the last build. A failure fails the build,
+# unless commands to run instead are given. "make -n" only shows the build.
 build-key = $(call escsq,$(2) LDFLAGS=$(USERLDFLAGS) $(CONFIG_CC_VERSION_TEXT))
 dry-run := $(findstring n,$(firstword -$(MAKEFLAGS)))
+# Headers the kernel build generates. When the kernel is built in the source
+# tree, they are written after the tools were built.
+generated-headers := -path '$(abs_srctree)/include/generated' -o -path '$(abs_srctree)/include/config' \
+	-o -path '$(abs_srctree)/arch/*/include/generated'
 
 define build
 	+$(Q)$(if $(dry-run),,if [ "$$(cat $(1)/.tools_build 2>/dev/null)" != '$(build-key)' ] $(if $(3),|| \
-	   [ -n "$$(find $(3) -newer $(1)/.tools_build -type f -print -quit 2>/dev/null)" ]); then \
+	   [ -n "$$(find $(3) \( $(generated-headers) \) -prune -o -newer $(1)/.tools_build -type f -print -quit 2>/dev/null)" ]); then \
 		rm -rf $(1); \
 	fi;) \
 	mkdir -p $(1) && $(MAKE) $(2) && \
 	$(if $(dry-run),:,printf '%s' '$(build-key)' > $(1)/.tools_build) || \
-	{ echo >&2 "tools_build: $(patsubst $(outdir)/%,%,$(1)) failed to build; set CONFIG_$(4)=n to skip it"; false; }
+	{ echo >&2 "tools_build: $(patsubst $(outdir)/%,%,$(1)) failed to build; set CONFIG_$(4)=n to skip it"; $(or $(5),false); }
 endef
 
 # Programs in tools/<name>, which track their own header dependencies
@@ -89,6 +94,125 @@ PHONY += perf
 perf: FORCE
 	$(call build,$(outdir)/perf,-C $(toolsdir)/perf -f Makefile.perf O=$(outdir)/perf $(perf-flags) $(perf-flags-y),,TOOLS_BUILD_PERF)
 
+# Selftests in tools/testing/selftests/<name>
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_ACCT)	+= acct
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_ALLOC_TAG)	+= alloc_tag
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_BREAKPOINTS)	+= breakpoints
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_CACHESTAT)	+= cachestat
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_CGROUP)	+= cgroup
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_CONNECTOR)	+= connector
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_CORE)	+= core
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_COREDUMP)	+= coredump
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_DAMON)	+= damon
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_DMABUF_HEAPS)	+= dmabuf-heaps
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_DRIVERS_DMA_BUF)	+= drivers/dma-buf
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_DRIVERS_NTSYNC)	+= drivers/ntsync
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_EFIVARFS)	+= efivarfs
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_FILELOCK)	+= filelock
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_FILESYSTEMS_BINDERFS)	+= filesystems/binderfs
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_FILESYSTEMS_CONFIGFS)	+= filesystems/configfs
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_FILESYSTEMS_EPOLL)	+= filesystems/epoll
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_FILESYSTEMS_EVENTFD)	+= filesystems/eventfd
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_FILESYSTEMS_FAILFS)	+= filesystems/failfs
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_FILESYSTEMS_FAT)	+= filesystems/fat
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_FILESYSTEMS_FILE_STRESSOR)	+= filesystems/file_stressor
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_FILESYSTEMS_FREEZE)	+= filesystems/freeze
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_FILESYSTEMS_MNTNS_UNBINDABLE)	+= filesystems/mntns_unbindable
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_FILESYSTEMS_MOUNT_CYCLE)	+= filesystems/mount_cycle
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_FILESYSTEMS_NSFS)	+= filesystems/nsfs
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_FILESYSTEMS_UMOUNT_PROPAGATION)	+= filesystems/umount_propagation
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_FILESYSTEMS_XATTR)	+= filesystems/xattr
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_FIRMWARE)	+= firmware
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_FPU)	+= fpu
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_FTRACE)	+= ftrace
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_GPIO)	+= gpio
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_INTEL_PSTATE)	+= intel_pstate
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_IPC)	+= ipc
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_IR)	+= ir
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_KCMP)	+= kcmp
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_KEXEC)	+= kexec
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_KSELFTEST_HARNESS)	+= kselftest_harness
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_LSM)	+= lsm
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_MEDIA_TESTS)	+= media_tests
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_MEMBARRIER)	+= membarrier
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_MINCORE)	+= mincore
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_MOUNT)	+= mount
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_MOUNT_SETATTR)	+= mount_setattr
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_MOVE_MOUNT_SET_GROUP)	+= move_mount_set_group
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_MSEAL_SYSTEM_MAPPINGS)	+= mseal_system_mappings
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_NCI)	+= nci
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_NET_CAN)	+= net/can
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_NET_FORWARDING)	+= net/forwarding
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_NET_MPTCP)	+= net/mptcp
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_NFSD)	+= nfsd
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_PCI_ENDPOINT)	+= pci_endpoint
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_PERF_EVENTS)	+= perf_events
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_PID_NAMESPACE)	+= pid_namespace
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_PIDFD)	+= pidfd
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_PIPE)	+= pipe
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_PROC)	+= proc
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_PTP)	+= ptp
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_PTRACE)	+= ptrace
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_RESCTRL)	+= resctrl
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_RING_BUFFER)	+= ring-buffer
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_RLIMITS)	+= rlimits
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_RSEQ)	+= rseq
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_RTC)	+= rtc
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_SCHED)	+= sched
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_SIGNAL)	+= signal
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_SIZE)	+= size
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_SPLICE)	+= splice
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_SYNC)	+= sync
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_SYSCALL_USER_DISPATCH)	+= syscall_user_dispatch
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_TDX)	+= tdx
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_THERMAL_INTEL_POWER_FLOOR)	+= thermal/intel/power_floor
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_THERMAL_INTEL_WORKLOAD_HINT)	+= thermal/intel/workload_hint
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_TIMENS)	+= timens
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_TMPFS)	+= tmpfs
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_USER_EVENTS)	+= user_events
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_VDSO)	+= vDSO
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_WATCHDOG)	+= watchdog
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_X86)	+= x86
+
+# The kernel headers are installed by now, as tools_build depends on them.
+# "-o headers" keeps a selftest that depends on its "headers" target from
+# running "make headers" in the kernel build a second time.
+selftest-flags := -o headers CC='$(call escsq,$(tools-cc))' KHDR_INCLUDES='-isystem $(CURDIR)/usr/include'
+
+# Unlike tools/build, the selftests do not track header dependencies. A
+# selftest is built again from scratch when its own directory, a header or
+# makefile any selftest may share, or the kernel sources and headers it
+# includes are newer than its last build.
+selftest-shared := $(outdir)/selftests/.shared
+selftest-extra-vDSO := $(abs_srctree)/arch/$(SRCARCH)/include $(abs_srctree)/include \
+	$(wildcard $(addprefix $(abs_srctree)/arch/$(SRCARCH)/,$(addsuffix /vgetrandom-chacha.S, \
+		vdso kernel/vdso entry/vdso/vdso64)))
+selftest-extra-x86 := $(abs_srctree)/arch/x86/include
+
+$(selftest-shared): FORCE
+	$(Q)mkdir -p $(@D); \
+	newest=$$(find $(CURDIR)/usr/include $(toolsdir)/include $(toolsdir)/arch $(toolsdir)/testing/selftests \
+		$(toolsdir)/scripts $(abs_srctree)/scripts/subarch.include \
+		-type f \( -name '*.h' -o -name '*.mk' -o -name 'Makefile*' -o -name '*.include' \) -printf '%T@\n' | \
+		sort -n | tail -n 1); \
+	touch -d "@$${newest:-0}" $@
+
+# As with "make kselftest-all", a selftest that fails to build does not fail
+# the build unless FORCE_TARGETS is set. kselftest_deps.sh lists the libraries
+# it needs that the compiler cannot link with. It leaves files behind in
+# TMPDIR, so it gets one of its own.
+selftest-failed = (cd $(toolsdir)/testing/selftests && tmp=$$(mktemp -d) && \
+	TMPDIR=$$tmp ./kselftest_deps.sh '$(call escsq,$(tools-cc))' $(1) | grep '^FAIL' >&2; \
+	rm -rf "$$tmp"); $(if $(FORCE_TARGETS),false,:)
+
+selftest-targets := $(addprefix selftest-,$(selftests-y))
+
+__tools_build: $(selftest-targets)
+
+PHONY += $(selftest-targets)
+$(selftest-targets): selftest-%: $(selftest-shared) FORCE
+	$(call build,$(outdir)/selftests/$*,-C $(toolsdir)/testing/selftests/$* OUTPUT=$(outdir)/selftests/$* $(selftest-flags),$(selftest-shared) $(toolsdir)/testing/selftests/$* $(selftest-extra-$*),TOOLS_BUILD_SELFTESTS_$(shell echo $* | tr a-z/- A-Z__),$(call selftest-failed,$*))
+
 PHONY += FORCE
 FORCE:
 
-- 
2.53.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793585589;
	b=J302dEcJh7pxZKrpi7XH4enIlU2Urr68SN8HDJ5YUjdccHS/RrnQH6I5MVVuf3eKOLIb
	 EFaP5puuX7QV3KqfWqgiqp+kPAeCZGKvI3HesK39CQtTslrBx9qI3PePGgWqXb2vMHxUm
	 lPjrqvDRrYv0QKpJpT9seNOpN1DyJwj8WCx7n06TFSXUfGoKtkeunh6bdZPlidHMpogxe
	 Q1iGWIBz0l6N9OarrtRsDMLtM8ezEzInKFeHWKaonawluI4JrfQ9wG1w7RdqCWz+DhNNj
	 lGuDlZPsoSNjJQxyJINGgWrGmJF10F2KRPVMW4Q4vUCOByjypqQOckfB18mFxFJ0XDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793585589;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+hcqaI3fakm5IofpIQuDxhisUvijHzChUJ+piqLdU4k=;
	b=Bk2FSkw8uIBy9O84OPAwwmojFL/M2ylZpsJl7flFTebpwBLMJ5whGaNKzFrSATZ/sgkt
	 RnVcmGSJqpBhrYdmCLqQuImRM5OCbdlAvVSxAPMSNiFaq/CH/TfO739m35SdUR3lLcn+/
	 WZqPYipYCHisaQlNnytEvAj4h4+MQeNWOVrGjAKnik/uDBdzFGAvDDKOcBalrUu0T9KgA
	 LyTpj/rnrPiURyCTdER9WzhO8dITf6u99IDBCRyFgYenz2JU12R9wL/WGRtyKp0fQloxl
	 nnfwy17kpyFIjyOSkCC37X4ZHi5408d9cEqb0/D+hbvYPH5JhnUIpSRQkNLlAlMPHuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Q/t+99Ln";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08A2606A334;
	Mon,  2 Nov 2026 02:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q/t+99Ln
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF911F000C1;
	Mon,  2 Nov 2026 02:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793585588;
	bh=+hcqaI3fakm5IofpIQuDxhisUvijHzChUJ+piqLdU4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q/t+99Ln2qDjyd4z6aTeJyv0fTBkdovu6/REyUDs5IPVFKyfrToFa2i0OIksFAdKx
	 8FtTDb0pe52nbrIMcd5HGCOKxaBb1FEx7CHkJbdopXUX4w7SHowKqWvwjpC2L3Adz7
	 fe9yDVGwaNp17oB2wmoOgmADU9eju2sOaVd78geMhLP5gDeo2g42xrUWg4HACJW6V3
	 DW8fUO6/xX6tdvlRreRfaXuK+05KyIwWpsUXO9ZVbwQsDbFa3Ebq2zwKau45Ovqf+L
	 +DZ0PpJPoNYTqP0w6mCX1GhWLKwtxj4CyXiLfoauN3bHL9Usefo4fsTJ+vwDloajGW
	 oBBqtPBjrWnAw==
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
Subject: [PATCH v3 5/7] tools: build kernel selftests in tools_build
Date: Sun,  1 Nov 2026 21:12:51 -0500
Message-ID: <20261102021253.2545235-6-sashal@kernel.org>
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
 tools/Makefile.kbuild | 122 +++++++++++++++++++-
 2 files changed, 371 insertions(+), 4 deletions(-)

diff --git a/tools/Kconfig b/tools/Kconfig
index 4f13e3b104377..aaeac9d86ba4e 100644
--- a/tools/Kconfig
+++ b/tools/Kconfig
@@ -86,4 +86,257 @@ config TOOLS_BUILD_USB
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
index 4b3ea73bc8ab9..590440121c8c9 100644
--- a/tools/Makefile.kbuild
+++ b/tools/Makefile.kbuild
@@ -44,10 +44,11 @@ endif
 squote := '
 escsq = $(subst $(squote),'\$(squote)',$1)
 
-# $(call build,<output directory>,<make arguments>,<files to check>,<CONFIG_ symbol>)
+# $(call build,<output directory>,<make arguments>,<files to check>,<CONFIG_ symbol>[,<on failure>])
 # Builds in an empty directory when the make arguments or LDFLAGS changed, or
-# when one of the files is newer than the last build. "make -n" only shows
-# the build.
+# when one of the files is newer than the last build. A failure fails the
+# build, unless commands to run instead are given. "make -n" only shows the
+# build.
 build-key = $(call escsq,$(2) LDFLAGS=$(USERLDFLAGS))
 dry-run := $(findstring n,$(firstword -$(MAKEFLAGS)))
 
@@ -58,7 +59,7 @@ define build
 	fi;) \
 	mkdir -p $(1) && $(MAKE) $(2) && \
 	$(if $(dry-run),:,printf '%s' '$(build-key)' > $(1)/.tools_build) || \
-	{ echo >&2 "tools_build: $(patsubst $(outdir)/%,%,$(1)) failed to build; set CONFIG_$(4)=n to skip it"; false; }
+	{ echo >&2 "tools_build: $(patsubst $(outdir)/%,%,$(1)) failed to build; set CONFIG_$(4)=n to skip it"; $(or $(5),false); }
 endef
 
 # Programs in tools/<name>, which track their own header dependencies
@@ -89,6 +90,119 @@ PHONY += perf
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
+selftest-flags := CC='$(call escsq,$(tools-cc))' KHDR_INCLUDES='-isystem $(CURDIR)/usr/include'
+
+# Unlike tools/build, the selftests do not track header dependencies. A
+# selftest is built again from scratch when its own directory, a header or
+# makefile any selftest may share, or the kernel sources and headers it
+# includes are newer than its last build.
+selftest-shared := $(outdir)/selftests/.shared
+selftest-extra-vDSO := $(abs_srctree)/arch/$(SRCARCH) $(abs_srctree)/include
+selftest-extra-x86 := $(abs_srctree)/arch/x86/include
+
+$(selftest-shared): FORCE
+	$(Q)mkdir -p $(@D); \
+	newest=$$(find $(CURDIR)/usr/include $(toolsdir)/include $(toolsdir)/arch $(toolsdir)/testing/selftests \
+		-type f \( -name '*.h' -o -name '*.mk' -o -name Makefile \) -printf '%T@\n' | \
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


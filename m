Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBF740245F;
	Sun, 11 Oct 2026 23:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791761817; cv=none; b=Mhv/+mI4NCN43190NVcdOrFHzLlg77Ofo0h5BzSLBFKrMccvV+XGJ15N1Af4YT2qRzu7hqmjQjPUYvarv4e/3lMsmhWN+c5kTrPPA9mDNGaPSk6mEz950qdbEUwlv3LnkyX52MarnXkBJPKcti89QBB0X9nVe1EZE60P+eOHxcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791761817; c=relaxed/simple;
	bh=+zvKjtkE9vDUbbB3Xakq0m4Uxq1Q+wQ6qCVHf50f1yA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u4cxNBlme7yufnPq1PM6yW+ASCwtkUK4ytEKCpX8aQTh87i25JSX94U6suqXWu0XowqAqU31Ce8z2y6JwPfnMj+FFEerj7xT0gwvt4dk4gm3fIs/YOJyyeaMhRGi9cRQiUOOSLX7dClA5RTThKtWHCdm/TzMbsRznJHr5q8Jay4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=is8yraI/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="is8yraI/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F0FA1F0089D;
	Sun, 11 Oct 2026 23:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791761815;
	bh=QFIrCGmdfKLpWjfordWIXHtvSMwkFwC6+TFMs7xDeXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=is8yraI/Ftf0uIYCQVqosUi7S4S9g+h+EPjOHSjGzgBJJOMlx17+pflj3YolUWdEn
	 XVGGjM/hYoH6bYNCm1v8GGv3qTr7y5wCpdO0FCv68bTadZuczrsDnaZoeIEV8dMpJi
	 GX7J7yr/wSmgrgSFHeUXH+4yi/MAZx6rlpUXqaLStJStwPC2QbWBTp+1tw3Uv8zKNU
	 MmRDNIQwx+eLWKQxVj2P2syqNya/Y4q7jzw0Nv6uyK5SMZ/lRb6V/DlbmbxkIVN1yH
	 zVnGtpRb0JIniz6tkvF77cBgpY0PIzH92N6z7r8AuNYIECa4j+AcElHSFwJ+7eyt8B
	 LaL2smX4QbdOw==
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
	Sasha Levin <sashal@kernel.org>
Subject: [RFC PATCH 4/6] tools: build kernel selftests in tools_build
Date: Sun, 11 Oct 2026 19:36:43 -0400
Message-ID: <20261011233647.2454648-5-sashal@kernel.org>
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

Add a "Kernel selftests" sub-menu with one entry per selftests directory
that builds with only a C library and does not write into the source
tree. Each is built as "make kselftest-all" builds it, with KHDR_INCLUDES
pointing at the UAPI headers installed in the object tree, but by its own
make, so the selected ones build in parallel. Selftests whose Makefile
does not use KHDR_INCLUDES still build against the C library's copy of
the UAPI headers.

The selftests do not track header dependencies, so a selftest is built
again from scratch when its own directory, a header or makefile any
selftest may share, or a kernel source it includes directly (the vDSO
test includes the architecture's vDSO code) is newer than its last
build.

Selftests that need libraries beyond the C library, a vmlinux with BTF,
or a sanitizer runtime are left out for now.

Assisted-by: LLM
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/Kconfig         | 239 ++++++++++++++++++++++++++++++++++++++++++
 tools/Makefile.kbuild | 100 ++++++++++++++++++
 2 files changed, 339 insertions(+)

diff --git a/tools/Kconfig b/tools/Kconfig
index 488f439592150..d713741782e22 100644
--- a/tools/Kconfig
+++ b/tools/Kconfig
@@ -84,4 +84,243 @@ config TOOLS_BUILD_USB
 	help
 	  Build tools/usb (testusb, ffs-test).
 
+menuconfig TOOLS_BUILD_SELFTESTS
+	bool "Kernel selftests"
+	help
+	  Build the selected targets under tools/testing/selftests, as
+	  "make kselftest-all" would, without running them.
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
index 62fd494253eca..c31347258d0a9 100644
--- a/tools/Makefile.kbuild
+++ b/tools/Makefile.kbuild
@@ -92,6 +92,106 @@ PHONY += perf
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
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_FILESYSTEMS_EPOLL)	+= filesystems/epoll
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_FILESYSTEMS_EVENTFD)	+= filesystems/eventfd
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_FILESYSTEMS_FAILFS)	+= filesystems/failfs
+selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_FILESYSTEMS_FAT)	+= filesystems/fat
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
+# makefile any selftest may share, or a kernel source it includes directly
+# is newer than its last build.
+selftest-shared := $(outdir)/selftests/.shared
+selftest-extra-vDSO := $(abs_srctree)/arch/$(SRCARCH)
+
+$(selftest-shared): FORCE
+	$(Q)mkdir -p $(@D); \
+	newest=$$(find $(CURDIR)/usr/include $(toolsdir)/include $(toolsdir)/testing/selftests \
+		-type f \( -name '*.h' -o -name '*.mk' -o -name Makefile \) -printf '%T@\n' | \
+		sort -n | tail -n 1); \
+	touch -d "@$${newest:-0}" $@
+
+selftest-targets := $(addprefix selftest-,$(selftests-y))
+
+__tools_build: $(selftest-targets)
+
+PHONY += $(selftest-targets)
+$(selftest-targets): selftest-%: $(selftest-shared) FORCE
+	$(call build,$(outdir)/selftests/$*,-C $(toolsdir)/testing/selftests/$* OUTPUT=$(outdir)/selftests/$* $(selftest-flags),$(selftest-shared) $(toolsdir)/testing/selftests/$* $(selftest-extra-$*),TOOLS_BUILD_SELFTESTS_$(shell echo $* | tr a-z/- A-Z__))
+
 PHONY += FORCE
 FORCE:
 
-- 
2.53.0


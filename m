Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0647529D281;
	Wed, 14 Jan 2026 01:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768353767; cv=none; b=BAKqkfyFcS0yIMFKMG9Sq7D5N82uGCUxaR9z/Io2AmGCCBwKmGFE4+t3vXkSOmRuMHnBexI4H6CLTJ0OkgThMHDkPwqPzvOIgxEEQ3TbkoJkIvxLTB3B8MGiaJ/vXCpnBj+G9GAjjWmHYwh5jMfJ3oh0DEo0aJQRHbp2W6LOMiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768353767; c=relaxed/simple;
	bh=ku1VivN8Oj5GKD9XQr8HZ8dGyY/qk1P9516GL+StqI4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UxHxpXLZdQFgoScoe3QTlN5Uai1iD9Fg1ZT0CpB8pBQ1A8rcnLO5UZl+6sQ4LuscbHy3SHV3tlAeAiltc3j5po9z0cPjuHyETfTY58/lmuUuyknnXAhl8gSHfEF3O5pN1PjvnHjF3zpMb0Rz0To7Hk1W9AjSUfAMg17idlMrgGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K/TC7QKa; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K/TC7QKa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768353755; x=1799889755;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ku1VivN8Oj5GKD9XQr8HZ8dGyY/qk1P9516GL+StqI4=;
  b=K/TC7QKaGAHsCuwPdD+QU8N4ml7sVS8uDfKkKIpDNJegaaknyoFoSnGt
   tvCos4fOQbFDD/0k9/pjIMfusGEelDhdY2MS48Fvfn6v+G15Dk6p6Ri60
   KlPZr8CPMGWT5qoZRWPEMPZxR8vBPkPchDQvV/qxmDRYfNPEgbHGy0Fk1
   7fcEXXRfvlymWTZZyeu3uPKNnel6GREqQVS5YLrO8s40yxHZKoKnRwRqM
   kUnlVaZe1zpX7qF8KC4AhPZtvssny2Ej51AhTyCtL+8SkhPAalifqBQHp
   lOdTHrKuSuZ/jo4x5V3Z2Ik8JGZA7IxMJgCCT+lDwlVNEeeKSSc1l8F/v
   g==;
X-CSE-ConnectionGUID: gGwxqO3vRY6rA70J+HhOnA==
X-CSE-MsgGUID: a2HC8b82SUiL5eZ7JkrNDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="87231539"
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="87231539"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 17:22:34 -0800
X-CSE-ConnectionGUID: 6tutQDjOTKeayWD4/CTrjQ==
X-CSE-MsgGUID: xmQaMqv1RRylpCADOKWieQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="204561219"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa007.jf.intel.com with ESMTP; 13 Jan 2026 17:22:30 -0800
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v3 7/7] perf/x86/intel: Add support for rdpmc user disable feature
Date: Wed, 14 Jan 2026 09:17:50 +0800
Message-Id: <20260114011750.350569-8-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260114011750.350569-1-dapeng1.mi@linux.intel.com>
References: <20260114011750.350569-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Starting with Panther Cove, the rdpmc user disable feature is supported.
This feature allows the perf system to disable user space rdpmc reads at
the counter level.

Currently, when a global counter is active, any user with rdpmc rights
can read it, even if perf access permissions forbid it (e.g., disallow
reading ring 0 counters). The rdpmc user disable feature mitigates this
security concern.

Details:

- A new RDPMC_USR_DISABLE bit (bit 37) in each EVNTSELx MSR indicates
  that the GP counter cannot be read by RDPMC in ring 3.
- New RDPMC_USR_DISABLE bits in IA32_FIXED_CTR_CTRL MSR (bits 33, 37,
  41, 45, etc.) for fixed counters 0, 1, 2, 3, etc.
- When calling rdpmc instruction for counter x, the following pseudo
  code demonstrates how the counter value is obtained:
  	If (!CPL0 && RDPMC_USR_DISABLE[x] == 1) ? 0 : counter_value;
- RDPMC_USR_DISABLE is enumerated by CPUID.0x23.0.EBX[2].

This patch extends the current global user space rdpmc control logic via
the sysfs interface (/sys/devices/cpu/rdpmc) as follows:

- rdpmc = 0:
  Global user space rdpmc and counter-level user space rdpmc for all
  counters are both disabled.
- rdpmc = 1:
  Global user space rdpmc is enabled during the mmap-enabled time window,
  and counter-level user space rdpmc is enabled only for non-system-wide
  events. This prevents counter data leaks as count data is cleared
  during context switches.
- rdpmc = 2:
  Global user space rdpmc and counter-level user space rdpmc for all
  counters are enabled unconditionally.

The new rdpmc settings only affect newly activated perf events; currently
active perf events remain unaffected. This simplifies and cleans up the
code. The default value of rdpmc remains unchanged at 1.

For more details about rdpmc user disable, please refer to chapter 15
"RDPMC USER DISABLE" in ISE documentation.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---

v3: Add words to mention rdpmc attribute is global even on hybrid
platforms in the documentation.

 .../sysfs-bus-event_source-devices-rdpmc      | 44 +++++++++++++++++++
 arch/x86/events/core.c                        | 21 +++++++++
 arch/x86/events/intel/core.c                  | 27 ++++++++++++
 arch/x86/events/perf_event.h                  |  6 +++
 arch/x86/include/asm/perf_event.h             |  8 +++-
 5 files changed, 104 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices-rdpmc

diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-rdpmc b/Documentation/ABI/testing/sysfs-bus-event_source-devices-rdpmc
new file mode 100644
index 000000000000..59ec18bbb418
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-rdpmc
@@ -0,0 +1,44 @@
+What:           /sys/bus/event_source/devices/cpu.../rdpmc
+Date:           November 2011
+KernelVersion:  3.10
+Contact:        Linux kernel mailing list linux-kernel@vger.kernel.org
+Description:    The /sys/bus/event_source/devices/cpu.../rdpmc attribute
+                is used to show/manage if rdpmc instruction can be
+                executed in user space. This attribute supports 3 numbers.
+                - rdpmc = 0
+                user space rdpmc is globally disabled for all PMU
+                counters.
+                - rdpmc = 1
+                user space rdpmc is globally enabled only in event mmap
+                ioctl called time window. If the mmap region is unmapped,
+                user space rdpmc is disabled again.
+                - rdpmc = 2
+                user space rdpmc is globally enabled for all PMU
+                counters.
+
+                In the Intel platforms supporting counter level's user
+                space rdpmc disable feature (CPUID.23H.EBX[2] = 1), the
+                meaning of 3 numbers is extended to
+                - rdpmc = 0
+                global user space rdpmc and counter level's user space
+                rdpmc of all counters are both disabled.
+                - rdpmc = 1
+                No changes on behavior of global user space rdpmc.
+                counter level's rdpmc of system-wide events is disabled
+                but counter level's rdpmc of non-system-wide events is
+                enabled.
+                - rdpmc = 2
+                global user space rdpmc and counter level's user space
+                rdpmc of all counters are both enabled unconditionally.
+
+                The default value of rdpmc is 1.
+
+                Please notice:
+                - global user space rdpmc's behavior would change
+                immediately along with the rdpmc value's change,
+                but the behavior of counter level's user space rdpmc
+                won't take effect immediately until the event is
+                reactivated or recreated.
+                - The rdpmc attribute is global, even for x86 hybrid
+                platforms. For example, changing cpu_core/rdpmc will
+                also change cpu_atom/rdpmc.
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index c2717cb5034f..6df73e8398cd 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2616,6 +2616,27 @@ static ssize_t get_attr_rdpmc(struct device *cdev,
 	return snprintf(buf, 40, "%d\n", x86_pmu.attr_rdpmc);
 }
 
+/*
+ * Behaviors of rdpmc value:
+ * - rdpmc = 0
+ *    global user space rdpmc and counter level's user space rdpmc of all
+ *    counters are both disabled.
+ * - rdpmc = 1
+ *    global user space rdpmc is enabled in mmap enabled time window and
+ *    counter level's user space rdpmc is enabled for only non system-wide
+ *    events. Counter level's user space rdpmc of system-wide events is
+ *    still disabled by default. This won't introduce counter data leak for
+ *    non system-wide events since their count data would be cleared when
+ *    context switches.
+ * - rdpmc = 2
+ *    global user space rdpmc and counter level's user space rdpmc of all
+ *    counters are enabled unconditionally.
+ *
+ * Suppose the rdpmc value won't be changed frequently, don't dynamically
+ * reschedule events to make the new rpdmc value take effect on active perf
+ * events immediately, the new rdpmc value would only impact the new
+ * activated perf events. This makes code simpler and cleaner.
+ */
 static ssize_t set_attr_rdpmc(struct device *cdev,
 			      struct device_attribute *attr,
 			      const char *buf, size_t count)
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index d6bdbb7e449a..f3ae1f8ee3cd 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3128,6 +3128,8 @@ static void intel_pmu_enable_fixed(struct perf_event *event)
 		bits |= INTEL_FIXED_0_USER;
 	if (hwc->config & ARCH_PERFMON_EVENTSEL_OS)
 		bits |= INTEL_FIXED_0_KERNEL;
+	if (hwc->config & ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE)
+		bits |= INTEL_FIXED_0_RDPMC_USER_DISABLE;
 
 	/*
 	 * ANY bit is supported in v3 and up
@@ -3263,6 +3265,27 @@ static void intel_pmu_enable_event_ext(struct perf_event *event)
 		__intel_pmu_update_event_ext(hwc->idx, ext);
 }
 
+static void intel_pmu_update_rdpmc_user_disable(struct perf_event *event)
+{
+	if (!x86_pmu_has_rdpmc_user_disable(event->pmu))
+		return;
+
+	/*
+	 * Counter scope's user-space rdpmc is disabled by default
+	 * except two cases.
+	 * a. rdpmc = 2 (user space rdpmc enabled unconditionally)
+	 * b. rdpmc = 1 and the event is not a system-wide event.
+	 *    The count of non-system-wide events would be cleared when
+	 *    context switches, so no count data is leaked.
+	 */
+	if (x86_pmu.attr_rdpmc == X86_USER_RDPMC_ALWAYS_ENABLE ||
+	    (x86_pmu.attr_rdpmc == X86_USER_RDPMC_CONDITIONAL_ENABLE &&
+	     event->ctx->task))
+		event->hw.config &= ~ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE;
+	else
+		event->hw.config |= ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE;
+}
+
 DEFINE_STATIC_CALL_NULL(intel_pmu_enable_event_ext, intel_pmu_enable_event_ext);
 
 static void intel_pmu_enable_event(struct perf_event *event)
@@ -3271,6 +3294,8 @@ static void intel_pmu_enable_event(struct perf_event *event)
 	struct hw_perf_event *hwc = &event->hw;
 	int idx = hwc->idx;
 
+	intel_pmu_update_rdpmc_user_disable(event);
+
 	if (unlikely(event->attr.precise_ip))
 		static_call(x86_pmu_pebs_enable)(event);
 
@@ -5869,6 +5894,8 @@ static void update_pmu_cap(struct pmu *pmu)
 		hybrid(pmu, config_mask) |= ARCH_PERFMON_EVENTSEL_UMASK2;
 	if (ebx_0.split.eq)
 		hybrid(pmu, config_mask) |= ARCH_PERFMON_EVENTSEL_EQ;
+	if (ebx_0.split.rdpmc_user_disable)
+		hybrid(pmu, config_mask) |= ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE;
 
 	if (eax_0.split.cntr_subleaf) {
 		cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_NUM_COUNTER_LEAF,
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 24a81d2916e9..cd337f3ffd01 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1333,6 +1333,12 @@ static inline u64 x86_pmu_get_event_config(struct perf_event *event)
 	return event->attr.config & hybrid(event->pmu, config_mask);
 }
 
+static inline bool x86_pmu_has_rdpmc_user_disable(struct pmu *pmu)
+{
+	return !!(hybrid(pmu, config_mask) &
+		 ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE);
+}
+
 extern struct event_constraint emptyconstraint;
 
 extern struct event_constraint unconstrained;
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 0d9af4135e0a..ff5acb8b199b 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -33,6 +33,7 @@
 #define ARCH_PERFMON_EVENTSEL_CMASK			0xFF000000ULL
 #define ARCH_PERFMON_EVENTSEL_BR_CNTR			(1ULL << 35)
 #define ARCH_PERFMON_EVENTSEL_EQ			(1ULL << 36)
+#define ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE	(1ULL << 37)
 #define ARCH_PERFMON_EVENTSEL_UMASK2			(0xFFULL << 40)
 
 #define INTEL_FIXED_BITS_STRIDE			4
@@ -40,6 +41,7 @@
 #define INTEL_FIXED_0_USER				(1ULL << 1)
 #define INTEL_FIXED_0_ANYTHREAD			(1ULL << 2)
 #define INTEL_FIXED_0_ENABLE_PMI			(1ULL << 3)
+#define INTEL_FIXED_0_RDPMC_USER_DISABLE		(1ULL << 33)
 #define INTEL_FIXED_3_METRICS_CLEAR			(1ULL << 2)
 
 #define HSW_IN_TX					(1ULL << 32)
@@ -50,7 +52,7 @@
 #define INTEL_FIXED_BITS_MASK					\
 	(INTEL_FIXED_0_KERNEL | INTEL_FIXED_0_USER |		\
 	 INTEL_FIXED_0_ANYTHREAD | INTEL_FIXED_0_ENABLE_PMI |	\
-	 ICL_FIXED_0_ADAPTIVE)
+	 ICL_FIXED_0_ADAPTIVE | INTEL_FIXED_0_RDPMC_USER_DISABLE)
 
 #define intel_fixed_bits_by_idx(_idx, _bits)			\
 	((_bits) << ((_idx) * INTEL_FIXED_BITS_STRIDE))
@@ -226,7 +228,9 @@ union cpuid35_ebx {
 		unsigned int    umask2:1;
 		/* EQ-bit Supported */
 		unsigned int    eq:1;
-		unsigned int	reserved:30;
+		/* rdpmc user disable Supported */
+		unsigned int    rdpmc_user_disable:1;
+		unsigned int	reserved:29;
 	} split;
 	unsigned int            full;
 };
-- 
2.34.1


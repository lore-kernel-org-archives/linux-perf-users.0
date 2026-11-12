Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794510574;
	b=5dgoNsX+1822uFK/lb0uYKflT7vj07gocpD5c0X5YAubjUeMjAR/ycgzZf/3aHDj0DKZ
	 kY4/yz6zmxC6CwGbkJzXL4NU5d/8StyjJSd3PnQWLjeLp+l9IZLA+4Jry08SOAYteFehA
	 xpzy79/ydpoKW44/WuWEqKf8RgPURw7wcAN2ylml/osUdSpYoGvAGoAu/eFWcplZbK5/l
	 JNAHgEAjkWK5isJluCJBzbZImS7gNCBbDyFCGeCJY32asGwedBHsBYINpW556cXKwx5mD
	 1J2rlZxA5SzzyL/UHmuAoY7izTUI1HV+wWyszh6zVTbDzQibenr2MhMx8O3m69e+dog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794510574;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=rlD44nnb+OQN2J1N8Blg7+FyOwp4Ia8QqwRMZlXAzKU=;
	b=uUcFkSf88i9Eh1qc7O/4WcHaErIPeN8oH8l0l6G5oWB3/He39f1/5CnYTWvYaQhMI1Yh
	 5VXQtPfs5Ma6rmmh2vnilojIZXZr78HFf4McXkCuhxPVXsudNahvmgwwEErrirrLLVmxC
	 8mKvNfXRMc1Sr+HzY2wAYFl8Y1+HU6DBbBRTPpZ/h+vA8sFrw8kNW+4L5FzSPCGJ+Au3r
	 ewdDcrYb6TAJqX9DSTNbGSE3X6+zhD3BQsaHpWJfKRI0dPmDQO8lH6R9vC43RzkLm274+
	 3C3TwTle1YsUtlYuWox98hVA9jV4yD0e8LXQjs/RMCX4CuZ2KR9owYdq/cnoWtSonrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A1EFUq0J;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1974660A380C
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 19:09:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1974660A380C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A1EFUq0J
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1b3acec6677so71272c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 11:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794510571; x=1795115371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rlD44nnb+OQN2J1N8Blg7+FyOwp4Ia8QqwRMZlXAzKU=;
        b=A1EFUq0JImFMJbFfxF7YOdzspXoC+QoNktsnd133VumqnMjetA1OOnPDi7+GdsD1Fg
         vpSp1iO3aVsyroAI0F9nKeFYV0K3QoQ4/CM6GclJDLM2gVaVUmi++DtivLCF56Vj3lCt
         W+cFSItKDjA0r2cwrO3Bq82k6G2IdB+oMbPUQAXnn136BtsWzMlMgvYXl/8LhmKHzdEi
         iHfbquJH8dFSgCutxUBR3HEsRce932xBeOKCmTtgmYg5wYRGYDdW1iFwp12uuxCA/o/h
         SV8raNRXrxJHjfrgSdWvy5GU5xIMz1QlLkUPOSTtGuhieuUtgJl5RFK5Isk3PzqX1G12
         vKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794510571; x=1795115371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rlD44nnb+OQN2J1N8Blg7+FyOwp4Ia8QqwRMZlXAzKU=;
        b=ZS/v3QEyUQsOclrDlTExIG8KSKb2P2IcIjf9jMmuqjwgbCgcCo5VLyjaJCdC65bm+F
         MV1JK2XJwjFj+ombCddMKkAV6UtejVqQ0FcNDC1Sv9K+EDQmy0+OYa5WXjGG7PRTclIG
         +A2SW6m6q26cxZ1Bq6fnuBwfesPqwmpZunaSrC2EcfpgNPEqkFHQEn2zBkOe4FdoFNR4
         iUDDLpiwvx5nPBcgauac5xxaWbCp/UGeQPoJ+JnLMPRG+4phYXIRIkkvVdvmzjeUjZ3B
         l9lXAYxUDKqQrVIJ5ZTp57fEVLeGCtUOTZnyBRLHlYvoYZOzjik9pm4i5Tm1cWE6oXf8
         iVag==
X-Forwarded-Encrypted: i=1; AL+hErHeqjvVpVBi8eSkfNwSOLMqj16kcRjD4iZPh4Tq8IJ0FjmqEFrNEGN7Fv0ympnvOr5klwVSkTQTHvm1HZWo+Eaj@vger.kernel.org
X-Gm-Message-State: APuU4Z8jF3Op3d1THz1/W9YtBbA2d7HYwGbUrcDKYq7MFz34R+eQ3JSP
	HgYUJ6rwj1r+S0l1Y5MTtzKNaGoXXEH5LcIZNc+GTTeUoNlDMT9vwg/L
X-Gm-Gg: AYBFou16y/L8WEG7US9e4D+NX2TE/krXdvBj3whFZsUsaP0lVjsgjt0Fml4pxz3/DJM
	0M+hNjEFdhmEZ599DZ4E6mX9RbpqraoMi8xxO7Bv098gqu29fpIsqyuYQaCM3T3qNxa3Cxv8SOh
	pCYQML71ZAH9yG7KM0XtcNkBh7YAJzJNj5vSFsyzlhzbBAGUdVMDapgAirh1n1SdbYoAADCJSgC
	DYVp9IUCBDD9WVvXNsDFHrNwDaFvjshOH82Pf7124NGjJwtJDq46KEFC9JC+4i+e2euqq3KKDHA
	e3jHEgvxD0K9TmoDm3X2J4prNTjDV0ohU3hED6/Wv1OVmDXbd5OSWTAYca5YdQ3YsOtjaq/KKUP
	wMPdCvODDjFo6GcWuYTSW/HShoUtfd69LzIslYR+WMl1jqZkVduPyHjw3n//f2Y/FG6RixqagCy
	NBKfeEupfc2//bJd/TMapQFYurOTmCuPZsQq6S3zaPqwSICLqwUWO+ERjvIBmjaiQcbZ3ZFqgSn
	S2SaXjwTgFrdJfo2kjcVNdH4fgFBXZ6eG84XsYbP1yNT3TqIYoWEY4G+LYZbxzK11q4x33WDJqB
	PodSFU8edx9JxR59YRHpKfr1oGXIsg==
X-Received: by 2002:a05:7022:38b:b0:196:7742:3928 with SMTP id a92af1059eb24-1b502fcdc89mr534279c88.0.1794510570769;
        Thu, 12 Nov 2026 11:09:30 -0800 (PST)
Received: from eldorado ([2600:8802:b00:1f88::287])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37956bad6casm395674eec.26.2026.11.12.11.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 11:09:29 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-mips@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
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
	Thomas Gleixner <tglx@kernel.org>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list),
	linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM),
	"Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: [PATCH 3/3] MIPS: perf: Add SB1 and SB1A performance counter support
Date: Thu, 12 Nov 2026 11:09:16 -0800
Message-ID: <20261112190916.3725141-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112190916.3725141-1-f.fainelli@gmail.com>
References: <20261112190916.3725141-1-f.fainelli@gmail.com>
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

Support the four CPU-local SB1 performance counters through the MIPS PMU
driver. Use 64-bit CP0 accesses for the 40 count bits and overflow bit,
validate the documented layout at initialization, and handle sampling on
CPU-local IP7. Keep the interrupt masked while no events are scheduled and
clear the unused Count/Compare source sharing IP7 before enabling it and
in the handler. Reset counters through CPU hotplug callbacks.

Expose the historical OProfile event catalog through raw events and 48
sysfs aliases, plus generic cycles, instructions, branches and branch
misses. Preserve the catalog's duplicate encodings and disambiguate its
duplicate names. Leave generic cache events unmapped where the historical
descriptions do not establish a reliable mapping.

Add explicit physical counter selection and independent exclusions for
EXL and ordinary kernel execution. These exclusions only remove modes
already permitted by perf attributes. Enforce counter 0's cycles-only
restriction and reject reserved configurations. Reassign flexible events
when fixed-counter requests require it, preserving counts and sampling
state, and support groups led by software events. Honor sampling throttling.

Document the ABI, hardware assumptions, usage and validation limits.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/arch/mips/index.rst    |   1 +
 Documentation/arch/mips/sb1-pmu.rst  | 162 ++++++++++++
 arch/mips/kernel/perf_event_mipsxx.c | 373 ++++++++++++++++++++++++++-
 include/linux/cpuhotplug.h           |   1 +
 4 files changed, 526 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/arch/mips/sb1-pmu.rst

diff --git a/Documentation/arch/mips/index.rst b/Documentation/arch/mips/index.rst
index 703e195b933d..71a06ccac173 100644
--- a/Documentation/arch/mips/index.rst
+++ b/Documentation/arch/mips/index.rst
@@ -10,5 +10,6 @@ MIPS-specific Documentation
 
    booting
    ingenic-tcu
+   sb1-pmu
 
    features
diff --git a/Documentation/arch/mips/sb1-pmu.rst b/Documentation/arch/mips/sb1-pmu.rst
new file mode 100644
index 000000000000..d589a6262c65
--- /dev/null
+++ b/Documentation/arch/mips/sb1-pmu.rst
@@ -0,0 +1,162 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+SB1 performance counters
+========================
+
+The SB1 CPU PMU on SB1250-family systems is supported by
+``CONFIG_PERF_EVENTS`` and ``CONFIG_HW_PERF_EVENTS``.  The same implementation
+supports SB1A CPUs and the BCM1480 interrupt controller.  Runtime validation
+has been performed on a BCM1250 B2 Sentosa; SB1A/BCM1480 coverage is currently
+limited to compile checks.
+
+The implementation uses four CPU-local CP0 counters with 40 count bits
+and overflow indication in bit 40, as described in the SB1 User's Manual,
+September 2000, sections 11.2 and 11.3.  Freeze-on-overflow is disabled.
+The CPU performance interrupt uses IP7, independently of the SiByte timer.
+Counter initialization and interrupt masking follow CPU hotplug state.
+IP7 is unmasked only while events are scheduled.  The otherwise unused CP0
+Count/Compare timer also asserts IP7; its pending condition is cleared before
+unmasking and when handling the shared interrupt.
+
+When updating an existing build, rebuild the MIPS CPU interrupt-controller
+object as well.  Adding the SiByte-specific ``irq.h`` changes the header
+search result, which existing object dependencies may not detect.  A clean
+build avoids retaining the old CPU interrupt base.
+
+Events
+------
+
+The full historical OProfile SB1 event catalog is exposed under
+``/sys/bus/event_source/devices/cpu/events/``.  Names are lowercase versions
+of OProfile names, including its historical ``branch_misspredicts`` spelling.
+The duplicate names for event IDs 0x0c and 0x15 have hexadecimal suffixes:
+``dcache_read_miss_0c`` and ``read_rq_sent_to_abus_15``.  The two historical
+names for 0x16 are both retained; these aliases do not resolve the catalog's
+ambiguous descriptions.
+
+Generic perf events are mapped as follows:
+
+=================== ===== =============================================
+Perf name           Event Meaning
+=================== ===== =============================================
+cycles              0x10  Elapsed cycles
+instructions        0x00  Instructions surviving stage 7
+branches            0x2c  Branch instructions surviving stage 4
+branch-misses       0x2f  Branch mispredicts
+=================== ===== =============================================
+
+The instruction and branch events retain their pipeline-stage semantics;
+they are not precise sampling events.  Generic cache events remain unmapped
+because the historical descriptions are insufficient to establish a faithful
+mapping.  All cache-related legacy events remain available by name and raw ID.
+
+Raw event IDs 0x00 through 0x2f, except 0x0e, are accepted.  Counter 0 only
+supports cycles; counters 1 through 3 support all catalog events.
+
+Counter selection and mode filtering
+-----------------------------------
+
+The ``counter`` format field selects a physical counter: 0 means automatic,
+and values 1 through 4 select physical counters 0 through 3.  A non-cycle
+event requesting physical counter 0 is rejected.  Automatic events may move
+to another eligible counter when a fixed-counter event is added, preserving
+their accumulated counts and sample periods.
+
+Perf's ``:u`` and ``:k`` modifiers control user and kernel counting.
+``exclude_exl=1`` additionally suppresses counting while Status.EXL is set;
+``exclude_kernel_mode=1`` suppresses ordinary kernel mode while preserving
+EXL counting.  These fields only remove modes permitted by perf's existing
+exclusions, so they cannot enable kernel counting for a user-only event.
+Together they provide OProfile's independent kernel/user/EXL controls.
+
+For example, ``cpu/cycles,exclude_kernel_mode=1/:k`` counts only EXL,
+whereas ``cpu/cycles,exclude_exl=1/:k`` counts kernel execution outside EXL.
+A zero setting retains the default.  Unknown configuration bits, nonzero
+config1/config2 and precise-IP requests are rejected.
+
+Examples::
+
+    perf stat -a -C 0 -e cycles -- sleep 5
+    perf stat -a -C 1 -e cpu/event=0x10/ -- sleep 5
+    perf stat -e instructions,branches,branch-misses -- ./workload
+    perf stat -e cpu/issue_l0/ -- ./workload
+    perf stat -e cpu/cycles,counter=4,exclude_exl=1/ -- ./workload
+    perf record -a -e cycles -c 10000000 -g -- sleep 10
+
+The last example uses a fixed sample period.  Begin with a large period to
+avoid excessive interrupt load.  These interrupts are maskable, so sampling
+cannot reliably attribute time spent with local interrupts disabled.
+Use ``perf --no-pager report --stdio`` when collecting reports through a
+serial shell.  On n32 userspace with 32-bit ``time_t``, a system date beyond
+2038 can make file metadata operations fail and cause ``perf report`` to
+exit without a useful diagnostic.  Correct the system date before recording.
+
+Callchains
+----------
+
+Kernel callchains use the existing MIPS unwinder.  SB1 userspace callchains
+use bounded, fault-tolerant scanning for standard MIPS function prologues,
+as in the former OProfile implementation.  This supports o32, n32 and n64
+stack slots and permits one leaf frame to use the sampled RA register.
+The scanner checks at most 128 preceding instructions per frame and stops
+on inaccessible memory or invalid frame data.  Nonstandard prologues,
+dynamic stack adjustments and signal trampolines can truncate the chain.
+No MIPS16 or microMIPS decoder is needed for SB1.
+
+Validation
+----------
+
+The public core manual predates production silicon and leaves event IDs
+unassigned.  OProfile supplies historical encodings and implementation
+precedent, but runtime tests are needed to establish behavior on each CPU
+revision.  In particular, verify the documented counter width and overflow
+boundary rather than assuming a successful boot establishes correctness.
+
+1. Boot with a serial console available.  Check for the SB1 PMU registration
+   message, ``/sys/bus/event_source/devices/cpu/``, and kernel warnings.
+   Record CPU and SoC revisions, kernel configuration and compiler version.
+2. Run cycles counting separately on both CPUs.  Compare counts with elapsed
+   time and a known clock frequency using a busy loop, then check user-only
+   and kernel-only counting with suitable workloads.  Idle counts depend on
+   the processor's wait behavior and are not a clock calibration reference.
+3. Check overflow delivery on each CPU using a large fixed sampling period.
+   Both CPU columns of the ``sb1-pmu`` line in ``/proc/interrupts`` should
+   advance in the corresponding tests.  Inspect ``perf report`` for plausible
+   kernel symbols and confirm that stopping perf stops PMU interrupts.
+   Verify user callchains against known nested functions in all supported
+   ABIs, including a task with an inaccessible saved-RA slot.
+4. Exercise all counters with four cycles events in a group.  Exercise the
+   restricted allocation with ``{cycles,r00,r08,r09}``.  Repeat with the
+   cycle event last.  Three non-cycle events fit simultaneously; four must
+   not be accepted as a simultaneously scheduled group.  Ungrouped events
+   exceeding the available counters should multiplex.  Mix automatic and
+   explicit counter requests in both orders, including a software group
+   leader, and compare duplicate events after reassignment.
+5. Repeat task-scoped counting and sampling with migration allowed and with
+   CPU affinity fixed.  Compare totals with repeated controlled workloads.
+   Check event deletion, rapid start/stop, overflow throttling, frequency-mode
+   sampling, invalid attribute combinations, and concurrent perf sessions
+   for warnings or interrupts left enabled.
+6. Where CPU hotplug is supported, offline and online the secondary CPU with
+   CPU-scoped and migrating task events.  Verify events are stopped before
+   counters are reset and work again after the CPU returns.
+7. Vary sampling periods and workload duration to exercise reloads and count
+   continuity.  Use a sufficiently long busy run to cross the documented
+   40-bit boundary for counting-only events.  Do not infer overflow correctness
+   solely from short counts or successful sample collection.
+8. Profile the iperf same-CPU and separate-CPU cases only after the basic
+   counter and interrupt checks pass.  Compare throughput with profiling
+   disabled to quantify measurement overhead.
+
+References
+----------
+
+* SB1 core manual:
+  https://ftpmirror.your.org/pub/misc/bitsavers/components/sibyte/SB-1_User_Manual_200009.pdf
+* Historical OProfile event encodings:
+  https://android.googlesource.com/platform/external/oprofile/+/b8927e3cf42594785896f4c8afe811f57ccb9fa1/events/mips/sb1/events
+* Historical Linux OProfile SB1 CPU recognition:
+  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/mips/oprofile/op_model_mipsxx.c?h=v4.19
+
+The SoC's memory-mapped system performance counters are separate from the
+CPU PMU and are not managed by this driver.
diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index 196a070349b0..765cdb6f8cae 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/cpumask.h>
+#include <linux/cpuhotplug.h>
 #include <linux/interrupt.h>
 #include <linux/smp.h>
 #include <linux/kernel.h>
@@ -28,6 +29,13 @@
 #define MIPS_TCS_PER_COUNTER 2
 #define MIPS_CPUID_TO_COUNTER_MASK (MIPS_TCS_PER_COUNTER - 1)
 
+#define SB1_EVENT_MASK		GENMASK_ULL(5, 0)
+#define SB1_COUNTER_MASK	GENMASK_ULL(10, 8)
+#define SB1_EXCLUDE_EXL		BIT_ULL(16)
+#define SB1_EXCLUDE_KERNEL	BIT_ULL(17)
+#define SB1_CONFIG_MASK		(SB1_EVENT_MASK | SB1_COUNTER_MASK | \
+				 SB1_EXCLUDE_EXL | SB1_EXCLUDE_KERNEL)
+
 struct cpu_hw_events {
 	/* Array of events on this cpu. */
 	struct perf_event	*events[MIPS_MAX_HWEVENTS];
@@ -93,6 +101,12 @@ struct mips_pmu {
 static int counter_bits;
 static struct mips_pmu mipspmu;
 
+static bool is_sb1_pmu(void)
+{
+	return current_cpu_type() == CPU_SB1 ||
+	       current_cpu_type() == CPU_SB1A;
+}
+
 #define M_PERFCTL_EVENT(event)		(((event) << MIPS_PERFCTRL_EVENT_S) & \
 					 MIPS_PERFCTRL_EVENT)
 #define M_PERFCTL_VPEID(vpe)		((vpe)	  << MIPS_PERFCTRL_VPEID_S)
@@ -311,12 +325,59 @@ static void mipsxx_pmu_write_control(unsigned int idx, unsigned int val)
 	}
 }
 
+/* Find an augmenting path so fixed-counter events can displace flexible ones. */
+static int sb1_alloc_counter(struct cpu_hw_events *cpuc, struct perf_event *event,
+			     unsigned int visited, bool fake)
+{
+	unsigned int mask = (event->hw.event_base >> 8) & 0xf;
+	int old = -1, idx, n;
+
+	for (n = 0; n < mipspmu.num_counters; n++)
+		if (cpuc->events[n] == event)
+			old = n;
+
+	for (n = 0; n < mipspmu.num_counters; n++) {
+		/* Prefer counter 0 for cycles, then the programmable counters. */
+		idx = n ? mipspmu.num_counters - n : 0;
+		if (!(mask & BIT(idx)) || (visited & BIT(idx)))
+			continue;
+		if (cpuc->events[idx] &&
+		    sb1_alloc_counter(cpuc, cpuc->events[idx],
+				      visited | BIT(idx), fake) < 0)
+			continue;
+
+		if (old >= 0) {
+			if (!fake) {
+				/* The PMU is paused throughout group scheduling. */
+				mipsxx_pmu_write_control(idx, 0);
+				mipspmu.write_counter(idx, mipspmu.read_counter(old));
+				cpuc->saved_ctrl[idx] = cpuc->saved_ctrl[old];
+				cpuc->saved_ctrl[old] = 0;
+				mipsxx_pmu_write_control(old, 0);
+				mipspmu.write_counter(old, 0);
+				event->hw.idx = idx;
+				perf_event_update_userpage(event);
+			}
+			cpuc->events[old] = NULL;
+			clear_bit(old, cpuc->used_mask);
+		}
+		cpuc->events[idx] = event;
+		set_bit(idx, cpuc->used_mask);
+		return idx;
+	}
+	return -EAGAIN;
+}
+
 static int mipsxx_pmu_alloc_counter(struct cpu_hw_events *cpuc,
-				    struct hw_perf_event *hwc)
+				    struct hw_perf_event *hwc, bool fake)
 {
 	int i;
 	unsigned long cntr_mask;
 
+	if (is_sb1_pmu())
+		return sb1_alloc_counter(cpuc,
+			container_of(hwc, struct perf_event, hw), 0, fake);
+
 	/*
 	 * We only need to care the counter mask. The range has been
 	 * checked definitely.
@@ -462,6 +523,8 @@ static void mipspmu_event_update(struct perf_event *event,
 		goto again;
 
 	delta = new_raw_count - prev_raw_count;
+	if (is_sb1_pmu())
+		delta &= CNTR_BIT_MASK(counter_bits);
 
 	local64_add(delta, &event->count);
 	local64_sub(delta, &hwc->period_left);
@@ -506,7 +569,7 @@ static int mipspmu_add(struct perf_event *event, int flags)
 	perf_pmu_disable(event->pmu);
 
 	/* To look for a free counter for this event. */
-	idx = mipsxx_pmu_alloc_counter(cpuc, hwc);
+	idx = mipsxx_pmu_alloc_counter(cpuc, hwc, false);
 	if (idx < 0) {
 		err = idx;
 		goto out;
@@ -564,6 +627,14 @@ static void mipspmu_enable(struct pmu *pmu)
 	write_unlock(&pmuint_rwlock);
 #endif
 	resume_local_counters();
+	if (is_sb1_pmu() &&
+	    !bitmap_empty(this_cpu_ptr(&cpu_hw_events)->used_mask,
+			  mipspmu.num_counters) &&
+	    !irq_percpu_is_enabled(mipspmu.irq)) {
+		/* Count/Compare shares IP7, but SiByte uses a separate timer. */
+		write_c0_compare(read_c0_count() - 1);
+		enable_percpu_irq(mipspmu.irq, IRQ_TYPE_NONE);
+	}
 }
 
 /*
@@ -579,6 +650,8 @@ static void mipspmu_enable(struct pmu *pmu)
  */
 static void mipspmu_disable(struct pmu *pmu)
 {
+	if (is_sb1_pmu() && irq_percpu_is_enabled(mipspmu.irq))
+		disable_percpu_irq(mipspmu.irq);
 	pause_local_counters();
 #ifdef CONFIG_MIPS_PERF_SHARED_TC_COUNTERS
 	write_lock(&pmuint_rwlock);
@@ -593,6 +666,10 @@ static int mipspmu_get_irq(void)
 {
 	int err;
 
+	/* SB1's CPU-local interrupt is reserved at PMU initialization. */
+	if (is_sb1_pmu())
+		return 0;
+
 	if (mipspmu.irq >= 0) {
 		/* Request my own irq handler. */
 		err = request_irq(mipspmu.irq, mipsxx_pmu_handle_irq,
@@ -621,6 +698,9 @@ static int mipspmu_get_irq(void)
 
 static void mipspmu_free_irq(void)
 {
+	if (is_sb1_pmu())
+		return;
+
 	if (mipspmu.irq >= 0)
 		free_irq(mipspmu.irq, &mipspmu);
 	else if (cp0_perfcount_irq < 0)
@@ -657,6 +737,10 @@ static int mipspmu_event_init(struct perf_event *event)
 	if (has_branch_stack(event))
 		return -EOPNOTSUPP;
 
+	if (is_sb1_pmu() && (event->attr.precise_ip || event->attr.config1 ||
+			     event->attr.config2))
+		return -EOPNOTSUPP;
+
 	switch (event->attr.type) {
 	case PERF_TYPE_RAW:
 	case PERF_TYPE_HARDWARE:
@@ -683,7 +767,10 @@ static int mipspmu_event_init(struct perf_event *event)
 	if (err)
 		return err;
 
-	return __hw_perf_event_init(event);
+	err = __hw_perf_event_init(event);
+	if (err && is_sb1_pmu() && !event->destroy)
+		hw_perf_event_destroy(event);
+	return err;
 }
 
 static struct pmu pmu = {
@@ -764,15 +851,18 @@ static int validate_group(struct perf_event *event)
 
 	memset(&fake_cpuc, 0, sizeof(fake_cpuc));
 
-	if (mipsxx_pmu_alloc_counter(&fake_cpuc, &leader->hw) < 0)
+	if ((!is_sb1_pmu() || leader->pmu == event->pmu) &&
+	    mipsxx_pmu_alloc_counter(&fake_cpuc, &leader->hw, true) < 0)
 		return -EINVAL;
 
 	for_each_sibling_event(sibling, leader) {
-		if (mipsxx_pmu_alloc_counter(&fake_cpuc, &sibling->hw) < 0)
+		if (is_sb1_pmu() && sibling->pmu != event->pmu)
+			continue;
+		if (mipsxx_pmu_alloc_counter(&fake_cpuc, &sibling->hw, true) < 0)
 			return -EINVAL;
 	}
 
-	if (mipsxx_pmu_alloc_counter(&fake_cpuc, &event->hw) < 0)
+	if (mipsxx_pmu_alloc_counter(&fake_cpuc, &event->hw, true) < 0)
 		return -EINVAL;
 
 	return 0;
@@ -791,7 +881,8 @@ static void handle_associated_event(struct cpu_hw_events *cpuc,
 	if (!mipspmu_event_set_period(event, hwc, idx))
 		return;
 
-	perf_event_overflow(event, data, regs);
+	if (perf_event_overflow(event, data, regs) && is_sb1_pmu())
+		mipsxx_pmu_disable_event(idx);
 }
 
 
@@ -941,6 +1032,207 @@ static const struct mips_perf_event mipsxxcore_event_map
 	[PERF_COUNT_HW_BRANCH_MISSES] = { 0x02, CNTR_ODD, T },
 };
 
+/* SB1 counter 0 only supports elapsed cycles. */
+static const struct mips_perf_event sb1_event_map[PERF_COUNT_HW_MAX] = {
+	[PERF_COUNT_HW_CPU_CYCLES] = { 0x10, CNTR_ALL },
+	[PERF_COUNT_HW_INSTRUCTIONS] = { 0x00, 0xeeeeeeee },
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = { 0x2c, 0xeeeeeeee },
+	[PERF_COUNT_HW_BRANCH_MISSES] = { 0x2f, 0xeeeeeeee },
+};
+
+/* Names and encodings from OProfile's events/mips/sb1/events. */
+PMU_EVENT_ATTR_STRING(cycles, sb1_cycles, "event=0x10");
+PMU_EVENT_ATTR_STRING(issue_l0, sb1_issue_l0, "event=0x28");
+PMU_EVENT_ATTR_STRING(issue_l1, sb1_issue_l1, "event=0x29");
+PMU_EVENT_ATTR_STRING(issue_e0, sb1_issue_e0, "event=0x2a");
+PMU_EVENT_ATTR_STRING(issue_e1, sb1_issue_e1, "event=0x2b");
+PMU_EVENT_ATTR_STRING(branch_misspredicts, sb1_branch_misspredicts, "event=0x2f");
+PMU_EVENT_ATTR_STRING(mbox_replay, sb1_mbox_replay, "event=0x1d");
+PMU_EVENT_ATTR_STRING(dcfifo, sb1_dcfifo, "event=0x1c");
+PMU_EVENT_ATTR_STRING(data_dependency_replay, sb1_data_dependency_replay, "event=0x1e");
+PMU_EVENT_ATTR_STRING(dcache_fill_replay, sb1_dcache_fill_replay, "event=0x1b");
+PMU_EVENT_ATTR_STRING(any_replay, sb1_any_replay, "event=0x1f");
+PMU_EVENT_ATTR_STRING(max_issue, sb1_max_issue, "event=0x20");
+PMU_EVENT_ATTR_STRING(no_valid_insn, sb1_no_valid_insn, "event=0x21");
+PMU_EVENT_ATTR_STRING(consumer_waiting_for_load, sb1_consumer_waiting_for_load, "event=0x22");
+PMU_EVENT_ATTR_STRING(not_data_ready, sb1_not_data_ready, "event=0x23");
+PMU_EVENT_ATTR_STRING(resource_constraint, sb1_resource_constraint, "event=0x24");
+PMU_EVENT_ATTR_STRING(issue_conflict_due_imiss, sb1_issue_conflict_due_imiss, "event=0x25");
+PMU_EVENT_ATTR_STRING(issue_conflict_due_dfill, sb1_issue_conflict_due_dfill, "event=0x26");
+PMU_EVENT_ATTR_STRING(insn_stage4, sb1_insn_stage4, "event=0x27");
+PMU_EVENT_ATTR_STRING(branch_stage4, sb1_branch_stage4, "event=0x2c");
+PMU_EVENT_ATTR_STRING(branch_really_taken, sb1_branch_really_taken, "event=0x2d");
+PMU_EVENT_ATTR_STRING(branch_predicted_taken, sb1_branch_predicted_taken, "event=0x2e");
+PMU_EVENT_ATTR_STRING(rq_length, sb1_rq_length, "event=0x01");
+PMU_EVENT_ATTR_STRING(uncached_rq_length, sb1_uncached_rq_length, "event=0x02");
+PMU_EVENT_ATTR_STRING(dcache_read_miss, sb1_dcache_read_miss, "event=0x03");
+PMU_EVENT_ATTR_STRING(dcache_filled_shd_nonc_exc, sb1_dcache_filled_shd_nonc_exc,
+		      "event=0x0a");
+PMU_EVENT_ATTR_STRING(dcache_fill_shared_line, sb1_dcache_fill_shared_line, "event=0x0b");
+PMU_EVENT_ATTR_STRING(dcache_read_miss_0c, sb1_dcache_read_miss_0c, "event=0x0c");
+PMU_EVENT_ATTR_STRING(writeback_returns, sb1_writeback_returns, "event=0x0f");
+PMU_EVENT_ATTR_STRING(victim_writeback, sb1_victim_writeback, "event=0x0d");
+PMU_EVENT_ATTR_STRING(upgrade_shared_to_exclusive, sb1_upgrade_shared_to_exclusive,
+		      "event=0x07");
+PMU_EVENT_ATTR_STRING(ld_st_hits_prefetch_in_queue, sb1_ld_st_hits_prefetch_in_queue,
+		      "event=0x06");
+PMU_EVENT_ATTR_STRING(prefetch_hits_cache_or_read_q, sb1_prefetch_hits_cache_or_read_q,
+		      "event=0x05");
+PMU_EVENT_ATTR_STRING(read_hits_read_q, sb1_read_hits_read_q, "event=0x04");
+PMU_EVENT_ATTR_STRING(biu_stalls_on_zb_addr_bus, sb1_biu_stalls_on_zb_addr_bus, "event=0x11");
+PMU_EVENT_ATTR_STRING(biu_stalls_on_zb_data_bus, sb1_biu_stalls_on_zb_data_bus, "event=0x12");
+PMU_EVENT_ATTR_STRING(read_rq_sent_to_abus, sb1_read_rq_sent_to_abus, "event=0x13");
+PMU_EVENT_ATTR_STRING(read_rq_nops_sent_to_abus, sb1_read_rq_nops_sent_to_abus, "event=0x14");
+PMU_EVENT_ATTR_STRING(read_rq_sent_to_abus_15, sb1_read_rq_sent_to_abus_15, "event=0x15");
+PMU_EVENT_ATTR_STRING(mbox_rq_when_biu_busy, sb1_mbox_rq_when_biu_busy, "event=0x16");
+PMU_EVENT_ATTR_STRING(store_cond_failed, sb1_store_cond_failed, "event=0x1a");
+PMU_EVENT_ATTR_STRING(snoop_rq_hits, sb1_snoop_rq_hits, "event=0x16");
+PMU_EVENT_ATTR_STRING(snoop_addr_q_full, sb1_snoop_addr_q_full, "event=0x17");
+PMU_EVENT_ATTR_STRING(r_resp_other_core, sb1_r_resp_other_core, "event=0x18");
+PMU_EVENT_ATTR_STRING(r_resp_other_core_d_mod, sb1_r_resp_other_core_d_mod, "event=0x19");
+PMU_EVENT_ATTR_STRING(load_survived_stage4, sb1_load_survived_stage4, "event=0x08");
+PMU_EVENT_ATTR_STRING(store_survived_stage4, sb1_store_survived_stage4, "event=0x09");
+PMU_EVENT_ATTR_STRING(insn_survived_stage7, sb1_insn_survived_stage7, "event=0x00");
+
+PMU_FORMAT_ATTR(event, "config:0-5");
+PMU_FORMAT_ATTR(counter, "config:8-10");
+PMU_FORMAT_ATTR(exclude_exl, "config:16");
+PMU_FORMAT_ATTR(exclude_kernel_mode, "config:17");
+
+static struct attribute *sb1_format_attrs[] = {
+	&format_attr_event.attr,
+	&format_attr_counter.attr,
+	&format_attr_exclude_exl.attr,
+	&format_attr_exclude_kernel_mode.attr,
+	NULL,
+};
+
+static const struct attribute_group sb1_format_group = {
+	.name = "format",
+	.attrs = sb1_format_attrs,
+};
+
+static struct attribute *sb1_event_attrs[] = {
+	&sb1_cycles.attr.attr,
+	&sb1_issue_l0.attr.attr,
+	&sb1_issue_l1.attr.attr,
+	&sb1_issue_e0.attr.attr,
+	&sb1_issue_e1.attr.attr,
+	&sb1_branch_misspredicts.attr.attr,
+	&sb1_mbox_replay.attr.attr,
+	&sb1_dcfifo.attr.attr,
+	&sb1_data_dependency_replay.attr.attr,
+	&sb1_dcache_fill_replay.attr.attr,
+	&sb1_any_replay.attr.attr,
+	&sb1_max_issue.attr.attr,
+	&sb1_no_valid_insn.attr.attr,
+	&sb1_consumer_waiting_for_load.attr.attr,
+	&sb1_not_data_ready.attr.attr,
+	&sb1_resource_constraint.attr.attr,
+	&sb1_issue_conflict_due_imiss.attr.attr,
+	&sb1_issue_conflict_due_dfill.attr.attr,
+	&sb1_insn_stage4.attr.attr,
+	&sb1_branch_stage4.attr.attr,
+	&sb1_branch_really_taken.attr.attr,
+	&sb1_branch_predicted_taken.attr.attr,
+	&sb1_rq_length.attr.attr,
+	&sb1_uncached_rq_length.attr.attr,
+	&sb1_dcache_read_miss.attr.attr,
+	&sb1_dcache_filled_shd_nonc_exc.attr.attr,
+	&sb1_dcache_fill_shared_line.attr.attr,
+	&sb1_dcache_read_miss_0c.attr.attr,
+	&sb1_writeback_returns.attr.attr,
+	&sb1_victim_writeback.attr.attr,
+	&sb1_upgrade_shared_to_exclusive.attr.attr,
+	&sb1_ld_st_hits_prefetch_in_queue.attr.attr,
+	&sb1_prefetch_hits_cache_or_read_q.attr.attr,
+	&sb1_read_hits_read_q.attr.attr,
+	&sb1_biu_stalls_on_zb_addr_bus.attr.attr,
+	&sb1_biu_stalls_on_zb_data_bus.attr.attr,
+	&sb1_read_rq_sent_to_abus.attr.attr,
+	&sb1_read_rq_nops_sent_to_abus.attr.attr,
+	&sb1_read_rq_sent_to_abus_15.attr.attr,
+	&sb1_mbox_rq_when_biu_busy.attr.attr,
+	&sb1_store_cond_failed.attr.attr,
+	&sb1_snoop_rq_hits.attr.attr,
+	&sb1_snoop_addr_q_full.attr.attr,
+	&sb1_r_resp_other_core.attr.attr,
+	&sb1_r_resp_other_core_d_mod.attr.attr,
+	&sb1_load_survived_stage4.attr.attr,
+	&sb1_store_survived_stage4.attr.attr,
+	&sb1_insn_survived_stage7.attr.attr,
+	NULL,
+};
+
+static const struct attribute_group sb1_event_group = {
+	.name = "events",
+	.attrs = sb1_event_attrs,
+};
+
+static const struct attribute_group *sb1_attr_groups[] = {
+	&sb1_format_group,
+	&sb1_event_group,
+	NULL,
+};
+
+/* The legacy catalog does not unambiguously define generic cache events. */
+static const struct mips_perf_event sb1_cache_map
+	[PERF_COUNT_HW_CACHE_MAX]
+	[PERF_COUNT_HW_CACHE_OP_MAX]
+	[PERF_COUNT_HW_CACHE_RESULT_MAX];
+
+static const struct mips_perf_event *sb1_pmu_map_raw_event(u64 config)
+{
+	unsigned int event = config & SB1_EVENT_MASK;
+	unsigned int counter = (config & SB1_COUNTER_MASK) >> 8;
+
+	if (config & ~SB1_CONFIG_MASK || counter > 4)
+		return ERR_PTR(-EINVAL);
+	if (event > 0x2f || event == 0x0e)
+		return ERR_PTR(-EOPNOTSUPP);
+	if (counter == 1 && event != 0x10)
+		return ERR_PTR(-EINVAL);
+
+	raw_event.event_id = event;
+	raw_event.cntr_mask = event == 0x10 ? CNTR_ALL : 0xeeeeeeee;
+	if (counter)
+		raw_event.cntr_mask = BIT(counter - 1) << 8;
+	return &raw_event;
+}
+
+static int sb1_pmu_cpu_online(unsigned int cpu)
+{
+	reset_counters((void *)(long)mipspmu.num_counters);
+	write_c0_compare(read_c0_count() - 1);
+	return 0;
+}
+
+static int sb1_pmu_cpu_offline(unsigned int cpu)
+{
+	if (irq_percpu_is_enabled(mipspmu.irq))
+		disable_percpu_irq(mipspmu.irq);
+	reset_counters((void *)(long)mipspmu.num_counters);
+	return 0;
+}
+
+static bool __init sb1_pmu_check_counters(void)
+{
+	unsigned int i;
+	bool valid = true;
+
+	/* Counters are disabled. Check the documented count and overflow bits. */
+	for (i = 0; i < mipspmu.num_counters; i++) {
+		mipspmu.write_counter(i, mipspmu.overflow - 1);
+		if (mipspmu.read_counter(i) != mipspmu.overflow - 1)
+			valid = false;
+		mipspmu.write_counter(i, mipspmu.overflow);
+		if (mipspmu.read_counter(i) != mipspmu.overflow)
+			valid = false;
+		mipspmu.write_counter(i, 0);
+	}
+	return valid;
+}
+
 /* 74K/proAptiv core has different branch event code. */
 static const struct mips_perf_event mipsxxcore_event_map2
 				[PERF_COUNT_HW_MAX] = {
@@ -1516,6 +1808,13 @@ static int __hw_perf_event_init(struct perf_event *event)
 	if (!attr->exclude_hv)
 		hwc->config_base |= MIPS_PERFCTRL_S;
 
+	if (is_sb1_pmu() && attr->type == PERF_TYPE_RAW) {
+		/* These controls only remove modes allowed by perf's exclusions. */
+		if (attr->config & SB1_EXCLUDE_EXL)
+			hwc->config_base &= ~MIPS_PERFCTRL_EXL;
+		if (attr->config & SB1_EXCLUDE_KERNEL)
+			hwc->config_base &= ~MIPS_PERFCTRL_K;
+	}
 	hwc->config_base &= M_PERFCTL_CONFIG_MASK;
 	/*
 	 * The event can belong to another cpu. We do not assign a local
@@ -1626,6 +1925,12 @@ static int mipsxx_pmu_handle_shared_irq(void)
 
 static irqreturn_t mipsxx_pmu_handle_irq(int irq, void *dev)
 {
+	if (is_sb1_pmu()) {
+		/* A legacy Count/Compare match can also assert this interrupt. */
+		write_c0_compare(read_c0_count() - 1);
+		mipsxx_pmu_handle_shared_irq();
+		return IRQ_HANDLED;
+	}
 	return mipsxx_pmu_handle_shared_irq();
 }
 
@@ -1889,7 +2194,7 @@ static const struct mips_perf_event *octeon_pmu_map_raw_event(u64 config)
 static int __init
 init_hw_perf_events(void)
 {
-	int counters, irq, pmu_type;
+	int counters, irq, pmu_type, ret, sb1_state = -1;
 
 	pr_info("Performance counters: ");
 
@@ -1914,6 +2219,16 @@ init_hw_perf_events(void)
 	mipspmu.map_raw_event = mipsxx_pmu_map_raw_event;
 
 	switch (current_cpu_type()) {
+	case CPU_SB1:
+	case CPU_SB1A:
+		if (!IS_ENABLED(CONFIG_SIBYTE_SB1xxx_SOC))
+			return -ENODEV;
+		mipspmu.name = "sb1";
+		mipspmu.general_event_map = &sb1_event_map;
+		mipspmu.cache_event_map = &sb1_cache_map;
+		mipspmu.map_raw_event = sb1_pmu_map_raw_event;
+		irq = MIPS_CPU_IRQ_BASE + 7;
+		break;
 	case CPU_24K:
 		mipspmu.name = "mips/24K";
 		mipspmu.general_event_map = &mipsxxcore_event_map;
@@ -2019,7 +2334,15 @@ init_hw_perf_events(void)
 	mipspmu.num_counters = counters;
 	mipspmu.irq = irq;
 
-	if (read_c0_perfctrl0() & MIPS_PERFCTRL_W) {
+	if (is_sb1_pmu()) {
+		/* Bit 30 is freeze enable on SB1, not the MIPS wide flag. */
+		counter_bits = 41;
+		mipspmu.max_period = (1ULL << 40) - 1;
+		mipspmu.valid_count = CNTR_BIT_MASK(counter_bits);
+		mipspmu.overflow = 1ULL << 40;
+		mipspmu.read_counter = mipsxx_pmu_read_counter_64;
+		mipspmu.write_counter = mipsxx_pmu_write_counter_64;
+	} else if (read_c0_perfctrl0() & MIPS_PERFCTRL_W) {
 		if (get_loongson3_pmu_type() == LOONGSON_PMU_TYPE2) {
 			counter_bits = 48;
 			mipspmu.max_period = (1ULL << 47) - 1;
@@ -2044,12 +2367,40 @@ init_hw_perf_events(void)
 
 	on_each_cpu(reset_counters, (void *)(long)counters, 1);
 
+	if (is_sb1_pmu()) {
+		if (!sb1_pmu_check_counters()) {
+			pr_err("SB1 counter width does not match the documented layout\n");
+			return -ENODEV;
+		}
+		ret = irq_set_percpu_devid(irq);
+		if (ret)
+			return ret;
+		irq_set_handler(irq, handle_percpu_devid_irq);
+		ret = request_percpu_irq(irq, mipsxx_pmu_handle_irq,
+					 "sb1-pmu", &cpu_hw_events);
+		if (ret)
+			return ret;
+		ret = cpuhp_setup_state(CPUHP_AP_PERF_MIPS_SB1_STARTING,
+					"perf/sb1:starting",
+					sb1_pmu_cpu_online, sb1_pmu_cpu_offline);
+		if (ret) {
+			free_percpu_irq(irq, &cpu_hw_events);
+			return ret;
+		}
+		sb1_state = CPUHP_AP_PERF_MIPS_SB1_STARTING;
+		pmu.attr_groups = sb1_attr_groups;
+	}
+
 	pr_cont("%s PMU enabled, %d %d-bit counters available to each "
 		"CPU, irq %d%s\n", mipspmu.name, counters, counter_bits, irq,
 		irq < 0 ? " (share with timer interrupt)" : "");
 
-	perf_pmu_register(&pmu, "cpu", PERF_TYPE_RAW);
+	ret = perf_pmu_register(&pmu, "cpu", PERF_TYPE_RAW);
+	if (ret && sb1_state >= 0) {
+		cpuhp_remove_state(sb1_state);
+		free_percpu_irq(irq, &cpu_hw_events);
+	}
 
-	return 0;
+	return ret;
 }
 early_initcall(init_hw_perf_events);
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 1b6dba159bb2..554f47fb5dd4 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -151,6 +151,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_X86_STARTING,
 	CPUHP_AP_PERF_X86_AMD_IBS_STARTING,
 	CPUHP_AP_PERF_XTENSA_STARTING,
+	CPUHP_AP_PERF_MIPS_SB1_STARTING,
 	CPUHP_AP_ARM_VFP_STARTING,
 	CPUHP_AP_ARM64_DEBUG_MONITORS_STARTING,
 	CPUHP_AP_PERF_ARM_HW_BREAKPOINT_STARTING,
-- 
2.53.0


Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508B0C4338F
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 Aug 2021 22:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30FD760EE9
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 Aug 2021 22:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245613AbhHFWvv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 6 Aug 2021 18:51:51 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:36552 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244342AbhHFWvs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 6 Aug 2021 18:51:48 -0400
Received: by mail-io1-f51.google.com with SMTP id f11so14471801ioj.3;
        Fri, 06 Aug 2021 15:51:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aNhQ9ZmzPJOmo+I2Q7thXIABafbqA4zdCQPskI9Z7RY=;
        b=lzujNNL3Vv9Ni+XcMKYj3gN2PB74Bbzej1T6VABaYwNbpaqNV0348VF1QmMBoS+WEU
         WgH/oSBff1n31WhgMITfVjvq6MUjcXdOoVM4bQ7qEdxFA+fu0SeYB6iDSTQs4DmRHGXL
         IL+ZBxRdYzJW0iNjbMy0/n/ZfgVhvhMxvZxIXBX5lCYN2Mo+guP7X2HplrpNiQ4iizPz
         B5a8Bf5Oxlzpq70icykOG4UEPRVvSiOa2aVSiEI0vZP8OVdgLr0sjcb7Ghn3nsVJWMf2
         eoLsh+u89SGHNcnGubfquKLZlXIjYSiWjOR/7sKPFnUbyN3BG84YKRs4vRwoE+YvXapT
         J9zw==
X-Gm-Message-State: AOAM5300hOaneQJBnIlpNQN+IEGES3e6GLaz0LWalXbY7vIUWrHN0Qv0
        sKN9bwGssNww6nsCrjQIbw==
X-Google-Smtp-Source: ABdhPJwp1yl7FNfSR4M3xKQ1/omJNjSg+MwUiezthna2uvz2B6OmvISZKw5yJuLLl+rUc0OPCpRyQQ==
X-Received: by 2002:a05:6602:21d6:: with SMTP id c22mr559258ioc.69.1628290291027;
        Fri, 06 Aug 2021 15:51:31 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.248])
        by smtp.googlemail.com with ESMTPSA id x11sm5670338ilu.3.2021.08.06.15.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 15:51:30 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        honnappa.nagarahalli@arm.com, Zachary.Leaf@arm.com,
        Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH v9 2/3] arm64: perf: Enable PMU counter userspace access for perf event
Date:   Fri,  6 Aug 2021 16:51:22 -0600
Message-Id: <20210806225123.1958497-3-robh@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210806225123.1958497-1-robh@kernel.org>
References: <20210806225123.1958497-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Arm PMUs can support direct userspace access of counters which allows for
low overhead (i.e. no syscall) self-monitoring of tasks. The same feature
exists on x86 called 'rdpmc'. Unlike x86, userspace access will only be
enabled for thread bound events. This could be extended if needed, but
simplifies the implementation and reduces the chances for any
information leaks (which the x86 implementation suffers from).

When an event is capable of userspace access and has been mmapped, userspace
access is enabled when the event is scheduled on a CPU's PMU. There's some
additional overhead clearing counters when disabled in order to prevent
leaking disabled counter data from other tasks.

Unlike x86, enabling of userspace access must be requested with a new
attr bit: config1:1. If the user requests userspace access and 64-bit
counters, then chaining will be disabled and the user will get the
maximum size counter the underlying h/w can support. The modes for
config1 are as follows:

config1 = 0 : user access disabled and always 32-bit
config1 = 1 : user access disabled and always 64-bit (using chaining if needed)
config1 = 2 : user access enabled and always 32-bit
config1 = 3 : user access enabled and counter size matches underlying counter.

Based on work by Raphael Gault <raphael.gault@arm.com>, but has been
completely re-written.

Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-perf-users@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>

---
v9:
 - Enabling/disabling of user access is now controlled in .start() and
   mmap hooks which are now called on CPUs that the event is on.
   Depends on rework of perf core and x86 RDPMC code posted here:
   https://lore.kernel.org/lkml/20210728230230.1911468-1-robh@kernel.org/

v8:
 - Rework user access tracking and enabling to be done on task
   context changes using sched_task() hook. This avoids the need for any
   IPIs, mm_switch hooks or undef instr handler.
 - Only support user access when explicitly requested on open and
   only for a thread bound events. This avoids some of the information
   leaks x86 has and simplifies the implementation.

v7:
 - Clear disabled counters when user access is enabled for a task to
   avoid leaking other tasks counter data.
 - Rework context switch handling utilizing sched_task callback
 - Add armv8pmu_event_can_chain() helper
 - Rework config1 flags handling structure
 - Use ARMV8_IDX_CYCLE_COUNTER_USER define for remapped user cycle
   counter index

v6:
 - Add new attr.config1 rdpmc bit for userspace to hint it wants
   userspace access when also requesting 64-bit counters.

v5:
 - Only set cap_user_rdpmc if event is on current cpu
 - Limit enabling/disabling access to CPUs associated with the PMU
   (supported_cpus) and with the mm_struct matching current->active_mm.

v2:
 - Move mapped/unmapped into arm64 code. Fixes arm32.
 - Rebase on cap_user_time_short changes

Changes from Raphael's v4:
  - Drop homogeneous check
  - Disable access for chained counters
  - Set pmc_width in user page
---
 arch/arm64/kernel/perf_event.c | 137 +++++++++++++++++++++++++++++++--
 include/linux/perf/arm_pmu.h   |   6 ++
 2 files changed, 135 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 74f77b68f5f0..66d8bf62e99c 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -285,6 +285,7 @@ static const struct attribute_group armv8_pmuv3_events_attr_group = {
 
 PMU_FORMAT_ATTR(event, "config:0-15");
 PMU_FORMAT_ATTR(long, "config1:0");
+PMU_FORMAT_ATTR(rdpmc, "config1:1");
 
 static int sysctl_perf_user_access __read_mostly;
 
@@ -306,9 +307,15 @@ static inline bool armv8pmu_event_is_64bit(struct perf_event *event)
 	return event->attr.config1 & 0x1;
 }
 
+static inline bool armv8pmu_event_want_user_access(struct perf_event *event)
+{
+	return event->attr.config1 & 0x2;
+}
+
 static struct attribute *armv8_pmuv3_format_attrs[] = {
 	&format_attr_event.attr,
 	&format_attr_long.attr,
+	&format_attr_rdpmc.attr,
 	NULL,
 };
 
@@ -377,7 +384,7 @@ static const struct attribute_group armv8_pmuv3_caps_attr_group = {
  */
 #define	ARMV8_IDX_CYCLE_COUNTER	0
 #define	ARMV8_IDX_COUNTER0	1
-
+#define	ARMV8_IDX_CYCLE_COUNTER_USER	32
 
 /*
  * We unconditionally enable ARMv8.5-PMU long event counter support
@@ -389,6 +396,15 @@ static bool armv8pmu_has_long_event(struct arm_pmu *cpu_pmu)
 	return (cpu_pmu->pmuver >= ID_AA64DFR0_PMUVER_8_5);
 }
 
+static inline bool armv8pmu_event_can_chain(struct perf_event *event)
+{
+	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
+
+	return !(event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT) &&
+	       armv8pmu_event_is_64bit(event) &&
+	       !armv8pmu_has_long_event(cpu_pmu);
+}
+
 /*
  * We must chain two programmable counters for 64 bit events,
  * except when we have allocated the 64bit cycle counter (for CPU
@@ -398,11 +414,9 @@ static bool armv8pmu_has_long_event(struct arm_pmu *cpu_pmu)
 static inline bool armv8pmu_event_is_chained(struct perf_event *event)
 {
 	int idx = event->hw.idx;
-	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 
 	return !WARN_ON(idx < 0) &&
-	       armv8pmu_event_is_64bit(event) &&
-	       !armv8pmu_has_long_event(cpu_pmu) &&
+	       armv8pmu_event_can_chain(event) &&
 	       (idx != ARMV8_IDX_CYCLE_COUNTER);
 }
 
@@ -733,6 +747,35 @@ static inline u32 armv8pmu_getreset_flags(void)
 	return value;
 }
 
+static void armv8pmu_disable_user_access(void)
+{
+	write_sysreg(0, pmuserenr_el0);
+}
+
+static void armv8pmu_enable_user_access(struct arm_pmu *cpu_pmu)
+{
+	struct pmu_hw_events *cpuc = this_cpu_ptr(cpu_pmu->hw_events);
+
+	if (!sysctl_perf_user_access)
+		return;
+
+	if (!bitmap_empty(cpuc->dirty_mask, ARMPMU_MAX_HWEVENTS)) {
+		int i;
+		/* Don't need to clear assigned counters. */
+		bitmap_xor(cpuc->dirty_mask, cpuc->dirty_mask, cpuc->used_mask, ARMPMU_MAX_HWEVENTS);
+
+		for_each_set_bit(i, cpuc->dirty_mask, ARMPMU_MAX_HWEVENTS) {
+			if (i == ARMV8_IDX_CYCLE_COUNTER)
+				write_sysreg(0, pmccntr_el0);
+			else
+				armv8pmu_write_evcntr(i, 0);
+		}
+		bitmap_zero(cpuc->dirty_mask, ARMPMU_MAX_HWEVENTS);
+	}
+
+	write_sysreg(ARMV8_PMU_USERENR_ER | ARMV8_PMU_USERENR_CR, pmuserenr_el0);
+}
+
 static void armv8pmu_enable_event(struct perf_event *event)
 {
 	/*
@@ -776,6 +819,16 @@ static void armv8pmu_disable_event(struct perf_event *event)
 
 static void armv8pmu_start(struct arm_pmu *cpu_pmu)
 {
+	if (sysctl_perf_user_access) {
+		struct perf_cpu_context *cpuctx = this_cpu_ptr(cpu_pmu->pmu.pmu_cpu_context);
+		struct perf_event_context *task_ctx = cpuctx->task_ctx;
+		if (atomic_read(&cpuctx->ctx.nr_user) ||
+		    (task_ctx && atomic_read(&task_ctx->nr_user)))
+			armv8pmu_enable_user_access(cpu_pmu);
+		else
+			armv8pmu_disable_user_access();
+	}
+
 	/* Enable all counters */
 	armv8pmu_pmcr_write(armv8pmu_pmcr_read() | ARMV8_PMU_PMCR_E);
 }
@@ -893,13 +946,16 @@ static int armv8pmu_get_event_idx(struct pmu_hw_events *cpuc,
 	if (evtype == ARMV8_PMUV3_PERFCTR_CPU_CYCLES) {
 		if (!test_and_set_bit(ARMV8_IDX_CYCLE_COUNTER, cpuc->used_mask))
 			return ARMV8_IDX_CYCLE_COUNTER;
+		else if (armv8pmu_event_is_64bit(event) &&
+			   armv8pmu_event_want_user_access(event) &&
+			   !armv8pmu_has_long_event(cpu_pmu))
+				return -EAGAIN;
 	}
 
 	/*
 	 * Otherwise use events counters
 	 */
-	if (armv8pmu_event_is_64bit(event) &&
-	    !armv8pmu_has_long_event(cpu_pmu))
+	if (armv8pmu_event_can_chain(event))
 		return	armv8pmu_get_chain_idx(cpuc, cpu_pmu);
 	else
 		return armv8pmu_get_single_idx(cpuc, cpu_pmu);
@@ -911,8 +967,44 @@ static void armv8pmu_clear_event_idx(struct pmu_hw_events *cpuc,
 	int idx = event->hw.idx;
 
 	clear_bit(idx, cpuc->used_mask);
-	if (armv8pmu_event_is_chained(event))
+	set_bit(idx, cpuc->dirty_mask);
+	if (armv8pmu_event_is_chained(event)) {
 		clear_bit(idx - 1, cpuc->used_mask);
+		set_bit(idx - 1, cpuc->dirty_mask);
+	}
+}
+
+static int armv8pmu_access_event_idx(struct perf_event *event)
+{
+	if (!sysctl_perf_user_access ||
+	    !(event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT))
+		return 0;
+
+	/*
+	 * We remap the cycle counter index to 32 to
+	 * match the offset applied to the rest of
+	 * the counter indices.
+	 */
+	if (event->hw.idx == ARMV8_IDX_CYCLE_COUNTER)
+		return ARMV8_IDX_CYCLE_COUNTER_USER;
+
+	return event->hw.idx;
+}
+
+static void armv8pmu_event_mapped(struct perf_event *event)
+{
+	if (atomic_read(&event->ctx->nr_user) != 1)
+		return;
+
+	armv8pmu_enable_user_access(to_arm_pmu(event->pmu));
+}
+
+static void armv8pmu_event_unmapped(struct perf_event *event)
+{
+	if (atomic_read(&event->ctx->nr_user) != 1)
+		return;
+
+	armv8pmu_disable_user_access();
 }
 
 /*
@@ -1008,9 +1100,22 @@ static int __armv8_pmuv3_map_event(struct perf_event *event,
 				       &armv8_pmuv3_perf_cache_map,
 				       ARMV8_PMU_EVTYPE_EVENT);
 
-	if (armv8pmu_event_is_64bit(event))
+	/*
+	 * At this point, the counter is not assigned. If a 64-bit counter is
+	 * requested, we must make sure the h/w has 64-bit counters if we set
+	 * the event size to 64-bit because chaining is not supported with
+	 * userspace access. This may still fail later on if the CPU cycle
+	 * counter is in use.
+	 */
+	if (armv8pmu_event_is_64bit(event) &&
+	    (!armv8pmu_event_want_user_access(event) ||
+	     armv8pmu_has_long_event(armpmu) || (hw_event_id == ARMV8_PMUV3_PERFCTR_CPU_CYCLES)))
 		event->hw.flags |= ARMPMU_EVT_64BIT;
 
+	/* Userspace counter access only enabled if requested and a per task event */
+	if (sysctl_perf_user_access && armv8pmu_event_want_user_access(event) && event->hw.target)
+		event->hw.flags |= PERF_EVENT_FLAG_USER_READ_CNT;
+
 	/* Only expose micro/arch events supported by this PMU */
 	if ((hw_event_id > 0) && (hw_event_id < ARMV8_PMUV3_MAX_COMMON_EVENTS)
 	    && test_bit(hw_event_id, armpmu->pmceid_bitmap)) {
@@ -1142,6 +1247,10 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
 	cpu_pmu->set_event_filter	= armv8pmu_set_event_filter;
 	cpu_pmu->filter_match		= armv8pmu_filter_match;
 
+	cpu_pmu->pmu.event_idx		= armv8pmu_access_event_idx;
+	cpu_pmu->pmu.event_mapped	= armv8pmu_event_mapped;
+	cpu_pmu->pmu.event_unmapped	= armv8pmu_event_unmapped;
+
 	cpu_pmu->name			= name;
 	cpu_pmu->map_event		= map_event;
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = events ?
@@ -1318,6 +1427,18 @@ void arch_perf_update_userpage(struct perf_event *event,
 	userpg->cap_user_time = 0;
 	userpg->cap_user_time_zero = 0;
 	userpg->cap_user_time_short = 0;
+	userpg->cap_user_rdpmc = !!userpg->index;
+
+	if (userpg->cap_user_rdpmc) {
+		struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
+
+		if (armv8pmu_event_is_64bit(event) &&
+		    (armv8pmu_has_long_event(cpu_pmu) ||
+		     (userpg->index == ARMV8_IDX_CYCLE_COUNTER_USER)))
+			userpg->pmc_width = 64;
+		else
+			userpg->pmc_width = 32;
+	}
 
 	do {
 		rd = sched_clock_read_begin(&seq);
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 505480217cf1..46f09c8d7e9a 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -54,6 +54,12 @@ struct pmu_hw_events {
 	 */
 	DECLARE_BITMAP(used_mask, ARMPMU_MAX_HWEVENTS);
 
+	/*
+	 * A 1 bit for an index indicates that the counter has been used for
+	 * an event and has not been cleared.
+	 */
+	DECLARE_BITMAP(dirty_mask, ARMPMU_MAX_HWEVENTS);
+
 	/*
 	 * Hardware lock to serialize accesses to PMU registers. Needed for the
 	 * read/modify/write sequences.
-- 
2.30.2


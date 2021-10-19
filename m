Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD804C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Oct 2021 23:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AFA26115A
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Oct 2021 23:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhJSXV3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 19 Oct 2021 19:21:29 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:34571 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbhJSXV2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 19 Oct 2021 19:21:28 -0400
Received: by mail-ot1-f53.google.com with SMTP id g62-20020a9d2dc4000000b0054752cfbc59so3993494otb.1;
        Tue, 19 Oct 2021 16:19:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HNEM7+5UcJvZL38axZ3E7memlwTEA9i6NOnHAXw00t8=;
        b=2t81ZUrKfBdzd60vmJETkwyURrX1r5DAPggxL7k9camqNr3LFvgISkAPZBZbDAB0l+
         0Ret+3OkbWreXLkrn03+vYXRmjXpk9em5KNOkfHVcegt5aXuOH5dGuajeIP878IwIHU/
         MhsTODfz+bMYzm32R8exznu/JnxKdUYH6xdI1TUeoGor+eG+hTovRr3IeW4taZdKz/Fm
         mhKrAzywq23dKV1w6m37P+MBZovUPHudu4FDPFuEHTWV7ZTQjVKJUjVzm5R02o3i/Hpq
         YSwufBHR8V+Eu4oCyUP5jXiCqD3rcVmq8aY7RC6TlndKtFp/c2mICNBIS8PWf9aCPcGf
         q1jA==
X-Gm-Message-State: AOAM532rsdvt2tOWS1dRt7GX8LMODRhvSnBYREEm8a+j957RO30wE+0m
        AjOmDBpOwE4ko8ChDWN93g==
X-Google-Smtp-Source: ABdhPJxymncZwslRuNkidKsgzYqwAKEo8GQB1bum4k6YuqUvYEPRrEMCzMDbD5t/dBvBzXtroHcslw==
X-Received: by 2002:a05:6830:4426:: with SMTP id q38mr7767207otv.303.1634685554517;
        Tue, 19 Oct 2021 16:19:14 -0700 (PDT)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id w141sm118375oif.20.2021.10.19.16.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 16:19:13 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Vince Weaver <vincent.weaver@maine.edu>,
        honnappa.nagarahalli@arm.com, Zachary.Leaf@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH v11 4/5] arm64: perf: Enable PMU counter userspace access for perf event
Date:   Tue, 19 Oct 2021 18:19:06 -0500
Message-Id: <20211019231907.1009567-5-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211019231907.1009567-1-robh@kernel.org>
References: <20211019231907.1009567-1-robh@kernel.org>
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

PMU EL0 access will be enabled when an event with userspace access is
part of the thread's context. This includes when the event is not
scheduled on the PMU. There's some additional overhead clearing
dirty counters when access is enabled in order to prevent leaking
disabled counter data from other tasks.

Unlike x86, enabling of userspace access must be requested with a new
attr bit: config1:1. If the user requests userspace access with 64-bit
counters, then the event open will fail if the h/w doesn't support
64-bit counters. Chaining is not supported with userspace access. The
modes for config1 are as follows:

config1 = 0 : user access disabled and always 32-bit
config1 = 1 : user access disabled and always 64-bit (using chaining if needed)
config1 = 2 : user access enabled and always 32-bit
config1 = 3 : user access enabled and always 64-bit

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
v11:
 - Add and use armv8pmu_event_has_user_read() helper
 - s/armv8pmu_access_event_idx/armv8pmu_user_event_idx/
 - Return error for user access when not a task bound event or no
   64-bit counters when requested.
 - Move custom sysctl handler function from prior patch to here

v10:
 - Don't control enabling user access based on mmap(). Changing the
   event_(un)mapped to run on the event's cpu doesn't work for x86.
   Triggering on mmap() doesn't limit access in any way and complicates
   the implementation.
 - Drop dirty counter tracking and just clear all unused counters.
 - Make the sysctl immediately disable access via IPI.
 - Merge armv8pmu_event_is_chained() and armv8pmu_event_can_chain()

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
 arch/arm64/kernel/perf_event.c | 117 +++++++++++++++++++++++++++++++--
 1 file changed, 110 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 6ae20c4217af..c11f08e4eeb6 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -285,6 +285,7 @@ static const struct attribute_group armv8_pmuv3_events_attr_group = {
 
 PMU_FORMAT_ATTR(event, "config:0-15");
 PMU_FORMAT_ATTR(long, "config1:0");
+PMU_FORMAT_ATTR(rdpmc, "config1:1");
 
 static int sysctl_perf_user_access __read_mostly;
 
@@ -293,9 +294,15 @@ static inline bool armv8pmu_event_is_64bit(struct perf_event *event)
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
 
@@ -364,7 +371,7 @@ static const struct attribute_group armv8_pmuv3_caps_attr_group = {
  */
 #define	ARMV8_IDX_CYCLE_COUNTER	0
 #define	ARMV8_IDX_COUNTER0	1
-
+#define	ARMV8_IDX_CYCLE_COUNTER_USER	32
 
 /*
  * We unconditionally enable ARMv8.5-PMU long event counter support
@@ -376,18 +383,22 @@ static bool armv8pmu_has_long_event(struct arm_pmu *cpu_pmu)
 	return (cpu_pmu->pmuver >= ID_AA64DFR0_PMUVER_8_5);
 }
 
+static inline bool armv8pmu_event_has_user_read(struct perf_event *event)
+{
+	return event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT;
+}
+
 /*
  * We must chain two programmable counters for 64 bit events,
  * except when we have allocated the 64bit cycle counter (for CPU
- * cycles event). This must be called only when the event has
- * a counter allocated.
+ * cycles event) or when user space counter access is enabled.
  */
 static inline bool armv8pmu_event_is_chained(struct perf_event *event)
 {
 	int idx = event->hw.idx;
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 
-	return !WARN_ON(idx < 0) &&
+	return !armv8pmu_event_has_user_read(event) &&
 	       armv8pmu_event_is_64bit(event) &&
 	       !armv8pmu_has_long_event(cpu_pmu) &&
 	       (idx != ARMV8_IDX_CYCLE_COUNTER);
@@ -720,6 +731,27 @@ static inline u32 armv8pmu_getreset_flags(void)
 	return value;
 }
 
+static void armv8pmu_disable_user_access(void)
+{
+	write_sysreg(0, pmuserenr_el0);
+}
+
+static void armv8pmu_enable_user_access(struct arm_pmu *cpu_pmu)
+{
+	int i;
+	struct pmu_hw_events *cpuc = this_cpu_ptr(cpu_pmu->hw_events);
+
+	/* Clear any unused counters to avoid leaking their contents */
+	for_each_clear_bit(i, cpuc->used_mask, cpu_pmu->num_events) {
+		if (i == ARMV8_IDX_CYCLE_COUNTER)
+			write_sysreg(0, pmccntr_el0);
+		else
+			armv8pmu_write_evcntr(i, 0);
+	}
+
+	write_sysreg(ARMV8_PMU_USERENR_ER | ARMV8_PMU_USERENR_CR, pmuserenr_el0);
+}
+
 static void armv8pmu_enable_event(struct perf_event *event)
 {
 	/*
@@ -763,6 +795,14 @@ static void armv8pmu_disable_event(struct perf_event *event)
 
 static void armv8pmu_start(struct arm_pmu *cpu_pmu)
 {
+	struct perf_event_context *task_ctx =
+		this_cpu_ptr(cpu_pmu->pmu.pmu_cpu_context)->task_ctx;
+
+	if (sysctl_perf_user_access && task_ctx && task_ctx->nr_user)
+		armv8pmu_enable_user_access(cpu_pmu);
+	else
+		armv8pmu_disable_user_access();
+
 	/* Enable all counters */
 	armv8pmu_pmcr_write(armv8pmu_pmcr_read() | ARMV8_PMU_PMCR_E);
 }
@@ -880,13 +920,16 @@ static int armv8pmu_get_event_idx(struct pmu_hw_events *cpuc,
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
+	if (armv8pmu_event_is_chained(event))
 		return	armv8pmu_get_chain_idx(cpuc, cpu_pmu);
 	else
 		return armv8pmu_get_single_idx(cpuc, cpu_pmu);
@@ -902,6 +945,22 @@ static void armv8pmu_clear_event_idx(struct pmu_hw_events *cpuc,
 		clear_bit(idx - 1, cpuc->used_mask);
 }
 
+static int armv8pmu_user_event_idx(struct perf_event *event)
+{
+	if (!sysctl_perf_user_access || !armv8pmu_event_has_user_read(event))
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
 /*
  * Add an event filter to a given event.
  */
@@ -998,6 +1057,24 @@ static int __armv8_pmuv3_map_event(struct perf_event *event,
 	if (armv8pmu_event_is_64bit(event))
 		event->hw.flags |= ARMPMU_EVT_64BIT;
 
+	/*
+	 * User events must be allocated into a single counter, and so
+	 * must not be chained.
+	 *
+	 * Most 64-bit events require long counter support, but 64-bit
+	 * CPU_CYCLES events can be placed into the dedicated cycle
+	 * counter when this is free.
+	 */
+	if (armv8pmu_event_want_user_access(event)) {
+		if ((armv8pmu_event_is_64bit(event) &&
+		     (hw_event_id != ARMV8_PMUV3_PERFCTR_CPU_CYCLES) &&
+		     !armv8pmu_has_long_event(armpmu)) ||
+		    !(event->attach_state & PERF_ATTACH_TASK))
+			return -EINVAL;
+
+		event->hw.flags |= PERF_EVENT_FLAG_USER_READ_CNT;
+	}
+
 	/* Only expose micro/arch events supported by this PMU */
 	if ((hw_event_id > 0) && (hw_event_id < ARMV8_PMUV3_MAX_COMMON_EVENTS)
 	    && test_bit(hw_event_id, armpmu->pmceid_bitmap)) {
@@ -1106,13 +1183,29 @@ static int armv8pmu_probe_pmu(struct arm_pmu *cpu_pmu)
 	return probe.present ? 0 : -ENODEV;
 }
 
+static void armv8pmu_disable_user_access_ipi(void *unused)
+{
+	armv8pmu_disable_user_access();
+}
+
+int armv8pmu_proc_user_access_handler(struct ctl_table *table, int write,
+                void *buffer, size_t *lenp, loff_t *ppos)
+{
+	int ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+	if (ret || !write || sysctl_perf_user_access)
+		return ret;
+
+	on_each_cpu(armv8pmu_disable_user_access_ipi, NULL, 1);
+	return 0;
+}
+
 static struct ctl_table armv8_pmu_sysctl_table[] = {
 	{
 		.procname       = "perf_user_access",
 		.data		= &sysctl_perf_user_access,
 		.maxlen		= sizeof(unsigned int),
 		.mode           = 0644,
-		.proc_handler	= proc_dointvec_minmax,
+		.proc_handler	= armv8pmu_proc_user_access_handler,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
@@ -1142,6 +1235,8 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
 	cpu_pmu->set_event_filter	= armv8pmu_set_event_filter;
 	cpu_pmu->filter_match		= armv8pmu_filter_match;
 
+	cpu_pmu->pmu.event_idx		= armv8pmu_user_event_idx;
+
 	cpu_pmu->name			= name;
 	cpu_pmu->map_event		= map_event;
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = events ?
@@ -1318,6 +1413,14 @@ void arch_perf_update_userpage(struct perf_event *event,
 	userpg->cap_user_time = 0;
 	userpg->cap_user_time_zero = 0;
 	userpg->cap_user_time_short = 0;
+	userpg->cap_user_rdpmc = armv8pmu_event_has_user_read(event);
+
+	if (userpg->cap_user_rdpmc) {
+		if (event->hw.flags & ARMPMU_EVT_64BIT)
+			userpg->pmc_width = 64;
+		else
+			userpg->pmc_width = 32;
+	}
 
 	do {
 		rd = sched_clock_read_begin(&seq);
-- 
2.32.0


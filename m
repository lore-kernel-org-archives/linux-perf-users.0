Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F55C48BCF
	for <linux-perf-users@archiver.kernel.org>; Wed,  9 Jun 2021 14:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F2F9613BC
	for <linux-perf-users@archiver.kernel.org>; Wed,  9 Jun 2021 14:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235587AbhFIOWb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 9 Jun 2021 10:22:31 -0400
Received: from mga09.intel.com ([134.134.136.24]:10581 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234688AbhFIOW1 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 9 Jun 2021 10:22:27 -0400
IronPort-SDR: hc4P2fKdaVkknrk3m/orhUulaEdAGvMfR6RL2ud82W4VwEIpuBJSs91wa068VfVmBVzzys6Wlh
 0vcw3jueLyBQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="205044724"
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="205044724"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 07:20:32 -0700
IronPort-SDR: ccrmQsG4oPgNJW2UtqWtXxTc97Bhea+hOxLnOO7l3AOs10HEHVZrVWHZ5uShnoxCUMMqUbBd7g
 1qR1rS1dodjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="482402685"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.79])
  by orsmga001.jf.intel.com with ESMTP; 09 Jun 2021 07:20:29 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] perf/x86: Add new event for AUX output counter index
Date:   Wed,  9 Jun 2021 17:20:53 +0300
Message-Id: <20210609142055.32226-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210609142055.32226-1-adrian.hunter@intel.com>
References: <20210609142055.32226-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

PEBS-via-PT records contain a mask of applicable counters. To identify
which event belongs to which counter, a side-band event is needed. Until
now, there has been no side-band event, and consequently users were limited
to using a single event.

Add such a side-band event. Note the event is optimised to output only
when the counter index changes for an event. That works only so long as
all PEBS-via-PT events are scheduled together, which they are for a
recording session because they are in a single group.

Also no attribute bit is used to select the new event, so a new
kernel is not compatible with older perf tools.  The assumption
being that PEBS-via-PT is sufficiently esoteric that users will not
be troubled by this.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/events/core.c          |  1 +
 arch/x86/events/intel/ds.c      | 16 ++++++++++++++++
 include/linux/perf_event.h      |  2 ++
 include/uapi/linux/perf_event.h | 15 +++++++++++++++
 kernel/events/core.c            | 30 ++++++++++++++++++++++++++++++
 5 files changed, 64 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 8f71dd72ef95..30d0d18eb4b6 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -660,6 +660,7 @@ static int __x86_pmu_event_init(struct perf_event *event)
 	event->destroy = hw_perf_event_destroy;
 
 	event->hw.idx = -1;
+	event->hw.idx_reported = -1;
 	event->hw.last_cpu = -1;
 	event->hw.last_tag = ~0ULL;
 
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 1ec8fd311f38..d4c149b6e82b 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1182,6 +1182,20 @@ static void intel_pmu_pebs_via_pt_disable(struct perf_event *event)
 		cpuc->pebs_enabled &= ~PEBS_VIA_PT_MASK;
 }
 
+static void intel_pmu_report_aux_output_id(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	/*
+	 * So long as all PEBS-via-PT events for a recording session are
+	 * scheduled together, then only changes to hwc->idx need be reported.
+	 */
+	if (hwc->idx != hwc->idx_reported) {
+		hwc->idx_reported = hwc->idx;
+		perf_report_aux_output_id(event, hwc->idx);
+	}
+}
+
 static void intel_pmu_pebs_via_pt_enable(struct perf_event *event)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -1191,6 +1205,8 @@ static void intel_pmu_pebs_via_pt_enable(struct perf_event *event)
 	if (!is_pebs_pt(event))
 		return;
 
+	intel_pmu_report_aux_output_id(event);
+
 	if (!(event->hw.flags & PERF_X86_EVENT_LARGE_PEBS))
 		cpuc->pebs_enabled |= PEBS_PMI_AFTER_EACH_RECORD;
 
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index f5a6a2f069ed..18bfa05537ab 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -141,6 +141,7 @@ struct hw_perf_event {
 			unsigned long	event_base;
 			int		event_base_rdpmc;
 			int		idx;
+			int		idx_reported;
 			int		last_cpu;
 			int		flags;
 
@@ -1397,6 +1398,7 @@ perf_event_addr_filters(struct perf_event *event)
 }
 
 extern void perf_event_addr_filters_sync(struct perf_event *event);
+extern void perf_report_aux_output_id(struct perf_event *event, u64 hw_id);
 
 extern int perf_output_begin(struct perf_output_handle *handle,
 			     struct perf_sample_data *data,
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index f92880a15645..c89535de1ec8 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1141,6 +1141,21 @@ enum perf_event_type {
 	 */
 	PERF_RECORD_TEXT_POKE			= 20,
 
+	/*
+	 * Data written to the AUX area by hardware due to aux_output, may need
+	 * to be matched to the event by an architecture-specific hardware ID.
+	 * This records the hardware ID, but requires sample_id to provide the
+	 * event ID. e.g. Intel PT uses this record to disambiguate PEBS-via-PT
+	 * records from multiple events.
+	 *
+	 * struct {
+	 *	struct perf_event_header	header;
+	 *	u64				hw_id;
+	 *	struct sample_id		sample_id;
+	 * };
+	 */
+	PERF_RECORD_AUX_OUTPUT_HW_ID		= 21,
+
 	PERF_RECORD_MAX,			/* non-ABI */
 };
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6fee4a7e88d7..bf98c8932ae2 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9055,6 +9055,36 @@ static void perf_log_itrace_start(struct perf_event *event)
 	perf_output_end(&handle);
 }
 
+void perf_report_aux_output_id(struct perf_event *event, u64 hw_id)
+{
+	struct perf_output_handle handle;
+	struct perf_sample_data sample;
+	struct perf_aux_event {
+		struct perf_event_header        header;
+		u64				hw_id;
+	} rec;
+	int ret;
+
+	if (event->parent)
+		event = event->parent;
+
+	rec.header.type	= PERF_RECORD_AUX_OUTPUT_HW_ID;
+	rec.header.misc	= 0;
+	rec.header.size	= sizeof(rec);
+	rec.hw_id	= hw_id;
+
+	perf_event_header__init_id(&rec.header, &sample, event);
+	ret = perf_output_begin(&handle, &sample, event, rec.header.size);
+
+	if (ret)
+		return;
+
+	perf_output_put(&handle, rec);
+	perf_event__output_id_sample(event, &handle, &sample);
+
+	perf_output_end(&handle);
+}
+
 static int
 __perf_event_account_interrupt(struct perf_event *event, int throttle)
 {
-- 
2.17.1


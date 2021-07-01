Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF91C11F64
	for <linux-perf-users@archiver.kernel.org>; Thu,  1 Jul 2021 13:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2553361410
	for <linux-perf-users@archiver.kernel.org>; Thu,  1 Jul 2021 13:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236732AbhGANTv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 1 Jul 2021 09:19:51 -0400
Received: from mga14.intel.com ([192.55.52.115]:9054 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236724AbhGANTv (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 1 Jul 2021 09:19:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10031"; a="208350658"
X-IronPort-AV: E=Sophos;i="5.83,314,1616482800"; 
   d="scan'208";a="208350658"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2021 06:17:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,314,1616482800"; 
   d="scan'208";a="493506034"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.79])
  by fmsmga002.fm.intel.com with ESMTP; 01 Jul 2021 06:17:17 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/3] perf/x86: Add new event for AUX output counter index
Date:   Thu,  1 Jul 2021 16:17:30 +0300
Message-Id: <20210701131732.31602-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210701131732.31602-1-adrian.hunter@intel.com>
References: <20210701131732.31602-1-adrian.hunter@intel.com>
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
---


Changes in V2:
	Use callback from x86_assign_hw_event


 arch/x86/events/core.c          |  6 ++++++
 arch/x86/events/intel/core.c    |  7 +++++++
 arch/x86/events/perf_event.h    |  1 +
 include/linux/perf_event.h      |  1 +
 include/uapi/linux/perf_event.h | 15 +++++++++++++++
 kernel/events/core.c            | 30 ++++++++++++++++++++++++++++++
 6 files changed, 60 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 8f71dd72ef95..3b71f54d26c7 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -66,6 +66,8 @@ DEFINE_STATIC_CALL_NULL(x86_pmu_enable_all,  *x86_pmu.enable_all);
 DEFINE_STATIC_CALL_NULL(x86_pmu_enable,	     *x86_pmu.enable);
 DEFINE_STATIC_CALL_NULL(x86_pmu_disable,     *x86_pmu.disable);
 
+DEFINE_STATIC_CALL_NULL(x86_pmu_assign, *x86_pmu.assign);
+
 DEFINE_STATIC_CALL_NULL(x86_pmu_add,  *x86_pmu.add);
 DEFINE_STATIC_CALL_NULL(x86_pmu_del,  *x86_pmu.del);
 DEFINE_STATIC_CALL_NULL(x86_pmu_read, *x86_pmu.read);
@@ -1217,6 +1219,8 @@ static inline void x86_assign_hw_event(struct perf_event *event,
 	hwc->last_cpu = smp_processor_id();
 	hwc->last_tag = ++cpuc->tags[i];
 
+	static_call_cond(x86_pmu_assign)(event, idx);
+
 	switch (hwc->idx) {
 	case INTEL_PMC_IDX_FIXED_BTS:
 	case INTEL_PMC_IDX_FIXED_VLBR:
@@ -2005,6 +2009,8 @@ static void x86_pmu_static_call_update(void)
 	static_call_update(x86_pmu_enable, x86_pmu.enable);
 	static_call_update(x86_pmu_disable, x86_pmu.disable);
 
+	static_call_update(x86_pmu_assign, x86_pmu.assign);
+
 	static_call_update(x86_pmu_add, x86_pmu.add);
 	static_call_update(x86_pmu_del, x86_pmu.del);
 	static_call_update(x86_pmu_read, x86_pmu.read);
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index e28892270c58..7a7c3b18acec 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2400,6 +2400,12 @@ static void intel_pmu_disable_event(struct perf_event *event)
 		intel_pmu_pebs_disable(event);
 }
 
+static void intel_pmu_assign_event(struct perf_event *event, int idx)
+{
+	if (is_pebs_pt(event))
+		perf_report_aux_output_id(event, idx);
+}
+
 static void intel_pmu_del_event(struct perf_event *event)
 {
 	if (needs_branch_stack(event))
@@ -4596,6 +4602,7 @@ static __initconst const struct x86_pmu intel_pmu = {
 	.enable_all		= intel_pmu_enable_all,
 	.enable			= intel_pmu_enable_event,
 	.disable		= intel_pmu_disable_event,
+	.assign			= intel_pmu_assign_event,
 	.add			= intel_pmu_add_event,
 	.del			= intel_pmu_del_event,
 	.read			= intel_pmu_read_event,
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index ad87cb36f7c8..0a13ca1aad61 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -711,6 +711,7 @@ struct x86_pmu {
 	void		(*enable_all)(int added);
 	void		(*enable)(struct perf_event *);
 	void		(*disable)(struct perf_event *);
+	void		(*assign)(struct perf_event *event, int idx);
 	void		(*add)(struct perf_event *);
 	void		(*del)(struct perf_event *);
 	void		(*read)(struct perf_event *event);
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index f5a6a2f069ed..4a25da3883c0 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1397,6 +1397,7 @@ perf_event_addr_filters(struct perf_event *event)
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
index 0ac818b3bea4..62e9838a32b1 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9053,6 +9053,36 @@ static void perf_log_itrace_start(struct perf_event *event)
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


Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1646CC11F65
	for <linux-perf-users@archiver.kernel.org>; Wed, 30 Jun 2021 09:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAD4361D0F
	for <linux-perf-users@archiver.kernel.org>; Wed, 30 Jun 2021 09:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbhF3JXX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 30 Jun 2021 05:23:23 -0400
Received: from mga07.intel.com ([134.134.136.100]:10722 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233653AbhF3JXW (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 30 Jun 2021 05:23:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10030"; a="272173514"
X-IronPort-AV: E=Sophos;i="5.83,311,1616482800"; 
   d="scan'208";a="272173514"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 02:20:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,311,1616482800"; 
   d="scan'208";a="419928542"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.79]) ([10.237.72.79])
  by fmsmga007.fm.intel.com with ESMTP; 30 Jun 2021 02:20:49 -0700
Subject: Re: [PATCH 1/3] perf/x86: Add new event for AUX output counter index
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210609142055.32226-1-adrian.hunter@intel.com>
 <20210609142055.32226-2-adrian.hunter@intel.com>
 <YNXW4+QqeO1KL4Xq@hirez.programming.kicks-ass.net>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <cc79fce0-2c92-dd55-fd50-46b28644f4fc@intel.com>
Date:   Wed, 30 Jun 2021 12:21:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNXW4+QqeO1KL4Xq@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 25/06/21 4:15 pm, Peter Zijlstra wrote:
> On Wed, Jun 09, 2021 at 05:20:53PM +0300, Adrian Hunter wrote:
> 
>> +static void intel_pmu_report_aux_output_id(struct perf_event *event)
>> +{
>> +	struct hw_perf_event *hwc = &event->hw;
>> +
>> +	/*
>> +	 * So long as all PEBS-via-PT events for a recording session are
>> +	 * scheduled together, then only changes to hwc->idx need be reported.
>> +	 */
>> +	if (hwc->idx != hwc->idx_reported) {
>> +		hwc->idx_reported = hwc->idx;
>> +		perf_report_aux_output_id(event, hwc->idx);
>> +	}
>> +}
> 
> AFAICT you want a callback in x86_assign_hw_event(), is that so?
> 

Yes, or open-coded e.g.

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 8f71dd72ef95..46dac45298d1 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1207,6 +1207,11 @@ static int collect_events(struct cpu_hw_events *cpuc, struct perf_event *leader,
 	return n;
 }
 
+static inline bool report_aux_output_id(struct perf_event *event)
+{
+	return is_pebs_pt(event);
+}
+
 static inline void x86_assign_hw_event(struct perf_event *event,
 				struct cpu_hw_events *cpuc, int i)
 {
@@ -1217,6 +1222,9 @@ static inline void x86_assign_hw_event(struct perf_event *event,
 	hwc->last_cpu = smp_processor_id();
 	hwc->last_tag = ++cpuc->tags[i];
 
+	if (report_aux_output_id(event))
+		perf_report_aux_output_id(event, idx);
+
 	switch (hwc->idx) {
 	case INTEL_PMC_IDX_FIXED_BTS:
 	case INTEL_PMC_IDX_FIXED_VLBR:

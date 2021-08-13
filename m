Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F2AC4338F
	for <linux-perf-users@archiver.kernel.org>; Fri, 13 Aug 2021 12:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C88CE60720
	for <linux-perf-users@archiver.kernel.org>; Fri, 13 Aug 2021 12:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbhHMMRP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:17:15 -0400
Received: from mga18.intel.com ([134.134.136.126]:24919 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229474AbhHMMRP (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 13 Aug 2021 08:17:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10074"; a="202710620"
X-IronPort-AV: E=Sophos;i="5.84,318,1620716400"; 
   d="scan'208";a="202710620"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2021 05:16:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,318,1620716400"; 
   d="scan'208";a="422851035"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by orsmga003.jf.intel.com with ESMTP; 13 Aug 2021 05:16:45 -0700
Subject: Re: [PATCH V2 1/3] perf/x86: Add new event for AUX output counter
 index
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210701131732.31602-1-adrian.hunter@intel.com>
 <20210701131732.31602-2-adrian.hunter@intel.com>
 <YOKzkPQ5gAeLUTnY@hirez.programming.kicks-ass.net>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <52e21dcc-3b0d-3c87-deb4-18ead45fed24@intel.com>
Date:   Fri, 13 Aug 2021 15:17:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YOKzkPQ5gAeLUTnY@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 5/07/21 10:24 am, Peter Zijlstra wrote:
> On Thu, Jul 01, 2021 at 04:17:30PM +0300, Adrian Hunter wrote:
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index e28892270c58..7a7c3b18acec 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -2400,6 +2400,12 @@ static void intel_pmu_disable_event(struct perf_event *event)
>>  		intel_pmu_pebs_disable(event);
>>  }
>>  
>> +static void intel_pmu_assign_event(struct perf_event *event, int idx)
>> +{
>> +	if (is_pebs_pt(event))
>> +		perf_report_aux_output_id(event, idx);
>> +}
>> +
>>  static void intel_pmu_del_event(struct perf_event *event)
>>  {
>>  	if (needs_branch_stack(event))
>> @@ -4596,6 +4602,7 @@ static __initconst const struct x86_pmu intel_pmu = {
>>  	.enable_all		= intel_pmu_enable_all,
>>  	.enable			= intel_pmu_enable_event,
>>  	.disable		= intel_pmu_disable_event,
>> +	.assign			= intel_pmu_assign_event,
>>  	.add			= intel_pmu_add_event,
>>  	.del			= intel_pmu_del_event,
>>  	.read			= intel_pmu_read_event,
> 
> How about we only set that method (or clear it again) when
> intel_cap.pebs_output_pt_available ?

I've finally got back to this, but now, in the case of hybrids,
there seems to be more than one intel_cap.pebs_output_pt_available.
Any suggestions?

> 
> Other than that, this looks good to me.
> 


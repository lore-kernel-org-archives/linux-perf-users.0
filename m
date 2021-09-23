Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32634C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Sep 2021 18:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19C3460EDF
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Sep 2021 18:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbhIWSaX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 23 Sep 2021 14:30:23 -0400
Received: from mga07.intel.com ([134.134.136.100]:18636 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242725AbhIWSaW (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Sep 2021 14:30:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="287585042"
X-IronPort-AV: E=Sophos;i="5.85,317,1624345200"; 
   d="scan'208";a="287585042"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 11:28:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,317,1624345200"; 
   d="scan'208";a="558646546"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.84]) ([10.237.72.84])
  by fmsmga002.fm.intel.com with ESMTP; 23 Sep 2021 11:28:46 -0700
Subject: Re: [PATCH V3 1/3] perf/x86: Add new event for AUX output counter
 index
To:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210907163903.11820-1-adrian.hunter@intel.com>
 <20210907163903.11820-2-adrian.hunter@intel.com>
 <ab6f9ec2-2571-de5a-d44a-427851b08d19@linux.intel.com>
 <20210910160409.GI4323@worktop.programming.kicks-ass.net>
 <453b9364-c350-79ca-00fa-b9e6ed6e3367@linux.intel.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <9da4ae5e-3e0e-180e-5bba-1351c08d7df9@intel.com>
Date:   Thu, 23 Sep 2021 21:29:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <453b9364-c350-79ca-00fa-b9e6ed6e3367@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 10/09/21 7:29 pm, Liang, Kan wrote:
> 
> 
> On 9/10/2021 12:04 PM, Peter Zijlstra wrote:
>> On Tue, Sep 07, 2021 at 01:45:22PM -0400, Liang, Kan wrote:
>>> On 9/7/2021 12:39 PM, Adrian Hunter wrote:
>>
>>>> @@ -4494,8 +4500,16 @@ static int intel_pmu_check_period(struct perf_event *event, u64 value)
>>>>        return intel_pmu_has_bts_period(event, value) ? -EINVAL : 0;
>>>>    }
>>>> +static void intel_aux_output_init(void)
>>>> +{
>>>> +    /* Refer also intel_pmu_aux_output_match() */
>>>> +    if (x86_pmu.intel_cap.pebs_output_pt_available)
>>>> +        x86_pmu.assign = intel_pmu_assign_event;
>>>> +}
>>>
>>> For a hybrid machine, x86_pmu.intel_cap.pebs_output_pt_available is always
>>> cleared. We probably need the PMU specific
>>> pmu->intel_cap.pebs_output_pt_available here.
>>>
>>>> +
>>>>    static int intel_pmu_aux_output_match(struct perf_event *event)
>>>>    {
>>>> +    /* intel_pmu_assign_event() is needed, refer intel_aux_output_init() */
>>>>        if (!x86_pmu.intel_cap.pebs_output_pt_available)
>>>>            return 0;
>>>>
>>>
>>> For a hybrid machine, this always return 0. I think we need to fix it first?
>>
>> AFAICT the patch is correct for !hybrid, and the hybrid PT muck can then
>> also fix this up, right?
>>
> 
> Yes, for !hybrid, the patch is good.
> 
> Since PEBS via PT is temporarily disabled for hybrid for now, the patch set should not bring any issues with hybrid either.
> The hybrid PT can be fixed separately.

I don't have much time to look at the hybrid case right now.

Would it be OK to go ahead with these patches?

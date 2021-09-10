Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA278C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Sep 2021 16:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEC94611AD
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Sep 2021 16:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbhIJQaW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 10 Sep 2021 12:30:22 -0400
Received: from mga02.intel.com ([134.134.136.20]:33493 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229543AbhIJQaU (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 10 Sep 2021 12:30:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10103"; a="208349032"
X-IronPort-AV: E=Sophos;i="5.85,283,1624345200"; 
   d="scan'208";a="208349032"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2021 09:29:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,283,1624345200"; 
   d="scan'208";a="694915605"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 10 Sep 2021 09:29:08 -0700
Received: from [10.209.0.27] (kliang2-MOBL.ccr.corp.intel.com [10.209.0.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 908D6580833;
        Fri, 10 Sep 2021 09:29:07 -0700 (PDT)
Subject: Re: [PATCH V3 1/3] perf/x86: Add new event for AUX output counter
 index
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
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
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <453b9364-c350-79ca-00fa-b9e6ed6e3367@linux.intel.com>
Date:   Fri, 10 Sep 2021 12:29:06 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210910160409.GI4323@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 9/10/2021 12:04 PM, Peter Zijlstra wrote:
> On Tue, Sep 07, 2021 at 01:45:22PM -0400, Liang, Kan wrote:
>> On 9/7/2021 12:39 PM, Adrian Hunter wrote:
> 
>>> @@ -4494,8 +4500,16 @@ static int intel_pmu_check_period(struct perf_event *event, u64 value)
>>>    	return intel_pmu_has_bts_period(event, value) ? -EINVAL : 0;
>>>    }
>>> +static void intel_aux_output_init(void)
>>> +{
>>> +	/* Refer also intel_pmu_aux_output_match() */
>>> +	if (x86_pmu.intel_cap.pebs_output_pt_available)
>>> +		x86_pmu.assign = intel_pmu_assign_event;
>>> +}
>>
>> For a hybrid machine, x86_pmu.intel_cap.pebs_output_pt_available is always
>> cleared. We probably need the PMU specific
>> pmu->intel_cap.pebs_output_pt_available here.
>>
>>> +
>>>    static int intel_pmu_aux_output_match(struct perf_event *event)
>>>    {
>>> +	/* intel_pmu_assign_event() is needed, refer intel_aux_output_init() */
>>>    	if (!x86_pmu.intel_cap.pebs_output_pt_available)
>>>    		return 0;
>>>
>>
>> For a hybrid machine, this always return 0. I think we need to fix it first?
> 
> AFAICT the patch is correct for !hybrid, and the hybrid PT muck can then
> also fix this up, right?
> 

Yes, for !hybrid, the patch is good.

Since PEBS via PT is temporarily disabled for hybrid for now, the patch 
set should not bring any issues with hybrid either.
The hybrid PT can be fixed separately.

Thanks,
Kan

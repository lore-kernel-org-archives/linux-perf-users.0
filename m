Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDBEC433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Sep 2021 19:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 469626124D
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Sep 2021 19:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242823AbhIWTYY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 23 Sep 2021 15:24:24 -0400
Received: from mga02.intel.com ([134.134.136.20]:57136 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242796AbhIWTYX (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Sep 2021 15:24:23 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="211165389"
X-IronPort-AV: E=Sophos;i="5.85,317,1624345200"; 
   d="scan'208";a="211165389"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 12:22:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,317,1624345200"; 
   d="scan'208";a="474957125"
Received: from um.fi.intel.com (HELO um) ([10.237.72.62])
  by orsmga007.jf.intel.com with ESMTP; 23 Sep 2021 12:22:48 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com
Subject: Re: [PATCH V3 1/3] perf/x86: Add new event for AUX output counter
 index
In-Reply-To: <9da4ae5e-3e0e-180e-5bba-1351c08d7df9@intel.com>
References: <20210907163903.11820-1-adrian.hunter@intel.com>
 <20210907163903.11820-2-adrian.hunter@intel.com>
 <ab6f9ec2-2571-de5a-d44a-427851b08d19@linux.intel.com>
 <20210910160409.GI4323@worktop.programming.kicks-ass.net>
 <453b9364-c350-79ca-00fa-b9e6ed6e3367@linux.intel.com>
 <9da4ae5e-3e0e-180e-5bba-1351c08d7df9@intel.com>
Date:   Thu, 23 Sep 2021 22:22:47 +0300
Message-ID: <87k0j7hzaw.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Adrian Hunter <adrian.hunter@intel.com> writes:

> On 10/09/21 7:29 pm, Liang, Kan wrote:
>> 
>> 
>> On 9/10/2021 12:04 PM, Peter Zijlstra wrote:
>>> On Tue, Sep 07, 2021 at 01:45:22PM -0400, Liang, Kan wrote:
>>>> On 9/7/2021 12:39 PM, Adrian Hunter wrote:
>>>
>>>>> @@ -4494,8 +4500,16 @@ static int intel_pmu_check_period(struct perf_event *event, u64 value)
>>>>>        return intel_pmu_has_bts_period(event, value) ? -EINVAL : 0;
>>>>>    }
>>>>> +static void intel_aux_output_init(void)
>>>>> +{
>>>>> +    /* Refer also intel_pmu_aux_output_match() */
>>>>> +    if (x86_pmu.intel_cap.pebs_output_pt_available)
>>>>> +        x86_pmu.assign = intel_pmu_assign_event;
>>>>> +}
>>>>
>>>> For a hybrid machine, x86_pmu.intel_cap.pebs_output_pt_available is always
>>>> cleared. We probably need the PMU specific
>>>> pmu->intel_cap.pebs_output_pt_available here.
>>>>
>>>>> +
>>>>>    static int intel_pmu_aux_output_match(struct perf_event *event)
>>>>>    {
>>>>> +    /* intel_pmu_assign_event() is needed, refer intel_aux_output_init() */
>>>>>        if (!x86_pmu.intel_cap.pebs_output_pt_available)
>>>>>            return 0;
>>>>>
>>>>
>>>> For a hybrid machine, this always return 0. I think we need to fix it first?
>>>
>>> AFAICT the patch is correct for !hybrid, and the hybrid PT muck can then
>>> also fix this up, right?
>>>
>> 
>> Yes, for !hybrid, the patch is good.
>> 
>> Since PEBS via PT is temporarily disabled for hybrid for now, the patch set should not bring any issues with hybrid either.
>> The hybrid PT can be fixed separately.
>
> I don't have much time to look at the hybrid case right now.
>
> Would it be OK to go ahead with these patches?

I'll deal with the PEBS-via-PT on hybrid. As it stands right now, this
patchset is good.

Regards,
--
Alex

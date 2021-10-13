Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0422C4332F
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Oct 2021 09:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CC9B60524
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Oct 2021 09:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239022AbhJMJO7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Oct 2021 05:14:59 -0400
Received: from mga02.intel.com ([134.134.136.20]:25033 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239008AbhJMJO7 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Oct 2021 05:14:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="214537144"
X-IronPort-AV: E=Sophos;i="5.85,370,1624345200"; 
   d="scan'208";a="214537144"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 02:12:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,370,1624345200"; 
   d="scan'208";a="570770415"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by fmsmga002.fm.intel.com with ESMTP; 13 Oct 2021 02:12:49 -0700
Subject: Re: [PATCH V3 1/3] perf/x86: Add new event for AUX output counter
 index
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210907163903.11820-1-adrian.hunter@intel.com>
 <20210907163903.11820-2-adrian.hunter@intel.com>
 <ab6f9ec2-2571-de5a-d44a-427851b08d19@linux.intel.com>
 <20210910160409.GI4323@worktop.programming.kicks-ass.net>
 <453b9364-c350-79ca-00fa-b9e6ed6e3367@linux.intel.com>
 <9da4ae5e-3e0e-180e-5bba-1351c08d7df9@intel.com>
 <87k0j7hzaw.fsf@ashishki-desk.ger.corp.intel.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <3211feb9-b8e3-21fc-958c-07c7c7766bf2@intel.com>
Date:   Wed, 13 Oct 2021 12:12:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87k0j7hzaw.fsf@ashishki-desk.ger.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 23/09/2021 22:22, Alexander Shishkin wrote:
> Adrian Hunter <adrian.hunter@intel.com> writes:
> 
>> On 10/09/21 7:29 pm, Liang, Kan wrote:
>>>
>>>
>>> On 9/10/2021 12:04 PM, Peter Zijlstra wrote:
>>>> On Tue, Sep 07, 2021 at 01:45:22PM -0400, Liang, Kan wrote:
>>>>> On 9/7/2021 12:39 PM, Adrian Hunter wrote:
>>>>
>>>>>> @@ -4494,8 +4500,16 @@ static int intel_pmu_check_period(struct perf_event *event, u64 value)
>>>>>>        return intel_pmu_has_bts_period(event, value) ? -EINVAL : 0;
>>>>>>    }
>>>>>> +static void intel_aux_output_init(void)
>>>>>> +{
>>>>>> +    /* Refer also intel_pmu_aux_output_match() */
>>>>>> +    if (x86_pmu.intel_cap.pebs_output_pt_available)
>>>>>> +        x86_pmu.assign = intel_pmu_assign_event;
>>>>>> +}
>>>>>
>>>>> For a hybrid machine, x86_pmu.intel_cap.pebs_output_pt_available is always
>>>>> cleared. We probably need the PMU specific
>>>>> pmu->intel_cap.pebs_output_pt_available here.
>>>>>
>>>>>> +
>>>>>>    static int intel_pmu_aux_output_match(struct perf_event *event)
>>>>>>    {
>>>>>> +    /* intel_pmu_assign_event() is needed, refer intel_aux_output_init() */
>>>>>>        if (!x86_pmu.intel_cap.pebs_output_pt_available)
>>>>>>            return 0;
>>>>>>
>>>>>
>>>>> For a hybrid machine, this always return 0. I think we need to fix it first?
>>>>
>>>> AFAICT the patch is correct for !hybrid, and the hybrid PT muck can then
>>>> also fix this up, right?
>>>>
>>>
>>> Yes, for !hybrid, the patch is good.
>>>
>>> Since PEBS via PT is temporarily disabled for hybrid for now, the patch set should not bring any issues with hybrid either.
>>> The hybrid PT can be fixed separately.
>>
>> I don't have much time to look at the hybrid case right now.
>>
>> Would it be OK to go ahead with these patches?
> 
> I'll deal with the PEBS-via-PT on hybrid. As it stands right now, this
> patchset is good.

Will anyone takes these patches?  Perhaps Arnaldo if no one objects?
The patches still seem to apply cleanly.

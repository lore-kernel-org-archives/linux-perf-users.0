Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B6016B3BC;
	Tue,  6 Aug 2024 21:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722981095; cv=none; b=EFH61BJ9qDKAYXHcPnAy46Mt05J0dR1lR5rVJKAbOQFJ3ZLZRxBDHOgZy3jkc/dSzqLxPWt1H8vTQruUNN+m9iPprS6+7mr77wcvY9hVkKHkP5eOek3TabNzvgk3yx/TIGtvm9lWpYOtKBa8iUnvkWD7yp+ApUK7IFKI8nztIrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722981095; c=relaxed/simple;
	bh=bmdgDGfW+GT5eXL6q9v/l5/DCvJLYrbDkb1NP9lnuIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JiLOmsY24sIZNF10CfS9MgrBNdx5W4NtXdp2eNJV/jq3aLeS/9cmP27+JMxI2dadkqSZ8BmNFRUr6bZ0SDO6tfOjDN15/8+UsAWP6HoGGQEnzwTO37R6lbbKgTSrUATmm7Vsc+cS1VX17mNSa2T9a+CFi5wbbIQyttGNjEyNYwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 255DE1063;
	Tue,  6 Aug 2024 14:51:58 -0700 (PDT)
Received: from [10.57.79.15] (unknown [10.57.79.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3EAF3F6A8;
	Tue,  6 Aug 2024 14:51:30 -0700 (PDT)
Message-ID: <4d4bafc0-161c-4195-b177-c06d386a42be@arm.com>
Date: Tue, 6 Aug 2024 22:51:38 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] perf/core: Allow multiple AUX PMU events with the
 same module
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240806204813.722372-1-leo.yan@arm.com>
 <20240806204813.722372-2-leo.yan@arm.com>
 <20240806211439.GB37996@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <20240806211439.GB37996@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/6/2024 10:14 PM, Peter Zijlstra wrote:
> On Tue, Aug 06, 2024 at 09:48:09PM +0100, Leo Yan wrote:
>> This commit changes the condition from checking the same PMU instance to
>> checking the same PMU driver module. This allows support for multiple
>> PMU events with the same driver module.
>>
>> As a result, more than one AUX event (e.g. arm_spe_0 and arm_spe_1) can
>> record trace into the AUX ring buffer.
>>
>> Signed-off-by: Leo Yan <leo.yan@arm.com>
>> ---
>>  kernel/events/core.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index aa3450bdc227..fdb8918e62a0 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -12344,9 +12344,10 @@ perf_event_set_output(struct perf_event *event, struct perf_event *output_event)
>>
>>       /*
>>        * If both events generate aux data, they must be on the same PMU
>> +      * module but can be with different PMU instances.
>>        */
>>       if (has_aux(event) && has_aux(output_event) &&
>> -         event->pmu != output_event->pmu)
>> +         event->pmu->module != output_event->pmu->module)
> 
> A very quick look at: arch/x86/events/intel/pt.c seems to suggest that
> doesn't set pmu->module. Which seems to suggest the above won't work for
> us.

Seems Intel PT and BTS drivers both do not set the pmu->module.

Either we assign the pmu->module for both drivers, or we can update this patch
like below:

        if (has_aux(event) && has_aux(output_event)) {
            /*
             * No idea the module for the PMU is pmu->module is NULL,
             * do not allow tracing for these two AUX event.
             */
            if (!event->pmu->module || !output_event->pmu->module)
                goto out;

            /*
             * Don't allow generate AUX trace data if PMUs don't come from
             * the same module.
             */
            if (event->pmu->module != output_event->pmu->module)
                goto out;
        }

How about you think?  Thanks for review!

Leo

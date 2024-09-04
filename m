Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BDF84A27;
	Wed,  4 Sep 2024 19:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725478575; cv=none; b=hc0M+nmElwGpKW5kGUjhroeBrHOUwb/BEz917htL0PLnwDcX98dnFKu9b8bHfr2cQOAzox9Q2ZUD2NDeNpXgmEmDdvDiIWqf5WFHxT6TZHCWi/5MKwm8lmBFqV1XATl6KgUdYsI7QsaZOlT3y54x98WDyy9hx1w+EVPLCuTtfLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725478575; c=relaxed/simple;
	bh=V8H9h4D/vsbMRsslKFibMKC/nC5ZrOYPvFPXzzeUJPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fe7Etg5626W4xw5gy5fGhvsKpI9PqXmtXXA10CflzTs7xeYZG2KBGLPbwd+vAvkRmpAslSCT3zrZCj2jsysuK8niNypQHrXEY3rsDp7+MydPRi4JEd9yg8vizBWCc7OH+L9brhCIsKAoqavNWU5CLQhCe9zS7SR5O9v0KU9MNuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2F95FEC;
	Wed,  4 Sep 2024 12:36:37 -0700 (PDT)
Received: from [10.57.81.194] (unknown [10.57.81.194])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBAC93F73B;
	Wed,  4 Sep 2024 12:36:08 -0700 (PDT)
Message-ID: <adfbd1ba-62ca-49c9-893a-3c10780ee186@arm.com>
Date: Wed, 4 Sep 2024 20:35:58 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/8] perf/core: Allow multiple AUX PMU events with the
 same module
To: Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Yicong Yang <yangyicong@hisilicon.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
References: <20240823113306.2310957-1-leo.yan@arm.com>
 <20240823113306.2310957-2-leo.yan@arm.com>
 <70a58dca-01dc-408b-a2f7-a854718a405b@intel.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <70a58dca-01dc-408b-a2f7-a854718a405b@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/2024 11:06 AM, Adrian Hunter wrote:
>> @@ -12345,9 +12345,16 @@ perf_event_set_output(struct perf_event *event, struct perf_event *output_event)
>>
>>       /*
>>        * If both events generate aux data, they must be on the same PMU
>> +      * module but can be with different PMU instances.
>> +      *
>> +      * For a built-in PMU module, the 'pmu->module' pointer is NULL,
>> +      * thus it is not feasible to compare the module pointers when
>> +      * AUX PMU drivers are built into the kernel image. Instead,
>> +      * comparing the .setup_aux() callback pointer can determine if
>> +      * the two PMU events come from the same PMU driver.
>>        */
>>       if (has_aux(event) && has_aux(output_event) &&
>> -         event->pmu != output_event->pmu)
>> +         event->pmu->setup_aux != output_event->pmu->setup_aux)
> 
> It is not very flexible and risks someone adding aux PMUs that
> do not want that rule but accidentally support it.  Another
> option is to add a PMU callback, but really you need to Peter's
> feedback.

Thanks a lot for sharing opinion, Adrian!

How about below code? An alternative way is to compare the PMU's parent
device driver, e.g. for Arm SPE PMU events, this can compare if two PMU
events are using the Arm SPE driver.

/*
 * If both events generate aux data, they must be on the same PMU
 * module but can be with different PMU instances.
 */
if (has_aux(event) && has_aux(output_event)) {
        /* It isn't allowed if it fails to find driver pointer */
        if (!event->pmu->parent || !event->pmu->parent->driver)
                goto out;

        if (!output_event->pmu->parent || !output_event->pmu->parent->driver)
                goto out;

        /*
         * It isn't allowed if aux events are not same type of PMU
         * device. This is determined by comparing the associated
         * driver pointers.
         */
        if (event->pmu->parent->driver != output_event->pmu->parent->driver)
                goto out;
}

I verified the code above, it also works well at my side.

@Peter.Z, Please let me know if this is okay for you.

Thanks,
Leo

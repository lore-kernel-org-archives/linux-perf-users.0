Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30388D512;
	Mon, 22 Jul 2024 14:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721658965; cv=none; b=K+QgVZL2KqmaguaXRwKi25ATzQaYAkP2u29JHaJFbajwkm0vycAqFvlRAcawqiacfICgz+iAUOE1uQKxaiDBbt4u3iBUxAtJD7OcdEJZYowl4wp2eG54dtsk5iv9HRjA36MQQddjty1Dt48C/xkEVfBmvOV3+oxsHw6UiD0+/KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721658965; c=relaxed/simple;
	bh=BpVyv/M3UGBgS/ElQfopI9P8wU/5L91obliX6RnpKpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=b4O4cuViA1SiMYy/vPIaQJNF+60WY0y8VIkbXNrDMpv9GdlU5/pb74APLKQfMaUBxy80Y4VdRKswYq9Axy/Il//RPGsPTzKtge5TKUX3sev1BmaOH/CA8C7/qo4ANLvf1sQTaGP57v6hFg/Sx7M0n9rgZ2nGJHvuB5Ancegyuvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27429FEC;
	Mon, 22 Jul 2024 07:36:29 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 96D233F73F;
	Mon, 22 Jul 2024 07:36:01 -0700 (PDT)
Message-ID: <e5bddf8b-931a-46fc-8461-7fce939e1445@arm.com>
Date: Mon, 22 Jul 2024 15:36:00 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/6] perf auxtrace arm: Set the 'auxtrace' flag for AUX
 events
To: Adrian Hunter <adrian.hunter@intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 James Clark <james.clark@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240721202113.380750-1-leo.yan@arm.com>
 <20240721202113.380750-3-leo.yan@arm.com>
 <785cf263-5a76-48d8-964b-c248297de47e@intel.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <785cf263-5a76-48d8-964b-c248297de47e@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/22/24 11:49, Adrian Hunter wrote:
> On 21/07/24 23:21, Leo Yan wrote:
>> Originally, the 'auxtrace' flag in the PMU event is used for AUX area
>> sampling. It indicates a PMU event is for AUX tracing.
>>
>> Set this flag for AUX trace events on Arm.
>>
>> Signed-off-by: Leo Yan <leo.yan@arm.com>
> 
> Note same as:
> 
> https://eur03.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2F20240715160712.127117-6-adrian.hunter%40intel.com%2F&data=05%7C02%7Cleo.yan%40arm.com%7C909e738ccfd84b1ad1dc08dcaa3bf922%7Cf34e597957d94aaaad4db122a662184d%7C0%7C0%7C638572421778104310%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=rJq9SLjbFOrZRkWIGLj8Xj682h%2BW%2FD8O0IL3ac0UcO4%3D&reserved=0
> 
> Either should be fine:
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Thank you for the patch, I will drop my one.

Leo
>> ---
>>   tools/perf/arch/arm/util/pmu.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
>> index 1c9541d01722..b7fa1245e242 100644
>> --- a/tools/perf/arch/arm/util/pmu.c
>> +++ b/tools/perf/arch/arm/util/pmu.c
>> @@ -25,6 +25,7 @@ void perf_pmu__arch_init(struct perf_pmu *pmu)
>>                /* add ETM default config here */
>>                pmu->selectable = true;
>>                pmu->perf_event_attr_init_default = cs_etm_get_default_config;
>> +             pmu->auxtrace = true;
>>   #if defined(__aarch64__)
>>        } else if (strstarts(pmu->name, ARM_SPE_PMU_NAME)) {
>>                pmu->selectable = true;
>> @@ -32,8 +33,10 @@ void perf_pmu__arch_init(struct perf_pmu *pmu)
>>                pmu->perf_event_attr_init_default = arm_spe_pmu_default_config;
>>                if (strstarts(pmu->name, "arm_spe_"))
>>                        pmu->mem_events = perf_mem_events_arm;
>> +             pmu->auxtrace = true;
>>        } else if (strstarts(pmu->name, HISI_PTT_PMU_NAME)) {
>>                pmu->selectable = true;
>> +             pmu->auxtrace = true;
>>   #endif
>>        }
>>   #endif
> 

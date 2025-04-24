Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B972D226D1D;
	Thu, 24 Apr 2025 11:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745494172; cv=none; b=mTmkAZUKM0FzzCyINzxsC6zpd0yMIbAplM6WDGcATflvCpA8ojGbb+j2meiEnFcouDgNKROE+j7tLjFGohhAB6AbMt1vbhFLbEqEZY2EAkbSh9yOTZpfwhArzQvaqSQZeTo4Ra5kA/ltLafdJelfDOv65CkhT7oDP10pcscG9/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745494172; c=relaxed/simple;
	bh=sJttvKSgPIpM39A5Gjrk3OfJuudi9ATjCC1FmN7cC98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CVJd8lBOpfNmBkCIySKvCZNtyoS2E53bFifRccsWfp4urugKw5FbI1so5ldQ2ffepaiTNO2FeNJ2M5UCpm/onx2O6T3rGst7N3pMV025Rse4IHO/rG4aHLuk0kVrQP867s0UW3QlbBjy3mHOamDJcaHuiYfwDHcvrrqjW3zz6wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D84C11063;
	Thu, 24 Apr 2025 04:29:24 -0700 (PDT)
Received: from [10.163.49.106] (unknown [10.163.49.106])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9C223F59E;
	Thu, 24 Apr 2025 04:29:23 -0700 (PDT)
Message-ID: <b002574d-e993-4b06-87f7-54bd01dfa500@arm.com>
Date: Thu, 24 Apr 2025 16:59:20 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] coresight: etm-perf: Add AUX_NON_CONTIGUOUS_PAGES to
 cs_etm PMU
To: Yabin Cui <yabinc@google.com>, Leo Yan <leo.yan@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Liang Kan <kan.liang@linux.intel.com>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <20250421215818.3800081-1-yabinc@google.com>
 <20250421215818.3800081-3-yabinc@google.com>
 <20250422142102.GI28953@e132581.arm.com>
 <CALJ9ZPNKZU7nVLyodN5i7GeRxWL6KzkXnqEJMv2sJkk2SwYi9Q@mail.gmail.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <CALJ9ZPNKZU7nVLyodN5i7GeRxWL6KzkXnqEJMv2sJkk2SwYi9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/24/25 01:31, Yabin Cui wrote:
> On Tue, Apr 22, 2025 at 7:21 AM Leo Yan <leo.yan@arm.com> wrote:
>>
>> On Mon, Apr 21, 2025 at 02:58:18PM -0700, Yabin Cui wrote:
>>> The cs_etm PMU, regardless of the underlying trace sink (ETF, ETR or
>>> TRBE), doesn't require contiguous pages for its AUX buffer.
>>
>> Though contiguous pages are not mandatory for TRBE, I would set the
>> PERF_PMU_CAP_AUX_NO_SG flag for it.  This can potentially benefit
>> performance.
> 
> As explained in the patch 1/2, my use case periodically collects ETM data
> from the field (using both TRBE and ETR), and needs to reduce memory
> fragmentation. If the performance impact is big, we can make it user
> configurable. Otherwise, shall we default it to non-contiguous pages?

But is not that already happening ? cs_etm does not set the PMU cap
PERF_PMU_CAP_AUX_NO_SG that means it can allocate non-contig memory
chunk. Where am I missing ?

> 
>>
>> For non per CPU sinks, it is fine to allocate non-contiguous pages.
>>
>> Thanks,
>> Leo
>>
>>> This patch adds the PERF_PMU_CAP_AUX_NON_CONTIGUOUS_PAGES capability
>>> to the cs_etm PMU. This allows the kernel to allocate non-contiguous
>>> pages for the AUX buffer, reducing memory fragmentation when using
>>> cs_etm.
>>>
>>> Signed-off-by: Yabin Cui <yabinc@google.com>
>>> ---
>>>  drivers/hwtracing/coresight/coresight-etm-perf.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
>>> index f4cccd68e625..c98646eca7f8 100644
>>> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
>>> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
>>> @@ -899,7 +899,8 @@ int __init etm_perf_init(void)
>>>       int ret;
>>>
>>>       etm_pmu.capabilities            = (PERF_PMU_CAP_EXCLUSIVE |
>>> -                                        PERF_PMU_CAP_ITRACE);
>>> +                                        PERF_PMU_CAP_ITRACE |
>>> +                                        PERF_PMU_CAP_AUX_NON_CONTIGUOUS_PAGES);
>>>
>>>       etm_pmu.attr_groups             = etm_pmu_attr_groups;
>>>       etm_pmu.task_ctx_nr             = perf_sw_context;
>>> --
>>> 2.49.0.805.g082f7c87e0-goog
>>>
>>>
> 

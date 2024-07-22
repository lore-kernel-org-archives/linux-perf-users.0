Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966F716DC21;
	Mon, 22 Jul 2024 14:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721658850; cv=none; b=nCA6Ote5eoglEiDFvb5RW05PNXOE0ExtGVUAfF7PlE290kQgPFJapv3VDKoURQwLIXvV5kEkI5MUBNeA2smY17mFFPd8mGos5gm36xdutWxojaZqfz+oJjh9oNXmrH9fUJpu8Bh2+BaveIeeHc9sHTV5+oZD8dILhgANn1q/IEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721658850; c=relaxed/simple;
	bh=o5fpqj5qKoEFnMlTe9W5SnQC0WHnZeWkSLHywUGDlMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=vGgLliU1WJnlJgO2kQ1GOLVwRRkJCz94F5Tf8yVVfbSoJb4D5+h/bWXYFmNWgTVXDBfwy4KnLHxB/pTWU+czayg8Wy6lUohe52eW5uaa+fYZa8EJKloODh0RGRkE5C/XFYcSTMFtSFPcKsED8G+nZR2raCcsvFKw8b4PiJq4dUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 537C8FEC;
	Mon, 22 Jul 2024 07:34:33 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C29233F73F;
	Mon, 22 Jul 2024 07:34:05 -0700 (PDT)
Message-ID: <ed39010f-fcdd-4046-b081-2e3e0eb1a346@arm.com>
Date: Mon, 22 Jul 2024 15:34:04 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/6] perf pmu: Directly use evsel's PMU pointer
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
 <20240721202113.380750-2-leo.yan@arm.com>
 <3c25ed2b-9538-4d10-9152-ed1e6106b41a@intel.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <3c25ed2b-9538-4d10-9152-ed1e6106b41a@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Adrian,

On 7/22/24 11:40, Adrian Hunter wrote:

[...]

> On 21/07/24 23:21, Leo Yan wrote:
>> Rather than iterating the whole PMU list for finding the associated PMU
>> device for an evsel, this commit optimizes to directly use evsel's 'pmu'
>> pointer for accessing PMU device.
>>
>> Signed-off-by: Leo Yan <leo.yan@arm.com>
>> ---
>>   tools/perf/util/pmu.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>> index 986166bc7c78..798cd5a2ebc4 100644
>> --- a/tools/perf/util/pmu.c
>> +++ b/tools/perf/util/pmu.c
>> @@ -1199,7 +1199,7 @@ void perf_pmu__warn_invalid_formats(struct perf_pmu *pmu)
>>
>>   bool evsel__is_aux_event(const struct evsel *evsel)
>>   {
>> -     struct perf_pmu *pmu = evsel__find_pmu(evsel);
>> +     struct perf_pmu *pmu = evsel->pmu;
> 
> Assumes event parser has populated evsel->pmu for auxtrace events.
> Could use a comment to that effect.

Sure, will add a comment for this.

Thanks,
Leo

>>
>>        return pmu && pmu->auxtrace;
>>   }
> 

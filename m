Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7AB19413B;
	Fri, 11 Oct 2024 09:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728639632; cv=none; b=OIyboOXlxHUuLQYfT5lqh7CqUvbX8pTQqlvMAWpoFiOR6t0Vv86HFJUn/oPPWMRdKqS323TuspEAd8aN5WcjomwNGp/S366rz5BUtQXVXDe/oCDbr737EeJwEPmW+FJGjQP+bi+ZVUC1GLjQKlTR70kUYzjiQDsZ8TDWjd7DHbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728639632; c=relaxed/simple;
	bh=tyfdDQJiJoJLVGJSmAWBpxESztApVjzUGDtHziLnH7E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=FNva6vsPnwQFcjmy+EsSNPl1W7WTq3QVBihVju0D+dCTWjUBijFoPd+9R6C/BJ1Bo2c1Q9fwJFtuONGnxfcpZwhFgbXNSRuD+6MObmxYoH518NrE9JSB+zkFX0XEtFtOensdmOTeByjZ9A7AEOKeZn21f6XoVjrpa1LxD+vpc0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4144497;
	Fri, 11 Oct 2024 02:40:59 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E580F3F73F;
	Fri, 11 Oct 2024 02:40:28 -0700 (PDT)
Message-ID: <dd674533-4d9c-4298-b6c3-9196b270f68b@arm.com>
Date: Fri, 11 Oct 2024 10:40:27 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/5] libperf cpumap: Correct reference count for
 perf_cpu_map__merge()
From: Leo Yan <leo.yan@arm.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240925195325.426533-1-leo.yan@arm.com>
 <20240925195325.426533-2-leo.yan@arm.com>
 <c30c5139-6f77-4a30-bba8-b9372949aec7@intel.com>
 <91690d5c-7f46-4f6d-8140-c6013d84a0f1@arm.com>
Content-Language: en-US
In-Reply-To: <91690d5c-7f46-4f6d-8140-c6013d84a0f1@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/11/24 10:34, Leo Yan wrote:

>> The 2 non-test uses of perf_cpu_map__merge both do:
>>
>>          a = perf_cpu_map__merge(a, b);
>>
>> so another way to make the API less misleading would be
>> to introduce:
>>
>>          err = perf_cpu_map__merge_in(&a, b);
>>
>> where:
>>
>> int perf_cpu_map__merge_in(struct perf_cpu_map **orig, struct perf_cpu_map 
>> *other)
>> {
>>          struct perf_cpu_map *result = perf_cpu_map__merge(*orig, other);
>>
>>          if (!result)
>>                  return -ENOMEM;
>>
>>          *orig = result;
>>          return 0;
>> }
>>
>> without any changes to perf_cpu_map__merge().
> 
> Just wandering why we cannot do the same thing for the perf_cpu_map__merge()
> function?
> 
>    int perf_cpu_map__merge_in(struct perf_cpu_map **orig,
>                               struct perf_cpu_map *other)

Sorry for typo and spamming. The above suggested definition is for 
perf_cpu_map__merge().


> This can allow us to avoid any confusion in the first place. And we don't need
> to maintain two functions for the same thing.
> 
> Thanks,
> Leo
> 
> 

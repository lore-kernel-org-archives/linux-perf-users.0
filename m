Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C348F20FAA4;
	Fri, 11 Oct 2024 09:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728640289; cv=none; b=Tf0XpBeu14FYv2kJWs2RY4lFr277kyOaFIA1FlnhMiwYmKbCvOQE4nuQxygtN1chSHioktpj3DBGyixklBKDa7br+ZhZ0T07p4fFiLsVm43tGhDIouAE9jEDHCsSM4iNS4FBaSoBP5OaswixDC0UP7+vPBiM58Mh8N9OPjcxg0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728640289; c=relaxed/simple;
	bh=Q6DZr1hxi4eR1B7AymIhAus8itNOJrWORD62HfgtYv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lj9VZhybf/IZPJY4DycqUzYB46cWzeBf7vxEWZCirVAA/Bm4iGML9FvdKl7uNnS+AAdbtDoXH2YD3/oe0EZgaPdafAPm5QxDQahyXS4nEiDAv0w1vSCn++q3VzlFSOW65n4Esz3VaTDFGpObN2gWOPizLm6LxoKjc0hQj6YqjBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A87A497;
	Fri, 11 Oct 2024 02:51:54 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B9923F73F;
	Fri, 11 Oct 2024 02:51:23 -0700 (PDT)
Message-ID: <bc1491be-6e08-465b-94be-6136bdac4d14@arm.com>
Date: Fri, 11 Oct 2024 10:51:22 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/5] libperf cpumap: Correct reference count for
 perf_cpu_map__merge()
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
 <dd674533-4d9c-4298-b6c3-9196b270f68b@arm.com>
 <d5864414-86ec-43d5-b38d-6c01a47e5b60@intel.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <d5864414-86ec-43d5-b38d-6c01a47e5b60@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/11/24 10:46, Adrian Hunter wrote:

[...]

>>>> int perf_cpu_map__merge_in(struct perf_cpu_map **orig, struct perf_cpu_map *other)
>>>> {
>>>>           struct perf_cpu_map *result = perf_cpu_map__merge(*orig, other);
>>>>
>>>>           if (!result)
>>>>                   return -ENOMEM;
>>>>
>>>>           *orig = result;
>>>>           return 0;
>>>> }
>>>>
>>>> without any changes to perf_cpu_map__merge().
>>>
>>> Just wandering why we cannot do the same thing for the perf_cpu_map__merge()
>>> function?
>>>
>>>     int perf_cpu_map__merge_in(struct perf_cpu_map **orig,
>>>                                struct perf_cpu_map *other)
>>
>> Sorry for typo and spamming. The above suggested definition is for perf_cpu_map__merge().
> 
> Yes - there is not much reason to have perf_cpu_map__merge()
> and perf_cpu_map__merge_in().

Thanks for suggestion!  Will move towards this.

Leo

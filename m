Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A0420ADDF;
	Fri, 11 Oct 2024 09:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728639284; cv=none; b=fyE+KCCPeuF/a3TRLxEdPwqewC+yac4YrmdG8B8j4wzlvbCotUnXxQCyatcVcsHZQ9JKuW/92Leb0kYdKu6eJRNVED3uN+t+8skt3Uw0DCZsrjnrNFYhoyrG9x3rosgd0+Gk8KTeHQmo4pPgyqUs2QUxD3eNjR7yUV3EbMy5MXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728639284; c=relaxed/simple;
	bh=R4IgQQjJnpkwQJ9cd9yA3/CN4yzPzwXpI2iQ2KWYo04=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KT3zG3p3yqExDqDbrFhI9qyp4FWHLeseV+1nVTogC93YkgQaWdDPGDJqzylZAWhR+nB74yqE3WAK7Y+Hzvr3x2Ge+jD5UfMahw9nObhnfZdUqHP6WFDB8xbTNkIMTs7GrrGfLsxJqD4wA2aJaYXL5u0mNQ+3MLe/NpfYr84cMfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17F9A497;
	Fri, 11 Oct 2024 02:35:11 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35C443F73F;
	Fri, 11 Oct 2024 02:34:40 -0700 (PDT)
Message-ID: <91690d5c-7f46-4f6d-8140-c6013d84a0f1@arm.com>
Date: Fri, 11 Oct 2024 10:34:38 +0100
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
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <c30c5139-6f77-4a30-bba8-b9372949aec7@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Adrian,

On 10/10/24 18:41, Adrian Hunter wrote:>
> On 25/09/24 22:53, Leo Yan wrote:
>> The perf_cpu_map__merge() function has two arguments, 'orig' and 'other',
>> and it returns results for three different cases:
>>
>>    Case 1: 'other' is a subset of 'orig'.
>>    Case 2: 'orig' is a subset of 'other'.
>>    Case 3: 'orig' and 'other' are not subsets of each other.
>>
>> The result combinations are:
>>
>>    +--------+-------------+-----------+-----------+
>>    | Cases  | Result      | orig      | other     |
>>    +--------+-------------+-----------+-----------+
>>    | Case1  | orig        | No change | No change |
>>    +--------+-------------+-----------+-----------+
>>    | Case2  | other       | No change | refcnt++  |
>>    +--------+-------------+-----------+-----------+
>>    | Case3  | New CPU map | refcnt--  | No change |
>>    +--------+-------------+-----------+-----------+
>>
>> Both Case 1 and Case 3 have a risk of releasing maps unexpectedly. This
>> is because the reference counter operations are not consistent crossing
>> different cases and leads to difficulty for callers handling them.
>>
>> For Case 1, because 'other' is a subset of 'orig', 'orig' is returned as
>> the merging result, but its refcnt is not incremented. This can lead to
>> the map being released repeatedly:
>>
>>    struct perf_cpu_map *a = perf_cpu_map__new("1,2");
>>    struct perf_cpu_map *b = perf_cpu_map__new("2");
>>
>>    /* 'm' and 'a' point to the same CPU map */
>>    struct perf_cpu_map *m = perf_cpu_map__merge(a, b);
>>
>>    ...
>>
>>    perf_cpu_map__put(m); -> Release the map
>>    perf_cpu_map__put(b);
>>    perf_cpu_map__put(a); -> Release the same merged again
>>
>> For Case 3, it is possible that the CPU map pointed to by 'orig' can be
>> released twice: within the function and outside of it.
>>
>>    struct perf_cpu_map *a = perf_cpu_map__new("1,2");
>>    struct perf_cpu_map *b = perf_cpu_map__new("3");
>>
>>    struct perf_cpu_map *m = perf_cpu_map__merge(a, b);
>>                               `> 'm' is new allocated map. But 'a' has
>>                                been released in the function.
>>    ...
>>
>>    perf_cpu_map__put(m);
>>    perf_cpu_map__put(b);
>>    perf_cpu_map__put(a); -> Release the 'a' map again
>>
>> This commit increases the reference counter if a passed map is returned.
>> For the case of a newly allocated map, it does not change the reference
>> counter for passed maps.
> 
> The 2 non-test uses of perf_cpu_map__merge both do:
> 
>          a = perf_cpu_map__merge(a, b);
> 
> so another way to make the API less misleading would be
> to introduce:
> 
>          err = perf_cpu_map__merge_in(&a, b);
> 
> where:
> 
> int perf_cpu_map__merge_in(struct perf_cpu_map **orig, struct perf_cpu_map *other)
> {
>          struct perf_cpu_map *result = perf_cpu_map__merge(*orig, other);
> 
>          if (!result)
>                  return -ENOMEM;
> 
>          *orig = result;
>          return 0;
> }
> 
> without any changes to perf_cpu_map__merge().

Just wandering why we cannot do the same thing for the perf_cpu_map__merge() 
function?

   int perf_cpu_map__merge_in(struct perf_cpu_map **orig,
                              struct perf_cpu_map *other)

This can allow us to avoid any confusion in the first place. And we don't need 
to maintain two functions for the same thing.

Thanks,
Leo


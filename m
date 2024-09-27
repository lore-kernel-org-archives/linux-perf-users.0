Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52314188CB7;
	Fri, 27 Sep 2024 08:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727424443; cv=none; b=R/mq3IknXtshPqOBbMm3BnhepGCqap82WQYdC1Z1Z1455Cb5PGelCCZTGrKAYtw51Pvcb0kvq5dqP7yilwy8bw+II9f91fGjnri02nWDdvY+Oh+TYFArcWtL7F8TgntMcoq0q1OALsiU2E7YE1Qvt4E2YQ+6xxGG5JwWwAxVQ/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727424443; c=relaxed/simple;
	bh=YRZ1ueWRpnNP2xNE0IWnl5wmfNtSmVQx7kZs4r+OZUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R0WOO4iRCiILZjKKRmA/BxoDRroYpFhGU7+/TMc2o8KITl00mhHBmCgSf1l56kifgnLiKLybw+ZnYzZBmwO1hNupG4MsxkMz2jnC+E2wIRVnYmVFtJg+5H0BVw3LccqbGCXB1ap18UrMAMV5g68wll3Obir9sz2yIaIOXJqlCV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 122F3150C;
	Fri, 27 Sep 2024 01:07:50 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 815EF3F6A8;
	Fri, 27 Sep 2024 01:07:18 -0700 (PDT)
Message-ID: <fe152d28-703b-4f97-9656-b351295a506a@arm.com>
Date: Fri, 27 Sep 2024 09:07:16 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] perf arm-spe: Calculate meta data size
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240914215458.751802-1-leo.yan@arm.com>
 <20240914215458.751802-3-leo.yan@arm.com> <ZvZNSr51YgWvc6tu@google.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <ZvZNSr51YgWvc6tu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/27/24 07:14, Namhyung Kim wrote:
> Warning: EXTERNAL SENDER, use caution when opening links or attachments.
> 
> 
> On Sat, Sep 14, 2024 at 10:54:55PM +0100, Leo Yan wrote:
>> The metadata is designed to contain a header and per CPU information.
>>
>> The arm_spe_find_cpus() function is introduced to identify how many CPUs
>> support ARM SPE. Based on the CPU number, calculates the metadata size.
>>
>> Signed-off-by: Leo Yan <leo.yan@arm.com>
>> ---
>>   tools/perf/arch/arm64/util/arm-spe.c | 35 +++++++++++++++++++++++++---
>>   1 file changed, 32 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
>> index c2d5c8ca4900..15478989ef30 100644
>> --- a/tools/perf/arch/arm64/util/arm-spe.c
>> +++ b/tools/perf/arch/arm64/util/arm-spe.c
>> @@ -37,11 +37,40 @@ struct arm_spe_recording {
>>        bool                    *wrapped;
>>   };
>>
>> +static struct perf_cpu_map *arm_spe_find_cpus(struct evlist *evlist)
> 
> Please add a comment that it returns a new cpu map, and caller should
> release the reference after use.

Will do.

Thanks,
Leo

>> +{
>> +     struct perf_cpu_map *event_cpus = evlist->core.user_requested_cpus;
>> +     struct perf_cpu_map *online_cpus = perf_cpu_map__new_online_cpus();
>> +     struct perf_cpu_map *intersect_cpus;
>> +
>> +     /* cpu map is not "any" CPU , we have specific CPUs to work with */
>> +     if (!perf_cpu_map__has_any_cpu(event_cpus)) {
>> +             intersect_cpus = perf_cpu_map__intersect(event_cpus, online_cpus);
>> +             perf_cpu_map__put(online_cpus);
>> +     /* Event can be "any" CPU so count all CPUs. */
>> +     } else {
>> +             intersect_cpus = online_cpus;
>> +     }
>> +
>> +     return intersect_cpus;
>> +}

Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07661FA4
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Oct 2024 07:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727855228; cv=none; b=ZOhKBzUmZu6TLJJZncvvZNJNd4mLsQPK+DxY9mwXcyFdKbYNmQzmf+A1SjtjzC7Rm7/p6+0r8GJvP9VgO1b6rqERVQ49rulPLtFjrl3G3n4gBftxYol8cKSG/5LnRJyhe3EcImb4e/9Ki+lYmHntnGLIIByCDhKSOuzy1XpBYYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727855228; c=relaxed/simple;
	bh=jku+KC/mN9Zz9vUW4BMABcLDOEE3TqBsb+4zZn1eU0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FVZ9SJt0Tm0GJ9ug6BoKSV5/pJDRjM7HTr3cz6/C1Qkc8IHYeYRbWIYkYYQGDUExSIoB9vnfoBOeiSqOhycsYkG13QZzyiOImq2Xlob8f2mW9XJapSWgHxS1yEbLVgCoHZgHgE4Bmj4SI4yC8Tzti7qdsb+i2tWeJtCYEVI6dcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA2AD339;
	Wed,  2 Oct 2024 00:47:34 -0700 (PDT)
Received: from [10.1.35.17] (PF4Q20KV.arm.com [10.1.35.17])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BEE963F64C;
	Wed,  2 Oct 2024 00:47:02 -0700 (PDT)
Message-ID: <9eae9026-bcbc-45f0-bb40-fee4af591a22@arm.com>
Date: Wed, 2 Oct 2024 08:47:00 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] perf arm-spe: Support metadata version 2
To: James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Besar Wicaksono <bwicaksono@nvidia.com>,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org
References: <20240928195547.59780-1-leo.yan@arm.com>
 <20240928195547.59780-5-leo.yan@arm.com>
 <552951c4-7a8e-44df-af23-8eb112c17709@linaro.org>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <552951c4-7a8e-44df-af23-8eb112c17709@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/1/2024 2:53 PM, James Clark wrote:

[...]

>> @@ -1267,15 +1339,24 @@ int arm_spe_process_auxtrace_info(union perf_event
>> *event,
>>       const char *cpuid = perf_env__cpuid(session->evlist->env);
>>       u64 midr = strtol(cpuid, NULL, 16);
>>       struct arm_spe *spe;
>> -     int err;
>> +     u64 **metadata = NULL;
>> +     u64 metadata_ver;
>> +     int nr_cpu, err;
>>
>>       if (auxtrace_info->header.size < sizeof(struct
>> perf_record_auxtrace_info) +
>>                                       min_sz)
>>               return -EINVAL;
>>
>> +     metadata = arm_spe__alloc_metadata(auxtrace_info, &metadata_ver,
>> +                                        &nr_cpu);
>> +     if (!metadata && metadata_ver != 1) {
>> +             pr_err("Failed to parse Arm SPE metadata.\n");
>> +             return -EINVAL;
>> +     }
>> +
>>       spe = zalloc(sizeof(struct arm_spe));
>>       if (!spe)
>> -             return -ENOMEM;
>> +             goto err_free_metadata;
>>
> 
> Hi Leo,
> 
> There's a build error here:
> 
> util/arm-spe.c:1402:6: error: variable 'err' is used uninitialized
> whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>         if (!spe)
>             ^~~~

Thanks for catching this issue.

It is interesting that Aarch64 cross compiler GCC-13 and GCC-14 both do not
report this issue, I reproduced the error until I changed to x86_64 GCC-11.

>>       err = auxtrace_queues__init(&spe->queues);
>>       if (err)
>> @@ -1284,8 +1365,14 @@ int arm_spe_process_auxtrace_info(union perf_event
>> *event,
>>       spe->session = session;
>>       spe->machine = &session->machines.host; /* No kvm support */
>>       spe->auxtrace_type = auxtrace_info->type;
>> -     spe->pmu_type = auxtrace_info->priv[ARM_SPE_PMU_TYPE];
>> +     if (metadata_ver == 1)
>> +             spe->pmu_type = auxtrace_info->priv[ARM_SPE_PMU_TYPE];
>> +     else
>> +             spe->pmu_type = auxtrace_info->priv[ARM_SPE_SHARED_PMU_TYPE];
> 
> I thought V2 saved the type per-CPU, so I wasn't that clear on the
> SHARED_PMU_TYPE vs ARM_SPE_PMU_TYPE use here. Maybe it's just a naming
> issue? If it's a placeholder value to generate events can it be the same
> name as the V1 enum, that way it's clearer that it's the same thing.
> 
> Like: ARM_SPE_PMU_TYPE_V2

Yes, in the end we will use the PMU type saved in per-CPU metadata which will
be updated in the multi AUX event patch series. Before we reach this point,
let us keep a PMU type in the metadata header.

I will rename to ARM_SPE_PMU_TYPE_V2.

Thanks for review.

Leo

> Other than that, for the whole set:
> 
> Reviewed-by: James Clark <james.clark@linaro.org>
> 

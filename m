Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFF713B58B;
	Fri, 27 Sep 2024 08:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727425001; cv=none; b=QCQQksJSXyBMAqERwhzyxlPFUbYnO6Q5UZuEv1j1udlSYo45DPe07XZVJg3eHHEgDncLnnuVfANGIjm01MNayLpGmZqS4EFcblVo/dGCkvBPB+Fmb7oIvmAFzQckiG/gZO3qKHG+/hFHKOZQtXwPVy1RQnhx7JJsiRof7ArymA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727425001; c=relaxed/simple;
	bh=cRW3AX/c1lHWXHtV/BeY50l4lkGC0423cx0OW/f+EaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UftRh8KkFrBT0BYWGXRLMkhCAuIG8D7T4uLrNGaQ3Aglg56InNnEo+7WLFrGBb3afsQJNU8C66kokHMLDslUxbg8GIL/EL/JJkFXzCZYiuXgOhgYoXIcvqwpIPMtaJNOtddzH3V5YobQFcJ45rj/VwA4dPrtdfZVbglQtRiTLF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1EB2165C;
	Fri, 27 Sep 2024 01:17:07 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BBE23F6A8;
	Fri, 27 Sep 2024 01:16:36 -0700 (PDT)
Message-ID: <4eea0c0e-e651-49cc-96ee-ef9809e80012@arm.com>
Date: Fri, 27 Sep 2024 09:16:34 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] perf arm-spe: Save per CPU information in metadata
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
 <20240914215458.751802-4-leo.yan@arm.com> <ZvZO96lj8-aZkuZw@google.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <ZvZO96lj8-aZkuZw@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/27/24 07:21, Namhyung Kim wrote:>
> On Sat, Sep 14, 2024 at 10:54:56PM +0100, Leo Yan wrote:
>> Save the Arm SPE information on a per-CPU basis. This approach is easier
>> in the decoding phase for retrieving metadata based on the CPU number of
>> every Arm SPE record.
>>
>> Signed-off-by: Leo Yan <leo.yan@arm.com>
>> ---
>>   tools/perf/arch/arm64/util/arm-spe.c | 71 +++++++++++++++++++++++++++-
>>   1 file changed, 70 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
>> index 15478989ef30..2790a37709a5 100644
>> --- a/tools/perf/arch/arm64/util/arm-spe.c
>> +++ b/tools/perf/arch/arm64/util/arm-spe.c
>> @@ -26,6 +26,8 @@
>>   #include "../../../util/arm-spe.h"
>>   #include <tools/libc_compat.h> // reallocarray
>>
>> +#define ARM_SPE_CPU_MAGIC            0x1010101010101010ULL
>> +
>>   #define KiB(x) ((x) * 1024)
>>   #define MiB(x) ((x) * 1024 * 1024)
>>
>> @@ -73,14 +75,66 @@ arm_spe_info_priv_size(struct auxtrace_record *itr __maybe_unused,
>>        return size;
>>   }
>>
>> +static int arm_spe_save_cpu_header(struct auxtrace_record *itr,
>> +                                struct perf_cpu cpu, __u64 data[])
>> +{
>> +     struct arm_spe_recording *sper =
>> +                     container_of(itr, struct arm_spe_recording, itr);
>> +     struct perf_pmu *pmu = NULL;
>> +     struct perf_pmu tmp_pmu;
>> +     char cpu_id_str[16];
>> +     char *cpuid = NULL;
>> +     u64 val;
>> +
>> +     snprintf(cpu_id_str, sizeof(cpu_id_str), "%d", cpu.cpu);
>> +     tmp_pmu.cpus = perf_cpu_map__new(cpu_id_str);
>> +     if (!tmp_pmu.cpus)
>> +             return -ENOMEM;
>> +
>> +     /* Read CPU MIDR */
>> +     cpuid = perf_pmu__getcpuid(&tmp_pmu);
>> +     if (!cpuid)
>> +             return -ENOMEM;
> 
> You'd better call perf_cpu_map__put() before return.

Will do.

Just for recording, 'cpuid' should be released at the end of function.

>> +     val = strtol(cpuid, NULL, 16);
>> +     perf_cpu_map__put(tmp_pmu.cpus);
>> +
>> +     data[ARM_SPE_MAGIC] = ARM_SPE_CPU_MAGIC;
>> +     data[ARM_SPE_CPU] = cpu.cpu;
>> +     data[ARM_SPE_CPU_NR_PARAMS] = ARM_SPE_CPU_PRIV_MAX - ARM_SPE_CPU_MIDR;
>> +     data[ARM_SPE_CPU_MIDR] = val;
>> +
>> +     /* Find the associate Arm SPE PMU for the CPU */
>> +     if (perf_cpu_map__has(sper->arm_spe_pmu->cpus, cpu))
>> +             pmu = sper->arm_spe_pmu;
>> +
>> +     if (!pmu) {
>> +             /* No Arm SPE PMU is found */
>> +             data[ARM_SPE_CPU_PMU_TYPE] = ULLONG_MAX;
>> +             data[ARM_SPE_CAP_MIN_IVAL] = 0;
>> +     } else {
>> +             data[ARM_SPE_CPU_PMU_TYPE] = pmu->type;
>> +
>> +             if (perf_pmu__scan_file(pmu, "caps/min_interval", "%lu", &val) != 1)
>> +                     val = 0;
>> +             data[ARM_SPE_CAP_MIN_IVAL] = val;
>> +     }
>> +
>> +     return ARM_SPE_CPU_PRIV_MAX;
>> +}
>> +
>>   static int arm_spe_info_fill(struct auxtrace_record *itr,
>>                             struct perf_session *session,
>>                             struct perf_record_auxtrace_info *auxtrace_info,
>>                             size_t priv_size)
>>   {
>> +     int i, ret;
>> +     size_t offset;
>>        struct arm_spe_recording *sper =
>>                        container_of(itr, struct arm_spe_recording, itr);
>>        struct perf_pmu *arm_spe_pmu = sper->arm_spe_pmu;
>> +     struct perf_cpu_map *cpu_map = arm_spe_find_cpus(session->evlist);
> 
> Maybe you can move this to later in the function to make the error
> handling easier.  Otherwise it should call perf_cpu_map__put().

Good point. Will do.

>> +     struct perf_cpu cpu;
>> +     __u64 *data;
>>
>>        if (priv_size != arm_spe_info_priv_size(itr, session->evlist))
>>                return -EINVAL;
>> @@ -89,8 +143,23 @@ static int arm_spe_info_fill(struct auxtrace_record *itr,
>>                return -EINVAL;
>>
>>        auxtrace_info->type = PERF_AUXTRACE_ARM_SPE;
>> -     auxtrace_info->priv[ARM_SPE_PMU_TYPE] = arm_spe_pmu->type;
>> +     auxtrace_info->priv[ARM_SPE_HEADER_VERSION] = ARM_SPE_HEADER_CURRENT_VERSION;
>> +     auxtrace_info->priv[ARM_SPE_HEADER_SIZE] =
>> +             ARM_SPE_AUXTRACE_PRIV_MAX - ARM_SPE_HEADER_VERSION;
>> +     auxtrace_info->priv[ARM_SPE_SHARED_PMU_TYPE] = arm_spe_pmu->type;
>> +     auxtrace_info->priv[ARM_SPE_CPUS_NUM] = perf_cpu_map__nr(cpu_map);
>> +
>> +     offset = ARM_SPE_AUXTRACE_PRIV_MAX;
>> +     perf_cpu_map__for_each_cpu(cpu, i, cpu_map) {
>> +             assert(offset < priv_size);
>> +             data = &auxtrace_info->priv[offset];
>> +             ret = arm_spe_save_cpu_header(itr, cpu, data);
>> +             if (ret < 0)
>> +                     return ret;
> 
> Please break the loop and release the cpu map.

Will do.

Thanks for good catchings!

Leo

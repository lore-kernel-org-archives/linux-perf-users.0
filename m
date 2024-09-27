Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1704BEEAA;
	Fri, 27 Sep 2024 08:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727425956; cv=none; b=R+WBF6xdutluEiBAEvZZBhog+3VPZdw4kU0akVXwgR3YSPPIrNiRfL2WsrIK/ledqZWjvxrn/+oFLs+eAzhRcaNRhTxCFQB1tiQQmfJbdQ4M9vR4E35cWmWoNUMdhP3bgxVY+5vcvWSiISq+u6Uv+8Qch7m19LQkgV3bYDps9bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727425956; c=relaxed/simple;
	bh=hOY4SrXnpTv8KmoqbrspjO0qN54pkC9+w44ahNF7rRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EzbvpBw9vE2EtEIHu3/S7ttj41z7liy1Mb3ZAEQvkByhpk3IUuqeeF7E3+q6gXZDQFYeCTA3NmFQLwNM6dlmTuCSGvh8SPacvYH0KAgUCU6DclgA3KLoeD8UYy0nPXvggg2JDJd3okQS2++CUK1KDH8NA7GbFXCYajuBj1Jw/QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E758C14BF;
	Fri, 27 Sep 2024 01:33:03 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5760F3F6A8;
	Fri, 27 Sep 2024 01:32:32 -0700 (PDT)
Message-ID: <437fed3a-2888-4fe0-9af7-5cee0204641f@arm.com>
Date: Fri, 27 Sep 2024 09:32:30 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] perf arm-spe: Support metadata version 2
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
 <20240914215458.751802-5-leo.yan@arm.com> <ZvZSRNi_rVnrecPZ@google.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <ZvZSRNi_rVnrecPZ@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/27/24 07:35, Namhyung Kim wrote:
> On Sat, Sep 14, 2024 at 10:54:57PM +0100, Leo Yan wrote:
>> This commit is to support metadata version 2 and at the meantime it is
>> backward compatible for version 1's format.
>>
>> The metadata version 1 doesn't include the ARM_SPE_HEADER_VERSION field.
>> As version 1 is fixed with two u64 fields, by checking the metadata
>> size, it distinguishes the metadata is version 1 or version 2 (and any
>> new versions if later will have). For version 2, it reads out CPU number
>> and retrieves the metadata info for every CPU.
>>
>> Signed-off-by: Leo Yan <leo.yan@arm.com>
>> ---
>>   tools/perf/util/arm-spe.c | 95 +++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 92 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
>> index 70989b1bae47..17782cb40fb5 100644
>> --- a/tools/perf/util/arm-spe.c
>> +++ b/tools/perf/util/arm-spe.c
>> @@ -78,6 +78,10 @@ struct arm_spe {
>>
>>        unsigned long                   num_events;
>>        u8                              use_ctx_pkt_for_pid;
>> +
>> +     u64                             **metadata;
>> +     u64                             metadata_ver;
>> +     u64                             metadata_nr_cpu;
>>   };
>>
>>   struct arm_spe_queue {
>> @@ -1016,6 +1020,73 @@ static int arm_spe_flush(struct perf_session *session __maybe_unused,
>>        return 0;
>>   }
>>
>> +static u64 *arm_spe__alloc_per_cpu_metadata(u64 *buf, int cpu_size)
>> +{
>> +     u64 *metadata;
>> +
>> +     metadata = zalloc(sizeof(*metadata) * cpu_size);
> 
> Maybe calloc() is slightly better here, but not a strong opinion.

Ah, here 'cpu_size' is the size of per CPU's metadata in bytes. It
should not multiply sizeof(*metadata), though this will not lead buffer
overwrite issue as it allocates a bigger buffer than used.

I will rename the 'cpu_size' argument to 'per_cpu_size'.

>> +     if (!metadata)
>> +             return NULL;
>> +
>> +     memcpy(metadata, buf, cpu_size);
> 
> I'm not sure if it's correct since you allocated cpu_size * 8 and copies
> only cpu_size.

As described above, here it is correct as the unit of 'cpu_size' is in
bytes.

>> +     return metadata;
>> +}
>> +
>> +static void arm_spe__free_metadata(u64 **metadata, int nr_cpu)
>> +{
>> +     int i;
>> +
>> +     for (i = 0; i < nr_cpu; i++)
>> +             zfree(&metadata[i]);
>> +     free(metadata);
>> +}
>> +
>> +static u64 **arm_spe__alloc_metadata(struct perf_record_auxtrace_info *info,
>> +                                  u64 *ver, int *nr_cpu)
>> +{
>> +     u64 *ptr = (u64 *)info->priv;
>> +     u64 metadata_size;
>> +     u64 **metadata = NULL;
>> +     int hdr_sz, cpu_sz, i;
>> +
>> +     metadata_size = info->header.size -
>> +             sizeof(struct perf_record_auxtrace_info);
>> +
>> +     /* Metadata version 1 */
>> +     if (metadata_size == ARM_SPE_AUXTRACE_V1_PRIV_SIZE) {
>> +             *ver = 1;
>> +             *nr_cpu = 0;
>> +             /* No per CPU metadata */
>> +             return NULL;
>> +     }
>> +
>> +     *ver = ptr[ARM_SPE_HEADER_VERSION];
>> +     hdr_sz = ptr[ARM_SPE_HEADER_SIZE];
>> +     *nr_cpu = ptr[ARM_SPE_CPUS_NUM];
>> +
>> +     metadata = zalloc(sizeof(*metadata) * (*nr_cpu));
> 
> calloc() instead?  But probably better defining a struct for metadata.

I will change to calloc(). It allocates a pointer array, so I will
try to change to 'u64 *metadata[] = NULL;' for clear definition.

Thanks,
Leo

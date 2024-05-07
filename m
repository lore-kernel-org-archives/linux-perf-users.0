Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F94815250E;
	Tue,  7 May 2024 09:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715075874; cv=none; b=l9I/bqsvK07JvFxxMawvzSkGgb2+KV6Hj9eHZKAGJEij1LrGPPOhCTlNTBCTtWk3xZEEwcmUKGhWZmCSuOGiPIJ9QUWxnOAWXtXVH5o46D0wNJO95uGWxb2juFxbCf8zNuj2HCi8H8z3wyIYUM7Fp3Ds11/v1E8g8zE9JLItNjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715075874; c=relaxed/simple;
	bh=u5LwolL8YZhKMmJ1a0cajaUoNHhi5YUay/+2/rPZvIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MmP9PxCMCB9i8HiwGJYHjE+outkT/N0Ikd5IGWd/n7sqRDGw/qod8fzHHTTRaMt9Vt6oAOrgWWEBwcheMMaOi0eamIs3Z8ruwTBPbi63JORozM6j6hJowtPZ7NqHIA7D/dt6w/erj1kZKo9Srb4Vf7nh1yoX4AGQm5MnZLzMZZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E9251063;
	Tue,  7 May 2024 02:58:17 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 46E393F587;
	Tue,  7 May 2024 02:57:48 -0700 (PDT)
Message-ID: <07e869aa-6c4d-46f1-bce1-fe37aa72ce87@arm.com>
Date: Tue, 7 May 2024 10:57:46 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/17] coresight: Make CPU id map a property of a trace ID
 map
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, John Garry
 <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Leo Yan <leo.yan@linux.dev>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-perf-users@vger.kernel.org, gankulkarni@os.amperecomputing.com,
 scclevenger@os.amperecomputing.com, coresight@lists.linaro.org,
 suzuki.poulose@arm.com, mike.leach@linaro.org
References: <20240429152207.479221-1-james.clark@arm.com>
 <20240429152207.479221-14-james.clark@arm.com>
 <8080ae06-7014-4afe-8620-ffaca6e3c597@arm.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <8080ae06-7014-4afe-8620-ffaca6e3c597@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 07/05/2024 07:22, Anshuman Khandual wrote:
> 
> 
> On 4/29/24 20:51, James Clark wrote:
>> The global CPU ID mappings won't work for per-sink ID maps so move it to
>> the ID map struct. coresight_trace_id_release_all_pending() is hard
>> coded to operate on the default map, but once Perf sessions use their
>> own maps the pending release mechanism will be deleted. So it doesn't
>> need to be extended to accept a trace ID map argument at this point.
>>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>  .../hwtracing/coresight/coresight-etm-perf.c  |  3 +-
>>  .../coresight/coresight-etm3x-core.c          |  3 +-
>>  .../coresight/coresight-etm4x-core.c          |  3 +-
>>  .../hwtracing/coresight/coresight-trace-id.c  | 28 ++++++++-----------
>>  .../hwtracing/coresight/coresight-trace-id.h  |  2 +-
>>  include/linux/coresight.h                     |  1 +
>>  6 files changed, 20 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
>> index 4afb9d29f355..25f1f87c90d1 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
>> @@ -508,7 +508,8 @@ static void etm_event_start(struct perf_event *event, int flags)
>>  		hw_id = FIELD_PREP(CS_AUX_HW_ID_VERSION_MASK,
>>  				   CS_AUX_HW_ID_CURR_VERSION);
>>  		hw_id |= FIELD_PREP(CS_AUX_HW_ID_TRACE_ID_MASK,
>> -				    coresight_trace_id_read_cpu_id(cpu));
>> +				    coresight_trace_id_read_cpu_id(cpu,
>> +						coresight_trace_id_map_default()));
>>  		perf_report_aux_output_id(event, hw_id);
>>  	}
>>  
>> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
>> index 4149e7675ceb..b21f5ad94e63 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
>> @@ -501,7 +501,8 @@ static int etm_enable_perf(struct coresight_device *csdev,
>>  	 * with perf locks - we know the ID cannot change until perf shuts down
>>  	 * the session
>>  	 */
>> -	trace_id = coresight_trace_id_read_cpu_id(drvdata->cpu);
>> +	trace_id = coresight_trace_id_read_cpu_id(drvdata->cpu,
>> +						  coresight_trace_id_map_default());
>>  	if (!IS_VALID_CS_TRACE_ID(trace_id)) {
>>  		dev_err(&drvdata->csdev->dev, "Failed to set trace ID for %s on CPU%d\n",
>>  			dev_name(&drvdata->csdev->dev), drvdata->cpu);
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> index f32c8cd7742d..d16d6efb26fa 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> @@ -776,7 +776,8 @@ static int etm4_enable_perf(struct coresight_device *csdev,
>>  	 * with perf locks - we know the ID cannot change until perf shuts down
>>  	 * the session
>>  	 */
>> -	trace_id = coresight_trace_id_read_cpu_id(drvdata->cpu);
>> +	trace_id = coresight_trace_id_read_cpu_id(drvdata->cpu,
>> +						  coresight_trace_id_map_default());
>>  	if (!IS_VALID_CS_TRACE_ID(trace_id)) {
>>  		dev_err(&drvdata->csdev->dev, "Failed to set trace ID for %s on CPU%d\n",
>>  			dev_name(&drvdata->csdev->dev), drvdata->cpu);
>> diff --git a/drivers/hwtracing/coresight/coresight-trace-id.c b/drivers/hwtracing/coresight/coresight-trace-id.c
>> index 45ddd50d09a6..b393603dd713 100644
>> --- a/drivers/hwtracing/coresight/coresight-trace-id.c
>> +++ b/drivers/hwtracing/coresight/coresight-trace-id.c
>> @@ -13,10 +13,12 @@
>>  #include "coresight-trace-id.h"
>>  
>>  /* Default trace ID map. Used in sysfs mode and for system sources */
>> -static struct coresight_trace_id_map id_map_default;
>> +static DEFINE_PER_CPU(atomic_t, id_map_default_cpu_ids) = ATOMIC_INIT(0);
>> +static struct coresight_trace_id_map id_map_default = {
>> +	.cpu_map = &id_map_default_cpu_ids
>> +};
>>  
>> -/* maintain a record of the mapping of IDs and pending releases per cpu */
>> -static DEFINE_PER_CPU(atomic_t, cpu_id) = ATOMIC_INIT(0);
>> +/* maintain a record of the pending releases per cpu */
>>  static cpumask_t cpu_id_release_pending;
>>  
>>  /* perf session active counter */
>> @@ -46,12 +48,6 @@ static void coresight_trace_id_dump_table(struct coresight_trace_id_map *id_map,
>>  #define PERF_SESSION(n)
>>  #endif
>>  
>> -/* unlocked read of current trace ID value for given CPU */
>> -static int _coresight_trace_id_read_cpu_id(int cpu)
>> -{
>> -	return atomic_read(&per_cpu(cpu_id, cpu));
>> -}
> 
> Just wondering where this per cpu cpu_id ^^ is being dropped off as well
> OR is it still getting used ?
> 

No it's still needed. It's not dropped in this set.

I just moved the implementation into coresight_trace_id_read_cpu_id()
rather than add a new argument to _coresight_trace_id_read_cpu_id().
Although I might change that because of Mike's comment about keeping
both the map and non map versions of the functions to reduce some of the
churn changing the callers.

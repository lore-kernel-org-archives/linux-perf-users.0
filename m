Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2448C21D591;
	Wed, 12 Aug 2026 02:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786501704; cv=none; b=JmtRBTEXKAQjnOONmd5Oe8jRGa/Yi0f4YQcFKfWli1H0KdJNdOLG2etRWy7Dzl/rl4jAmGBNyaG5UgDWLwRdJ3+W6OvrQ1QIH6hKn98VoTpbW1s18G1JPKwbqHoWbF+mEiEAfwAgjkFsONZZGxNDRvCkArQsEgoWcOeR91mgnng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786501704; c=relaxed/simple;
	bh=9R8pdrhIoX/TmxU982cTgn3RQLGnVbi8FdvSfuCwUIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WuhrHY9TVfHkiElY2JCmZQx9JFTV0sRBHbY8r3DjUsLaOePFu6Kdyy85z/Is4l3KJl8ntj2XqcaN+LMJoDKLqZwABy3nTVRdnlsmipUpFrIJ01ppqfGTglJzUEfsiVverwwByRy5JiZB94KHx5+/HvljPvJCjSs9afExro2XN/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hKXTX5ZwrzKHMfX;
	Wed, 12 Aug 2026 10:28:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id B939140539;
	Wed, 12 Aug 2026 10:28:17 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgAnkYg_2ntqD_MHCA--.39355S2;
	Wed, 12 Aug 2026 10:28:17 +0800 (CST)
Message-ID: <1910f712-8ea6-4916-82ac-0c1c2eac653c@huaweicloud.com>
Date: Wed, 12 Aug 2026 10:28:15 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/23] perf annotate: Deduplicate overlapping ARM SPE
 events for data type profiling
To: Adrian Hunter <adrian.hunter@intel.com>,
 Namhyung Kim <namhyung@kernel.org>, james.clark@linaro.org,
 xueshuai@linux.alibaba.com, Li Huafei <lihuafei1@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>, leo.yan@linux.dev,
 Ian Rogers <irogers@google.com>, Kim Phillips <kim.phillips@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Bill Wendling <morbo@google.com>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Zecheng Li <zli94@ncsu.edu>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20260808122400.2961238-1-wutengda@huaweicloud.com>
 <20260808122400.2961238-10-wutengda@huaweicloud.com>
 <20083f61-9724-445c-ad45-d77f9e8d2266@intel.com>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20083f61-9724-445c-ad45-d77f9e8d2266@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAnkYg_2ntqD_MHCA--.39355S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKrW8trW7Jr15Gr4rJw4UCFg_yoWxGrWkpr
	4a9Fn8Kwn5Xr40kw1ava15Xr1F93yfXFW3GwnFka15Awn8ur95tFyxtr15KFZxXrn8Z34S
	vws093s8Wa45ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
	WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	jIksgUUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/8/10 14:57, Adrian Hunter wrote:
> On 08/08/2026 15:23, Tengda Wu wrote:
>> When data type profiling is enabled on ARM SPE, multiple overlapping
>> events (e.g., l1d-miss, tlb-access) are synthesized for a single sampled
>> instruction, as shown below:
>>
>>   Available samples
>>   0 arm_spe_0/ts_enable=1,pa_enable=1,load_filter=1,store_filter=1,min_latency=30/
>>   0 dummy:u
>>   84K l1d-miss
>>   95K l1d-access
>>   77K llc-miss
>>   58K llc-access
>>   9K tlb-miss
>>   108K tlb-access
>>   0 branch
>>   13K remote-access
>>   108K memory
>>   108K instructions
>>
>> While 'perf report' provides an interactive menu for users to select a
>> specific event to prevent duplicate counting, 'perf annotate' lacks such
>> a mechanism. Consequently, it counts all instructions across these
>> overlapping events, which inflates the profile and distorts the data
>> type statistics.
>>
>> Although using the '--itrace' option can work around this issue (e.g.:
>> perf annotate --data-type --stdio --itrace=i1i), it is inconvenient for
>> users to specify this explicitly every time.
>>
>> To address this, introduce itrace_synth_opts.dont_overlap. Set this to true
>> when data type profiling is enabled and the user has not explicitly
>> specified an itrace option. Then, during arm_spe_process_auxtrace_info(),
>> adjust the synthesized event options based on the dont_overlap value to
>> only enable instruction event synthesis, thereby achieving automatic
>> deduplication.
>>
>> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
>> ---
>>  tools/perf/builtin-annotate.c |  8 ++++++++
>>  tools/perf/util/arm-spe.c     | 17 +++++++++++++++++
>>  tools/perf/util/auxtrace.h    |  2 ++
>>  3 files changed, 27 insertions(+)
>>
>> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
>> index 69cb72b2082a..616f54bf4868 100644
>> --- a/tools/perf/builtin-annotate.c
>> +++ b/tools/perf/builtin-annotate.c
>> @@ -873,6 +873,14 @@ int cmd_annotate(int argc, const char **argv)
>>  	annotate.session = perf_session__new(&data, &annotate.tool);
>>  	if (IS_ERR(annotate.session))
>>  		return PTR_ERR(annotate.session);
>> +	/*
>> +	 * Hardware tracing (e.g.: ARM SPE) may generate overlapping events
>> +	 * per instruction. When data type profiling is enabled, enable
>> +	 * dont_overlap to deduplicate them to avoid skewed stats, but only
>> +	 * if user hasn't specified itrace options (respect user override).
>> +	 */
>> +	if (annotate.data_type && !itrace_synth_opts.set)
>> +		itrace_synth_opts.dont_overlap = true;
>>  
>>  	annotate.session->itrace_synth_opts = &itrace_synth_opts;
>>  
>> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
>> index 401aab529309..1721882423f6 100644
>> --- a/tools/perf/util/arm-spe.c
>> +++ b/tools/perf/util/arm-spe.c
>> @@ -2033,6 +2033,9 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
>>  		/* Default nanoseconds period not supported */
>>  		spe->synth_opts.period_type = PERF_ITRACE_PERIOD_INSTRUCTIONS;
>>  		spe->synth_opts.period = 1;
>> +
>> +		if (session->itrace_synth_opts)
>> +			spe->synth_opts.dont_overlap = session->itrace_synth_opts->dont_overlap;
>>  	}
>>  
>>  	if (spe->synth_opts.period_type != PERF_ITRACE_PERIOD_INSTRUCTIONS) {
>> @@ -2044,6 +2047,20 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
>>  		ui__warning("Arm SPE has a hardware-based sampling period.\n\n"
>>  			    "--itrace periods > 1i downsample by an interval of n SPE samples rather than n instructions.\n");
>>  
>> +	if (spe->synth_opts.dont_overlap) {
>> +		/*
>> +		 * The 'instructions' event is the most comprehensive,
>> +		 * synthesize it exclusively.
>> +		 */
>> +		spe->synth_opts.flc = false;
>> +		spe->synth_opts.llc = false;
>> +		spe->synth_opts.tlb = false;
>> +		spe->synth_opts.branches = false;
>> +		spe->synth_opts.remote_access = false;
>> +		spe->synth_opts.mem = false;
>> +		spe->synth_opts.instructions = true;
>> +	}
>> +
>>  	err = arm_spe_synth_events(spe, session);
>>  	if (err)
>>  		goto err_free_queues;
>> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
>> index 6947f3f284c0..ebb4e9e8e574 100644
>> --- a/tools/perf/util/auxtrace.h
>> +++ b/tools/perf/util/auxtrace.h
>> @@ -80,6 +80,7 @@ enum itrace_period_type {
>>   * @intr_events: whether to synthesize interrupt events
>>   * @errors: whether to synthesize decoder error events
>>   * @dont_decode: whether to skip decoding entirely
>> + * @dont_overlap: whether to deduplicate overlapping events
> 
> This doesn't seem to match what you are actually doing, which
> seems to be to choose particular default itrace options for
> 'perf annotate --data-type'
> 
> I wonder if this should really be handled by
> itrace_synth_opts__set_default()?
> 

Placing this in itrace_synth_opts__set_default() may not be appropriate.

The current approach is designed to constrain the following conditions:

1. Using perf annotate
2. With --data-type specified
3. Based on ARM SPE
4. Without --itrace explicitly specified

When these conditions are all met, we want to enable --itrace=i1i by default,
effectively making this option built-in.

If we were to place the --itrace=i1i configuration inside
itrace_synth_opts__set_default(), conditions 1, 2, and 3 would not be
reachable from that context, as there's no way to propagate that information
into the function. Configuring it directly there would take effect globally,
impacting other commands such as perf report and perf script.

Therefore, the current approach passes the dont_overlap information through
itrace (satisfying conditions 1, 2, and 4), and then configures --itrace=i1i
inside the ARM SPE driver (satisfying condition 3).

Thanks,
Tengda

> 
>>   * @log: write a decoding log
>>   * @calls: limit branch samples to calls (can be combined with @returns)
>>   * @returns: limit branch samples to returns (can be combined with @calls)
>> @@ -128,6 +129,7 @@ struct itrace_synth_opts {
>>  	bool			intr_events;
>>  	bool			errors;
>>  	bool			dont_decode;
>> +	bool			dont_overlap;
>>  	bool			log;
>>  	bool			calls;
>>  	bool			returns;


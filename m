Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41F147A0B7;
	Tue, 21 Jul 2026 11:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784634004; cv=none; b=rACwS4donzgTN7qABfurf5NVEezXOlc+AlFmkMknYb++cSZaMtNpA49ioiFOjw7B5VeZ/Kyd+doZvnStYMOfcF2GNbyNpFR/I7VpYK0k5+sW3krXNexTgr+b5jNQIjLefmPQuIR6UfTSkeCJ4qGXGvoSd538wTi8sgTG0DqJ160=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784634004; c=relaxed/simple;
	bh=JXWdx8p2WhqAD942C81MkHbveCEBg991JO/9hHnkfyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TBtqIgbLOQkUKvhXs+MT2gx3A1TVe/7aiOR7NcwUN+naDBBNfAhtRq6oi4vh79zExdabWbr2u/Fu17Kwl6ITPT2zqu3K/xlmbJRIavZqe4RfkpXDetQTOnrFDkKkWjwG+HggupHJ8fkuQBxDGX5bIY0CRTs9l1JpZ51lCeB87ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h4Fm037HvzYQtxt;
	Tue, 21 Jul 2026 19:39:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A50E44058D;
	Tue, 21 Jul 2026 19:39:55 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgCnAW6KWl9qfBEcCA--.5778S2;
	Tue, 21 Jul 2026 19:39:55 +0800 (CST)
Message-ID: <f7a94138-e29f-4b1a-948d-ef4933e7d0c5@huaweicloud.com>
Date: Tue, 21 Jul 2026 19:39:53 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/21] perf auxtrace: Set default period to 1 for
 PERF_ITRACE_PERIOD_INSTRUCTIONS type
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, leo.yan@linux.dev,
 Ian Rogers <irogers@google.com>, Kim Phillips <kim.phillips@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Bill Wendling <morbo@google.com>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Zecheng Li <zli94@ncsu.edu>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 Li Huafei <lihuafei1@huawei.com>, Shuai Xue <xueshuai@linux.alibaba.com>,
 Namhyung Kim <namhyung@kernel.org>, James Clark <james.clark@linaro.org>
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
 <20260701035355.752944-12-wutengda@huaweicloud.com>
 <07c8c780-5eeb-4310-80cd-3ff18952a688@intel.com>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <07c8c780-5eeb-4310-80cd-3ff18952a688@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgCnAW6KWl9qfBEcCA--.5778S2
X-Coremail-Antispam: 1UD129KBjvJXoWxur4xAF47ArWrXrW8Gw4Durg_yoWrKrWfpr
	n8tFWfJr4kXry8KwnFyr47Za4fAw4jqF1UG3s3JrWjy34j9ry8tFy7tr15CF4xGrnYkr9r
	ZFZ0qr1Uury5JaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIa
	0PDUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Hi Adrian,

On 2026/7/21 16:08, Adrian Hunter wrote:
> On 01/07/2026 06:53, Tengda Wu wrote:
>> When using --itrace=M for data type profiling on arm64, the 'Percent'
>> values in perf annotate output are all zero:
>>
>> Annotate type: 'struct mmu_gather_batch' in [kernel.kallsyms] (15 samples):
>> ============================================================================
>>  Percent     offset       size  field
>>     0.00          0       0x10  struct mmu_gather_batch  {
>>     0.00          0        0x8      struct mmu_gather_batch*    next;
>>     0.00        0x8        0x4      unsigned int        nr;
>>     0.00        0xc        0x4      unsigned int        max;
>>     0.00       0x10          0      struct encoded_page*[]      encoded_pages;
>>                                 };
>>
>> However, adding the -n option reveals non-zero sample counts:
>>
>> Annotate type: 'struct mmu_gather_batch' in [kernel.kallsyms] (15 samples):
>> ============================================================================
>>  Samples     offset       size  field
>>       15          0       0x10  struct mmu_gather_batch  {
>>       13          0        0x8      struct mmu_gather_batch*    next;
>>        2        0x8        0x4      unsigned int        nr;
>>        0        0xc        0x4      unsigned int        max;
>>        0       0x10          0      struct encoded_page*[]      encoded_pages;
>>                                 };
>>
>> The root cause is that when period is not explicitly specified in the
>> --itrace option, it remains zero after itrace_do_parse_synth_opts().
>> The zero period then flows through annotated_data_type__update_samples()
>> where h->period accumulates to zero, and print_annotated_data_type_value()
>> calculates the 'Percent' as zero.
> 
> The period is for instructions samples i.e. options 'i' or 'y'.  Why is
> it being used in the 'M' case?  What samples are being synthesized in
> that case?
> 

The 'M' case is just one example. On arm64, 't' and 'f' also have the
same percent-zero issue.

How ARM SPE synthesizes events:

ARM SPE can synthesize multiple event types from a single instruction.
For example, the 'M' case targets instructions that cause memory
interaction events, while the 't' case targets instructions that trigger
TLB access/miss events. Users can specify the desired event types via
the itrace option to obtain corresponding data type profiling results.

How data type computes Percent:

Data type profiling computes Percent based on the period. The flow is as
follows:

arm_spe_prep_sample():
        sample->period = spe->synth_opts.period;

__hists__add_entry():
        he.stat.period = sample->period;

annotated_data_type__update_samples():
        h->period += period;
        h->addr[offset].period += period;

print_annotated_data_value():
        double percent = h->period ? (100.0 * period / h->period) : 0;

Therefore, if synth_opts.period is not specified (remains zero), the
final Percent calculation results in zero.

As you pointed out, if period is intended to be limited to only the 'i'
and 'y' options, then setting period to 1 in the current patch may not
be appropriate.

In fact, within print_annotated_data_value(), Percent could also be
computed from the sample count. Moreover, I noticed that 'perf annotate'
already has a --percent-type parameter that allows users to specify
whether Percent is based on period or hit (which I understand to be the
sample count). Perhaps it would be more reasonable to adapt
print_annotated_data_value() to honor the --percent-type parameter
instead.

Thanks,
Tengda

>>
>> In itrace_do_parse_synth_opts(), non-'iy' options have their period
>> type set to PERF_ITRACE_PERIOD_INSTRUCTIONS, but period remains zero.
>> Since a zero period is meaningless for this type, default to 1 (one
>> sample per instruction).
>>
>> With this fix applied, the result is as follows:
>>
>> Annotate type: 'struct mmu_gather_batch' in [kernel.kallsyms] (15 samples):
>> ============================================================================
>>  Percent     offset       size  field
>>   100.00          0       0x10  struct mmu_gather_batch  {
>>    86.67          0        0x8      struct mmu_gather_batch*    next;
>>    13.33        0x8        0x4      unsigned int        nr;
>>     0.00        0xc        0x4      unsigned int        max;
>>     0.00       0x10          0      struct encoded_page*[]      encoded_pages;
>>                                 };
>>
>> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
>> ---
>>  tools/perf/util/auxtrace.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
>> index 0b851f32e98c..415b68a2bba9 100644
>> --- a/tools/perf/util/auxtrace.c
>> +++ b/tools/perf/util/auxtrace.c
>> @@ -1759,6 +1759,12 @@ int itrace_do_parse_synth_opts(struct itrace_synth_opts *synth_opts,
>>  			synth_opts->period = PERF_ITRACE_DEFAULT_PERIOD;
>>  	}
>>  
>> +	if (!period_set &&
>> +	    synth_opts->period_type == PERF_ITRACE_PERIOD_INSTRUCTIONS) {
>> +		/* Indicates a sample is taken for every instruction. */
>> +		synth_opts->period = 1;
>> +	}
>> +
>>  	return 0;
>>  
>>  out_err:
> 


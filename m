Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938C4C47095
	for <linux-perf-users@archiver.kernel.org>; Wed,  9 Jun 2021 08:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E9436136D
	for <linux-perf-users@archiver.kernel.org>; Wed,  9 Jun 2021 08:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237329AbhFIIZF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 9 Jun 2021 04:25:05 -0400
Received: from mga01.intel.com ([192.55.52.88]:7219 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236161AbhFIIZC (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 9 Jun 2021 04:25:02 -0400
IronPort-SDR: npEVE186Hlzc8j6uSYt+hBaEPhWWnzZ+YTkyfMWbnX0/GAD9f9meAKZnxpLbbrq7qpHlEMJ9Jn
 MtIoLOzh/Yvw==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="226395376"
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; 
   d="scan'208";a="226395376"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 01:23:00 -0700
IronPort-SDR: 7PEud1cuUSnZaaYrwPItsgM29nX57AV8UOQZF+rIBpJ1HMHahxHxx4pGAdJBq15m7Pker0o5nl
 bzOIPse5OozQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; 
   d="scan'208";a="482294965"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.79]) ([10.237.72.79])
  by orsmga001.jf.intel.com with ESMTP; 09 Jun 2021 01:22:56 -0700
Subject: Re: [PATCH v2 8/8] perf record: Directly bail out for compat case
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
References: <20210602103007.184993-1-leo.yan@linaro.org>
 <20210602103007.184993-9-leo.yan@linaro.org>
 <c321e998-6fd2-86e9-7876-7250a9b23c25@intel.com>
 <20210602123847.GE10272@leoy-ThinkPad-X240s>
 <96e5fac6-17a2-ea03-9b15-338b84321ecf@intel.com>
 <20210607150903.GC1071897@leoy-ThinkPad-X240s>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <d87d8fd8-c6f1-9d9b-5c2e-629588123a9c@intel.com>
Date:   Wed, 9 Jun 2021 11:23:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210607150903.GC1071897@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 7/06/21 6:09 pm, Leo Yan wrote:
> On Mon, Jun 07, 2021 at 01:23:43PM +0300, Adrian Hunter wrote:
>> On 2/06/21 3:38 pm, Leo Yan wrote:
>>> Hi Adrain,
>>>
>>> On Wed, Jun 02, 2021 at 02:18:47PM +0300, Adrian Hunter wrote:
>>>> On 2/06/21 1:30 pm, Leo Yan wrote:
>>>>> Since the 64-bit atomicity is not promised in 32-bit perf, directly
>>>>> report the error and bail out for this case.
>>>>>
>>>>> Now only applies on x86_64 and Arm64 platforms.
>>>>>
>>>>> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
>>>>
>>>> Maybe we can do better for the compat case.
>>>>
>>>> We can assume the upper 32-bits change very seldom,
>>>> and always increase. So for the 'read' case:
>>>>
>>>> 	u64 first, second, last;
>>>> 	u64 mask = (u64)((u32)-1) << 32;
>>>>
>>>> 	do {
>>>> 		first = READ_ONCE(pc->aux_head);
>>>> 		rmb();
>>>> 		second = READ_ONCE(pc->aux_head);
>>>> 		rmb();
>>>> 		last = READ_ONCE(pc->aux_head);
>>>> 	} while ((first & mask) != (last & mask));
>>>> 	return second;
>>>>
>>>> For the write case, we can cause a fatal error only if the new
>>>> tail has non-zero upper 32-bits.  That gives up to 4GiB of data
>>>> before aborting:
>>>>
>>>> 	if (tail & mask)
>>>> 		return -1;
>>>> 	smp_mb();
>>>> 	WRITE_ONCE(pc->aux_tail, tail);
>>>
>>> Seems to me, it's pointless to only support aux_head for 64-bit and
>>> support aux_tail for 32-bit.  I understand this can be helpful for the
>>> snapshot mode which only uses aux_head, but it still fails to support
>>> the normal case for AUX ring buffer using 64-bit head/tail.
>>
>> I am not sure why you say it is pointless.  'perf record' would still be
>> able to capture up to 4GiB of data. Do you mean you usually capture more
>> than 4GiB of data?
> 
> Okay, understand.  We can support 32-bit perf for compat mode when the
> trace data is less than 4GiB.
> 
>> I was thinking we would separate out the compat case:
>>
>> #if BITS_PER_LONG == 32
>> 	if (kernel_is_64_bit)
>> 		return compat_auxtrace_mmap__[read_head/write_tail]()
>> #endif
>>
>> So the non-compat cases would not be affected.
> 
> Because I don't want to introduce the complexity for read/write head
> and tail, and we also need to handle the same issue for the perf ring
> buffer.  So how about below change?
> 
> The main idea for below change is it allows the perf to run normally
> on the compat mode and exitly if detects the buffer head is close to
> the low 32-bit's overflow: when detect the low 32-bit value is bigger
> than 0xf0000000 (so we have 256MiB margin to the overflow), it reports
> error and exit.
> 
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index 1b4091a3b508..2a9965bfeab4 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -1693,6 +1693,14 @@ static int __auxtrace_mmap__read(struct mmap *map,
>  	pr_debug3("auxtrace idx %d old %#"PRIx64" head %#"PRIx64" diff %#"PRIx64"\n",
>  		  mm->idx, old, head, head - old);
>  
> +#ifdef BITS_PER_LONG == 32
> +	if (kernel_is_64bit() && head >= 0xf0000000) {

You are assuming the head never increases by more than 256MiB which
means you should limit the buffer size to 256MiB maximum.

To me this seems a bit too far from an ideal solution.

I would have thought separating out the compat case makes things
simpler to understand.

> +		pr_err("32-bit perf cannot read 64-bit value atomically;\n");
> +		pr_err("exit to avoid the 4GB (32-bit) AUX buffer overflow on compat mode.\n");
> +		return -ENOMEM;
> +	}
> +#endif
> +
>  	if (mm->mask) {
>  		head_off = head & mm->mask;
>  		old_off = old & mm->mask;
> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> index 9130f6fad8d5..823b69895b85 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c
> @@ -405,3 +405,20 @@ int perf_env__numa_node(struct perf_env *env, int cpu)
>  
>  	return cpu >= 0 && cpu < env->nr_numa_map ? env->numa_map[cpu] : -1;
>  }
> +
> +int perf_kernel_is_64bit(void)
> +{
> +	struct utsname uts;
> +	int ret;
> +
> +	ret = uname(&uts);
> +	if (ret < 0)
> +		return 0;
> +
> +	if (!strncmp(uts.machine, "x86_64", 6) ||
> +	    !strncmp(uts.machine, "aarch64", 7) ||
> +	    !strncmp(uts.machine, "arm64", 5))
> +		return 1;
> +
> +	return 0;
> +}

Obviously, we don't need to keep checking uname. It could be a global variable
that is always set up early.


> diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
> index ca249bf5e984..c6c034fc08f6 100644
> --- a/tools/perf/util/env.h
> +++ b/tools/perf/util/env.h
> @@ -147,4 +147,6 @@ void perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node);
>  struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id);
>  
>  int perf_env__numa_node(struct perf_env *env, int cpu);
> +
> +int perf_kernel_is_64bit(void);
>  #endif /* __PERF_ENV_H */
> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> index ab7108d22428..f1d3725d599a 100644
> --- a/tools/perf/util/mmap.c
> +++ b/tools/perf/util/mmap.c
> @@ -323,6 +323,14 @@ int perf_mmap__push(struct mmap *md, void *to,
>  	if (rc < 0)
>  		return (rc == -EAGAIN) ? 1 : -1;
>  
> +#ifdef BITS_PER_LONG == 32
> +	if (kernel_is_64bit() && head >= 0xf0000000) {
> +		pr_err("32-bit perf cannot read 64-bit value atomically;\n");
> +		pr_err("exit to avoid the 4GB (32-bit) buffer overflow on compat mode.\n");
> +		return -ENOMEM;
> +	}
> +#endif
> +
>  	size = md->core.end - md->core.start;
>  
>  	if ((md->core.start & md->core.mask) + size != (md->core.end & md->core.mask)) {
> 
> Thanks,
> Leo
> 


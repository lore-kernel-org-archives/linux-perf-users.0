Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AC7C07E95
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 07:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 747E2611C1
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 07:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbhGMHJr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Jul 2021 03:09:47 -0400
Received: from mga05.intel.com ([192.55.52.43]:29445 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232908AbhGMHJq (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Jul 2021 03:09:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10043"; a="295759013"
X-IronPort-AV: E=Sophos;i="5.84,235,1620716400"; 
   d="scan'208";a="295759013"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 00:06:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,235,1620716400"; 
   d="scan'208";a="492642935"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.79]) ([10.237.72.79])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Jul 2021 00:06:52 -0700
Subject: Re: [PATCH v4 11/11] perf auxtrace: Add
 compat_auxtrace_mmap__{read_head|write_tail}
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
References: <20210711104105.505728-1-leo.yan@linaro.org>
 <20210711104105.505728-12-leo.yan@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <2e4cbd2f-19b6-6fca-a8e3-86ba14247cb8@intel.com>
Date:   Tue, 13 Jul 2021 10:07:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210711104105.505728-12-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 11/07/21 1:41 pm, Leo Yan wrote:
> When perf runs in compat mode (kernel in 64-bit mode and the perf is in
> 32-bit mode), the 64-bit value atomicity in the user space cannot be
> assured, E.g. on some architectures, the 64-bit value accessing is split
> into two instructions, one is for the low 32-bit word accessing and
> another is for the high 32-bit word.
> 
> This patch introduces two functions compat_auxtrace_mmap__read_head()
> and compat_auxtrace_mmap__write_tail(), as their naming indicates, when
> perf tool works in compat mode, it uses these two functions to access
> the AUX head and tail.  These two functions can allow the perf tool to
> work properly in certain conditions, e.g. when perf tool works in
> snapshot mode with only using AUX head pointer, or perf tool uses the
> AUX buffer and the incremented tail is not bigger than 4GB.
> 
> When perf tool cannot handle the case when the AUX tail is bigger than
> 4GB, the function compat_auxtrace_mmap__write_tail() returns -1 and
> tells the caller to bail out for the error.
> 
> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/auxtrace.c |  9 ++--
>  tools/perf/util/auxtrace.h | 94 +++++++++++++++++++++++++++++++++++++-
>  2 files changed, 98 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index 6a63be8b2430..d6fc250fbf97 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -1766,10 +1766,13 @@ static int __auxtrace_mmap__read(struct mmap *map,
>  	mm->prev = head;
>  
>  	if (!snapshot) {
> -		auxtrace_mmap__write_tail(mm, head);
> -		if (itr->read_finish) {
> -			int err;
> +		int err;
>  
> +		err = auxtrace_mmap__write_tail(mm, head);
> +		if (err < 0)
> +			return err;
> +
> +		if (itr->read_finish) {
>  			err = itr->read_finish(itr, mm->idx);
>  			if (err < 0)
>  				return err;
> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
> index d68a5e80b217..66de7b6e65ec 100644
> --- a/tools/perf/util/auxtrace.h
> +++ b/tools/perf/util/auxtrace.h
> @@ -18,6 +18,8 @@
>  #include <asm/bitsperlong.h>
>  #include <asm/barrier.h>
>  
> +#include "env.h"
> +
>  union perf_event;
>  struct perf_session;
>  struct evlist;
> @@ -440,23 +442,111 @@ struct auxtrace_cache;
>  
>  #ifdef HAVE_AUXTRACE_SUPPORT
>  
> +/*
> + * In the compat mode kernel runs in 64-bit and perf tool runs in 32-bit mode,
> + * 32-bit perf tool cannot access 64-bit value atomically, which might lead to
> + * the issues caused by the below sequence on multiple CPUs: when perf tool
> + * accesses either the load operation or the store operation for 64-bit value,
> + * on some architectures the operation is divided into two instructions, one
> + * is for accessing the low 32-bit value and another is for the high 32-bit;
> + * thus these two user operations can give the kernel chances to access the
> + * 64-bit value, and thus leads to the unexpected load values.
> + *
> + *   kernel (64-bit)                        user (32-bit)
> + *
> + *   if (LOAD ->aux_tail) { --,             LOAD ->aux_head_lo
> + *       STORE $aux_data      |       ,--->
> + *       FLUSH $aux_data      |       |     LOAD ->aux_head_hi
> + *       STORE ->aux_head   --|-------`     smp_rmb()
> + *   }                        |             LOAD $data
> + *                            |             smp_mb()
> + *                            |             STORE ->aux_tail_lo
> + *                            `----------->
> + *                                          STORE ->aux_tail_hi
> + *
> + * For this reason, it's impossible for the perf tool to work correctly when
> + * the AUX head or tail is bigger than 4GB (more than 32 bits length); and we
> + * can not simply limit the AUX ring buffer to less than 4GB, the reason is
> + * the pointers can be increased monotonically (e.g in snapshot mode), whatever

At least for Intel PT, in snapshot mode, the head is always an offset
into the buffer, so never more than 4GB for a 32-bit perf tool. So maybe
leave out "(e.g in snapshot mode)"

> + * the buffer size it is, at the end the head and tail can be bigger than 4GB
> + * and carry out to the high 32-bit.
> + *
> + * To mitigate the issues and improve the user experience, we can allow the
> + * perf tool working in certain conditions and bail out with error if detect
> + * any overflow cannot be handled.
> + *
> + * For reading the AUX head, it reads out the values for three times, and
> + * compares the high 4 bytes of the values between the first time and the last
> + * time, if there has no change for high 4 bytes injected by the kernel during
> + * the user reading sequence, it's safe for use the second value.
> + *
> + * When update the AUX tail and detects any carrying in the high 32 bits, it
> + * means there have two store operations in user space and it cannot promise
> + * the atomicity for 64-bit write, so return '-1' in this case to tell the
> + * caller an overflow error has happened.
> + */
> +static inline u64 compat_auxtrace_mmap__read_head(struct auxtrace_mmap *mm)
> +{
> +	struct perf_event_mmap_page *pc = mm->userpg;
> +	u64 first, second, last;
> +	u64 mask = (u64)(UINT32_MAX) << 32;
> +
> +	do {
> +		first = READ_ONCE(pc->aux_head);
> +		/* Ensure all reads are done after we read the head */
> +		smp_rmb();
> +		second = READ_ONCE(pc->aux_head);
> +		/* Ensure all reads are done after we read the head */
> +		smp_rmb();
> +		last = READ_ONCE(pc->aux_head);
> +	} while ((first & mask) != (last & mask));
> +
> +	return second;
> +}
> +
> +static inline int compat_auxtrace_mmap__write_tail(struct auxtrace_mmap *mm,
> +						    u64 tail)
> +{
> +	struct perf_event_mmap_page *pc = mm->userpg;
> +	u64 mask = (u64)(UINT32_MAX) << 32;
> +
> +	if (tail & mask)
> +		return -1;
> +
> +	/* Ensure all reads are done before we write the tail out */
> +	smp_mb();
> +	WRITE_ONCE(pc->aux_tail, tail);
> +	return 0;
> +}
> +
>  static inline u64 auxtrace_mmap__read_head(struct auxtrace_mmap *mm)
>  {
>  	struct perf_event_mmap_page *pc = mm->userpg;
> -	u64 head = READ_ONCE(pc->aux_head);
> +	u64 head;
> +
> +#if BITS_PER_LONG == 32
> +	if (kernel_is_64_bit)
> +		return compat_auxtrace_mmap__read_head(mm);
> +#endif
> +	head = READ_ONCE(pc->aux_head);
>  
>  	/* Ensure all reads are done after we read the head */
>  	smp_rmb();
>  	return head;
>  }
>  
> -static inline void auxtrace_mmap__write_tail(struct auxtrace_mmap *mm, u64 tail)
> +static inline int auxtrace_mmap__write_tail(struct auxtrace_mmap *mm, u64 tail)
>  {
>  	struct perf_event_mmap_page *pc = mm->userpg;
>  
> +#if BITS_PER_LONG == 32
> +	if (kernel_is_64_bit)
> +		return compat_auxtrace_mmap__write_tail(mm, tail);
> +#endif
>  	/* Ensure all reads are done before we write the tail out */
>  	smp_mb();
>  	WRITE_ONCE(pc->aux_tail, tail);
> +	return 0;
>  }
>  
>  int auxtrace_mmap__mmap(struct auxtrace_mmap *mm,
> 


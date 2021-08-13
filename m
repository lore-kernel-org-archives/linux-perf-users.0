Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676A8C4338F
	for <linux-perf-users@archiver.kernel.org>; Fri, 13 Aug 2021 16:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A74061042
	for <linux-perf-users@archiver.kernel.org>; Fri, 13 Aug 2021 16:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234502AbhHMQXF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 13 Aug 2021 12:23:05 -0400
Received: from foss.arm.com ([217.140.110.172]:55506 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234260AbhHMQXC (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 13 Aug 2021 12:23:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76E851FB;
        Fri, 13 Aug 2021 09:22:35 -0700 (PDT)
Received: from [10.57.41.96] (unknown [10.57.41.96])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 621583F718;
        Fri, 13 Aug 2021 09:22:32 -0700 (PDT)
Subject: Re: [PATCH v1 2/3] perf auxtrace: Add
 compat_auxtrace_mmap__{read_head|write_tail}
To:     Leo Yan <leo.yan@linaro.org>
References: <20210809112727.596876-1-leo.yan@linaro.org>
 <20210809112727.596876-3-leo.yan@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Li Huafei <lihuafei1@huawei.com>, coresight@lists.linaro.org
From:   James Clark <james.clark@arm.com>
Message-ID: <2b4e0c07-a8df-cca6-6a94-328560f4b0c6@arm.com>
Date:   Fri, 13 Aug 2021 17:22:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210809112727.596876-3-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 09/08/2021 12:27, Leo Yan wrote:
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
> + * the pointers can be increased monotonically, whatever the buffer size it is,
> + * at the end the head and tail can be bigger than 4GB and carry out to the
> + * high 32-bit.
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
> +u64 __weak compat_auxtrace_mmap__read_head(struct auxtrace_mmap *mm)
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

Hi Leo,

I had a couple of questions about this bit. If we're assuming that the
high bytes of 'first' and 'last' are equal, then 'second' is supposed
to be somewhere in between or equal to 'first' and 'last'.

If that's the case, wouldn't it be better to return 'last', because it's
closer to the value at the time of reading? And then in that case, if
last is returned, then why do a read for 'second' at all? Can 'second' be
skipped and just read first and last?

Also maybe it won't make a difference, but is there a missing smp_rmb()
between the read of 'last' and 'first'?

Thanks
James

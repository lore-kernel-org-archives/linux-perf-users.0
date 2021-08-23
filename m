Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AE5C4338F
	for <linux-perf-users@archiver.kernel.org>; Mon, 23 Aug 2021 12:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1E1861078
	for <linux-perf-users@archiver.kernel.org>; Mon, 23 Aug 2021 12:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236769AbhHWMYa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 23 Aug 2021 08:24:30 -0400
Received: from foss.arm.com ([217.140.110.172]:52734 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236754AbhHWMYa (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 23 Aug 2021 08:24:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D044101E;
        Mon, 23 Aug 2021 05:23:47 -0700 (PDT)
Received: from [10.57.43.155] (unknown [10.57.43.155])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F3863F766;
        Mon, 23 Aug 2021 05:23:44 -0700 (PDT)
Subject: Re: [PATCH v1 3/3] perf auxtrace arm: Support
 compat_auxtrace_mmap__{read_head|write_tail}
To:     Leo Yan <leo.yan@linaro.org>
References: <20210809112727.596876-1-leo.yan@linaro.org>
 <20210809112727.596876-4-leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Li Huafei <lihuafei1@huawei.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        John Garry <john.garry@huawei.com>, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
From:   James Clark <james.clark@arm.com>
Message-ID: <6ce4057a-57cf-501d-6449-2069cd00ba57@arm.com>
Date:   Mon, 23 Aug 2021 13:23:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210809112727.596876-4-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 09/08/2021 12:27, Leo Yan wrote:
> When the tool runs with compat mode on Arm platform, the kernel is in
> 64-bit mode and user space is in 32-bit mode; the user space can use
> instructions "ldrd" and "strd" for 64-bit value atomicity.
> 
> This patch adds compat_auxtrace_mmap__{read_head|write_tail} for arm
> building, it uses "ldrd" and "strd" instructions to ensure accessing
> atomicity for aux head and tail.  The file arch/arm/util/auxtrace.c is
> built for arm and arm64 building, these two functions are not needed for
> arm64, so check the compiler macro "__arm__" to only include them for
> arm building.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/arch/arm/util/auxtrace.c | 32 +++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
> index b187bddbd01a..c7c7ec0812d5 100644
> --- a/tools/perf/arch/arm/util/auxtrace.c
> +++ b/tools/perf/arch/arm/util/auxtrace.c
> @@ -107,3 +107,35 @@ struct auxtrace_record
>  	*err = 0;
>  	return NULL;
>  }
> +
> +#if defined(__arm__)
> +u64 compat_auxtrace_mmap__read_head(struct auxtrace_mmap *mm)
> +{
> +	struct perf_event_mmap_page *pc = mm->userpg;
> +	u64 result;
> +
> +	__asm__ __volatile__(
> +"	ldrd    %0, %H0, [%1]"
> +	: "=&r" (result)
> +	: "r" (&pc->aux_head), "Qo" (pc->aux_head)
> +	);
> +
> +	return result;
> +}

Hi Leo,

I see that this is a duplicate of the atomic read in arch/arm/include/asm/atomic.h

For x86, it's possible to include tools/include/asm/atomic.h, but that doesn't
include arch/arm/include/asm/atomic.h and there are some other #ifdefs that might
make it not so easy for Arm. Just wondering if you considered trying to include the
existing one? Or decided that it was easier to duplicate it?

Other than that, I have tested that the change works with a 32bit build with snapshot
and normal mode.

Reviewed by: James Clark <james.clark@arm.com>
Tested by: James Clark <james.clark@arm.com>
 
> +
> +int compat_auxtrace_mmap__write_tail(struct auxtrace_mmap *mm, u64 tail)
> +{
> +	struct perf_event_mmap_page *pc = mm->userpg;
> +
> +	/* Ensure all reads are done before we write the tail out */
> +	smp_mb();
> +
> +	__asm__ __volatile__(
> +"	strd    %2, %H2, [%1]"
> +	: "=Qo" (pc->aux_tail)
> +	: "r" (&pc->aux_tail), "r" (tail)
> +	);
> +
> +	return 0;
> +}
> +#endif
> 

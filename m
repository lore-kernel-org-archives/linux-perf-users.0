Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCB2C433E6
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Feb 2021 15:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12AE864E6E
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Feb 2021 15:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbhBHPmy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Feb 2021 10:42:54 -0500
Received: from foss.arm.com ([217.140.110.172]:36986 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233438AbhBHPkn (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Feb 2021 10:40:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB9C11FB;
        Mon,  8 Feb 2021 07:39:56 -0800 (PST)
Received: from [10.57.43.128] (unknown [10.57.43.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D1E6E3F719;
        Mon,  8 Feb 2021 07:39:52 -0800 (PST)
Subject: Re: [PATCH 4/4] perf tools: determine if LR is the return address
To:     Alexandre Truong <alexandre.truong@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kemeng Shi <shikemeng@huawei.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Al Grant <al.grant@arm.com>,
        Wilco Dijkstra <wilco.dijkstra@arm.com>
References: <20210122161854.5289-1-alexandre.truong@arm.com>
 <20210122161854.5289-4-alexandre.truong@arm.com>
From:   James Clark <james.clark@arm.com>
Message-ID: <3184a838-9784-eb86-09ad-ceadabcd3381@arm.com>
Date:   Mon, 8 Feb 2021 17:39:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210122161854.5289-4-alexandre.truong@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 22/01/2021 18:18, Alexandre Truong wrote:

> +}
> +
> +static int add_entry(struct unwind_entry *entry, void *arg)
> +{
> +	struct entries *entries = arg;
> +
> +	entries->stack[entries->i++] = entry->ip;
> +	return 0;
> +}
> +
> +u64 get_leaf_frame_caller_aarch64(struct perf_sample *sample, struct thread *thread)
> +{
> +	u64 leaf_frame;
> +	struct entries entries = {{0, 0}, 0};
> +
> +	if (get_leaf_frame_caller_enabled(sample))
> +		return 0;
> +
> +	unwind__get_entries(add_entry, &entries, thread, sample, 2);
> +	leaf_frame = callchain_param.order == ORDER_CALLER ?
> +		entries.stack[0] : entries.stack[1];
> +
> +	if (leaf_frame + 1 == sample->user_regs.regs[PERF_REG_ARM64_LR])
> +		return sample->user_regs.regs[PERF_REG_ARM64_LR];

Hi Alex,

From your other reply about your investigation it looks like the check against PERF_REG_ARM64_LR isn't
required because libunwind won't return a value if it's not correct. Whether it's equal to the LR or not.

And PERF_REG_ARM64_LR points to the instruction _after_ the call site. i.e. where to return to,
not where the call was made from. So just leaf_frame rather than leaf_frame+1 would be more accurate.

I was also looking at unwind_entry in machine.c which is similar to your add_entry function and saw that it
does some extra bits like this:

	if (symbol_conf.hide_unresolved && entry->ms.sym == NULL)
		return 0;

	if (append_inlines(cursor, &entry->ms, entry->ip) == 0)
		return 0;

	/*
	 * Convert entry->ip from a virtual address to an offset in
	 * its corresponding binary.
	 */
	if (entry->ms.map)
		addr = map__map_ip(entry->ms.map, entry->ip);

I have a feeling you will also need to do those on your values returned from libunwind to make it 100%
equivalent.

James

> +	return 0;
> +}
> diff --git a/tools/perf/util/arm-frame-pointer-unwind-support.h b/tools/perf/util/arm-frame-pointer-unwind-support.h
> new file mode 100644
> index 000000000000..16dc03fa9abe
> --- /dev/null
> +++ b/tools/perf/util/arm-frame-pointer-unwind-support.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __PERF_ARM_FRAME_POINTER_UNWIND_SUPPORT_H
> +#define __PERF_ARM_FRAME_POINTER_UNWIND_SUPPORT_H
> +
> +u64 get_leaf_frame_caller_aarch64(struct perf_sample *sample, struct thread *thread);
> +
> +#endif /* __PERF_ARM_FRAME_POINTER_UNWIND_SUPPORT_H */
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 40082d70eec1..bc6147e46c89 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -34,6 +34,7 @@
>  #include "bpf-event.h"
>  #include <internal/lib.h> // page_size
>  #include "cgroup.h"
> +#include "arm-frame-pointer-unwind-support.h"
>  
>  #include <linux/ctype.h>
>  #include <symbol/kallsyms.h>
> @@ -2671,10 +2672,12 @@ static int find_prev_cpumode(struct ip_callchain *chain, struct thread *thread,
>  	return err;
>  }
>  
> -static u64 get_leaf_frame_caller(struct perf_sample *sample __maybe_unused,
> -		struct thread *thread __maybe_unused)
> +static u64 get_leaf_frame_caller(struct perf_sample *sample, struct thread *thread)
>  {
> -	return 0;
> +	if (strncmp(thread->maps->machine->env->arch, "aarch64", 7) == 0)
> +		return get_leaf_frame_caller_aarch64(sample, thread);
> +	else
> +		return 0;
>  }
>  
>  static int thread__resolve_callchain_sample(struct thread *thread,
> 

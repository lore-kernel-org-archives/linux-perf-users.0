Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0A9C4708F
	for <linux-perf-users@archiver.kernel.org>; Wed,  2 Jun 2021 11:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EB89613B1
	for <linux-perf-users@archiver.kernel.org>; Wed,  2 Jun 2021 11:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbhFBLUZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 2 Jun 2021 07:20:25 -0400
Received: from mga11.intel.com ([192.55.52.93]:54588 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229695AbhFBLUZ (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 2 Jun 2021 07:20:25 -0400
IronPort-SDR: PcnN1ZYgQXagXXVh8549c/4nm++knddi+8z3vp+7m1WXcocGAiqX380u6WDKtSEGTz/LBvm6wZ
 ubM3rOVMTYZA==
X-IronPort-AV: E=McAfee;i="6200,9189,10002"; a="200753169"
X-IronPort-AV: E=Sophos;i="5.83,242,1616482800"; 
   d="scan'208";a="200753169"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 04:18:31 -0700
IronPort-SDR: jBFkqpqJsLwCoFu1dX6G+w7cN+0fUYsPhXufsWCi5oP2GRnVnyNnwRSImg6Xrfn5l0Tcuog1B2
 cdnGu2ae0uKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,242,1616482800"; 
   d="scan'208";a="479672850"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by orsmga001.jf.intel.com with ESMTP; 02 Jun 2021 04:18:26 -0700
Subject: Re: [PATCH v2 8/8] perf record: Directly bail out for compat case
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <c321e998-6fd2-86e9-7876-7250a9b23c25@intel.com>
Date:   Wed, 2 Jun 2021 14:18:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210602103007.184993-9-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 2/06/21 1:30 pm, Leo Yan wrote:
> Since the 64-bit atomicity is not promised in 32-bit perf, directly
> report the error and bail out for this case.
> 
> Now only applies on x86_64 and Arm64 platforms.
> 
> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>

Maybe we can do better for the compat case.

We can assume the upper 32-bits change very seldom,
and always increase. So for the 'read' case:

	u64 first, second, last;
	u64 mask = (u64)((u32)-1) << 32;

	do {
		first = READ_ONCE(pc->aux_head);
		rmb();
		second = READ_ONCE(pc->aux_head);
		rmb();
		last = READ_ONCE(pc->aux_head);
	} while ((first & mask) != (last & mask));
	return second;

For the write case, we can cause a fatal error only if the new
tail has non-zero upper 32-bits.  That gives up to 4GiB of data
before aborting:

	if (tail & mask)
		return -1;
	smp_mb();
	WRITE_ONCE(pc->aux_tail, tail);

> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/builtin-record.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 3337b5f93336..f47e298281f7 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -74,6 +74,7 @@
>  #include <linux/zalloc.h>
>  #include <linux/bitmap.h>
>  #include <sys/time.h>
> +#include <sys/utsname.h>
>  
>  struct switch_output {
>  	bool		 enabled;
> @@ -848,6 +849,22 @@ static int record__mmap_evlist(struct record *rec,
>  				  opts->auxtrace_sample_mode;
>  	char msg[512];
>  
> +#ifndef __LP64__
> +	struct utsname uts;
> +	int ret;
> +
> +	ret = uname(&uts);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!strncmp(uts.machine, "x86_64", 6) || !strncmp(uts.machine, "aarch64", 7) ||
> +	    !strncmp(uts.machine, "arm64", 5)) {
> +		pr_err("Error, 32-bit perf cannot record from a 64-bit kernel.\n"
> +		       "Please use a 64-bit version of perf instead.\n");
> +		return -ENOTSUP;
> +	}
> +#endif
> +
>  	if (opts->affinity != PERF_AFFINITY_SYS)
>  		cpu__setup_cpunode_map();
>  
> 


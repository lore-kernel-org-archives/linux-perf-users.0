Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA014C07E95
	for <linux-perf-users@archiver.kernel.org>; Sat, 10 Jul 2021 12:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D313613BF
	for <linux-perf-users@archiver.kernel.org>; Sat, 10 Jul 2021 12:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhGJMjc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 10 Jul 2021 08:39:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:14794 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230448AbhGJMjc (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 10 Jul 2021 08:39:32 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10040"; a="231600490"
X-IronPort-AV: E=Sophos;i="5.84,229,1620716400"; 
   d="scan'208";a="231600490"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2021 05:36:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,229,1620716400"; 
   d="scan'208";a="629174899"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.79]) ([10.237.72.79])
  by orsmga005.jf.intel.com with ESMTP; 10 Jul 2021 05:36:40 -0700
Subject: Re: [PATCH v3 07/10] perf: Cleanup for
 HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT
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
References: <20210704071644.107397-1-leo.yan@linaro.org>
 <20210704071644.107397-8-leo.yan@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <86cd5d3d-2441-2f8e-28ab-54802e47c68b@intel.com>
Date:   Sat, 10 Jul 2021 15:36:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210704071644.107397-8-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 4/07/21 10:16 am, Leo Yan wrote:
> Since the __sync functions have been dropped, This patch removes unused
> build and checking for HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT in perf tool.
> 
> Note, there have a test for SYNC_COMPARE_AND_SWAP and the test file is
> located in build/feature/test-sync-compare-and-swap.c.  Since there
> still has several components using the sync functions, it's deliberately
> to not be removed.

I don't quite follow that.  If they aren't using the feature test
macro, then why keep the feature test?

> 
>   $ cd linux/tools
>   $ git grep __sync_val_compare_and_swap | awk '{ printf $1"\n" }'
>   build/feature/test-sync-compare-and-swap.c:
>   include/asm-generic/atomic-gcc.h:
>   testing/selftests/bpf/progs/atomics.c:
>   testing/selftests/bpf/progs/atomics.c:
>   testing/selftests/bpf/progs/atomics.c:
>   testing/selftests/bpf/progs/atomics.c:
>   testing/selftests/futex/include/atomic.h:
>   testing/selftests/futex/include/futextest.h:
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/Makefile.config | 4 ----
>  tools/perf/util/auxtrace.c | 5 -----
>  2 files changed, 9 deletions(-)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index eb8e487ef90b..4a0d9a6defc7 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -349,10 +349,6 @@ CXXFLAGS += $(INC_FLAGS)
>  
>  LIBPERF_CFLAGS := $(CORE_CFLAGS) $(EXTRA_CFLAGS)
>  
> -ifeq ($(feature-sync-compare-and-swap), 1)
> -  CFLAGS += -DHAVE_SYNC_COMPARE_AND_SWAP_SUPPORT
> -endif
> -
>  ifeq ($(feature-pthread-attr-setaffinity-np), 1)
>    CFLAGS += -DHAVE_PTHREAD_ATTR_SETAFFINITY_NP
>  endif
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index 44bd04dbb6d6..db6255b55c90 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -130,11 +130,6 @@ int auxtrace_mmap__mmap(struct auxtrace_mmap *mm,
>  		return 0;
>  	}
>  
> -#if BITS_PER_LONG != 64 && !defined(HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT)
> -	pr_err("Cannot use AUX area tracing mmaps\n");
> -	return -1;
> -#endif
> -
>  	pc->aux_offset = mp->offset;
>  	pc->aux_size = mp->len;
>  
> 


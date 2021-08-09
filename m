Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1F9C4338F
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 20:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBE986101E
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 20:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhHIUCj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 9 Aug 2021 16:02:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:58108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229483AbhHIUCj (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 Aug 2021 16:02:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E02686056B;
        Mon,  9 Aug 2021 20:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628539338;
        bh=n8gtlw3IyiLYqu4+9qU9LPJ3PiUmIz8KgvCh3DjVqOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LgrDCopn65ratKG6U00C/T8QdPzLLrhFq4yK1FHO+k2+eh+EVoS5zjpc+NzBkz+/9
         GF5gghoDes2jbb7VkBzFNe7BZ6cZ+xPBRhRgqYToBICp7ZTNg55B+QIokDaAp/Aif5
         n4QOQX+7BVh6b7pYtzrOFZCUTM0gnYxl4m1TorVobHjN/XPv8OauUPmxWFx/C3W91p
         +FfUY+jmEwJnBqnazaegkVhvWdGn4PGBGW675xDB4gB6wJNCX/pVxEMuze4DPnceOS
         o+FmP4Q/OHxWi3PutG0yvKeBSWyGpG9P08FZAWfZaJ+hoQ6GPOtP9dmdCqjP5dzkxD
         l6xqKWGM7mzGQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 626DC410A0; Mon,  9 Aug 2021 17:02:15 -0300 (-03)
Date:   Mon, 9 Aug 2021 17:02:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Song Liu <songliubraving@fb.com>, x86@kernel.org,
        Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org
Subject: Re: [PATCH v5 8/9] perf: Cleanup for
 HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT
Message-ID: <YRGJx5zJ9/OHob/C@kernel.org>
References: <20210809111407.596077-1-leo.yan@linaro.org>
 <20210809111407.596077-9-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809111407.596077-9-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Aug 09, 2021 at 07:14:06PM +0800, Leo Yan escreveu:
> Since the __sync functions have been dropped, This patch removes unused
> build and checking for HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT in perf tool.
 

Thanks, applied to perf/core.

- Arnaldo

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
> index 2dcf3d12ba32..f33f09b8b535 100644
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
> -- 
> 2.25.1
> 

-- 

- Arnaldo

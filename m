Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A43C4338F
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 20:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 238A76056B
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 20:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbhHIUCs (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 9 Aug 2021 16:02:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:58224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233152AbhHIUCs (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 Aug 2021 16:02:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 35FB461004;
        Mon,  9 Aug 2021 20:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628539347;
        bh=j3hndUG7lkQkjtsWLC+uWaE1KhSwN1hBDeqIoSynZqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZEXhcJ1/owU75BaTBzvK3QMgLAgphLMzuxK8d69yqoBzKlbV8IyS21aNtNK/RWg3e
         evQm5tu5h3uJcn/4XrSWPXCuc/v/vOn1+Vcidxe4AEO1Ynmbya4sn1lcUPs13VWKHh
         S+dES0hzPdYih1DEM0ykSMDQr9mWd67B2IBwITXxbL5Qbdpl0ilIgB+YGl3F5q3gQU
         KUmyl9b/qBsTmw8kbgUs8qKRK0YWJ1WS0tAjS3uBvN+OLn2vtcNVRE+lzNH3jDouvm
         pC/6HzRzIqv89zNYg8HwOqRtV0lVQNTEV5rGKchb6sXtfcDACrViCPnNfcXb6N3mRz
         vLsZA715YKDuw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5D987410A1; Mon,  9 Aug 2021 17:02:24 -0300 (-03)
Date:   Mon, 9 Aug 2021 17:02:24 -0300
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
Subject: Re: [PATCH v5 9/9] tools: Remove feature-sync-compare-and-swap
 feature detection
Message-ID: <YRGJ0IbubWMql/Is@kernel.org>
References: <20210809111407.596077-1-leo.yan@linaro.org>
 <20210809111407.596077-10-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809111407.596077-10-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Aug 09, 2021 at 07:14:07PM +0800, Leo Yan escreveu:
> Since the __sync functions have been removed from perf, it's needless
> for perf tool to test the feature sync-compare-and-swap.
> 
> The feature test is not used by any other components, remove it.

Thanks, applied to perf/core.

- Arnaldo

 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/build/Makefile.feature                     |  1 -
>  tools/build/feature/Makefile                     |  4 ----
>  tools/build/feature/test-all.c                   |  4 ----
>  tools/build/feature/test-sync-compare-and-swap.c | 15 ---------------
>  4 files changed, 24 deletions(-)
>  delete mode 100644 tools/build/feature/test-sync-compare-and-swap.c
> 
> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index 04a8e3db8a54..3dd2f68366f9 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -34,7 +34,6 @@ FEATURE_TESTS_BASIC :=                  \
>          dwarf_getlocations              \
>          eventfd                         \
>          fortify-source                  \
> -        sync-compare-and-swap           \
>          get_current_dir_name            \
>          gettid				\
>          glibc                           \
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index ec203e28407f..eff55d287db1 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -9,7 +9,6 @@ FILES=                                          \
>           test-dwarf_getlocations.bin            \
>           test-eventfd.bin                       \
>           test-fortify-source.bin                \
> -         test-sync-compare-and-swap.bin         \
>           test-get_current_dir_name.bin          \
>           test-glibc.bin                         \
>           test-gtk2.bin                          \
> @@ -260,9 +259,6 @@ $(OUTPUT)test-libdw-dwarf-unwind.bin:
>  $(OUTPUT)test-libbabeltrace.bin:
>  	$(BUILD) # -lbabeltrace provided by $(FEATURE_CHECK_LDFLAGS-libbabeltrace)
>  
> -$(OUTPUT)test-sync-compare-and-swap.bin:
> -	$(BUILD)
> -
>  $(OUTPUT)test-compile-32.bin:
>  	$(CC) -m32 -o $@ test-compile.c
>  
> diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
> index 464873883396..920439527291 100644
> --- a/tools/build/feature/test-all.c
> +++ b/tools/build/feature/test-all.c
> @@ -106,10 +106,6 @@
>  # include "test-libdw-dwarf-unwind.c"
>  #undef main
>  
> -#define main main_test_sync_compare_and_swap
> -# include "test-sync-compare-and-swap.c"
> -#undef main
> -
>  #define main main_test_zlib
>  # include "test-zlib.c"
>  #undef main
> diff --git a/tools/build/feature/test-sync-compare-and-swap.c b/tools/build/feature/test-sync-compare-and-swap.c
> deleted file mode 100644
> index 3bc6b0768a53..000000000000
> --- a/tools/build/feature/test-sync-compare-and-swap.c
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include <stdint.h>
> -
> -volatile uint64_t x;
> -
> -int main(int argc, char *argv[])
> -{
> -	uint64_t old, new = argc;
> -
> -	(void)argv;
> -	do {
> -		old = __sync_val_compare_and_swap(&x, 0, 0);
> -	} while (!__sync_bool_compare_and_swap(&x, old, new));
> -	return old == new;
> -}
> -- 
> 2.25.1
> 

-- 

- Arnaldo

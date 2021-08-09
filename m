Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A989CC4338F
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 19:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8856C60230
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 19:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbhHIUAQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 9 Aug 2021 16:00:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234531AbhHIUAP (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 Aug 2021 16:00:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C720C61004;
        Mon,  9 Aug 2021 19:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628539194;
        bh=Msrq3Ws5eje8NQNbuX6lQYdEdZAw97itqHqwLJx2sy4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hgnff71PIIP9emJH6dKm3PQr1Nd9pecsF8qcvAAmJxmsv84N+mw0rToWe0r/zXPWP
         bnniu+51RrZRqVW8Bab5Ajq0biWvtrbUffHCF4e7nbAve7iw9+0CEcFEx+KNEu8Nj6
         vymzvyeYeuJVh/zms1Bfv4kUB6BfDJJQnsRUKIueyGhJYTTLhxoBYfoL9Bb0FzrprY
         M3LZO4NT74AVFikP121aweiw8nmzVCYtFNrzvLjD7RXcDtqfnutUGbpoxd/SwN6Hly
         b8zlfz3eFNFicLBuipcRA3igb/hq9TGKt0fl5LYgAuk/ETYx5uVA1m1hz4Y3QJQ3wk
         cwlmlD9K7riAg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5F4AB403F2; Mon,  9 Aug 2021 16:59:51 -0300 (-03)
Date:   Mon, 9 Aug 2021 16:59:51 -0300
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
Subject: Re: [PATCH v5 5/9] perf auxtrace: Use WRITE_ONCE() for updating
 aux_tail
Message-ID: <YRGJN/gpf+Q80bd9@kernel.org>
References: <20210809111407.596077-1-leo.yan@linaro.org>
 <20210809111407.596077-6-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809111407.596077-6-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Aug 09, 2021 at 07:14:03PM +0800, Leo Yan escreveu:
> Use WRITE_ONCE() for updating aux_tail, so can avoid unexpected memory
> behaviour.

Thanks, applied to perf/core.

- Arnaldo

 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  tools/perf/util/auxtrace.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
> index cc1c1b9cec9c..79227b8864cd 100644
> --- a/tools/perf/util/auxtrace.h
> +++ b/tools/perf/util/auxtrace.h
> @@ -480,7 +480,7 @@ static inline void auxtrace_mmap__write_tail(struct auxtrace_mmap *mm, u64 tail)
>  	/* Ensure all reads are done before we write the tail out */
>  	smp_mb();
>  #if BITS_PER_LONG == 64 || !defined(HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT)
> -	pc->aux_tail = tail;
> +	WRITE_ONCE(pc->aux_tail, tail);
>  #else
>  	do {
>  		old_tail = __sync_val_compare_and_swap(&pc->aux_tail, 0, 0);
> -- 
> 2.25.1
> 

-- 

- Arnaldo

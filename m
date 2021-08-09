Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6008C4338F
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 14:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FFDF6101D
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 14:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbhHIOyb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 9 Aug 2021 10:54:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:42328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231478AbhHIOya (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 Aug 2021 10:54:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 34A1560C41;
        Mon,  9 Aug 2021 14:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628520850;
        bh=83f7z34kd8o684E4Kj/wmBh4rlOyA2DHLiEBx97X158=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fUr/klYIPb1ZxcX3jinvYOy2b8MjWGO8+yaNWW2gar+4NLhMo3wajUvqFSNzXUQ9x
         b00BroZDDo+qIJqtZWwhdutBAnoblHirWHXAIkpTMaXzFW566kgwkpQXJ2DX7lZZno
         8c5Q+IvC5tal2Gxv2FOiphBCtTCsCIv70bDYOK65WIrOVFue+LuP0udJznyNb19hxS
         cMQupg68tfc19herrrrqN/RS2kJTcfN+BxHVGbc+vdX3HjnBGRx11AmWjmmftUf0t9
         /JFsnVpPs/CQumKeKK/NiIFmYtcxt21aOg8O2k+E70CYlJUrtsxOEOWMRsxebCxA/Q
         wIvvcZ5ROVIrA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 65DBC403F2; Mon,  9 Aug 2021 11:54:07 -0300 (-03)
Date:   Mon, 9 Aug 2021 11:54:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     mingo@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 3/7] perf/bench-futex: Factor out futex_flag
Message-ID: <YRFBj3jGABt1zkQX@kernel.org>
References: <20210809043301.66002-1-dave@stgolabs.net>
 <20210809043301.66002-4-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809043301.66002-4-dave@stgolabs.net>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Sun, Aug 08, 2021 at 09:32:57PM -0700, Davidlohr Bueso escreveu:
> This is common across all tests, move it into futex.h.

Wouldn't be better to have it defined in one place and then in futex.h
just have a 'extern int futex_flag;' declaration?

I applied the first two patches already.

- Arnaldo
 
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> ---
>  tools/perf/bench/futex-hash.c          | 1 -
>  tools/perf/bench/futex-lock-pi.c       | 1 -
>  tools/perf/bench/futex-requeue.c       | 1 -
>  tools/perf/bench/futex-wake-parallel.c | 1 -
>  tools/perf/bench/futex-wake.c          | 1 -
>  tools/perf/bench/futex.h               | 3 +++
>  6 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-hash.c
> index ddca7558e559..b71a34204b79 100644
> --- a/tools/perf/bench/futex-hash.c
> +++ b/tools/perf/bench/futex-hash.c
> @@ -30,7 +30,6 @@
>  #include <err.h>
>  
>  static bool done = false;
> -static int futex_flag = 0;
>  
>  struct timeval bench__start, bench__end, bench__runtime;
>  static pthread_mutex_t thread_lock;
> diff --git a/tools/perf/bench/futex-lock-pi.c b/tools/perf/bench/futex-lock-pi.c
> index ce980df23bb0..bc208edf3de3 100644
> --- a/tools/perf/bench/futex-lock-pi.c
> +++ b/tools/perf/bench/futex-lock-pi.c
> @@ -32,7 +32,6 @@ struct worker {
>  static u_int32_t global_futex = 0;
>  static struct worker *worker;
>  static bool done = false;
> -static int futex_flag = 0;
>  static pthread_mutex_t thread_lock;
>  static unsigned int threads_starting;
>  static struct stats throughput_stats;
> diff --git a/tools/perf/bench/futex-requeue.c b/tools/perf/bench/futex-requeue.c
> index 66747bfe22cf..4001312122be 100644
> --- a/tools/perf/bench/futex-requeue.c
> +++ b/tools/perf/bench/futex-requeue.c
> @@ -36,7 +36,6 @@ static pthread_mutex_t thread_lock;
>  static pthread_cond_t thread_parent, thread_worker;
>  static struct stats requeuetime_stats, requeued_stats;
>  static unsigned int threads_starting;
> -static int futex_flag = 0;
>  
>  static struct bench_futex_parameters params = {
>  	/*
> diff --git a/tools/perf/bench/futex-wake-parallel.c b/tools/perf/bench/futex-wake-parallel.c
> index 958372ad159c..ea4fdea6e2f3 100644
> --- a/tools/perf/bench/futex-wake-parallel.c
> +++ b/tools/perf/bench/futex-wake-parallel.c
> @@ -53,7 +53,6 @@ static pthread_cond_t thread_parent, thread_worker;
>  static pthread_barrier_t barrier;
>  static struct stats waketime_stats, wakeup_stats;
>  static unsigned int threads_starting;
> -static int futex_flag = 0;
>  
>  static struct bench_futex_parameters params;
>  
> diff --git a/tools/perf/bench/futex-wake.c b/tools/perf/bench/futex-wake.c
> index 9ed4d65416f3..1cf651c8ee5c 100644
> --- a/tools/perf/bench/futex-wake.c
> +++ b/tools/perf/bench/futex-wake.c
> @@ -37,7 +37,6 @@ static pthread_mutex_t thread_lock;
>  static pthread_cond_t thread_parent, thread_worker;
>  static struct stats waketime_stats, wakeup_stats;
>  static unsigned int threads_starting;
> -static int futex_flag = 0;
>  
>  static struct bench_futex_parameters params = {
>  	/*
> diff --git a/tools/perf/bench/futex.h b/tools/perf/bench/futex.h
> index 6f8b85b67348..f7cd22bbd677 100644
> --- a/tools/perf/bench/futex.h
> +++ b/tools/perf/bench/futex.h
> @@ -13,6 +13,9 @@
>  #include <sys/types.h>
>  #include <linux/futex.h>
>  
> +/* FUTEX_PRIVATE_FLAG or zero */
> +static int futex_flag = 0;
> +
>  struct bench_futex_parameters {
>  	bool silent;
>  	bool fshared;
> -- 
> 2.26.2
> 

-- 

- Arnaldo

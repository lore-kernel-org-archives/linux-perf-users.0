Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0BFC4338F
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 14:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F4C46101D
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 14:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbhHIO4p (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 9 Aug 2021 10:56:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:47712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234054AbhHIO4p (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 Aug 2021 10:56:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A35C060E97;
        Mon,  9 Aug 2021 14:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628520984;
        bh=+oMVH2KSsU3LfIJY4UlhBzUXGbJvNmJ2lQEqg9/XfCY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dm9JuJNP1KeSOglqUrhRBmt2/kwrgOqJYsJ23UMQVGzy6bnHf4S68WnZT9W0atHco
         oEg7EzbaknjTbVNIpGHxD1GjWxJccr5IbGkzRqV3l15f8vtm0hNjB0pJropb0DOWHx
         0VFtPA5J4pjG3cwcub/8kinz/gQDknQAqAfZc9Y9xfse2CrpPnge+JM3HLdMRuRnI+
         k76aDPHfjoPVqui1l9G9Qcrl+U4k9lZy4RU6hJeQmQl+Rmd2gfQ6qashXwd36QkIKA
         dIQ0X3kwUU6TpuZiqAwVmuja8H7tGw13aqgdDgcbAOUc9Bu/yjl/SMMz3nflF0GYUo
         ZVQzQiJ1z5j7Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 470A6403F2; Mon,  9 Aug 2021 11:56:22 -0300 (-03)
Date:   Mon, 9 Aug 2021 11:56:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     mingo@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 4/7] perf/bench-futex: Add --mlockall parameter
Message-ID: <YRFCFqM9QBoUrl18@kernel.org>
References: <20210809043301.66002-1-dave@stgolabs.net>
 <20210809043301.66002-5-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809043301.66002-5-dave@stgolabs.net>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Sun, Aug 08, 2021 at 09:32:58PM -0700, Davidlohr Bueso escreveu:
> This adds, across all futex benchmarks, the -m/--mlockall option
> which is a common operation for realtime workloads by not incurring
> in page faults in paths that want determinism. As such, threads
> started after a call to mlockall(2) will generate page faults
> immediately since the new stack is immediately forced to memory,
> due to the MCL_FUTURE flag.

Applied.

At some point these options could be handled in a common
futex_parse_options() function that would consume argv[] and then the
specific futex benchmarks would continue from where the common function
left off.

- Arnaldo
 
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> ---
>  tools/perf/bench/futex-hash.c          | 7 +++++++
>  tools/perf/bench/futex-lock-pi.c       | 7 +++++++
>  tools/perf/bench/futex-requeue.c       | 7 +++++++
>  tools/perf/bench/futex-wake-parallel.c | 8 ++++++++
>  tools/perf/bench/futex-wake.c          | 8 ++++++++
>  tools/perf/bench/futex.h               | 1 +
>  6 files changed, 38 insertions(+)
> 
> diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-hash.c
> index b71a34204b79..af9fbb409472 100644
> --- a/tools/perf/bench/futex-hash.c
> +++ b/tools/perf/bench/futex-hash.c
> @@ -20,6 +20,7 @@
>  #include <linux/kernel.h>
>  #include <linux/zalloc.h>
>  #include <sys/time.h>
> +#include <sys/mman.h>
>  #include <perf/cpumap.h>
>  
>  #include "../util/stat.h"
> @@ -55,6 +56,7 @@ static const struct option options[] = {
>  	OPT_UINTEGER('f', "futexes", &params.nfutexes, "Specify amount of futexes per threads"),
>  	OPT_BOOLEAN( 's', "silent",  &params.silent, "Silent mode: do not display data/details"),
>  	OPT_BOOLEAN( 'S', "shared",  &params.fshared, "Use shared futexes instead of private ones"),
> +	OPT_BOOLEAN( 'm', "mlockall", &params.mlockall, "Lock all current and future memory"),
>  	OPT_END()
>  };
>  
> @@ -141,6 +143,11 @@ int bench_futex_hash(int argc, const char **argv)
>  	act.sa_sigaction = toggle_done;
>  	sigaction(SIGINT, &act, NULL);
>  
> +	if (params.mlockall) {
> +		if (mlockall(MCL_CURRENT | MCL_FUTURE))
> +			err(EXIT_FAILURE, "mlockall");
> +	}
> +
>  	if (!params.nthreads) /* default to the number of CPUs */
>  		params.nthreads = cpu->nr;
>  
> diff --git a/tools/perf/bench/futex-lock-pi.c b/tools/perf/bench/futex-lock-pi.c
> index bc208edf3de3..d2927d2eb3f7 100644
> --- a/tools/perf/bench/futex-lock-pi.c
> +++ b/tools/perf/bench/futex-lock-pi.c
> @@ -21,6 +21,7 @@
>  #include <err.h>
>  #include <stdlib.h>
>  #include <sys/time.h>
> +#include <sys/mman.h>
>  
>  struct worker {
>  	int tid;
> @@ -47,6 +48,7 @@ static const struct option options[] = {
>  	OPT_BOOLEAN( 'M', "multi",   &params.multi, "Use multiple futexes"),
>  	OPT_BOOLEAN( 's', "silent",  &params.silent, "Silent mode: do not display data/details"),
>  	OPT_BOOLEAN( 'S', "shared",  &params.fshared, "Use shared futexes instead of private ones"),
> +	OPT_BOOLEAN( 'm', "mlockall", &params.mlockall, "Lock all current and future memory"),
>  	OPT_END()
>  };
>  
> @@ -164,6 +166,11 @@ int bench_futex_lock_pi(int argc, const char **argv)
>  	act.sa_sigaction = toggle_done;
>  	sigaction(SIGINT, &act, NULL);
>  
> +	if (params.mlockall) {
> +		if (mlockall(MCL_CURRENT | MCL_FUTURE))
> +			err(EXIT_FAILURE, "mlockall");
> +	}
> +
>  	if (!params.nthreads)
>  		params.nthreads = cpu->nr;
>  
> diff --git a/tools/perf/bench/futex-requeue.c b/tools/perf/bench/futex-requeue.c
> index 4001312122be..88cb7e2a6729 100644
> --- a/tools/perf/bench/futex-requeue.c
> +++ b/tools/perf/bench/futex-requeue.c
> @@ -27,6 +27,7 @@
>  #include <err.h>
>  #include <stdlib.h>
>  #include <sys/time.h>
> +#include <sys/mman.h>
>  
>  static u_int32_t futex1 = 0, futex2 = 0;
>  
> @@ -50,6 +51,7 @@ static const struct option options[] = {
>  	OPT_UINTEGER('q', "nrequeue", &params.nrequeue, "Specify amount of threads to requeue at once"),
>  	OPT_BOOLEAN( 's', "silent",   &params.silent, "Silent mode: do not display data/details"),
>  	OPT_BOOLEAN( 'S', "shared",   &params.fshared, "Use shared futexes instead of private ones"),
> +	OPT_BOOLEAN( 'm', "mlockall", &params.mlockall, "Lock all current and future memory"),
>  	OPT_END()
>  };
>  
> @@ -133,6 +135,11 @@ int bench_futex_requeue(int argc, const char **argv)
>  	act.sa_sigaction = toggle_done;
>  	sigaction(SIGINT, &act, NULL);
>  
> +	if (params.mlockall) {
> +		if (mlockall(MCL_CURRENT | MCL_FUTURE))
> +			err(EXIT_FAILURE, "mlockall");
> +	}
> +
>  	if (!params.nthreads)
>  		params.nthreads = cpu->nr;
>  
> diff --git a/tools/perf/bench/futex-wake-parallel.c b/tools/perf/bench/futex-wake-parallel.c
> index ea4fdea6e2f3..ef1f8237fd81 100644
> --- a/tools/perf/bench/futex-wake-parallel.c
> +++ b/tools/perf/bench/futex-wake-parallel.c
> @@ -34,6 +34,7 @@ int bench_futex_wake_parallel(int argc __maybe_unused, const char **argv __maybe
>  #include <err.h>
>  #include <stdlib.h>
>  #include <sys/time.h>
> +#include <sys/mman.h>
>  
>  struct thread_data {
>  	pthread_t worker;
> @@ -61,6 +62,8 @@ static const struct option options[] = {
>  	OPT_UINTEGER('w', "nwakers", &params.nwakes, "Specify amount of waking threads"),
>  	OPT_BOOLEAN( 's', "silent",  &params.silent, "Silent mode: do not display data/details"),
>  	OPT_BOOLEAN( 'S', "shared",  &params.fshared, "Use shared futexes instead of private ones"),
> +	OPT_BOOLEAN( 'm', "mlockall", &params.mlockall, "Lock all current and future memory"),
> +
>  	OPT_END()
>  };
>  
> @@ -238,6 +241,11 @@ int bench_futex_wake_parallel(int argc, const char **argv)
>  	act.sa_sigaction = toggle_done;
>  	sigaction(SIGINT, &act, NULL);
>  
> +	if (params.mlockall) {
> +		if (mlockall(MCL_CURRENT | MCL_FUTURE))
> +			err(EXIT_FAILURE, "mlockall");
> +	}
> +
>  	cpu = perf_cpu_map__new(NULL);
>  	if (!cpu)
>  		err(EXIT_FAILURE, "calloc");
> diff --git a/tools/perf/bench/futex-wake.c b/tools/perf/bench/futex-wake.c
> index 1cf651c8ee5c..40e492c7996a 100644
> --- a/tools/perf/bench/futex-wake.c
> +++ b/tools/perf/bench/futex-wake.c
> @@ -27,6 +27,7 @@
>  #include <err.h>
>  #include <stdlib.h>
>  #include <sys/time.h>
> +#include <sys/mman.h>
>  
>  /* all threads will block on the same futex */
>  static u_int32_t futex1 = 0;
> @@ -51,6 +52,8 @@ static const struct option options[] = {
>  	OPT_UINTEGER('w', "nwakes",  &params.nwakes, "Specify amount of threads to wake at once"),
>  	OPT_BOOLEAN( 's', "silent",  &params.silent, "Silent mode: do not display data/details"),
>  	OPT_BOOLEAN( 'S', "shared",  &params.fshared, "Use shared futexes instead of private ones"),
> +	OPT_BOOLEAN( 'm', "mlockall", &params.mlockall, "Lock all current and future memory"),
> +
>  	OPT_END()
>  };
>  
> @@ -141,6 +144,11 @@ int bench_futex_wake(int argc, const char **argv)
>  	act.sa_sigaction = toggle_done;
>  	sigaction(SIGINT, &act, NULL);
>  
> +	if (params.mlockall) {
> +		if (mlockall(MCL_CURRENT | MCL_FUTURE))
> +			err(EXIT_FAILURE, "mlockall");
> +	}
> +
>  	if (!params.nthreads)
>  		params.nthreads = cpu->nr;
>  
> diff --git a/tools/perf/bench/futex.h b/tools/perf/bench/futex.h
> index f7cd22bbd677..1c8fa469993f 100644
> --- a/tools/perf/bench/futex.h
> +++ b/tools/perf/bench/futex.h
> @@ -19,6 +19,7 @@ static int futex_flag = 0;
>  struct bench_futex_parameters {
>  	bool silent;
>  	bool fshared;
> +	bool mlockall;
>  	bool multi; /* lock-pi */
>  	unsigned int runtime; /* seconds*/
>  	unsigned int nthreads;
> -- 
> 2.26.2
> 

-- 

- Arnaldo

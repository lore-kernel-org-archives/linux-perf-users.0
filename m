Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAE6C433F5
	for <linux-perf-users@archiver.kernel.org>; Sat, 13 Nov 2021 14:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA64A6108E
	for <linux-perf-users@archiver.kernel.org>; Sat, 13 Nov 2021 14:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbhKMO1l (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 13 Nov 2021 09:27:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:44488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231912AbhKMO1k (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 13 Nov 2021 09:27:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5238C60F14;
        Sat, 13 Nov 2021 14:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636813488;
        bh=FT8gMq+MSBzairgpGlCKoivpdpULKI7Z2H6kOiyfbEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XJHrxE14XwbIObDWgJbgAYnx53J5XDDD+BMFAms6iQ57HFkNe3qYTL352JW4EdH7o
         yMNrAKAvD5Y4sAythaQRANzofrU+xRUeLf83dL+nxq1oU8V6OPAvxVueJsgV8L00pP
         X2Di42kJ28wdwgBduf3Vrx1WwQ5SYqSyTzzqjAvVbWIygdyOBhC8yYBhRnxB3obZ5U
         hVaKSOSxW+3fRhO2svYFQr4dMnRT7yI9qXmmFef2hvO+aaNL8bssdg+0E6THIdcJhi
         beXNNcDL9UY8yP0uB0onPH/L3XPKasTwjVEcgmBVMBvrkv+NvGxZOqfHg87aS5qBxY
         5BTztMMgPZAXQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DB205410A2; Sat, 13 Nov 2021 11:24:45 -0300 (-03)
Date:   Sat, 13 Nov 2021 11:24:45 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Sohaib Mohamed <sohaib.amhmd@gmail.com>
Cc:     irogers@google.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf bench: futex: Fix memory leak of perf_cpu_map__new
Message-ID: <YY/Krdzop6DY8KHv@kernel.org>
References: <20211112201134.77892-1-sohaib.amhmd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112201134.77892-1-sohaib.amhmd@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Nov 12, 2021 at 10:11:33PM +0200, Sohaib Mohamed escreveu:
> ASan reports memory leaks while running:
> 
> $ sudo ./perf bench futex all
> 
> The leaks are caused by perf_cpu_map__new not being freed.
> This patch adds the missing perf_cpu_map__put since it calls
> cpu_map_delete implicitly.
> 
> Fixes: 9c3516d1b850 ("libperf: Add perf_cpu_map__new()/perf_cpu_map__read() functions")

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
> ---
>  tools/perf/bench/futex-lock-pi.c       | 1 +
>  tools/perf/bench/futex-requeue.c       | 1 +
>  tools/perf/bench/futex-wake-parallel.c | 1 +
>  tools/perf/bench/futex-wake.c          | 1 +
>  4 files changed, 4 insertions(+)
> 
> diff --git a/tools/perf/bench/futex-lock-pi.c b/tools/perf/bench/futex-lock-pi.c
> index 5d1fe9c35807..137890f78e17 100644
> --- a/tools/perf/bench/futex-lock-pi.c
> +++ b/tools/perf/bench/futex-lock-pi.c
> @@ -233,6 +233,7 @@ int bench_futex_lock_pi(int argc, const char **argv)
>  	print_summary();
> 
>  	free(worker);
> +	perf_cpu_map__put(cpu);
>  	return ret;
>  err:
>  	usage_with_options(bench_futex_lock_pi_usage, options);
> diff --git a/tools/perf/bench/futex-requeue.c b/tools/perf/bench/futex-requeue.c
> index 97fe31fd3a23..f7a5ffebb940 100644
> --- a/tools/perf/bench/futex-requeue.c
> +++ b/tools/perf/bench/futex-requeue.c
> @@ -294,6 +294,7 @@ int bench_futex_requeue(int argc, const char **argv)
>  	print_summary();
> 
>  	free(worker);
> +	perf_cpu_map__put(cpu);
>  	return ret;
>  err:
>  	usage_with_options(bench_futex_requeue_usage, options);
> diff --git a/tools/perf/bench/futex-wake-parallel.c b/tools/perf/bench/futex-wake-parallel.c
> index e970e6b9ad53..0983f40b4b40 100644
> --- a/tools/perf/bench/futex-wake-parallel.c
> +++ b/tools/perf/bench/futex-wake-parallel.c
> @@ -329,6 +329,7 @@ int bench_futex_wake_parallel(int argc, const char **argv)
>  	print_summary();
> 
>  	free(blocked_worker);
> +	perf_cpu_map__put(cpu);
>  	return ret;
>  }
>  #endif /* HAVE_PTHREAD_BARRIER */
> diff --git a/tools/perf/bench/futex-wake.c b/tools/perf/bench/futex-wake.c
> index 77f058a47790..2226a475e782 100644
> --- a/tools/perf/bench/futex-wake.c
> +++ b/tools/perf/bench/futex-wake.c
> @@ -222,5 +222,6 @@ int bench_futex_wake(int argc, const char **argv)
>  	print_summary();
> 
>  	free(worker);
> +	perf_cpu_map__put(cpu);
>  	return ret;
>  }
> --
> 2.25.1

-- 

- Arnaldo

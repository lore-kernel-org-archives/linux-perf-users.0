Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8FF4562A1;
	Mon,  5 Oct 2026 23:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791244639; cv=none; b=HOJTwHogVmq7o4PN++RbwlQKQF3/WXDet0NORBp7/7HjlFWY09p3NF+RoFjRux9MHRaV9pH1B9jpK/zkQU04MtapV9Crl1Z3CAHI+5AJwVDfYhl9gpLo9wuU+IYDsDGI9JGm9KabRrv8Gf21E23zVidKSix3X9f+aLU59TRXDVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791244639; c=relaxed/simple;
	bh=yT8gqoa/4ztRFgqPSpI0BXdonF3WA+i3bPo/ylqQDb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1ORR2AratdL/NNQejX33OoQoSvkbTFu5z/33MAHwji6avzZC3l7R9DUMqS4dceA1YYUv1rLgH008lXtYbrF/uaTpeQprsROP4FHnjt9QlVXirzREEA7Rx0wIJH+SNemrA+qqhflHLxjTA5Dj7n0mlFrXyDc0Z9v5h+eeYUwIdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNFsT5Fc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNFsT5Fc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AFE01F00893;
	Mon,  5 Oct 2026 23:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791244637;
	bh=GmqChsCskmeQWDGnrsanwnuTgpC2kNrMBJyEC7YtwtI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NNFsT5FcHGlH8uMN6RFjdOlbq3j8Ol10dUvHoOvflGFkgBIv5QlNA3OiBbVgHle4K
	 wIccpBgIFr4/4SHeDuf1QK6nBJsqNhAQoUc6My5UW8ypYSL0ujIhjNBCP7KDVB9zy2
	 xKHYpuyUduscJ1j1T8dUdxmOUUjldcjPWDLImhVnP5fEvofPN+NJhUXrfo2+BA/UPb
	 Yhw/0KMAt9cIWaZFbJLcTYsJwrEDjlA/IoVQeIBm05rcr5QT//szRNd1g5ajPjJmb7
	 ZaC4P5zJGRDkHRKQZak3dz3wK/qQuBbzR8q6L97dVinFKAKU2AOXT0e/8XSjlOtmWv
	 8+ae55tnUu+MA==
Date: Mon, 5 Oct 2026 16:57:15 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Michal Pluta <michalpl2003@gmail.com>
Cc: acme@kernel.org, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 8/8] perf bench futex: Fix wording in futex bench messages
Message-ID: <asQ5W6FU7l5LlYEo@google.com>
References: <20260926190407.1106421-1-michalpl2003@gmail.com>
 <20260926190407.1106421-9-michalpl2003@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260926190407.1106421-9-michalpl2003@gmail.com>

On Sat, Sep 26, 2026 at 08:04:07PM +0100, Michal Pluta wrote:
> When the kernel is using a different number of hash buckets than
> requested with -b, the message printed is ungrammatical, and it ends
> with a stale errno even though nothing failed:
> 
>   Requested number of hash buckets does not currently used.
>   Requested: 3 in usage: 64
>   perf: prctl(PR_FUTEX_HASH): No such file or directory
> 
> Fix the wording and use errx(), so that no errno text is printed:
> 
>   Requested number of buckets differs from the number in use.
>   Requested: 3, in use: 64
>   perf: prctl(PR_FUTEX_HASH)

Maybe better split the errx() change as it seems there are some other
places need the same change.

Thanks,
Namhyung

> 
> Also fix "Wokeup" in the 'futex wake' output, which should be "Woke up".
> 
> Fixes: 60035a3981a7 ("tools/perf: Allow to select the number of hash buckets")
> Assisted-by: LLM
> Signed-off-by: Michal Pluta <michalpl2003@gmail.com>
> ---
>  tools/perf/bench/futex-wake.c | 4 ++--
>  tools/perf/bench/futex.c      | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/bench/futex-wake.c b/tools/perf/bench/futex-wake.c
> index 7674622639ca..2cbf31e121d5 100644
> --- a/tools/perf/bench/futex-wake.c
> +++ b/tools/perf/bench/futex-wake.c
> @@ -89,7 +89,7 @@ static void print_summary(void)
>  	double waketime_stddev = stddev_stats(&waketime_stats);
>  	unsigned int wakeup_avg = avg_stats(&wakeup_stats);
>  
> -	printf("Wokeup %d of %d threads in %.4f ms (+-%.2f%%)\n",
> +	printf("Woke up %d of %d threads in %.4f ms (+-%.2f%%)\n",
>  	       wakeup_avg,
>  	       params.nthreads,
>  	       waketime_avg / USEC_PER_MSEC,
> @@ -223,7 +223,7 @@ int bench_futex_wake(int argc, const char **argv)
>  		update_stats(&waketime_stats, runtime_us);
>  
>  		if (!params.silent) {
> -			printf("[Run %d]: Wokeup %d of %d threads in %.4f ms\n",
> +			printf("[Run %d]: Woke up %d of %d threads in %.4f ms\n",
>  			       j + 1, nwoken, params.nthreads,
>  			       runtime_us / (double)USEC_PER_MSEC);
>  		}
> diff --git a/tools/perf/bench/futex.c b/tools/perf/bench/futex.c
> index 5757d47f8f7c..be0cbc03682c 100644
> --- a/tools/perf/bench/futex.c
> +++ b/tools/perf/bench/futex.c
> @@ -43,9 +43,9 @@ void futex_print_nbuckets(struct bench_futex_parameters *params)
>  				printf("Can't query number of buckets: %m\n");
>  				err(EXIT_FAILURE, "prctl(PR_FUTEX_HASH)");
>  			}
> -			printf("Requested number of hash buckets does not currently used.\n");
> -			printf("Requested: %d in usage: %d\n", params->nbuckets, ret);
> -			err(EXIT_FAILURE, "prctl(PR_FUTEX_HASH)");
> +			printf("Requested number of buckets differs from the number in use.\n");
> +			printf("Requested: %d, in use: %d\n", params->nbuckets, ret);
> +			errx(EXIT_FAILURE, "prctl(PR_FUTEX_HASH)");
>  		}
>  		if (params->nbuckets == 0)
>  			ret = asprintf(&futex_hash_mode, "Futex hashing: global hash");
> -- 
> 2.43.0
> 

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8745F382;
	Mon, 10 Mar 2025 22:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741645037; cv=none; b=TVfyXYu4lKhET3zYsi45B+v9i/rH557jRKihlKR7xO5n4TLp90EZ8/LcRvIoYFlGfid7XeK8EtlBJuQT8rtiw1VgK5WLDGNaUWIXloS+BcUtLHAdZkmuekQVI2KDvdAjK6+re9DTVKyiPx/hLWJ0uq7kB4+PYp8AU+wcMhBiIbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741645037; c=relaxed/simple;
	bh=MMlIFG8Zv8CNscu9Rs/8LPn9paecut0nXKKHd2+sAQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BvtvWWDjN7mlc2lfdXEAyxg+e5uQXfrpSBZTZqqJB8Y0vmJdA/hYi33p8Dxol42+bkdbVeSgBkusnRE2MEvzHb8vtydt+Es8qIL+G3IpEwNT45H//hhz3H7/pNBWJf2R1kdDLvjU7B29ZZSZvnbk5BF3+WAnui/jf6iPhrhMoQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCk6sLe2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCk6sLe2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53482C4CEE5;
	Mon, 10 Mar 2025 22:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741645037;
	bh=MMlIFG8Zv8CNscu9Rs/8LPn9paecut0nXKKHd2+sAQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CCk6sLe2Dd91Dh8G6F0l8+Dzz0r0BkNpj6iAF7j2qd/ROJVpkeyiqtAfH+PaeS0bG
	 JrKo6SoPV9R6DgbEcG23JVX8ZL2Uxy/DQXEy3h9YG+lyeRpW/wbgq+PhVKXC8QSy14
	 sqgd/c1m1lztc3YVa1uxcfDn1lpP7WwXxt9Sz1Zp8yV8Fb9JZFHscNHKtrrRb/N9zg
	 49JCfuPsCbiBt6tpYqtZmKDW9XbdvVzrJohJ1oojogE96PazyaEdZVUNGvYQIazMPz
	 KGjJ2R6pcwWUGOanPp2Ur0EStciAbM9SkY4lbkLi4L2w97BEHDATYaPXle4fqR2NmG
	 3stzNiVRY+MZg==
Date: Mon, 10 Mar 2025 15:17:14 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	James Clark <james.clark@linaro.org>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Levi Yun <yeoreum.yun@arm.com>, Ze Gao <zegao2021@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: Re: [PATCH v2 11/11] perf python tracepoint: Switch to using
 parse_events
Message-ID: <Z89k6lWxRSBfCGvM@google.com>
References: <20250228222308.626803-1-irogers@google.com>
 <20250228222308.626803-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250228222308.626803-12-irogers@google.com>

On Fri, Feb 28, 2025 at 02:23:08PM -0800, Ian Rogers wrote:
> Rather than manually configuring an evsel, switch to using
> parse_events for greater commonality with the rest of the perf code.
> 
> Reviewed-by: Howard Chu <howardchu95@gmail.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/python/tracepoint.py | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/perf/python/tracepoint.py b/tools/perf/python/tracepoint.py
> index bba68a6d4515..38b2b6d11f64 100755
> --- a/tools/perf/python/tracepoint.py
> +++ b/tools/perf/python/tracepoint.py
> @@ -5,24 +5,23 @@
>  
>  import perf
>  
> -class tracepoint(perf.evsel):
> -    def __init__(self, sys, name):
> -        config = perf.tracepoint(sys, name)
> -        perf.evsel.__init__(self,
> -                            type   = perf.TYPE_TRACEPOINT,
> -                            config = config,
> -                            freq = 0, sample_period = 1, wakeup_events = 1,
> -                            sample_type = perf.SAMPLE_PERIOD | perf.SAMPLE_TID | perf.SAMPLE_CPU | perf.SAMPLE_RAW | perf.SAMPLE_TIME)
> -
>  def main():
> -    tp      = tracepoint("sched", "sched_switch")
>      cpus    = perf.cpu_map()
>      threads = perf.thread_map(-1)
> +    evlist = perf.parse_events("sched:sched_switch", cpus, threads)
> +    # Disable tracking of mmaps and similar that are unnecessary.
> +    for ev in evlist:
> +        ev.tracking = False
> +    # Configure evsels with default record options.
> +    evlist.config()

I think the default option uses frequency of 4000 but tracepoints want
to use period of 1.  Also I'm not sure if it sets the proper sample type
bits namely PERF_SAMPLE_RAW.

Thanks,
Namhyung


> +    # Simplify the sample_type and read_format of evsels
> +    for ev in evlist:
> +        ev.sample_type = ev.sample_type & ~perf.SAMPLE_IP
> +        ev.read_format = 0
>  
> -    evlist = perf.evlist(cpus, threads)
> -    evlist.add(tp)
>      evlist.open()
>      evlist.mmap()
> +    evlist.enable();
>  
>      while True:
>          evlist.poll(timeout = -1)
> -- 
> 2.48.1.711.g2feabab25a-goog
> 

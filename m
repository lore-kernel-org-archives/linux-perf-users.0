Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71B429BDAA;
	Tue, 18 Nov 2025 01:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763430212; cv=none; b=BtG/9DbyzKEgnS8Ya391WYxACWcsc/kKSCIbZvLcofWQcEgwwbxXqmVLCgEKK8+NlPvORCwwvXZzhEgTh93p2cfttn1yul78clfl3oSxlt9KErIIOS5rpf2FtY9KUYoQOBaamBw1TzjR9LmhQ/I0f9sLirBwCjPgCX80HlKydN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763430212; c=relaxed/simple;
	bh=T+WaWbx5/tCaXXKs5oIjTmg6+g62YN9B+N2yj80oAPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4NGimwe+VfE3Q0jX8+wub3aNvPhowXQ+9IEJbESyUB57nc8rQ6DS0dsUEexyrSZcwCDugypH7R+rLPh2QT6PvrF4NZ6AwBV6yT0n99KexKlD0IPh/DKEjd/0OQHjnx55+Y46pKwrqWfJQgXxgI72xHsUUc4fWorCkvgwxzn5uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pRAzClFn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRAzClFn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F3DC4AF12;
	Tue, 18 Nov 2025 01:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763430211;
	bh=T+WaWbx5/tCaXXKs5oIjTmg6+g62YN9B+N2yj80oAPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pRAzClFnuSNuMPV9NGPAtZxs/ONf7VDLhzQZm0rb5AW5lSjbdpakd/CzxnOn53VYE
	 ULI0g2tKQVGn4QyFZmErb0/VhSqu2jAhAj7eZ5yqLARji/QTTEURSN12uX8pDt2mmx
	 ncLF4BrdJv9d2prUQOob7fLYv9a0hvJhfV1mlj6F7OmQIY+QntJmrkyouErXnGk0Sl
	 CzNL4irUmhvA5PPY3EsmaTj58ahxo42qowHb9VUvvgBi45wn05xdkSxn46Z2HzKYMO
	 fbFdrjuYyarAJvjkeRyIsoef4aF6dBJieD7Lb/7ptDEFs8KaCMsV0DS4SEv8AMNxhU
	 YewjLzEWpm9rg==
Date: Mon, 17 Nov 2025 17:43:27 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: Re: [PATCH] perf: Fix 0 count issue of cpu-clock
Message-ID: <aRvPP18TCNKKCw3r@google.com>
References: <20251112080526.3971392-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251112080526.3971392-1-dapeng1.mi@linux.intel.com>

Hello,

On Wed, Nov 12, 2025 at 04:05:26PM +0800, Dapeng Mi wrote:
> Currently cpu-clock event always returns 0 count, e.g.,
> 
> perf stat -e cpu-clock -- sleep 1
> 
>  Performance counter stats for 'sleep 1':
>                  0      cpu-clock                        #    0.000 CPUs utilized
>        1.002308394 seconds time elapsed
> 
> The root cause is the commit 'bc4394e5e79c ("perf: Fix the throttle
>  error of some clock events")' adds PERF_EF_UPDATE flag check before
> calling cpu_clock_event_update() to update the count, however the
> PERF_EF_UPDATE flag is never set when the cpu-clock event is stopped in
> counting mode (pmu->dev() -> cpu_clock_event_del() ->
> cpu_clock_event_stop()). This leads to the cpu-clock event count is
> never updated.
> 
> To fix this issue, force to set PERF_EF_UPDATE flag for cpu-clock event
> just like what task-clock does. Besides, or flags with PERF_EF_UPDATE
> for task-clock although currently the flags argument would always be 0.
> 
> Fixes: bc4394e5e79c ("perf: Fix the throttle error of some clock events")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
> 
> With this change, both cpu-clock and task-clock can do counting and
> samping correctly.
> 
> 1. perf stat -e cpu-clock,task-clock -- true
> 
>  Performance counter stats for 'true':
>            240,636      cpu-clock                        #    0.358 CPUs utilized
>            243,319      task-clock                       #    0.362 CPUs utilized
> 
> 2. perf record -e cpu-clock -c 10000 -Iax,bx -- sleep 1
> [ perf record: Woken up 2 times to write data ]
> [ perf record: Captured and wrote 0.028 MB perf.data (36 samples) ]
> 
> 3. perf record -e task-clock -c 10000 -Iax,bx -- sleep 1
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.029 MB perf.data (41 samples) ]
> 
>  kernel/events/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index f6a08c73f783..77d3af5959c1 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -11964,7 +11964,7 @@ static int cpu_clock_event_add(struct perf_event *event, int flags)
>  
>  static void cpu_clock_event_del(struct perf_event *event, int flags)
>  {
> -	cpu_clock_event_stop(event, flags);
> +	cpu_clock_event_stop(event, flags | PERF_EF_UPDATE);
>  }
>  
>  static void cpu_clock_event_read(struct perf_event *event)
> @@ -12043,7 +12043,7 @@ static int task_clock_event_add(struct perf_event *event, int flags)
>  
>  static void task_clock_event_del(struct perf_event *event, int flags)
>  {
> -	task_clock_event_stop(event, PERF_EF_UPDATE);
> +	task_clock_event_stop(event, flags | PERF_EF_UPDATE);
>  }
>  
>  static void task_clock_event_read(struct perf_event *event)
> 
> base-commit: 2093d8cf80fa5552d1025a78a8f3a10bf3b6466e
> prerequisite-patch-id: a15bcd62a8dcd219d17489eef88b66ea5488a2a0
> prerequisite-patch-id: 2a0eefce67b21d1f30c272fd8115b0dc1aca3897
> -- 
> 2.34.1
> 

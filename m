Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF6422087;
	Tue, 10 Dec 2024 13:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733838712; cv=none; b=Z23Us3ZGC1y8j75a67CCChTcRils4NLV089Bkp0qMjiplKjYFCB2zDVZoaPjZQyPAGqy6q107t+X5Uj3RQVb6mC9gqzI4xzjjWMTnXEW1uWLi9g/4PkvYSP6t1C+6WMJkPPJyf3/XC6PialKZqVCq2N3UhNCfz1IvhbjFd4vg78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733838712; c=relaxed/simple;
	bh=w3mv4fHBCVqEeM6Pi3ba1qB9dAfsMIm1GhXtgjzgL04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QE32GEKjVLuK2/YPN8bMKcPcTUQB0uPAov/GNIQYsrbkDNEYA/r2jiGK5zO6tRz5PaqR9xPzLttO87CO5DyrF4LUx6ru8Ffu3tKE+/9DOSrqUDfNovG/7ZEH5DVytlOLqBnnL9NysFRLT4naS+ESZVr0agi4wZ1dexYXKjK/I7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUgCyr46; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUgCyr46"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37F8C4CED6;
	Tue, 10 Dec 2024 13:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733838711;
	bh=w3mv4fHBCVqEeM6Pi3ba1qB9dAfsMIm1GhXtgjzgL04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YUgCyr46IwvzNRTmuGifNzUwzIpvfI8RX35zlauubPL+5htQDzGo3FveBOLQXpVAA
	 VIduXmjlYQiEuR4RzfXEo8h8V1Nt4Ntp4XBkEWDF8xDAJpoYsJy+EVrcg+Ud+Y4hNZ
	 AH4IAjqz73eI4Y3+deJVAh8f600YGnwBycyUXX8mh8xFvpmvVASkZnqLzKSEcg3eRb
	 alwmOf03iiPYi3GftDzOD68I0g+EQEZnMe9qCB78lL2sxJqMtI4IpcvJ9BMKjnZ526
	 DnZLpnHb01haFD0iq9a9j9ED9fsKM/jDYhXWpQLzsXK6MVT0rG+JrFM/OiOqBhMIF8
	 FtfFz8BCA4xkQ==
Date: Tue, 10 Dec 2024 10:51:47 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>,
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, irogers@google.com,
	thomas.falcon@intel.com, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] libperf: evlist: Fix --cpu argument on hybrid
 platform
Message-ID: <Z1hHc-Q-TKgagORu@x1>
References: <20241114160450.295844-1-james.clark@linaro.org>
 <20241114160450.295844-2-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241114160450.295844-2-james.clark@linaro.org>

On Thu, Nov 14, 2024 at 04:04:48PM +0000, James Clark wrote:
> Since the linked fixes: commit, specifying a CPU on hybrid platforms
> results in an error because Perf tries to open an extended type event
> on "any" CPU which isn't valid. Extended type events can only be opened
> on CPUs that match the type.
 
> Before (working):
 
>   $ perf record --cpu 1 -- true
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 2.385 MB perf.data (7 samples) ]
 
> After (not working):
 
>   $ perf record -C 1 -- true
>   WARNING: A requested CPU in '1' is not supported by PMU 'cpu_atom' (CPUs 16-27) for event 'cycles:P'
>   Error:
>   The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (cpu_atom/cycles:P/).
>   /bin/dmesg | grep -i perf may provide additional information.
> 
> (Ignore the warning message, that's expected and not particularly
> relevant to this issue).
> 
> This is because perf_cpu_map__intersect() of the user specified CPU (1)
> and one of the PMU's CPUs (16-27) correctly results in an empty (NULL)
> CPU map. However for the purposes of opening an event, libperf converts
> empty CPU maps into an any CPU (-1) which the kernel rejects.
> 
> Fix it by deleting evsels with empty CPU maps in the specific case where
> user requested CPU maps are evaluated.


Namhyung, I think this should go via perf-tools,

Before, on an hybrid Intel processor:

  ⬢ [acme@toolbox perf-tools]$ grep -m1 'model name' /proc/cpuinfo 
  model name	: 13th Gen Intel(R) Core(TM) i7-1365U
  ⬢ [acme@toolbox perf-tools]$

  root@x1:~# perf record -C 1 -- true
  WARNING: A requested CPU in '1' is not supported by PMU 'cpu_atom' (CPUs 4-11) for event 'cycles:P'
  Error:
  The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (cpu_atom/cycles/P).
  "dmesg | grep -i perf" may provide additional information.
  root@x1:~# 

After the patch:

  root@x1:~# perf record -C 1 -- true
  WARNING: A requested CPU in '1' is not supported by PMU 'cpu_atom' (CPUs 4-11) for event 'cycles:P'
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 1.369 MB perf.data (8 samples) ]
  root@x1:~#
  root@x1:~# perf evlist -v
  cpu_core/cycles/P: type: 0 (PERF_TYPE_HARDWARE), size: 136, config: 0x400000000, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|CPU|PERIOD|IDENTIFIER, read_format: ID|LOST, disabled: 1, freq: 1, precise_ip: 3, sample_id_all: 1
  dummy:u: type: 1 (software), size: 136, config: 0x9 (PERF_COUNT_SW_DUMMY), { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|CPU|IDENTIFIER, read_format: ID|LOST, exclude_kernel: 1, exclude_hv: 1, mmap: 1, comm: 1, task: 1, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1
  root@x1:~#

All on CPU 1:

  root@x1:~# perf report -D | grep PERF_RECORD_SAMPLE
  1 1809541166457609 0x15e410 [0x38]: PERF_RECORD_SAMPLE(IP, 0x4001): 719180/719180: 0xffffffff9b1ce418 period: 1 addr: 0
  1 1809541166470019 0x15e448 [0x38]: PERF_RECORD_SAMPLE(IP, 0x4001): 719180/719180: 0xffffffff9a0206b1 period: 1 addr: 0
  1 1809541166475543 0x15e480 [0x38]: PERF_RECORD_SAMPLE(IP, 0x4001): 719180/719180: 0xffffffff9a0a9158 period: 5 addr: 0
  1 1809541166478316 0x15e4b8 [0x38]: PERF_RECORD_SAMPLE(IP, 0x4001): 719180/719180: 0xffffffff9a0a9158 period: 53 addr: 0
  1 1809541166480879 0x15e4f0 [0x38]: PERF_RECORD_SAMPLE(IP, 0x4001): 719180/719180: 0xffffffff9a0a9158 period: 667 addr: 0
  1 1809541166483895 0x15e528 [0x38]: PERF_RECORD_SAMPLE(IP, 0x4001): 719180/719180: 0xffffffff9b1bcbcc period: 8537 addr: 0
  1 1809541166489116 0x15e560 [0x38]: PERF_RECORD_SAMPLE(IP, 0x4001): 719180/719180: 0xffffffff9a009b3b period: 98429 addr: 0
  1 1809541168375508 0x15e620 [0x38]: PERF_RECORD_SAMPLE(IP, 0x4001): 0/0: 0xffffffff9b0e2a34 period: 732596 addr: 0
  root@x1:~#

Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

James, the second patch isn't applying to perf-tools/perf-tools.

- Arnaldo
 
> Fixes: 251aa040244a ("perf parse-events: Wildcard most "numeric" events")
> Reviewed-by: Ian Rogers <irogers@google.com>
> Tested-by: Thomas Falcon <thomas.falcon@intel.com>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/lib/perf/evlist.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index c6d67fc9e57e..83c43dc13313 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -47,6 +47,20 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
>  		 */
>  		perf_cpu_map__put(evsel->cpus);
>  		evsel->cpus = perf_cpu_map__intersect(evlist->user_requested_cpus, evsel->own_cpus);
> +
> +		/*
> +		 * Empty cpu lists would eventually get opened as "any" so remove
> +		 * genuinely empty ones before they're opened in the wrong place.
> +		 */
> +		if (perf_cpu_map__is_empty(evsel->cpus)) {
> +			struct perf_evsel *next = perf_evlist__next(evlist, evsel);
> +
> +			perf_evlist__remove(evlist, evsel);
> +			/* Keep idx contiguous */
> +			if (next)
> +				list_for_each_entry_from(next, &evlist->entries, node)
> +					next->idx--;
> +		}
>  	} else if (!evsel->own_cpus || evlist->has_user_cpus ||
>  		(!evsel->requires_cpu && perf_cpu_map__has_any_cpu(evlist->user_requested_cpus))) {
>  		/*
> @@ -80,11 +94,11 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
>  
>  static void perf_evlist__propagate_maps(struct perf_evlist *evlist)
>  {
> -	struct perf_evsel *evsel;
> +	struct perf_evsel *evsel, *n;
>  
>  	evlist->needs_map_propagation = true;
>  
> -	perf_evlist__for_each_evsel(evlist, evsel)
> +	list_for_each_entry_safe(evsel, n, &evlist->entries, node)
>  		__perf_evlist__propagate_maps(evlist, evsel);
>  }
>  
> -- 
> 2.34.1

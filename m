Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9481D1A265E;
	Thu,  6 Feb 2025 19:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738870040; cv=none; b=ONgO/ivJEbQ/l+Cb++6qq7xLNVBvsQOd+Wcrulv2srUUg4TBFa0eO1QuFdDwEWnpY+HXrWaGVwEoByrGuCgORIIOcW/ZIQZJlBoTpKfPb5tQrmoNsNCg914vf8BzDO1B6g4C8o/xM1UUxLWN/O1XtaGgbxp/BC+Dow+xCTi/Jxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738870040; c=relaxed/simple;
	bh=6WSN3lP4ZSygn5wjxoRwkbwnphUTrjuQUbSHCfna+vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IwWw+Sf+4OlZZc+5xiYdltXOrBfC051c289uWoOpTysun6qra4Ts/0dekTACfi9TMWzD3tuWICuK9BZ/ENEznsHNFwzGxiGv5ODnjNaCSe5Ia9Fsn1H8bUtf5G/hax0MENTjhmDesv4p6sdYQq7XDdhBm3U39WVDXx3U8skHae8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXgrm/Z5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXgrm/Z5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806C2C4CEDD;
	Thu,  6 Feb 2025 19:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738870040;
	bh=6WSN3lP4ZSygn5wjxoRwkbwnphUTrjuQUbSHCfna+vc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oXgrm/Z5aX0YkuFOVybBOc4ryfLdlyuKgvuK1l+s/RwKoJNUjV0ZRJKWNqaBvLvJQ
	 0jkaih6P5CTSaGnXKQgtTMKztOnt+AFnuUfi6Nwrf2eza+uXoMnJIzTFCHSALShQNX
	 VfyiSr58e1mJKEA2FfESoqLkSJUueXqQdFCdWx6Uc62nr1o0KpPH/z+f3toHRm7je2
	 x7pQ1BwLd8s4pQl3MQ8hsVxMczxUhBahGnoE2aMCxsdZ8izHWBJHY2FoNVvZyQPx0H
	 z9XG9a7s42ummPEmu1KvimoD+jnI30Kt/aU817AYYWbu2nAbMtQcYVzqh8G8Vn0A8P
	 KhH6q43a6011A==
Date: Thu, 6 Feb 2025 20:27:17 +0100
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v14 05/10] perf evsel: Assemble offcpu samples
Message-ID: <Z6UNFXZUlo4wMZ7V@x1>
References: <20241215181220.754822-1-howardchu95@gmail.com>
 <20241215181220.754822-6-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241215181220.754822-6-howardchu95@gmail.com>

On Sun, Dec 15, 2024 at 10:12:15AM -0800, Howard Chu wrote:
> Use the data in bpf-output samples, to assemble offcpu samples. In
> evsel__is_offcpu_event(), Check if sample_type is PERF_SAMPLE_RAW to
> support off-cpu sample data created by an older version of perf.
 
> Testing compatibility on offcpu samples collected by perf before this patch series:
 
> See below, the sample_type still uses PERF_SAMPLE_CALLCHAIN

Getting back from vacation, so bear with me, please :-)

So, while at this point:

⬢ [acme@toolbox perf-tools-next]$ git log --oneline -5
bfd7461c25a5e667 (HEAD) perf record --off-cpu: Dump off-cpu samples in BPF
e75f8ce63bfa6cb9 perf record --off-cpu: Preparation of off-cpu BPF program
0ffab9d26971c91c perf record --off-cpu: Parse off-cpu event
efc3fe2070853b7d perf evsel: Expose evsel__is_offcpu_event() for future use
357b965deba9fb71 (perf-tools-next/perf-tools-next) perf stat: Changes to event name uniquification
⬢ [acme@toolbox perf-tools-next]$

And trying to test this series I do:

root@number:~# perf -v
perf version 6.13.rc2.gbfd7461c25a5
root@number:~#

root@number:~# perf record --off-cpu sleep 5s
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.037 MB perf.data (7 samples) ]
root@number:~# perf evlist
cpu_atom/cycles/P
cpu_core/cycles/P
offcpu-time
dummy:u
root@number:~#

And:

root@number:~# perf evlist -v
cpu_atom/cycles/P: type: 0 (PERF_TYPE_HARDWARE), size: 136, config: 0xa00000000, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|PERIOD|IDENTIFIER, read_format: ID|LOST, disabled: 1, inherit: 1, freq: 1, enable_on_exec: 1, precise_ip: 3, sample_id_all: 1
cpu_core/cycles/P: type: 0 (PERF_TYPE_HARDWARE), size: 136, config: 0x400000000, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|PERIOD|IDENTIFIER, read_format: ID|LOST, disabled: 1, inherit: 1, freq: 1, enable_on_exec: 1, precise_ip: 3, sample_id_all: 1
offcpu-time: type: 1 (software), size: 136, config: 0xa (PERF_COUNT_SW_BPF_OUTPUT), { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|CPU|PERIOD|IDENTIFIER, read_format: ID|LOST, disabled: 1, enable_on_exec: 1, sample_id_all: 1
dummy:u: type: 1 (software), size: 136, config: 0x9 (PERF_COUNT_SW_DUMMY), { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|IDENTIFIER, read_format: ID|LOST, inherit: 1, exclude_kernel: 1, exclude_hv: 1, mmap: 1, comm: 1, task: 1, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1
root@number:~#

Above the "offcpu-time" event doesn't have the PERF_SAMPLE_CALLCHAIN in
sample_type, so I should be using some other 'perf record --off-cpu'
specific option?

The HEAD mentions:

"Collect tid, period, callchain, and cgroup id and dump them when off-cpu
time threshold is reached."

But that doesn't match the "offcpu-time" sample_type, right?
 
> $ perf script --header -i ./perf.data.ptn | grep "event : name = offcpu-time"
>  # event : name = offcpu-time, , id = { 237917, 237918, 237919, 237920 }, type = 1 (software), size = 136, config = 0xa (PERF_COUNT_SW_BPF_OUTPUT), { sample_period, sample_freq } = 1, sample_type = IP|TID|TIME|CALLCHAIN|CPU|PERIOD|IDENTIFIER, read_format = ID|LOST, disabled = 1, freq = 1, sample_id_all = 1
> 
> The output is correct.

You mean because it has PERF_SAMPLE_CALLCHAIN in the sample_type?
 
> $ perf script -i ./perf.data.ptn | grep offcpu-time
> gmain    2173 [000] 18446744069.414584:  100102015 offcpu-time:
> NetworkManager     901 [000] 18446744069.414584:    5603579 offcpu-time:
> Web Content 1183550 [000] 18446744069.414584:      46278 offcpu-time:
> gnome-control-c 2200559 [000] 18446744069.414584: 11998247014 offcpu-time:

> And after this patch series:

After the _whole_ series? Or at this point in the series?

I'm trying to test it patch by patch, to see from output from 'perf
report -D', perf script, etc that the patch descriptions match what the
code does and then double checking by trying to reproduce it, step by
step.

I'll try to do it at the end of the series, but thought about trowing in
these questions to help me understand your work.

Thanks!

- Arnaldo
 
> $ perf script --header -i ./perf.data.off-cpu-v9 | grep "event : name = offcpu-time"
>  # event : name = offcpu-time, , id = { 237959, 237960, 237961, 237962 }, type = 1 (software), size = 136, config = 0xa (PERF_COUNT_SW_BPF_OUTPUT), { sample_period, sample_freq } = 1, sample_type = IP|TID|TIME|CPU|PERIOD|RAW|IDENTIFIER, read_format = ID|LOST, disabled = 1, freq = 1, sample_id_all = 1
> 
> perf $ ./perf script -i ./perf.data.off-cpu-v9 | grep offcpu-time
>      gnome-shell    1875 [001] 4789616.361225:  100097057 offcpu-time:
>      gnome-shell    1875 [001] 4789616.461419:  100107463 offcpu-time:
>          firefox 2206821 [002] 4789616.475690:  255257245 offcpu-time:
> 
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Link: https://lore.kernel.org/r/20241108204137.2444151-7-howardchu95@gmail.com
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/evsel.c | 35 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index fc33104cd659..277b5babd63e 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1244,7 +1244,8 @@ static void evsel__set_default_freq_period(struct record_opts *opts,
>  
>  bool evsel__is_offcpu_event(struct evsel *evsel)
>  {
> -	return evsel__is_bpf_output(evsel) && evsel__name_is(evsel, OFFCPU_EVENT);
> +	return evsel__is_bpf_output(evsel) && evsel__name_is(evsel, OFFCPU_EVENT) &&
> +	       evsel->core.attr.sample_type & PERF_SAMPLE_RAW;
>  }
>  
>  /*
> @@ -2846,6 +2847,35 @@ static inline bool evsel__has_branch_counters(const struct evsel *evsel)
>  	return false;
>  }
>  
> +static int __set_offcpu_sample(struct perf_sample *data)
> +{
> +	u64 *array = data->raw_data;
> +	u32 max_size = data->raw_size, *p32;
> +	const void *endp = (void *)array + max_size;
> +
> +	if (array == NULL)
> +		return -EFAULT;
> +
> +	OVERFLOW_CHECK_u64(array);
> +	p32 = (void *)array++;
> +	data->pid = p32[0];
> +	data->tid = p32[1];
> +
> +	OVERFLOW_CHECK_u64(array);
> +	data->period = *array++;
> +
> +	OVERFLOW_CHECK_u64(array);
> +	data->callchain = (struct ip_callchain *)array++;
> +	OVERFLOW_CHECK(array, data->callchain->nr * sizeof(u64), max_size);
> +	data->ip = data->callchain->ips[1];
> +	array += data->callchain->nr;
> +
> +	OVERFLOW_CHECK_u64(array);
> +	data->cgroup = *array;
> +
> +	return 0;
> +}
> +
>  int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>  			struct perf_sample *data)
>  {
> @@ -3197,6 +3227,9 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>  		array = (void *)array + sz;
>  	}
>  
> +	if (evsel__is_offcpu_event(evsel))
> +		return __set_offcpu_sample(data);
> +
>  	return 0;
>  }
>  
> -- 
> 2.43.0

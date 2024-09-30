Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0318A47;
	Mon, 30 Sep 2024 05:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727674637; cv=none; b=FEmnK4loECU6du1IEJy5z/4qC62EqEUlNGbXxqr+qnmSzs+4nRGRO9ZCBkU1rhKQ+nCYatn+KGBkeQXoS2EtdFnpzxKzQkj9/UUlurtAfrK1qyL67br+lKnMWLGt4FlN7o9xSSSuDLOEJriiIX773JgS590ObSRhlw5/lzzDjBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727674637; c=relaxed/simple;
	bh=BYqOSqfTh6J2OAJd0WeucA8ThTwzfXalrEuCCdu44v0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cpyZwrNcWqp/s0EdMDc/keFNg6Y8tR3DzFgF/b7vWO/IZCQg9QK5KGA6tLO+4yKPeCayWpHYgplYJbBK+4GQqOwtfQCLGnLPbmfWasVvHpw3ICxVhz+S3L5wo8Tlb8gPuMV+yYGCs4279N7YfR9k6QKS77bfrYHzHMCqsTJ2qEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUUnyUjK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUUnyUjK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90DEC4CECE;
	Mon, 30 Sep 2024 05:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727674636;
	bh=BYqOSqfTh6J2OAJd0WeucA8ThTwzfXalrEuCCdu44v0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eUUnyUjKGvjKYl9CSlX9dpFmzmXJL3TJpKbxX8ERMGPv1/P90YLxFhA8AMOkHd01q
	 SjVe64vZoNxRYkce4FblZc8TGUyvHklZKiTQk8USN4+3bOUB4uXXTI+VxjPODrbm4/
	 Mt2opxg0bYOvIQNnE7lesDyT5lPGrDy7DcVmUoUq856YvkBV5CJ4QHXl/ov/cyhuBn
	 KdHt71HWZ9ht8BoNKXlFkhGyZ7wSPEldLhd79zH29t1ZmgT4qQjQCBCBquH1EAUwsA
	 C5NClCvYT+/pSqzE1HOgSQjJp8LymfvH4T4wWwXmhPPOT3RRxXiu9YnpMrFC38J+Up
	 BJKwXxOjjZvEA==
Date: Sun, 29 Sep 2024 22:37:14 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/8] perf evsel: Set off-cpu BPF output to system-wide
Message-ID: <Zvo5Cv9BQ0dGSPGD@google.com>
References: <20240927202736.767941-1-howardchu95@gmail.com>
 <20240927202736.767941-2-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240927202736.767941-2-howardchu95@gmail.com>

On Fri, Sep 27, 2024 at 01:27:29PM -0700, Howard Chu wrote:
> pid = -1 for off-cpu's bpf-output event.
> 
> This makes 'perf record -p <PID> --off-cpu', and 'perf record --off-cpu
> <workload>' work. Otherwise bpf-output cannot be collected.
> 
> The reason (conjecture): say if we open perf_event on pid = 11451, then
> in BPF, we call bpf_perf_event_output() when a direct sample is ready to
> be dumped. But currently the perf_event of pid 11451 is not __fully__
> sched_in yet, so in kernel/trace/bpf_trace.c's
> __bpf_perf_event_output(), there will be event->oncpu != cpu, thus
> return -EOPNOTSUPP, direct off-cpu sample output failed.
> 
> if (unlikely(event->oncpu != cpu))
> 		return -EOPNOTSUPP;
> 
> So I'm making it pid = -1, everybody can do bpf_perf_event_output()
> 
> P.S. In perf trace this is not necessary, because it uses syscall
> tracepoints, instead of sched_switch.
> 
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/util/evsel.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index edfb376f0611..500ca62669cb 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2368,6 +2368,9 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>  
>  			test_attr__ready();
>  
> +			if (evsel__is_offcpu_event(evsel))
> +				pid = -1;
> +

This looks hacky.  I think you'll end up having two copies of offcpu
events if there are two target tasks.  Maybe you can replace the thread
map of the offcpu event to have a single entry (-1) for any thread after
creating the event.

Thanks,
Namhyung


>  			/* Debug message used by test scripts */
>  			pr_debug2_peo("sys_perf_event_open: pid %d  cpu %d  group_fd %d  flags %#lx",
>  				pid, perf_cpu_map__cpu(cpus, idx).cpu, group_fd, evsel->open_flags);
> -- 
> 2.43.0
> 

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795075563;
	b=xMLM5+HDcCsyGsjHreun94czFrmMpcrRI/96An54Nwpl3EXHX1wqNdh93fTAgj0rE6uD
	 mjSGCDsx0LJG52f0kN9LScaTwZcpPNJpnFvQ8no3yYVTk8leFG0JzCHb1fMlDv1Y61M1k
	 bcse9KiyRT2L6xZuNabxefjPTIEJTmMVQDy5BrER/MpsJmEiveyhHT79qw55jNTxqYa6L
	 +BaiR8mZ470gjfe4MBtesGyvl+a+IdRZGlQN73IMOyf19DC3j/ATA37dK7ohZYegpCLXQ
	 z0hJyxRnLX4LQ1CyhjG7ZS/324ojyuf2ODOSLstSlYBR5ehKKS6r5VUymWsDrbEwfOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795075563;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=NGaR3lJVfV+MRnY85Wfg7XZ1Shhuzc7a+WVB2B8Hqso=;
	b=mVHZ9IvZSQjxpW1GmVbwfqJfW4BPQGlnJrkp7BhGUCNY9IYs+H+ZRQSZlpunzDi3a1xI
	 MC1DFX2IOM3cBkRs3Xpv5wnL1u9mH8a1gD1Phr18bGORm0+7HapgIjN52Qm+osEE+wCWX
	 8V7Av1NIChqGTGQZLzuE7Uz3xHze9o1zPIXlVCeYJcjJJ4JLKb0kWfCx00cuHL+0HcuC9
	 SaXPWDAjVdphETEm9eBL+FJRBxzPMXMWH+6+24LBq/L3c5brLN0JN+UDjzp5OV79gEYXM
	 osS9/r3N0AFYiAzhNAXLUBmRNYlFVxZHGeDaBTZXj5kREtJ5N0OkeHDHCh8rFIaqR/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YRurZ4Gt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E319A606A326;
	Thu, 19 Nov 2026 08:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YRurZ4Gt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DDE41F000C5;
	Thu, 19 Nov 2026 08:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795075562;
	bh=NGaR3lJVfV+MRnY85Wfg7XZ1Shhuzc7a+WVB2B8Hqso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YRurZ4GtKKFowTw7KF3/kI7eG7krpdbVPMVpXnG4LtoQ3H3wTjpg1OR35QjY0vbFu
	 N6hCwl53Tqzng4a39StBetGcW/SrscHnuuUZDPZHKDsdZsOYyz8eGgKTRP7VlTZu3z
	 gh3huqxGOielaB9gVIlH4KNv8GaLUD1JzxSF4Mre8/YVy5ScaxJlSdYhcXiOFaSzOH
	 4T41ThhUVnKYNfV7iMfPHNHueMQm+m/Czg7U2GI3JPOedsqEY7fY6coHwTGbCOruMv
	 Uxdrqm+09MDa/Rozfw51jBAolXhGC+7+t/hYlcJOX9ysEKvudhwJIWFZ2xWeE9msGD
	 xzSTClS+D1aJA==
Date: Thu, 19 Nov 2026 00:06:00 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: TAKANO Mitsuhiro <takano32@gmail.com>, Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Hang Zhengyang <hang.zhengyang1010@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] perf stat: Count kernel events in a group led by a
 tool event
Message-ID: <av6t6M0fUYdtXDEu@google.com>
References: <20261111-tool-pmu-leader-v2-1-3faa0fb98c51@gmail.com>
 <20261111110616.2249764-1-takano32@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261111110616.2249764-1-takano32@gmail.com>

Hello,

On Wed, Nov 11, 2026 at 11:06:16AM +0000, TAKANO Mitsuhiro wrote:
> From: Hang Zhengyang <hang.zhengyang1010@gmail.com>
> 
> A tool event like user_time has no perf event in the kernel, but
> get_group_fd() still passes its fd, the /proc/stat fd, as the group_fd
> of the members.  The kernel rejects each member with EBADF and nothing
> is counted:
> 
>   $ perf stat -a -e '{user_time,cycles,instructions}' -- sleep 0.05
>                    0      user_time
>      <not supported>      cycles
>      <not supported>      instructions

Thanks for reporting this.  Looks like a tricky case for tool events.
I think it's better to make the first non-tool event as a leader, but
I'm afraid it'd make evlist management complex.

Ian, any thoughts?

Thanks,
Namhyung

> 
> Open the members with group_fd = -1, as the enable/disable code already
> assumes, and read them on their own: the leader is not asked for counts
> of events that are not in its kernel group.  A kernel event member is
> opened disabled, as a leader is, so that it starts with the workload
> and still honours -D and --control.  A tool event member is left as it
> is: it counts from open and an explicit disable is what stops it, so
> disabling it here would leave nobody to start it when perf relies on
> enable_on_exec.
> 
>   $ perf stat -a -e '{user_time,cycles,instructions}' -- sleep 0.05
>                    0      user_time
>             38257394      cycles
>             21228043      instructions
> 
> The kernel events in such a group are no longer scheduled together,
> which is the price of counting them at all.  A tool event used as a
> member, as in '{cycles,user_time}', is still not counted; that also
> needs the leader's group read to be handled and is left for a
> follow-up.
> 
> Fixes: 6828d6929b76 ("perf evsel: Refactor tool events")
> Written with LLM assistants: the group_fd change and its testing by
> Hang Zhengyang with Claude, the v3 condition and its measurement by
> TAKANO Mitsuhiro with Hermes Agent.  perf was built here and
> 'perf test -v 10' passes with and without the change.
> Signed-off-by: Hang Zhengyang <hang.zhengyang1010@gmail.com>
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
> ---
> v3: open only the kernel event members disabled.  A tool event member
>     counts from open and an explicit disable is what stops it, so
>     opening it disabled left nobody to start it when perf relies on
>     enable_on_exec: 'perf stat -e "{user_time,system_time}" -- sleep
>     0.2' went from ~2.7 ms of system_time to 0 on an arm64 KVM guest.
>     The non-standard Assisted-by tag is replaced by a prose
>     disclosure, and the patch is regenerated on 7.4-rc2.
> 
>     The libperf fix that stops the NULL dereference is a separate
>     patch (<20261111101625.2204836-1-takano32@gmail.com>); this one
>     does not depend on it.
> 
>  tools/perf/builtin-stat.c | 16 ++++++++++++----
>  tools/perf/util/evsel.c   |  8 ++++++++
>  2 files changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 37752d6bfef4..57956f55ea09 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -719,9 +719,10 @@ static int create_perf_stat_counter(struct evsel *evsel,
>  	/*
>  	 * The event is part of non trivial group, let's enable
>  	 * the group read (for leader) and ID retrieval for all
> -	 * members.
> +	 * members.  Members of a tool event leader are opened and
> +	 * read on their own.
>  	 */
> -	if (leader->core.nr_members > 1)
> +	if (leader->core.nr_members > 1 && !evsel__is_tool(leader))
>  		attr->read_format |= PERF_FORMAT_ID|PERF_FORMAT_GROUP;
>  
>  	attr->inherit = !config->no_inherit && list_empty(&evsel->bpf_counter_list);
> @@ -748,9 +749,16 @@ static int create_perf_stat_counter(struct evsel *evsel,
>  	/*
>  	 * Disabling all counters initially, they will be enabled
>  	 * either manually by us or by kernel via enable_on_exec
> -	 * set later.
> +	 * set later.  A kernel event that a tool event leader has as
> +	 * a member is not in the kernel's group either, so it has to
> +	 * be opened disabled to start together with the workload.
> +	 * A tool event member counts from open and is only stopped by
> +	 * an explicit disable, so leaving it enabled here keeps its
> +	 * count; disabling it would leave nobody to start it when
> +	 * perf relies on enable_on_exec.
>  	 */
> -	if (evsel__is_group_leader(evsel)) {
> +	if (evsel__is_group_leader(evsel) ||
> +	    (evsel__is_tool(leader) && !evsel__is_tool(evsel))) {
>  		attr->disabled = 1;
>  
>  		if (target__enable_on_exec(&target))
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index d060fca8090f..7f514cde6840 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2370,6 +2370,14 @@ static int get_group_fd(struct evsel *evsel, int cpu_map_idx, int thread)
>  	if (!evsel->supported || evsel__is_group_leader(evsel))
>  		return -1;
>  
> +	/*
> +	 * A tool event leader has no perf event to group with, so open
> +	 * the member on its own, or report the group as broken (-2) if
> +	 * the leader failed to open.
> +	 */
> +	if (evsel__is_tool(leader))
> +		return leader->supported ? -1 : -2;
> +
>  	/*
>  	 * Leader must be already processed/open,
>  	 * if not it's a bug.
> 
> base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
> -- 
> 2.53.0
> 

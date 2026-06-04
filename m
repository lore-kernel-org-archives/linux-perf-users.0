Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5873847B410;
	Thu,  4 Jun 2026 13:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780580229; cv=none; b=qe3VSjg8HVtfK/M0UzOjRsMCF8oJIk7jzJeKhGv3afLazes3whpwdRVHEv14EeQy4y0Jx/Y8jMOveIxkn2qnHxunUVRC61yqvnqoNje4pese6b5Yix6g7x+OZRbryRNUAaJMV7pCovJ5ppWOxNfJxp37qI4xy0lacVKBemRNt8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780580229; c=relaxed/simple;
	bh=/A3I6Mm/iWqRDzlI+gJL4s3eFINNghjZoZF3oPlcVM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/9YFngFh6ohzeEczGXdfbb3S6YJBs0sW9fkCLMLhNRv4h3yAHYxgLF5SbBhOhPpiVAh4+tHxwj/671ttNLd9Sahf7UlAy/GwsuTZdjHlNPbsHGo8Gq3VOZRwPTTNnhViYYeFLeJ+3qTTMH2Be0wLzeXGjqil7IX2JqxeYWoWjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9GKsIh9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9GKsIh9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D7021F00893;
	Thu,  4 Jun 2026 13:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780580228;
	bh=c8rufnC3OyssSfV4od8wc/qZoNac5XlsTX4KA8GgiEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=k9GKsIh9XZT5xOjtZEdmut9fY8mST+qsNW5QdtaeZFJ1FJOB+TxgRUHc+Q4/meY7+
	 xrYAs4kMZ9ia0IVpeLcgMe2JxF9CevLlWpYR3yBZZHb9/AWwHkQZiMYQ3tK0jvsKpz
	 gPsTdZmCD1bNeicsIEBSC6csarthhPe7158pmg2hzsKrNw5Zl05XF48LqkJBmVgqms
	 TMxWk2kGi3YacH0OxDlhyiAwDiRNGGKnVy7I8p6aZPcDrlhpc71TX1pOi7YBMnjUB/
	 RjPqDxKERDM0ltsU7l4+3Hf4qTjeSPzKCwvYzr/xIn4qeGFll/FVxvUnM1tZ3XzJWs
	 4A4+HqSN2+0mA==
Date: Thu, 4 Jun 2026 10:37:05 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>, james.clark@linaro.org,
	tycho@kernel.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] perf/lock: enable end-timestamp accounting for
 cgroup aggregation
Message-ID: <aiF_gZBqoajF1xXe@x1>
References: <20260530195940.78700-1-suchitkarunakaran@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260530195940.78700-1-suchitkarunakaran@gmail.com>

On Sun, May 31, 2026 at 01:29:40AM +0530, Suchit Karunakaran wrote:
> update_lock_stat() handles lock contentions that start but never reach a
> contention_end event (e.g., locks still held when profiling stops), but
> previously treated LOCK_AGGR_CGROUP as a no-op due to missing cgroup
> context in userspace.
> 
> Fix this by adding a cgroup_id field to struct tstamp_data, recording it
> at contention_begin using get_current_cgroup_id() when aggr_mode is
> LOCK_AGGR_CGROUP. Capturing it at contention_begin is semantically
> correct, the contention cost is incurred by the task that had to wait,
> not by whatever task happens to be running at contention_end. It is also
> preferable from a performance standpoint, as contention_end runs just
> before the task enters the critical section.
> 
> Update contention_end to use pelem->cgroup_id instead of calling
> get_current_cgroup_id() dynamically, ensuring both complete and
> incomplete contention events attribute the wait time to the cgroup at
> wait-start time consistently.

Namhyung, can you provide an Acked-by or Reviewed-by?

Thanks,

- Arnaldo
 
> Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> ---
>  tools/perf/util/bpf_lock_contention.c          | 4 ++--
>  tools/perf/util/bpf_skel/lock_contention.bpf.c | 4 +++-
>  tools/perf/util/bpf_skel/lock_data.h           | 1 +
>  3 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
> index cbd7435579fe..1a5bd2ff8ee4 100644
> --- a/tools/perf/util/bpf_lock_contention.c
> +++ b/tools/perf/util/bpf_lock_contention.c
> @@ -463,8 +463,8 @@ static void update_lock_stat(int map_fd, int pid, u64 end_ts,
>  		stat_key.lock_addr_or_cgroup = ts_data->lock;
>  		break;
>  	case LOCK_AGGR_CGROUP:
> -		/* TODO */
> -		return;
> +		stat_key.lock_addr_or_cgroup = ts_data->cgroup_id;
> +		break;
>  	default:
>  		return;
>  	}
> diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> index 96e7d853b9ed..139199811020 100644
> --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> @@ -536,6 +536,8 @@ int contention_begin(u64 *ctx)
>  	pelem->timestamp = bpf_ktime_get_ns();
>  	pelem->lock = (__u64)ctx[0];
>  	pelem->flags = (__u32)ctx[1];
> +	if (aggr_mode == LOCK_AGGR_CGROUP)
> +		pelem->cgroup_id = get_current_cgroup_id();
>  
>  	if (needs_callstack) {
>  		u32 i = 0;
> @@ -771,7 +773,7 @@ int contention_end(u64 *ctx)
>  			key.stack_id = pelem->stack_id;
>  		break;
>  	case LOCK_AGGR_CGROUP:
> -		key.lock_addr_or_cgroup = get_current_cgroup_id();
> +		key.lock_addr_or_cgroup = pelem->cgroup_id;
>  		break;
>  	default:
>  		/* should not happen */
> diff --git a/tools/perf/util/bpf_skel/lock_data.h b/tools/perf/util/bpf_skel/lock_data.h
> index 28c5e5aced7f..652e114e6b87 100644
> --- a/tools/perf/util/bpf_skel/lock_data.h
> +++ b/tools/perf/util/bpf_skel/lock_data.h
> @@ -13,6 +13,7 @@ struct owner_tracing_data {
>  struct tstamp_data {
>  	u64 timestamp;
>  	u64 lock;
> +	u64 cgroup_id;
>  	u32 flags;
>  	s32 stack_id;
>  };
> -- 
> 2.54.0

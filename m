Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460DF1D63F0;
	Wed, 22 Apr 2026 21:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776893288; cv=none; b=RsSJyexOlOYnr0J/ox1j2dV48wcdbt2pOa2RwqreTGnMdC1hznQ/wTl4I2B1Zsf7XY88ixnlnMVfJ50WJk62C9QMITrmdLSQiKakWx5QWsnCgOqT4iNSrrOI4e+BfXZ9vTQ3eNpxEUVLPdpNYl8BKJNtwBV2/Wf7DWpQEJW8BKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776893288; c=relaxed/simple;
	bh=CMuT/V9zBpFyvDZhpAvD8tTpAypPAEeQ/XsYgHFkRIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TxmkFpFSkwmgzLF9o10alF05hEDbPrcDcUveKbthRUlBltOrhh/PuwSZEB0Ur6CNBohAZJ5/8TvfiIHfxP23H9Z3GBzBDSfpfBayC6lx5Je1DrHUpa/cUlNfAAsXurRvonvINhg8C9J8fKxKunmtrtJkuOB9HaO+4grkyUCdpVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UyMfptUF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyMfptUF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4782AC19425;
	Wed, 22 Apr 2026 21:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776893287;
	bh=CMuT/V9zBpFyvDZhpAvD8tTpAypPAEeQ/XsYgHFkRIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UyMfptUFwsGE8dO87G09902t/2+7SkHuEf5uElyD74H0Qr8NJfj2KZvc19E7SyX9k
	 tfvnl9OgFMge7aDeOM4Hl2Gweo9FN723141PFW5ccNR8sP/GH7rqzMvp+HnpyNkmkY
	 6drMNnZf+f4u6JNLb+5PklFw4VXcNCqaHq7unUZGlSSQTkH9eARmw2/YtTsKNEEsK5
	 FEOb3nNwwQJsGARolqbX98Cp641x6hbBsmnsJ/NPvOmcnaiAwsbfS16T7eAJtJSuaW
	 Ke3lTwJZgCaOqamY5qb8XjWnbKXYCrWR41WW+xbl7rAKeDATtB+DwBV5XxrjoQqlV9
	 1vKbmv8llA6+w==
Date: Wed, 22 Apr 2026 14:28:05 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	james.clark@linaro.org, tycho@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH] perf/lock: enable end-timestamp accounting for cgroup
 aggregation
Message-ID: <aek9ZQvchuPoUBo4@google.com>
References: <20260420184656.331306-1-suchitkarunakaran@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260420184656.331306-1-suchitkarunakaran@gmail.com>

On Tue, Apr 21, 2026 at 12:16:56AM +0530, Suchit Karunakaran wrote:
> update_lock_stat() handles lock contentions that start but never reach a
> contention_end event (e.g., locks still held when profiling stops), but
> previously treated LOCK_AGGR_CGROUP as a no-op due to missing cgroup
> context in userspace; fix this by adding a cgroup_id field to
> struct tstamp_data, recording it at contention_begin using
> get_current_cgroup_id() when aggr_mode == LOCK_AGGR_CGROUP, and using
> ts_data->cgroup_id to build the aggregation key in update_lock_stat(),
> matching the contention_end behavior in BPF and ensuring correct
> attribution of incomplete events.
> 
> Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> ---
>  tools/perf/util/bpf_lock_contention.c          | 4 ++--
>  tools/perf/util/bpf_skel/lock_contention.bpf.c | 2 ++
>  tools/perf/util/bpf_skel/lock_data.h           | 1 +
>  3 files changed, 5 insertions(+), 2 deletions(-)
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
> index 96e7d853b9ed..d0e2cad02fa3 100644
> --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> @@ -536,6 +536,8 @@ int contention_begin(u64 *ctx)
>  	pelem->timestamp = bpf_ktime_get_ns();
>  	pelem->lock = (__u64)ctx[0];
>  	pelem->flags = (__u32)ctx[1];
> +	if (aggr_mode == LOCK_AGGR_CGROUP)
> +		pelem->cgroup_id = get_current_cgroup_id();

If we do this, we can use it in contention_end() too.

Thanks,
Namhyung

>  
>  	if (needs_callstack) {
>  		u32 i = 0;
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
> 2.53.0
> 

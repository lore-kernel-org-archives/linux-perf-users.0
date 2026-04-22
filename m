Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD503148C9;
	Wed, 22 Apr 2026 02:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776825660; cv=none; b=OTMWuUe49JNnE4oUDyp/STUsmFypaf+otFYc9JNYmcEuvj+cNXIc7hAQJLUEv4kbuXKeH7eHsaeX31aSCf7/9GasUGlPBbnrdfL8BLqv8DaR0DbI9a3FPts5G+2CUBSO6HLOH/YvdTKF0dFOTnrGS0C9zbFf+xV0UP3tbj902yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776825660; c=relaxed/simple;
	bh=bKu9cPgYERopw0PQgTINDBcTh6EB/aziLsJ1miFX1LQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+6CTfAfM+H9FjgsnqxgOHnGLexZaETMxQW1TTZ9zMLrwcKqA59EhuZrTdCGHVV3ck955CpAQ8UUEiGTK3rJz1/8i6vdOGYTEheG7i3UFNyAL07O73OB5xtdl1D9Y/pi8mYWax8Bp1NEVLE5p3ZaUe0wMQ5l/vLv1oyoiWCNVh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lb4MGnQ7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lb4MGnQ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED021C2BCB0;
	Wed, 22 Apr 2026 02:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776825659;
	bh=bKu9cPgYERopw0PQgTINDBcTh6EB/aziLsJ1miFX1LQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lb4MGnQ7IUicomGOoNsXKG6wNL1Q8DdaoVGu+hv0YKOSKP3dyelTb8fdNq93Eq1WC
	 laZ1joIJf40dQRkyaqgYdIJ8y7CnxlxkM2wox5i3TKNASb5mW7FIDlOrTctxh8ChV0
	 Pu1B48a9nb7iHTaTSFf1h8fMRZVPntFG4VEj4FS0paDqw5nUMCz2OlFVdppGhEP3hP
	 2wjrhckgJLXmmRDowH7tnH+y5XObtdWl00u3P/x3LNoF2LyOmqe2886FCeYCkXU7Js
	 C6mXx2yWOHLF80eAA5r9x+tvVg1Rn9cZeXyf4iKsmUyfNQtpwPQ7aFIdm/e7Md6u8o
	 ZkXxlpR1qNjGw==
Date: Tue, 21 Apr 2026 19:40:57 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	james.clark@linaro.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] perf/lock: Fix non-atomic max/time and min_time updates
 in contention_data
Message-ID: <aeg1ORW2I-YLvpFL@google.com>
References: <20260419182754.143225-1-suchitkarunakaran@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260419182754.143225-1-suchitkarunakaran@gmail.com>

Hello,

On Sun, Apr 19, 2026 at 11:57:54PM +0530, Suchit Karunakaran wrote:
> The update_contention_data() had a FIXME noting that max_time and
> min_time updates lacked atomicity. Two CPUs could simultaneously
> read a stale value, pass the comparison check and race on the
> write-back, with the smaller value potentially overwriting the
> larger one and silently corrupting the statistics.
> 
> Fix this by replacing the bare conditional assignments with a
> bpf_loop()-based CAS retry loop. Each field tracks its own
> convergence independently via max_done/min_done flags in cas_ctx,
> so a successful CAS on one field is never retried even if the
> other field needs more attempts.

Interesting!

It looks like bpf_loop() is added at v5.17 - more than 4 years ago.
Then I think it's ok to have it now.

> 
> Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  .../perf/util/bpf_skel/lock_contention.bpf.c  | 50 +++++++++++++++++--
>  1 file changed, 45 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> index 96e7d853b9ed..5c8431be674a 100644
> --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> @@ -175,6 +175,13 @@ struct mm_struct___new {
>  	struct rw_semaphore mmap_lock;
>  } __attribute__((preserve_access_index));
>  
> +struct cas_ctx {
> +	struct contention_data *data;
> +	u64 duration;
> +	int max_done;
> +	int min_done;
> +};
> +
>  extern struct kmem_cache *bpf_get_kmem_cache(u64 addr) __ksym __weak;
>  
>  /* control flags */
> @@ -486,16 +493,49 @@ static inline s32 get_owner_stack_id(u64 *stacktrace)
>  	return -1;
>  }
>  
> +static long cas_min_max_cb(u64 idx, void *arg)
> +{
> +	struct cas_ctx *ctx = arg;
> +
> +	if (!ctx->max_done) {
> +		u64 old_max = ctx->data->max_time;
> +
> +		if (old_max >= ctx->duration) {
> +			ctx->max_done = 1;
> +		} else {
> +			u64 r = __sync_val_compare_and_swap(
> +				&ctx->data->max_time, old_max, ctx->duration);
> +			if (r == old_max)
> +				ctx->max_done = 1;
> +		}
> +	}
> +
> +	if (!ctx->min_done) {
> +		u64 old_min = ctx->data->min_time;
> +
> +		if (old_min <= ctx->duration) {
> +			ctx->min_done = 1;
> +		} else {
> +			u64 r = __sync_val_compare_and_swap(
> +				&ctx->data->min_time, old_min, ctx->duration);
> +			if (r == old_min)
> +				ctx->min_done = 1;
> +		}
> +	}
> +
> +	return (ctx->max_done && ctx->min_done) ? 1 : 0;
> +}
> +
>  static inline void update_contention_data(struct contention_data *data, u64 duration, u32 count)
>  {
>  	__sync_fetch_and_add(&data->total_time, duration);
>  	__sync_fetch_and_add(&data->count, count);
>  
> -	/* FIXME: need atomic operations */
> -	if (data->max_time < duration)
> -		data->max_time = duration;
> -	if (data->min_time > duration)
> -		data->min_time = duration;
> +	struct cas_ctx ctx = {
> +		.data     = data,
> +		.duration = duration,
> +		.max_done = 0,
> +		.min_done = 0,
> +	};
> +	bpf_loop(64, cas_min_max_cb, &ctx, 0);
>  }
>  
>  static inline void update_owner_stat(u32 id, u64 duration, u32 flags)
> -- 
> 2.53.0
> 

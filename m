Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6407643E9DF;
	Thu,  4 Jun 2026 13:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780580020; cv=none; b=IzXHMGJKZaKPDGH3cuNgzVfkpUe2/ae81V701N95uhpjvW9fh12ZHBBp6nKqHJG5BB6VstMfz+ivMrB4snAWV7/HpemC8Qvs0TdwqsyVOeS1CGQwQwvB6FXYuh3CJ1VKrDHifpdvrkP0Yvxcz3CRoR2q5yrX/fYnY+qY+hBQSsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780580020; c=relaxed/simple;
	bh=yZSkVXlDbjzFob7Q16Cq8Zu/ezlmu0+Ud0qF5K8DAB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1sjJi2o7/tfOUSAqR5O2pjAMtZRuNDemMMvqHpwSAlopnEXXU6Ox2dfqcLlzd9kSHOLUTW437LEZJrAHnpGn4DU4Q29U4IHpDTM/LRKg+F59bYWFehE+UL/qf0CMxgxR2gj9kNv2Ca5XSLE3oQzaLV40Kn3/uw49l6mO5uTirI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=km0QBbof; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="km0QBbof"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4351F00893;
	Thu,  4 Jun 2026 13:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780580018;
	bh=fG5xt+sPNYpmLAvoLl4NXn9NnTJ1digykIO6Avya/aU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=km0QBbofreNJd5rXisB9prHOWLirLn+UGix1iZ/D0CE8FZPhLhmBsmLAsbFUMIusc
	 FQCwgwttXTmAsXqmw11g2e18WUikiiBy6TCmn/lCwn8l7b2IMa0KvSRddPQPAZD5o0
	 lYLDYkzP7UWir+pkYT5REd4DMq0D6YOgvz7Kv2C176u7slxuLZ4cSTlR7O2jwHP2Ac
	 E327prq0PrgxAcUvttrQyCeUKbUeEREA1DHwpD3bLtYqRUiJz1fseRRijUuewN9T2q
	 Lsa8+69apymmuH3CdNEgVa2HALOmFbkCDSdNDSD0Eg0TOHp4HzpkND3rR7e+/IoIqd
	 zQG1zHzcZA53g==
Date: Thu, 4 Jun 2026 10:33:35 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	james.clark@linaro.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 1/2] perf/lock: Fix non-atomic max/time and min_time
 updates in contention_data
Message-ID: <aiF-r_YqOHAOiDKq@x1>
References: <20260530195230.69382-1-suchitkarunakaran@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260530195230.69382-1-suchitkarunakaran@gmail.com>

On Sun, May 31, 2026 at 01:22:30AM +0530, Suchit Karunakaran wrote:
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
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf-tools-next, for v7.2.

- Arnaldo

> Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
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
> 2.54.0

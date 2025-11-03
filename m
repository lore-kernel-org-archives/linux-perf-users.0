Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7BE303CAF;
	Mon,  3 Nov 2025 14:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762179302; cv=none; b=R51QtpZuIZeUZO/0caGX351TCgOuCFldT4daxq2FXNiT1Ggw99A+jcAe/XUIroxS9TrRGzWXSox7awLrJ6HSN6vBtD6Fz5CKoD3XtUVse3GxC45BOZw5UrAlIdnq8Hi7Di8NH/uXKsBVz9sMJrV9NiPPjFKl1m1DCZ3vMqqu6FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762179302; c=relaxed/simple;
	bh=fs90Ul4vTnu9dV9I/VxXT9SC/TJ8z2rQUAx6krg4/Gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O74wzks0Mo8Dbtc+TpnTHx3i6/CEwckq2wBn4JT2BpTolcXXVtSnox2m+wnbwm0IsKE+5LIe/ag+3OXm2D/KXJLtk+dbaa1QrvoRNyKkbQ93eoL9PSfSLG7hMpvvMZjCU2p8zfdkW39yy6CUCeIwdCMuKlLuDKyUsnAFxSmDDmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3o01LlD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3o01LlD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EAD4C4CEE7;
	Mon,  3 Nov 2025 14:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762179301;
	bh=fs90Ul4vTnu9dV9I/VxXT9SC/TJ8z2rQUAx6krg4/Gk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X3o01LlDmBO8alUjN9fiIY8ZAoR7Yj4bPPQbuFzEScyf0Q+7jfwgwoRGax0TZ3ojY
	 tzyICCPRCpa3zMyy/7yD27/7XPdsRJKROidbqzVoisReUN7xz3/qO5eQpYtP+0n6A+
	 34LWRNe/+fecNcLTHGQPnYdnTsVIHQS17sRl0IOPv+7Q+bvTglLRtYh82ZIRHggnbS
	 IlPpUHlT5+zj0383kredcBozFfs9sR65eKFqhRDVZfuacSnlVtfOMy90LDKuqYxA8v
	 edKiJH984rvPsqH/NuUuzAS/qRIfHyzmhuTlxxicOom0g9wiUFZ31J4wexSJ9qpm8J
	 tWMwbSQu69+lg==
Date: Mon, 3 Nov 2025 14:14:56 +0000
From: Will Deacon <will@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	James Clark <james.clark@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: arm_spe: Ensure trace is disabled when TRUNCATED
 flag is set
Message-ID: <aQi44CZOiwhI19dd@willie-the-truck>
References: <20251015-arm_spe_fix_truncated_flag-v1-1-555e328cba05@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015-arm_spe_fix_truncated_flag-v1-1-555e328cba05@arm.com>

On Wed, Oct 15, 2025 at 07:23:37PM +0100, Leo Yan wrote:
> The TRUNCATED flag can be set in the following cases:
> 
>  1. When data loss is detected (PMBSR_EL1.DL == 0b1).
>  2. When arm_spe_perf_aux_output_begin() fails to find a valid limit
>     because it runs out of free space.
> 
> Currently, only the first case invokes irq_work_run() to execute the
> event disable callback, while the second case does not.
> 
> Move the call to irq_work_run() later with checking the TRUNCATED flag,
> so that both cases are handled and redundant calls are avoided.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  drivers/perf/arm_spe_pmu.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> index fa50645feddadbea5dc1e404f80f62cf5aa96fd4..05ba977f75d607a1d524f68694db9ea18a6ef20c 100644
> --- a/drivers/perf/arm_spe_pmu.c
> +++ b/drivers/perf/arm_spe_pmu.c
> @@ -731,12 +731,6 @@ static irqreturn_t arm_spe_pmu_irq_handler(int irq, void *dev)
>  	if (act == SPE_PMU_BUF_FAULT_ACT_SPURIOUS)
>  		return IRQ_NONE;
>  
> -	/*
> -	 * Ensure perf callbacks have completed, which may disable the
> -	 * profiling buffer in response to a TRUNCATION flag.
> -	 */
> -	irq_work_run();
> -
>  	switch (act) {
>  	case SPE_PMU_BUF_FAULT_ACT_FATAL:
>  		/*
> @@ -765,6 +759,15 @@ static irqreturn_t arm_spe_pmu_irq_handler(int irq, void *dev)
>  		break;
>  	}
>  
> +	/*
> +	 * The TRUNCATED flag is set when data loss is detected by PMBSR_EL1.DL,
> +	 * or arm_spe_perf_aux_output_begin() sets the flag if runs out of free
> +	 * space. Ensure that all perf callbacks have completed for disabling
> +	 * the profiling buffer.
> +	 */
> +	if (handle->aux_flags & PERF_AUX_FLAG_TRUNCATED)
> +		irq_work_run();

I'm not sure about this. afaict, perf_aux_output_begin() can fail
(return NULL) without setting the TRUNCATED flag but with a disable
pending in irq work. It also feels a little fragile moving the existing
irq_work_run() call as that could easily break in future if e.g. irq
work is used for other manipulation of the buffer controls.

Given that this isn't a fast path, isn't it simpler and safer just to
do something like the below?

Will

--->8

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index fa50645fedda..8a38d69e9600 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -758,6 +758,10 @@ static irqreturn_t arm_spe_pmu_irq_handler(int irq, void *dev)
                if (!(handle->aux_flags & PERF_AUX_FLAG_TRUNCATED)) {
                        arm_spe_perf_aux_output_begin(handle, event);
                        isb();
+
+                       /* Insightful comment here */
+                       if (event->hw.state)
+                               irq_work_run();
                }
                break;
        case SPE_PMU_BUF_FAULT_ACT_SPURIOUS:


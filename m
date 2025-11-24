Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AF231329E;
	Mon, 24 Nov 2025 16:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764000868; cv=none; b=k/0pGSwH+X+Z7vhSKERXnRkBzS+Ct/xpX7ZFeeJUb97f8X+1aEHXMuUynJSWUBiJQ50SvNHzq3+G3uZSA4tS4WHPbi4Ky51gIg/aH/sJKep2rUSCDoxDRXLFRYnmO5CHXPkLGOzJxzVQcL8DXKcnAIunRLqneA3sSydVljCoPas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764000868; c=relaxed/simple;
	bh=G9H9wGmU1A3UKAZvzaabdyQPVDbzmy328mGagCCY2HE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBPukbX0N31IvQhrqWByyaUu5UVkJVU0lzBnSunRPru7ReMZ/G3gcz8BDzoq5Dd7BnABI/ex9JbER4eniEQfWQCxfOoJvOks0vMKtZVg3XWh71q3N4sfW1piOfIwgf4kvqF+pmsjHx1jhDG0Xr5XvfBG2uUQspe8g6ObSwacu9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVf+cccL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVf+cccL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 769F6C4CEF1;
	Mon, 24 Nov 2025 16:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764000868;
	bh=G9H9wGmU1A3UKAZvzaabdyQPVDbzmy328mGagCCY2HE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iVf+cccLqZeIumQJBrKQmcOzC4IQbSYnAiDhcu+WlJ815ho82ogCeo63mawAgqQUz
	 qN7OXkYouTRmI6b5neBgoZmF9voOPg5VX0uf3DKeXV8MfK8v3hVIb+nnY9ARBuLRry
	 XuN2K3QXfHXyKU9qjo1r6RkMlaHnWZWKY/Sg9DZhycIhSE86bR771Cv6CvMqPyzdxz
	 2Byh0p/RmMhjNai65JmDmRvvFYgHm8l1lCP8WVZEYEYjIKtWU0mldFdx85JUMN35pz
	 DhqtVfB3UhOw87MTpLATfJrvESq4xImvwEzApdf7sW5qiMvkdjn/nXW0cHVxB2lkjX
	 jibPH3lTObHHA==
Date: Mon, 24 Nov 2025 16:14:23 +0000
From: Will Deacon <will@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	James Clark <james.clark@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf: arm_spe: Correct setting the
 PERF_HES_STOPPED flag
Message-ID: <aSSEXzMr1drvL2zz@willie-the-truck>
References: <20251110-arm_spe_fix_truncated_flag-v2-0-a629740985cc@arm.com>
 <20251110-arm_spe_fix_truncated_flag-v2-1-a629740985cc@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110-arm_spe_fix_truncated_flag-v2-1-a629740985cc@arm.com>

On Mon, Nov 10, 2025 at 04:28:31PM +0000, Leo Yan wrote:
> In arm_spe_perf_aux_output_begin(), if the calculation of limit fails
> and arm_spe_pmu_next_off() returns zero, the driver misses to set the
> PERF_HES_STOPPED flag for the event.  As a result, hwc->state does not
> reflect the latest state, which can mislead subsequent operations.
> 
> Validate the limit when exiting the function: if the limit is 0,
> that tracing is disabled, set the PERF_HES_STOPPED flag accordingly.
> 
> Fixes: d5d9696b0380 ("drivers/perf: Add support for ARMv8.2 Statistical Profiling Extension")
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  drivers/perf/arm_spe_pmu.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> index fa50645feddadbea5dc1e404f80f62cf5aa96fd4..fc8f908c2c3a270f2d1ae574c2badb1fbcf51484 100644
> --- a/drivers/perf/arm_spe_pmu.c
> +++ b/drivers/perf/arm_spe_pmu.c
> @@ -597,7 +597,6 @@ static void arm_spe_perf_aux_output_begin(struct perf_output_handle *handle,
>  	/* Start a new aux session */
>  	buf = perf_aux_output_begin(handle, event);
>  	if (!buf) {
> -		event->hw.state |= PERF_HES_STOPPED;
>  		/*
>  		 * We still need to clear the limit pointer, since the
>  		 * profiler might only be disabled by virtue of a fault.
> @@ -608,15 +607,19 @@ static void arm_spe_perf_aux_output_begin(struct perf_output_handle *handle,
>  
>  	limit = buf->snapshot ? arm_spe_pmu_next_snapshot_off(handle)
>  			      : arm_spe_pmu_next_off(handle);
> -	if (limit)
> -		limit |= PMBLIMITR_EL1_E;
> +	if (!limit)
> +		goto out_write_limit;

Is 'limit == 0' always indicative of an error, even in snapshot mode?

If __arm_spe_pmu_next_off() fails, it will call perf_aux_output_end()
with the TRUNCATED flag set, which should then disable the event
via arm_spe_pmu_del() and update the state there.

Is that not happening?

Will

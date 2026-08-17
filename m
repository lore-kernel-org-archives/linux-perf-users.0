Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344253EB80E;
	Mon, 17 Aug 2026 23:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787008650; cv=none; b=rS/icCWyt+URrnogwnZ2Ff0VF/D+ADV4gDEeTmxNQMT5XhHXQpfqGvHrG+p+GdElPkNqMHyedljzUOH7RD3evoTd0RNEkYnvaoVboLAJWPM2Lvq9jb5n3AjHNiSonc0tK5Lg2gA5ZCOtf1W7BWHHK7l9ytTukt4pSkNgcZx2sTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787008650; c=relaxed/simple;
	bh=/lBOkp7Jzkz4Z9Ofm0G8WRXkRefnMJ6gbOQmdZXWjCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aaVAB39CEm1WIEcVW1cN9akzN1M2Q7VC7YFWIAa96cR+lu/B8RIZFQj1V2ucGFrWRpY8In/asonBrnzEbdhbxQsMga+5wzzjHOwcH0RcKy86upAkksmVrnk4nT019vqcJ8d3xUfc2RGp1tP2h82qHIIiimXBAewohEukpraIc7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jk2nrL3d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jk2nrL3d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B47B1F000E9;
	Mon, 17 Aug 2026 23:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787008648;
	bh=HGFofkwksGTTvQhdIrOz5sfJoOEECrVnlSYAziwG4c8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jk2nrL3dBcSvRPRaIv9YK/QF8aZR2DdUUqk+Se5q5EPJEoFoihFLEWgNaGLa1JOLz
	 vC6pXY16dquy1t/RpjUyv6JsjTWnow6Fi2dCwSxa2Gj79CQEJZydmDvPHXavUNLyPu
	 Toq16oSTDfNWy4gWnhz7DSyyi9PGucS5wiRkYiZ15YXrrp+QqeT7Gp2vMWw7DJ2KhJ
	 N5NVU80sFCfKudVSUrWGptrPbgkQZLs2lKziCbCe4C3Qr9lL9ACTgWtVaEJWJjwTEG
	 Mz3BAdlX/KsZkoJHWd/vsSmu5cZooIhoYE/LknU6k+ujfB9L9+CoJEuL2Bb6hSOvNI
	 HZSOcWprwYAyw==
Date: Tue, 18 Aug 2026 08:17:27 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, abyssmystery@gmail.com, adrian.hunter@intel.com,
	james.clark@linaro.org, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org
Subject: Re: [PATCH v4] perf fdarray: Fix destructor invocation and event
 counting in fdarray__filter
Message-ID: <aoOWh-e5BR2PX27Q@google.com>
References: <20260723050409.991665-1-irogers@google.com>
 <20260817230431.424646-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260817230431.424646-1-irogers@google.com>

On Mon, Aug 17, 2026 at 04:04:31PM -0700, Ian Rogers wrote:
> When processing POLLHUP or POLLERR for an event in fdarray__filter, the
> function invokes its destructor callback. However, the exact behavior
> around unhandled POLLHUP events on control pipe descriptors caused
> premature termination due to thread and evlist pollfd index mismatches.
> This occurred because they were skipped by the early nonfilterable continue.

Do you have a concrete scenario to check this behavior so that we can
verify the fix?  It'd be great if we can add a test case.

Thanks,
Namhyung

> 
> Address this by refining the early continue filter to only skip system-wide
> perf events (which are nonfilterable but not non_perf_event). Control
> descriptors (non_perf_event) now fall through to appropriately have their
> fd value unset to -1 on POLLHUP while avoiding their destructors. Finally,
> maintain the invariant that the active event counter (nr) increments strictly
> and only for completely filterable events.
> 
> Fixes: fb4751e79c45 ("perf record: Fix teardown hang on system-wide multi-threaded sessions")
> Assisted-by: Gemini:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/api/fd/array.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/lib/api/fd/array.c b/tools/lib/api/fd/array.c
> index 67b73481df27..3681ad7c6527 100644
> --- a/tools/lib/api/fd/array.c
> +++ b/tools/lib/api/fd/array.c
> @@ -116,14 +116,23 @@ int fdarray__filter(struct fdarray *fda, short revents,
>  		return 0;
>  
>  	for (fd = 0; fd < fda->nr; ++fd) {
> -		if (fda->priv[fd].flags & fdarray_flag__nonfilterable)
> +		/*
> +		 * System-wide perf events are nonfilterable but not non_perf_event.
> +		 * We want to skip them entirely and never process revents on them.
> +		 */
> +		if ((fda->priv[fd].flags & fdarray_flag__nonfilterable) &&
> +		    !(fda->priv[fd].flags & fdarray_flag__non_perf_event))
>  			continue;
>  
>  		if (!fda->entries[fd].events)
>  			continue;
>  
>  		if (fda->entries[fd].revents & revents) {
> -			if (entry_destructor)
> +			/*
> +			 * Control descriptors are non_perf_event and don't need
> +			 * their perf-specific destructors triggered.
> +			 */
> +			if (entry_destructor && !(fda->priv[fd].flags & fdarray_flag__non_perf_event))
>  				entry_destructor(fda, fd, arg);
>  
>  			/*
> @@ -136,7 +145,8 @@ int fdarray__filter(struct fdarray *fda, short revents,
>  			continue;
>  		}
>  
> -		++nr;
> +		if (!(fda->priv[fd].flags & fdarray_flag__nonfilterable))
> +			++nr;
>  	}
>  
>  	return nr;
> -- 
> 2.55.0.699.gb54405d56f-goog
> 

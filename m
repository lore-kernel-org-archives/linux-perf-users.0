Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E540E2368F2
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Dec 2024 17:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733939439; cv=none; b=s1UqLb0yQK4X6ygLM7VWpB3lH/5/X4H4Y3rnvAgPrUSbDVHOuer0vK7eVxF9vh8tUYd1IQJMLWsfoG5jWB19hwYH3tgEkyQvZwpqzZrh64pwC2WLRpTSd1bdPEQrjnuDEMyLTB//7baADp+2eSSVKovsKZyComzYOFkTlxL5s2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733939439; c=relaxed/simple;
	bh=MUBHlE+svtf5gWqZ0dHZtD11PdQIN0w8nI84TKxI/4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ai51z0YBkJO/vWTwAn6T/52OhzP8H7bNJRL7jSN0rKjuPe84IArS0m0muBNv5APfAh1uC0Y4zPlu6ty8Wo565WaalAduIsUV3dzxBJbyZxve2iwgVui4ioW4ehXfMXbi15ETmJqUZSabc8yNQhXiMCZhHFw0eaZTPM/4Gi1cJms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjpk/8+y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjpk/8+y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51553C4CED2;
	Wed, 11 Dec 2024 17:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733939437;
	bh=MUBHlE+svtf5gWqZ0dHZtD11PdQIN0w8nI84TKxI/4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kjpk/8+yn/nwL9Ki1BCaOEsP25vW6K+TQ8g3b7PJwSi/Zezq0ohvXmG9ZEkUdyWfk
	 vD9WiTmGbc3IfrhFKp+BM0OEmrlPAYGi1OQtwfo3Ra1biY5/ZiyOwKdpBdc0z9PF2h
	 E6rWO9wMpm1owknAWIh/N/K01FXgQqbA8j2avdW32I6pSdL0O+WncWHFezWG8kcwD3
	 IDMsLKx8ZnESMuTR8A8UUl2cpBZ0Xb08WqUiJ0I010W19jzXcztcML9UIvvWzf0ue0
	 AeL7wsYEJGaC2okzKGW3oxxdW942dKkRA9/QirgipyJh3qTbSAGmNwcgdHoO1hVfdb
	 gp7jS/NBikvqQ==
Date: Wed, 11 Dec 2024 09:50:35 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Andi Kleen <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] Update perf tools topdown documentation
Message-ID: <Z1nQ65jDU9YW8MFu@google.com>
References: <20241210193554.93013-1-ak@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241210193554.93013-1-ak@linux.intel.com>

Hello,

On Tue, Dec 10, 2024 at 11:35:54AM -0800, Andi Kleen wrote:
> - Document and give examples for the Lunar Lake perf metrics reset mode.
> - Fix the error handling for mmap (it returns -1 on error, not 0)
> - Clarify the slots placement documentation. It is not Icelake specific
> and also applies for non sampling.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/Documentation/topdown.txt | 33 +++++++++++++++++++++++-----
>  1 file changed, 28 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/Documentation/topdown.txt b/tools/perf/Documentation/topdown.txt
> index 5c17fff694ee..3e2340f3f78e 100644
> --- a/tools/perf/Documentation/topdown.txt
> +++ b/tools/perf/Documentation/topdown.txt
> @@ -87,7 +87,7 @@ if (slots_fd < 0)
>  
>  /* Memory mapping the fd permits _rdpmc calls from userspace */
>  void *slots_p = mmap(0, getpagesize(), PROT_READ, MAP_SHARED, slots_fd, 0);
> -if (!slot_p)
> +if (slot_p == (void*)-1L)

We can check with MAP_FAILED.

Thanks,
Namhyung

>  	.... error ...
>  
>  /*
> @@ -107,7 +107,7 @@ if (metrics_fd < 0)
>  
>  /* Memory mapping the fd permits _rdpmc calls from userspace */
>  void *metrics_p = mmap(0, getpagesize(), PROT_READ, MAP_SHARED, metrics_fd, 0);
> -if (!metrics_p)
> +if (metrics_p == (void*)-1L)
>  	... error ...
>  
>  Note: the file descriptors returned by the perf_event_open calls must be memory
> @@ -290,15 +290,38 @@ This "opens" a new measurement period.
>  A program using RDPMC for TopDown should schedule such a reset
>  regularly, as in every few seconds.
>  
> -Limits on Intel Ice Lake
> -========================
> +Newer Intel CPUs (Lunar Lake, Arrow Lake+) support resetting the perf
> +metrics automatically RDPMC, which can avoid a system call or needing
> +to schedule special resets.
> +
> +This is available if /sys/devices/cpu*/cap/metrics_clear
> +exists, and requires setting an opt-in bit when opening the 
> +slots counter:
> +
> +if (access("/sys/devices/cpu/cap/metrics_clear") &&
> +    access("/sys/devices/cpu_core/cap/metrics_clear"))
> +     ... functionality not supported ...
> +
> +#define INTEL_TD_CFG_METRIC_CLEAR 1ULL
> +
> +struct perf_event_attr slots_event = {
> +	... same as slots example above ...
> +	.config1 = INTEL_TD_CFG_METRIC_CLEAR,
> +};
> +
> +... open and map counter same as example above ...
> +
> +Then any metric read will reset the metrics and slots.
> +
> +Using perf metrics with perf stat
> +=================================
>  
>  Four pseudo TopDown metric events are exposed for the end-users,
>  topdown-retiring, topdown-bad-spec, topdown-fe-bound and topdown-be-bound.
>  They can be used to collect the TopDown value under the following
>  rules:
>  - All the TopDown metric events must be in a group with the SLOTS event.
> -- The SLOTS event must be the leader of the group.
> +- The SLOTS event must be the first entry of the group.
>  - The PERF_FORMAT_GROUP flag must be applied for each TopDown metric
>    events
>  
> -- 
> 2.47.1
> 

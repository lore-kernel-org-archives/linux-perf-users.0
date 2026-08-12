Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CACA30D3F4;
	Wed, 12 Aug 2026 13:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786539798; cv=none; b=nhRzXjz2sjkZAP5IzHlTmheWMbg25bxJigF268zYBIGY0brzr0UueWXTBk6yytdoHbfRHUlBsF9UQki55YDablSGW0idUerxHxt5DlB0Th1OA3Xl2B4wM03HxCs6JMflBdKtdcVOiKrEjwCKpIO4M7+qpAQb1Ra9G7iFOpYvON0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786539798; c=relaxed/simple;
	bh=KMZhlJDNPq0c5+f89FpuCxOeRd5xdLN1+fOw5bjGJXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=me8rfbH0B6HUUsalp8TvjpmbYcNhPg8VB6xKWIyX3jkw9H/hBjeSN/YsU8O8+Ar5y7dgIuEHAD2yEEbLJuA3Bg8FUlrdD34ItAZZ9januQ9IuKlqLGKUITyRiuGNw57BBy51EjkVZxRRFwzLyI36W+7QWYsCB+hJ3ldjK5Yw6Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frM/Zbn6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frM/Zbn6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D181F00A3F;
	Wed, 12 Aug 2026 13:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786539796;
	bh=HeLL5bDtg8tn88i9BNzl3zKkd0qCTEFtMdb7eqCt4/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=frM/Zbn6zRo1HBA5npuNwlYahT5EbA3GXytNC4cw3xjBg20y+dxz++499bztCJewG
	 GlkEqiqLEigvg5U4gkqKwWh5bnNtslr9HFhDaPv7zgtaWaclaK25S/qSodro9+Qvg5
	 IwCX/pB5OTfUcjVyii3p3MXgQfrhUB3HpJmlFK86eLVCVFucQrr6TdXmft372F9++I
	 BHREhXa73dc5HOo2kBRhLR6Xjhc1Pre0FcpKn0WYwH1yjB5yrDx+NR6gKgTzgjJ720
	 839gTF6mXmncAWxJ4Uiz5x43HwlzkCmxevSqUme+2/VLQfCgEKEuXyOthJvYKvyWsb
	 Td7rkRktLFTzA==
Date: Wed, 12 Aug 2026 22:03:10 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Jiebin Sun <jiebin.sun@intel.com>
Cc: acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
	adrian.hunter@intel.com, alexander.shishkin@linux.intel.com,
	irogers@google.com, james.clark@linaro.org, jolsa@kernel.org,
	mark.rutland@arm.com, dapeng1.mi@linux.intel.com,
	thomas.falcon@intel.com, tianyou.li@intel.com,
	wangyang.guo@intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 6/9] perf c2c: add function view hierarchy entry
 creation
Message-ID: <anxvDnc2Kx-OSQEj@google.com>
References: <20260810052647.588867-1-jiebin.sun@intel.com>
 <20260810052647.588867-7-jiebin.sun@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260810052647.588867-7-jiebin.sun@intel.com>

On Mon, Aug 10, 2026 at 01:26:44PM +0800, Jiebin Sun wrote:
> Add the entry-creation layer: owned-reference child allocation and
> insertion, and the level-1/2/3 lookup-or-create functions keyed by
> function symbol (level 1 read-side, level 2 writer) and by the source
> cacheline's existing index (level 3).
> 
> Give synthetic children normal entry operations and acquire their thread
> and map-symbol references. This lets the hierarchy teardown use
> hist_entry__delete() for the common fields while the function-view free
> callback handles the private child tree and containing allocation.
> 
> Reuse cacheline_idx to preserve the source entry identity without adding
> function-view-only state. The browser can later use the same index to find
> the original cacheline entry.
> 
> These are driven by the hierarchy builder in the next patch and are
> __maybe_unused until then.
> 
> Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Falcon <thomas.falcon@intel.com>
> Reviewed-by: Tianyou Li <tianyou.li@intel.com>
> Reviewed-by: Wangyang Guo <wangyang.guo@intel.com>
> ---
>  tools/perf/ui/browsers/c2c-function.c | 293 +++++++++++++++++++++++++-
>  1 file changed, 282 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browsers/c2c-function.c
> index 4bf8406fde55..4099d4c7e7b4 100644
> --- a/tools/perf/ui/browsers/c2c-function.c
> +++ b/tools/perf/ui/browsers/c2c-function.c
> @@ -28,6 +28,7 @@
>  #include "../../util/addr_location.h"
>  #include "../../util/cacheline.h"
>  #include "../../util/debug.h"
> +#include "../../util/dso.h"
>  #include "../../util/hist.h"
>  #include "../../util/map.h"
>  #include "../../util/mem-events.h"
> @@ -57,12 +58,34 @@ static inline __maybe_unused u64 c2c_hitm_count(const struct c2c_stats *stats)
>  	return stats->tot_hitm;
>  }
>  
> -static inline __maybe_unused bool symbol_name_equal(struct symbol *a, struct symbol *b)
> +static int64_t c2c_function_cmp(const struct map_symbol *left,
> +				const struct map_symbol *right)
>  {
> -	/* Two unknown symbols compare equal, matching cmp_null() in util/sort.c. */
> -	if (!a || !b)
> -		return a == b;
> -	return arch__compare_symbol_names(a->name, b->name) == 0;
> +	const struct dso *left_dso = left->map ? map__dso(left->map) : NULL;
> +	const struct dso *right_dso = right->map ? map__dso(right->map) : NULL;
> +	int ret;
> +
> +	if (!left_dso || !right_dso) {
> +		if (left_dso != right_dso)
> +			return left_dso ? 1 : -1;

What if both DSOs are NULL?

Thanks,
Namhyung


> +	} else {
> +		/*
> +		 * Use the same DSO name as _sort__dso_cmp() (short name unless
> +		 * verbose), so this matches the DSO comparison the level-1
> +		 * entries are deduplicated by; otherwise same-basename DSOs
> +		 * could be split or merged inconsistently across levels.
> +		 */
> +		const char *left_name = verbose > 0 ?
> +			dso__long_name(left_dso) : dso__short_name(left_dso);
> +		const char *right_name = verbose > 0 ?
> +			dso__long_name(right_dso) : dso__short_name(right_dso);
> +
> +		ret = strcmp(left_name, right_name);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return _sort__sym_cmp(left->sym, right->sym);
>  }

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A03189B87
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Sep 2024 15:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725377059; cv=none; b=P3Zz/D+aDCIsDuu+xA7u8mPZVk5CPjJBJO+bmobC7yX8Wi3MKlMq5jLbheJzkQ5iRvp+E+jvDHn+Cxi65ailyQie/jK1uhbjWCAwSGH9muz+V8Uprqd9jbf4D42X/AQLdeVQuVFi2tlJn5a/Gv6BGSAERZ23maufrxfFPtk9MXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725377059; c=relaxed/simple;
	bh=Jk8XOFjBm56wPbaRGcvPLxaH3u8UaqmFkFydKBs+H10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxk5wPGdmjLCnsWFTVXOkpjWhdmkTgQ58+cgL5gIMW7pnxM3PdbNoA6SPzwHWm+u2ffHyY93uiCTcjoj2saNIaAIb1IeYN02LC/7MJxNEmvjm0GyH+1AKN3g1DRt3C93o3g2xtqd+v1qUJ/kpwMNv+o+6YjcBYYoyfjhEllvpBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b50IycaD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b50IycaD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910CCC4CEC4;
	Tue,  3 Sep 2024 15:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725377059;
	bh=Jk8XOFjBm56wPbaRGcvPLxaH3u8UaqmFkFydKBs+H10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b50IycaDoTrknQDpYst5bfGrNE6aQiGQO6mxdKIB1yTmdXiqgNQ9VNIC0AUbeVsoa
	 kasiLdfc9uEmtvtAZgkdBbYBfP7GUXi8LYfW/ffduw3hoXAB1idcRBV2YjsyYp4LSy
	 1g/pw0989ZnLmOhmug/Jm/z21BtCTy6JlIHOI2SvFf/vz8ajJSdmw/p+CPhdX9n3/V
	 2oU75Cp8HR0NjpnKD8XJQBbLivdmgIhSx446eojGRsLhs0W3FNm+fWnlxOdgL9g4+5
	 prFLCTzPxW1mC1642MFOf4Sbv/L7IlydKHBsV+GXdUDVEE6Bf0WWimpH1DiVXDUXjW
	 73ueGcGOfBhKA==
Date: Tue, 3 Sep 2024 12:24:15 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, James Clark <james.clark@arm.com>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf maps: Output debugging info for 'perf test'
Message-ID: <ZtcqH4hqQDoyJ_j4@x1>
References: <20240512110555.999-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240512110555.999-1-leo.yan@arm.com>

On Sun, May 12, 2024 at 12:05:55PM +0100, Leo Yan wrote:
> When run the test case 'maps__merge_in', it reports:

Leo, this fell thru the cracks, now I tried to merge it but it isn't
applying anymore, can you check, please?

- Arnaldo
 
>   # perf test -vvv maps__merge_in
>      58: maps__merge_in:
>   --- start ---
>   test child forked, pid 35232
>   overlapping maps in bpf_prog_1 (disable tui for more info)
>   overlapping maps in bpf_prog_2 (disable tui for more info)
>   overlapping maps in bpf_prog_3 (disable tui for more info)
>   overlapping maps in bpf_prog_2 (disable tui for more info)
>   overlapping maps in bpf_prog_3 (disable tui for more info)
>   overlapping maps in kcore1 (disable tui for more info)
>   ---- end(0) ----
> 
> The log suggests to disable TUI mode for printing verbose log. On the
> other hand, 'perf test' always runs without enabling TUI mode.
> 
> The flag 'user_browser' is not a bool value. When it's equal or greater
> than 1 the tool works in TUI or GUI mode, otherwise, 0 or '-1' means the
> tool works as stdio mode. Correct the condition checking for the flag
> 'user_browser' to print the debugging logs properly.
> 
> After:
> 
>   # ./perf test -vvv maps__merge_in
> 
>    58: maps__merge_in:
> 
>   --- start ---
>   test child forked, pid 36529
>   overlapping maps:
>    c8-12c 0 bpf_prog_1
>    64-3e8 0 kcore1
>    64-c8 0 kcore1
>    12c-3e8 c8 kcore1
>   overlapping maps:
>    1f4-258 0 bpf_prog_2
>    12c-3e8 c8 kcore1
>    12c-1f4 c8 kcore1
>    258-3e8 1f4 kcore1
>   ...
>   ---- end(0) ----
>    58: maps__merge_in                                                  : Ok
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/perf/util/maps.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
> index ce13145a9f8e..073be9c309f9 100644
> --- a/tools/perf/util/maps.c
> +++ b/tools/perf/util/maps.c
> @@ -764,7 +764,7 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
>  		if (map__start(pos) >= map__end(new))
>  			break;
>  
> -		if (use_browser) {
> +		if (use_browser >= 1) {
>  			pr_debug("overlapping maps in %s (disable tui for more info)\n",
>  				map__dso(new)->name);
>  		} else if (verbose >= 2) {
> @@ -787,7 +787,7 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
>  			}
>  			map__set_end(before, map__start(new));
>  
> -			if (verbose >= 2 && !use_browser)
> +			if (verbose >= 2 && use_browser <= 0)
>  				map__fprintf(before, fp);
>  		}
>  		if (map__end(new) < map__end(pos)) {
> @@ -805,7 +805,7 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
>  			assert(map__map_ip(pos, map__end(new)) ==
>  			       map__map_ip(after, map__end(new)));
>  
> -			if (verbose >= 2 && !use_browser)
> +			if (verbose >= 2 && use_browser <= 0)
>  				map__fprintf(after, fp);
>  		}
>  		/*
> -- 
> 2.39.2

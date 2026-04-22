Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1742E20299B;
	Wed, 22 Apr 2026 02:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776824148; cv=none; b=t0MTVmPnVixovSKNKi+GsE+DnTdSC8GoP3tTrLF+sWwLLxLUdWrkanhbFgEpF8jY10kKq+9ZAvt3yfHItqEpfWl6PJX4p6zbb97EgSPmyGIFJbyND3s8Xsg+3iXj8DuDWKXJeJRQ3HaWAqkbrAB69/nrrGA2Btt4d5/BM6XSBWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776824148; c=relaxed/simple;
	bh=YnUD94tSN1Ut9kS7+Zs8vMD4pEL3mG+wS9baxpsgie4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O51/XZwFRjWdNOaa4NPfM9ZvCaeHyOWmLqaGnw1QMVdsvcpSRyRKCfJhNDyL54sXr5kpNZy7+04+yRK1f7Zo0v6AG1mzFB2gjeU9Jl0n04BH8APwd8ODtwKKEWDZMUkEOZ04RbKwGybx5UeUbdRrr7lSYvHRTrghCLFtqJT3BqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LcnSzXNW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LcnSzXNW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D4FC2BCB0;
	Wed, 22 Apr 2026 02:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776824147;
	bh=YnUD94tSN1Ut9kS7+Zs8vMD4pEL3mG+wS9baxpsgie4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LcnSzXNWs31PjpHvDvCMR1dV6Td4KbMg1M/ieloifZYhkwInHcLO/yUDhJSEjo3Tn
	 xTnwR1hTUOM62IBK9gHgjLCFCeRZTmEsp+NGv2K8kCJBJ2GDxAqR/BoGRT1OPOUmlR
	 Rj80AtKJV/w9XMpFipvqkFhjXl6QB3PJ2tz6739K1WUuS40Ymw3o7Pu+tlyZtL3Ohq
	 rnFwFbrWO5QhlNg7cjppQQv8ODFyf9RoGwos+It9XfT/T580qFiQpcC5C4Bi0yUIy0
	 Ni0Hl/RWfwpE53YHX41m4Y6oUemcRVm1h/JI7FwRIlNnTQJlMg1YyFH5htI9oj8hb2
	 Et7pPr6RXPB3A==
Date: Tue, 21 Apr 2026 19:15:45 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf annotate: Fix crashes on empty annotate windows
Message-ID: <aegvUXJTQT9qRoDs@google.com>
References: <20260420-james-perf-annotate-assert-v1-1-ddf04d640569@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260420-james-perf-annotate-assert-v1-1-ddf04d640569@linaro.org>

On Mon, Apr 20, 2026 at 12:52:17PM +0100, James Clark wrote:
> Annotate can open with an empty window if the disassembly tool fails.
> After the linked change, the TUI started assuming there was a current
> annotation line and could assert or segfault in the seek, refresh, and
> source-toggle paths.
> 
> Handle empty annotate windows explicitly: set the asm entry count before
> resetting the browser, return early when refreshing an empty list, and
> ignore source line toggle when there is no current annotation line.
> 
> Fixes the following when opening an annotation:
> 
>   perf: ui/browser.c:125: ui_browser__list_head_seek: Assertion `pos != NULL' failed.
>   Aborted
> 
> Fixes: e201757f7a0a ("perf annotate: Fix source code annotate with objdump")
> Assisted-by: GitHub Copilot:GPT-5.4
> Signed-off-by: James Clark <james.clark@linaro.org>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/ui/browser.c           | 3 +++
>  tools/perf/ui/browsers/annotate.c | 5 ++++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
> index dc88427b4ae5..321187b204d3 100644
> --- a/tools/perf/ui/browser.c
> +++ b/tools/perf/ui/browser.c
> @@ -513,6 +513,9 @@ unsigned int ui_browser__list_head_refresh(struct ui_browser *browser)
>  	struct list_head *head = browser->entries;
>  	int row = 0;
>  
> +	if (browser->nr_entries == 0)
> +		return 0;
> +
>  	if (browser->top == NULL || browser->top == browser->entries)
>                  browser->top = ui_browser__list_head_filter_entries(browser, head->next);
>  
> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> index ea17e6d29a7e..0261cd922183 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c
> @@ -449,6 +449,9 @@ static bool annotate_browser__toggle_source(struct annotate_browser *browser,
>  	struct annotation_line *al;
>  	off_t offset = browser->b.index - browser->b.top_idx;
>  
> +	if (browser->b.nr_entries == 0)
> +		return false;
> +
>  	browser->b.seek(&browser->b, offset, SEEK_CUR);
>  	al = list_entry(browser->b.top, struct annotation_line, node);
>  
> @@ -542,8 +545,8 @@ static void annotate_browser__show_full_location(struct ui_browser *browser)
>  static void ui_browser__init_asm_mode(struct ui_browser *browser)
>  {
>  	struct annotation *notes = browser__annotation(browser);
> -	ui_browser__reset_index(browser);
>  	browser->nr_entries = notes->src->nr_asm_entries;
> +	ui_browser__reset_index(browser);
>  }
>  
>  static int sym_title(struct symbol *sym, struct map *map, char *title,
> 
> ---
> base-commit: 841dbf4871c57ce2da18c4ea7ffac5487d0eda16
> change-id: 20260417-james-perf-annotate-assert-20f520eeb35b
> 
> Best regards,
> -- 
> James Clark <james.clark@linaro.org>
> 

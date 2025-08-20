Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A83428489B;
	Wed, 20 Aug 2025 21:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755724399; cv=none; b=DsBwGEHkO+SbJgXSHLpXL0fvZVNwQJyPr5E44+xuQZ36Jy1U2ay/JF/QSUH+mUP/nraaW8jLQ1eOkLhd27eXgRB660MAxPXLZyaj2Vhs4h7haSG6D2HlQuiLzbIWz4DKlvMNBIv+5BOMjtCC69ViEkISvNio96VoLCfovSIBR8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755724399; c=relaxed/simple;
	bh=swTgXjyVEFW0wP1Js/acWsQ7tBKvZztqaKDArXFL87s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iybISTTxWCZG2pwdfmjY1oTfVzI+2OF9WsO6b3vKQLH2ILPGIniLKXNGOwMJz/c8ZptBJoMphGTa3pV2Nxr6FOGeSOBrYzdAOfj0bhhMZJ/UA00LWWJeNss3qWh8TIZxj16G8IUSsMA9ePIf4yJJ9VPEsbfGr+Xssq6COa6CCy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GapdvAIF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GapdvAIF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A205C4CEE7;
	Wed, 20 Aug 2025 21:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755724398;
	bh=swTgXjyVEFW0wP1Js/acWsQ7tBKvZztqaKDArXFL87s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GapdvAIFyvkhNCfQDWs8oBKjZFFEVzsXPYFcEVH4t39FFa2mrfzYPI2yIFgl+usOQ
	 vwuONbmBnmai3pCQst9jNrFjrpIa8sgUWeBrnwTV5tg0g3+xSuLh3ygax/e5LOt3yf
	 +7JiVZ0azKIpKESa+vuk6Fae7I/uYGmsWW7lcDtNP6GDx1YjeGbeRQ47cv7jJJzaJD
	 BgXu4yRcG2yKLUcZ1U2Dql6DSPH3LalUcykssEdI8yKgA0oBGODlY+Q1VkY4+qDM0K
	 9SlXrv+fm0La9zgrhkpCgiC0+yrVY3ISt0SmIqUw/7AIkEOC1g7SEUiZ+X7yWbIlZ8
	 206MzxWE687QA==
Date: Wed, 20 Aug 2025 18:13:15 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 08/12] perf annotate: Add 'T' hot key to toggle data
 type display
Message-ID: <aKY6a0ELxX3jru1q@x1>
References: <20250816031635.25318-1-namhyung@kernel.org>
 <20250816031635.25318-9-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250816031635.25318-9-namhyung@kernel.org>

On Fri, Aug 15, 2025 at 08:16:31PM -0700, Namhyung Kim wrote:
> Support data type display with a key press so that users can toggle the
> output dynamically on TUI.  Also display "[Type]" in the title line if
> it's enabled.

Testing here I see:

   0.81 │       mov     0x9c(%r8),%r11d         # data-type: struct cfs_rq +0x9c

If I ask for source code by pressing 's':

        │     delta += sa->period_contrib;                                                                                                                              ▒
   0.97 │       mov     0x9c(%r8),%r11d         # data-type: struct cfs_rq +0x9c

So it is the 'period_contrib' field of 'struct cfs_rq', humm, not:

root@number:~# pahole -E --hex cfs_rq | grep 0x9c -B 10 -A10
	struct sched_entity *      next;                                                 /*  0x60   0x8 */

	/* XXX 24 bytes hole, try to pack */

	/* --- cacheline 2 boundary (128 bytes) --- */
	struct sched_avg {
		/* typedef u64 -> __u64 */ long long unsigned int last_update_time;      /*  0x80   0x8 */
		/* typedef u64 -> __u64 */ long long unsigned int load_sum;              /*  0x88   0x8 */
		/* typedef u64 -> __u64 */ long long unsigned int runnable_sum;          /*  0x90   0x8 */
		/* typedef u32 -> __u32 */ unsigned int       util_sum;                  /*  0x98   0x4 */
		/* typedef u32 -> __u32 */ unsigned int       period_contrib;            /*  0x9c   0x4 */
		long unsigned int  load_avg;                                             /*  0xa0   0x8 */
		long unsigned int  runnable_avg;                                         /*  0xa8   0x8 */
		long unsigned int  util_avg;                                             /*  0xb0   0x8 */
		unsigned int       util_est;                                             /*  0xb8   0x4 */
	} avg __attribute__((__aligned__(64))); /*  0x80  0x40 */

	/* XXX last struct has 4 bytes of padding */

	/* --- cacheline 3 boundary (192 bytes) --- */
	struct {
root@number:~#

So it is in a subtype and probably this is an improvement to be made,
right?

- Arnaldo
 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/ui/browsers/annotate.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> index e5b35336f0d33d7e..dfe869c20e35da77 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c
> @@ -533,9 +533,10 @@ static void ui_browser__init_asm_mode(struct ui_browser *browser)
>  static int sym_title(struct symbol *sym, struct map *map, char *title,
>  		     size_t sz, int percent_type)
>  {
> -	return snprintf(title, sz, "%s  %s [Percent: %s]", sym->name,
> +	return snprintf(title, sz, "%s  %s [Percent: %s] %s", sym->name,
>  			dso__long_name(map__dso(map)),
> -			percent_type_str(percent_type));
> +			percent_type_str(percent_type),
> +			annotate_opts.code_with_type ? "[Type]" : "");
>  }
>  
>  /*
> @@ -909,7 +910,8 @@ static int annotate_browser__run(struct annotate_browser *browser,
>  		"b             Toggle percent base [period/hits]\n"
>  		"B             Branch counter abbr list (Optional)\n"
>  		"?             Search string backwards\n"
> -		"f             Toggle showing offsets to full address\n");
> +		"f             Toggle showing offsets to full address\n"
> +		"T             Toggle data type display\n");
>  			continue;
>  		case 'r':
>  			script_browse(NULL, NULL);
> @@ -1029,6 +1031,12 @@ static int annotate_browser__run(struct annotate_browser *browser,
>  		case 'f':
>  			annotation__toggle_full_addr(notes, ms);
>  			continue;
> +		case 'T':
> +			annotate_opts.code_with_type ^= 1;
> +			if (browser->dbg == NULL)
> +				browser->dbg = debuginfo__new(dso__long_name(map__dso(ms->map)));
> +			annotate_browser__show(&browser->b, title, help);
> +			continue;
>  		case K_LEFT:
>  		case '<':
>  		case '>':
> @@ -1133,8 +1141,7 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
>  
>  	ret = annotate_browser__run(&browser, evsel, hbt);
>  
> -	if (annotate_opts.code_with_type)
> -		debuginfo__delete(browser.dbg);
> +	debuginfo__delete(browser.dbg);
>  	if (not_annotated && !notes->src->tried_source)
>  		annotated_source__purge(notes->src);
>  
> -- 
> 2.50.1

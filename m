Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BBF3346A6;
	Sat, 29 Aug 2026 21:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788038192; cv=none; b=HrHxXAwFiaxQIP9ShEjfLcOi1sDe2HPjvzg3aF+qcfnxz1HwptAgXw/MrhSfnXuU4L4tZg+r2iLUm0tzK1f8H2J4PqgLO4Xyx1r+pax8f5/JslhfkXJVY1nN86rFq70cF6cv/EaMi8rH0F4dtsMKZd3nAmsH8H7A4MSyOaar8tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788038192; c=relaxed/simple;
	bh=EJV2TB420ZnEEfFdTeVSon8O/uii/pZDjhNK7C4p32Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DNWGh1bYBkfAIBmHsVhA46sy/8k7QYPtlsGnRcKkorRFQ7rmetH07fT9xp+biiuOC9yDlcCSSOXIZ/RRjq39MmniRhkbxq9UK61K4aNqYAp18H2qI7O+K3Gp3HDwno1/+jWb7GAt2GNUPLD2IKE+qF54fZiCPLBnEcnbHjVJa7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLx8qE7U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLx8qE7U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F23901F000E9;
	Sat, 29 Aug 2026 21:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788038191;
	bh=tQSBh8HHZIoNEOUDVfZe1FU25EMqr9DFZVM2Kan8l5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MLx8qE7Ucogo3voSDlogBRHAMIKbfp20IXBisdrxvQgAbA7vS6pm+FVDISL4tpPJs
	 rcQvVMKtvOOS1YpPfRhjmRz+GQKkCwts74M7K975G8OqGJ6Pp1EpWqXCWzsFSbuxg5
	 itB4WCSDMb+YZao/GkWv82DxEpQlg9GDY8Jq/hLCDwN/YSrZgqZW3NzdghTS08sgEL
	 VUXuq6TqOzM6dxjvMiPMZbV9HZNodybQ5OEPkd0ZvwW5Y5kz26HjM9ZCbfYXfLr1EE
	 SOWG9+h9HUMoG1oLuPtBwAOVZHL+aqCcMv+ZaYBXAc00H5Iet7AWD/OJivPfoMrXxX
	 bdJtKbxzPBRjA==
Date: Sat, 29 Aug 2026 14:16:29 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Andi Kleen <ak@linux.intel.com>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4 3/4] perf tools: Add support for displaying weights in
 annotate
Message-ID: <apNMLUna4pngFX3O@google.com>
References: <20260818230229.1491871-1-ak@linux.intel.com>
 <20260818230229.1491871-4-ak@linux.intel.com>
 <20260818231536.6E7761F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260818231536.6E7761F000E9@smtp.kernel.org>

Hi Andi,

On Tue, Aug 18, 2026 at 11:15:36PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> - [Medium] The TUI browser width calculation omits cycle and branch counter widths, leading to visual truncation.
> - [Medium] Toggling weight columns globally freezes the weight mask for all symbols, breaking accurate display.
> - [Medium] Use of compile-time host architecture macros breaks cross-platform analysis for weight modes.
> - [Low] Typographical error in the `--weights` command-line option description.
> --
> 
> --- Patch [3]: [PATCH v4 3/4] perf tools: Add support for displaying weights in annotate ---
> commit 9eb5862996d191c9f87138b1476aa94808cc5008
> Author: Andi Kleen <ak@linux.intel.com>
> 
> perf tools: Add support for displaying weights in annotate
> 
> Add support for showing all the three possible per IP weights in
> annotate. The weights are shown by defaults if any are non zero. This
> is useful, especially with the new insn lat statistics, but also
> for all the existing weights.
> 
> Add a hotkey to the interactive browser to turn them off (w), as well
> as a perf annotate command line option.
> 
> > diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> > index 69cb72b2082a6..998f472152e2f 100644
> > --- a/tools/perf/builtin-annotate.c
> > +++ b/tools/perf/builtin-annotate.c
> [ ... ]
> > @@ -719,6 +719,8 @@ int cmd_annotate(int argc, const char **argv)
> >  	OPT_BOOLEAN(0, "tui", &annotate.use_tui, "Use the TUI interface"),
> >  #endif
> >  	OPT_BOOLEAN(0, "stdio", &annotate.use_stdio, "Use the stdio interface"),
> > +	OPT_BOOLEAN(0, "weights", &symbol_conf.annotate_weight,
> > +		    "Hide or hide weight columns in annotation. Default show if non zero."),
> 
> [Severity: Low]
> This isn't a bug, but there is a typo in the help text here. "Hide or hide"
> should probably be "Show or hide" to match the identical option added to
> builtin-report.c.

Please fix.

> 
> > diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> > index e47a467750890..16713d85db7c5 100644
> > --- a/tools/perf/ui/browsers/annotate.c
> > +++ b/tools/perf/ui/browsers/annotate.c
> [ ... ]
> > @@ -1091,6 +1093,15 @@ static int annotate_browser__run(struct annotate_browser *browser,
> >  				symbol_conf.show_total_period = true;
> >  			annotation__update_column_widths(notes);
> >  			continue;
> > +		case 'w':
> > +			symbol_conf.annotate_weight = !symbol_conf.annotate_weight;
> > +			symbol_conf.weight_mask_user = true;
> > +			symbol_conf.weight_mask = !symbol_conf.annotate_weight ?
> > +				0 : sym_hist__weight_mask(annotation__histogram(notes, evsel));
> 
> [Severity: Medium]
> Does toggling weight columns globally freeze the weight mask for all symbols?
> 
> Because symbol_conf is global, when the 'w' hotkey sets
> symbol_conf.weight_mask_user to true, all subsequently viewed symbols will
> use the frozen mask from this current symbol.
> 
> If a newly opened symbol has different weights (for example, WEIGHT_INSNLAT
> instead of WEIGHT_WEIGHT), those relevant columns might incorrectly remain
> hidden.
> 
> [ ... ]
> > @@ -1228,7 +1239,7 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
> >  	browser.b.width = notes->src->widths.max_line_len;
> >  	browser.b.nr_entries = notes->src->nr_entries;
> >  	browser.b.entries = &notes->src->source;
> > -	browser.b.width += 18; /* Percentage */
> > +	browser.b.width += annotation__pcnt_width(notes, evsel);
> 
> [Severity: Medium]
> Could this width calculation result in visual truncation of the TUI browser?
> 
> By replacing the hardcoded 18 with annotation__pcnt_width() in
> __hist_entry__tui_annotate(), the browser width calculation remains strictly
> bound to the percentage and weight columns. It doesn't appear to make any
> allowance for the IPC, cycles, or branch counters that might be displayed.
> 
> If no weights are present, the padding drops significantly, which might set
> the horizontal scroll limit too narrow to show the full annotated line.

I don't remember where 18 came from but it seems we need to check
different annotation mode like IPC or branch counters with this change.

> 
> > diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> > index df70e95a84704..d4886e18275ef 100644
> > --- a/tools/perf/util/annotate.c
> > +++ b/tools/perf/util/annotate.c
> [ ... ]
> > @@ -778,6 +797,47 @@ static bool needs_type_info(struct annotated_data_type *data_type)
> >  	return (data_type != &stackop_type) && (data_type != &canary_type);
> >  }
> >  
> > +static const char *annotation__weight_mode_str(enum symbol__weight_mode mode)
> > +{
> > +	switch (mode) {
> > +	case WEIGHT_NONE:
> > +		return "";
> > +	case WEIGHT_WEIGHT:
> > +		return "Weight";
> > +	case WEIGHT_INSNLAT:
> > +		return "InsnLat";
> > +	case WEIGHT_WEIGHT3:
> > +#ifdef __powerpc__
> > +		return "PCycleLat";
> > +#elif defined(__x86_64__)
> > +		return "RetireLat";
> > +#else
> > +		return "Weight3";
> > +#endif
> 
> [Severity: Medium]
> Does using compile-time host architecture macros break cross-platform
> analysis for weight modes?
> 
> If an ARM64 host machine analyzes an x86_64 perf.data file, it will
> incorrectly display "Weight3" instead of "RetireLat".
> 
> Would it be better to dynamically inspect the ELF machine constant
> (e_machine) via the evsel or session structures instead of relying on host
> compile-time macros?

Right, I think you can pass an evsel and get a session then e_machine
from it.

Thanks,
Namhyung

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260818230229.1491871-1-ak@linux.intel.com?part=3

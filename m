Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EAC223DF1;
	Thu,  5 Jun 2025 21:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749157962; cv=none; b=jWItoZRKVaD6UMkJCwioA3KLutiU46c7rKKWRGcIR8xZZKhRNQoCSbdZUh7dWjOAlVStZy1uQo/48s6sotkClLTotL4oghlaF0srgpIOnd+S4Ca9+cVxM/zFi8mteJh8G+MFtvTJ+jgrggXZGbeh1mbbIMVyR0moBbaltSAuC7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749157962; c=relaxed/simple;
	bh=E68LmhCReqJaa8c0bb4Z5dTVK2OKwRICpy+jtrk0fyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oeVtl7pjeyz8rPdee23f9yNNu1zqEPROWVES+zWXV8/ndcOJ1NcsG/Jfm7RO5Ofsb3e9nq2yyew4Z6roxAHRqkDcHS3CXFM0mF0F2hvKWY+MNXffTx43gCQqsW93B4bihXuq6io+lA/mjNXdlKsg7p1aaFC44rHm9n9TQ1J65XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVS91JNi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVS91JNi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D8ADC4CEE7;
	Thu,  5 Jun 2025 21:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749157961;
	bh=E68LmhCReqJaa8c0bb4Z5dTVK2OKwRICpy+jtrk0fyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mVS91JNiqbGBzl3h+h3hlDuuvJzDxjUKCrBYM0bEx4e0yNzT1pyQQtIS4tZXkVS7i
	 JD6RQA8Cd+9U/8pcMDwcx20A0y3esrTslmNkqlpwsfGF57T3nzTicRGi131qF3C2f6
	 uwMHfqXl6hvaXUp2ovoKk/2mn2hXDzaMsBhiJcrsjjSzmn4tqkVNt9VrjJEr89dkhE
	 xk4YGLsw7t6ues0R0VGmdvU5cPau7D8qZykCZBdh/EUjqoHinP+SQT9r5LCez7axp0
	 V36RJ/gpiTBKeUE6rgTxQz6suIeyy+22PpObB4PH4eI/VlW8ofsJq15Hf9UkDzpuBk
	 MTNXpHDzC2ZBw==
Date: Thu, 5 Jun 2025 18:12:38 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH 6/6] perf annotate: Add 'y' hot key to toggle data type
 display
Message-ID: <aEIIRmb6SNOroSJJ@x1>
References: <20250601065302.12531-1-namhyung@kernel.org>
 <20250601065302.12531-7-namhyung@kernel.org>
 <aEICHsZPYbN5KWTa@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEICHsZPYbN5KWTa@x1>

On Thu, Jun 05, 2025 at 05:46:22PM -0300, Arnaldo Carvalho de Melo wrote:
> On Sat, May 31, 2025 at 11:53:02PM -0700, Namhyung Kim wrote:
> > Support data type display with a key press so that users can toggle the
> > output dynamically on TUI.
> 
> 'd', 'T', control+d, control+t are all available, why 'y'? :-)
> 
> Apart from these minor nits,

There is one issue I noticed now that Ingo mentioned earlier, if you
press 'y' to get Data type display we better add some visual cue that
this is toggled, like was done for source code view in:

commit c6043d35c0f3eb5bcbeb6309e10c4ae33d203841
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Tue Apr 8 19:03:43 2025 -0300

    perf ui browser annotate: Show in the title the source code view toggle
    
    Ingo reported that having a visual cue if the source code view is
    enabled will help in noticing a bug when no source is presented.
    
    Change the title scnprintf routine for the annotation browser to do
    that.
    
    Suggested-by: Ingo Molnar <mingo@kernel.org>

Also I did it with a simple perf.data file, no data stuff in it,
probably it is best to show that if what is required for it to work is
present in the perf.data file.

Or to tell what is needed for that hotkey/feature to work, which I think
is even better and more informative.

- Arnaldo
 
> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> - Arnaldo
>  
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/ui/browsers/annotate.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> > index 686fa54e545e275c..cd1d452035a265d3 100644
> > --- a/tools/perf/ui/browsers/annotate.c
> > +++ b/tools/perf/ui/browsers/annotate.c
> > @@ -827,7 +827,8 @@ static int annotate_browser__run(struct annotate_browser *browser,
> >  		"b             Toggle percent base [period/hits]\n"
> >  		"B             Branch counter abbr list (Optional)\n"
> >  		"?             Search string backwards\n"
> > -		"f             Toggle showing offsets to full address\n");
> > +		"f             Toggle showing offsets to full address\n"
> > +		"y             Toggle data type display\n");
> >  			continue;
> >  		case 'r':
> >  			script_browse(NULL, NULL);
> > @@ -947,6 +948,11 @@ static int annotate_browser__run(struct annotate_browser *browser,
> >  		case 'f':
> >  			annotation__toggle_full_addr(notes, ms);
> >  			continue;
> > +		case 'y':
> > +			annotate_opts.code_with_type ^= 1;
> > +			if (browser->dbg == NULL)
> > +				browser->dbg = debuginfo__new(dso__long_name(map__dso(ms->map)));
> > +			continue;
> >  		case K_LEFT:
> >  		case '<':
> >  		case '>':
> > @@ -1035,8 +1041,7 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
> >  
> >  	ret = annotate_browser__run(&browser, evsel, hbt);
> >  
> > -	if (annotate_opts.code_with_type)
> > -		debuginfo__delete(browser.dbg);
> > +	debuginfo__delete(browser.dbg);
> >  	if(not_annotated)
> >  		annotated_source__purge(notes->src);
> >  
> > -- 
> > 2.49.0
> > 

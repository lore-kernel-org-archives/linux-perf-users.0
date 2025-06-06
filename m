Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C853E14F98;
	Fri,  6 Jun 2025 03:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749179069; cv=none; b=FTQwxyKPsMyGkVkqOIEX3G+ejHPs6ekpFvu/zHNSgBCo/1v9WLvpbg9nKGy5+MQfOAI4Sa9S0EF1i/7lJaiuQlMrCLKYUipz6U8MgON0Xf3qSRLsayQbcV3MTDJd2TDlOzZwWiuYiQAOlFodZlnis3mcpEmG1c4DjVHa9+V4BFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749179069; c=relaxed/simple;
	bh=Bb5B2N/50aofcLkxGWqoRvUWdtbs6I+b50RSOa2ECLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DftPsOwF2pZGuMg4LfpaCNVrtNmdxY7gSeFTgU+2uEdPROpt1SELPZCb+gH7ECVTanuYZGTsvLar5LhuS7jITEFYvWC6DTdWA4zD1d364Wnxrq9RuIuHKKYVH7E/OxOAkJdaUzOIr5uqnRdU+lpUmGKWPRZwOQhxAwCCMqQa7sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOxggLK+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOxggLK+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E7AC4CEE7;
	Fri,  6 Jun 2025 03:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749179069;
	bh=Bb5B2N/50aofcLkxGWqoRvUWdtbs6I+b50RSOa2ECLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kOxggLK+F7SYrbNgCRncBHLwWta1wcVufY7Ic89Kv+nPDnbNNF/4gEkwNT5jLi64w
	 l6aNY8ofXYgntkJGm7+raVwB/9aZM/x8MjYMGfZ38sY1HoxOPefMlXnpTGFc/PHmtq
	 DhUKbES4+w3KnEGf4T34A4McD1TxtWq5YpheanLCsbC84xt4MSU4ZVR8y//k0wzAjH
	 SiJwIBilk4U4lZCP3E5znf+b/5xZ5cJA1MMx5z5IdIrLomxicexmgJLzzzNkh+I3ww
	 RIdHNB5ExFFtx0YFKzjcl95RW+Qxl8Amk1C9VMevFBJir2LNceNr8a/q9nXyf+Kv7h
	 WkA3r1jqMTs6Q==
Date: Thu, 5 Jun 2025 20:04:27 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH 6/6] perf annotate: Add 'y' hot key to toggle data type
 display
Message-ID: <aEJau5NU75auBkOt@google.com>
References: <20250601065302.12531-1-namhyung@kernel.org>
 <20250601065302.12531-7-namhyung@kernel.org>
 <aEICHsZPYbN5KWTa@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Maybe 'T'.  I thought 'y' won't be used by others later but it may be
used by 'y/n' questions.

> 
> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Thanks!
Namhyung

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

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B902514F98;
	Fri,  6 Jun 2025 03:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749179512; cv=none; b=CaxDH0k1N7K0ONDGPG213iNP/iVS1rf7JDlY1WFkbz1UuxNXqyYJbE1n6j9mj387KN+ibI15Yz6EXwCDfyY1YGWTdnaRtZmN6R9LWQCncrqKBeU9VQkb97Oq+6EtWpAK4PzjknkMmuuEhACFuVm9vemSpQs7r8ayAIGKBsRXGrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749179512; c=relaxed/simple;
	bh=K7rB+pNMC5V6WRfP4mITzDMaQ2yQ+1udlCEQQx9o4/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2xdeFDzBm5bViJ4q2lKmApMc9UcjbkTJyOxQ4iv6auBSt3ZQHqw6d1Wgw9cB1uRjgERd88sIrAGph0HkSSxguXC7K42srXBi1GbZa0Exz1XeuSWoTiOjGSv/6yQKvZsbQr+fl9xiUO4ovttI3DyaV56QozABwXzjVttdR53loA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FR3gTaij; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FR3gTaij"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30AF5C4CEE7;
	Fri,  6 Jun 2025 03:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749179512;
	bh=K7rB+pNMC5V6WRfP4mITzDMaQ2yQ+1udlCEQQx9o4/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FR3gTaijgNaBjVQrqHlwUEWANXtWAmBVRXDtxn7v5SnRCuawWoxGct+Jyh0iyGwIH
	 RT6u0KD9Mk4mrLBvXut7k+exFZ+7Fe+Pr7NYWQCuUjCbo0H/sk3eZcPKo/ivyO0CX5
	 iV038gAqwJto0v7xuByZo1nbWzrWjP1gWJS0sDBQOnRcJ755dmb4kUMkAuM/xPjYx0
	 se67gXrXlbMnjWeoKpJBNoRetsSjbxdWgqPFTpx81KueM0TMDCCjqssO/KDXkVFoWo
	 vVHzGMZ6Gbem40+4LUgZCBwF2zHtfYAZbcHtZqoHELQPkUGodZOIvcv2Et+S5VrX8R
	 oS2OxJj0NYHkA==
Date: Thu, 5 Jun 2025 20:11:50 -0700
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
Message-ID: <aEJcdkWNWCKFhxXq@google.com>
References: <20250601065302.12531-1-namhyung@kernel.org>
 <20250601065302.12531-7-namhyung@kernel.org>
 <aEICHsZPYbN5KWTa@x1>
 <aEIIRmb6SNOroSJJ@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aEIIRmb6SNOroSJJ@x1>

On Thu, Jun 05, 2025 at 06:12:38PM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, Jun 05, 2025 at 05:46:22PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Sat, May 31, 2025 at 11:53:02PM -0700, Namhyung Kim wrote:
> > > Support data type display with a key press so that users can toggle the
> > > output dynamically on TUI.
> > 
> > 'd', 'T', control+d, control+t are all available, why 'y'? :-)
> > 
> > Apart from these minor nits,
> 
> There is one issue I noticed now that Ingo mentioned earlier, if you
> press 'y' to get Data type display we better add some visual cue that
> this is toggled, like was done for source code view in:
> 
> commit c6043d35c0f3eb5bcbeb6309e10c4ae33d203841
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Tue Apr 8 19:03:43 2025 -0300
> 
>     perf ui browser annotate: Show in the title the source code view toggle
>     
>     Ingo reported that having a visual cue if the source code view is
>     enabled will help in noticing a bug when no source is presented.
>     
>     Change the title scnprintf routine for the annotation browser to do
>     that.
>     
>     Suggested-by: Ingo Molnar <mingo@kernel.org>

Yep, I'll do that as well.

> 
> Also I did it with a simple perf.data file, no data stuff in it,
> probably it is best to show that if what is required for it to work is
> present in the perf.data file.
> 
> Or to tell what is needed for that hotkey/feature to work, which I think
> is even better and more informative.

Sure, I'll add a message that the dso has no DWARF info.

Thanks,
Namhyung

> 
> - Arnaldo
>  
> > Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > - Arnaldo
> >  
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >  tools/perf/ui/browsers/annotate.c | 11 ++++++++---
> > >  1 file changed, 8 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> > > index 686fa54e545e275c..cd1d452035a265d3 100644
> > > --- a/tools/perf/ui/browsers/annotate.c
> > > +++ b/tools/perf/ui/browsers/annotate.c
> > > @@ -827,7 +827,8 @@ static int annotate_browser__run(struct annotate_browser *browser,
> > >  		"b             Toggle percent base [period/hits]\n"
> > >  		"B             Branch counter abbr list (Optional)\n"
> > >  		"?             Search string backwards\n"
> > > -		"f             Toggle showing offsets to full address\n");
> > > +		"f             Toggle showing offsets to full address\n"
> > > +		"y             Toggle data type display\n");
> > >  			continue;
> > >  		case 'r':
> > >  			script_browse(NULL, NULL);
> > > @@ -947,6 +948,11 @@ static int annotate_browser__run(struct annotate_browser *browser,
> > >  		case 'f':
> > >  			annotation__toggle_full_addr(notes, ms);
> > >  			continue;
> > > +		case 'y':
> > > +			annotate_opts.code_with_type ^= 1;
> > > +			if (browser->dbg == NULL)
> > > +				browser->dbg = debuginfo__new(dso__long_name(map__dso(ms->map)));
> > > +			continue;
> > >  		case K_LEFT:
> > >  		case '<':
> > >  		case '>':
> > > @@ -1035,8 +1041,7 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
> > >  
> > >  	ret = annotate_browser__run(&browser, evsel, hbt);
> > >  
> > > -	if (annotate_opts.code_with_type)
> > > -		debuginfo__delete(browser.dbg);
> > > +	debuginfo__delete(browser.dbg);
> > >  	if(not_annotated)
> > >  		annotated_source__purge(notes->src);
> > >  
> > > -- 
> > > 2.49.0
> > > 

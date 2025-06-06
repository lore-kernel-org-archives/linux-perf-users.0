Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CB528A1FC;
	Fri,  6 Jun 2025 17:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749230560; cv=none; b=d8fyl+XYEs1U8Rk4j0NEOqYPlCvrrw7MLIUEM0MkWWZytvPKpOs+YKH0si7LjZgXAkQXbSt5wOluOnTAvb6jWuAS8fctdGUp3jHCrJBGZI/BwlmHwozCXQ1oBcsp/qMxlWcnLpysRMOI157t1HbyfKxgtAUIyAlOWW7DPPwRcOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749230560; c=relaxed/simple;
	bh=0atULy2Iq2qF/7j6WC9JTdSiYaM3w4GwwMV2Hc29u3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hAdNBNVQdUxxb3uIlbgTrbs1IQXPcBwbKz4kiOdiFyNJ0wRVT5PRL/LmDcvbFBGi7oTDjQgGuAuWA5m62suAOpMXP01edcml3i/jP3Sp4j+GL04c6hA5s6KE7NZVSQ6pXOv4oejpEQIruv9W4fSTF7JODBlrbePltGxtRQm4rrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lreZ6pQf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lreZ6pQf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3171C4CEEB;
	Fri,  6 Jun 2025 17:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749230560;
	bh=0atULy2Iq2qF/7j6WC9JTdSiYaM3w4GwwMV2Hc29u3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lreZ6pQfaLqfmxODBGlWGCeR0ChuKG2doladcLgy6Qq7z/QtrnpcuCP0ABec+a2R7
	 EYnpFFRMDFOEtZgviYREmC17YDvyy1F4eudmNdBG6sxqcI9znRYdkNY5Ch/vk3hrJC
	 jLB8xldQi74UJgtJ8PwxH8KfJpBPbRzV6D+tK80CZUoRm6OLb0enDJ565fEdb8nhKw
	 rFM7zyvVTmPc9hfnywL5aO20R/iVlufYzphN1GsCd7+pOhTHM0rKI5QDn2P7KoreSN
	 a66rGl1nte8o9sz3Xxd3c8Rqd1W28pMEprB9iRdPdf2JHWYxO/3kOgYHybO/3IFEQm
	 3c+h/XU3FaASA==
Date: Fri, 6 Jun 2025 10:22:38 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@kernel.org>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1] perf top/report TUI: Provide visual cue when
 starting annotation
Message-ID: <aEMj3reqzWXvd6tD@google.com>
References: <aEIJJIiuRTVjPaPT@x1>
 <aEJdAs9P8m2ZiY5Y@google.com>
 <aEMC6a3BCbSWfcuz@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aEMC6a3BCbSWfcuz@x1>

On Fri, Jun 06, 2025 at 12:02:01PM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, Jun 05, 2025 at 08:14:10PM -0700, Namhyung Kim wrote:
> > On Thu, Jun 05, 2025 at 06:16:20PM -0300, Arnaldo Carvalho de Melo wrote:
> > > Sometimes it takes a while for the annotation to be presented after
> > > pressing 'a' in the 'perf top'/'report' TUI, provide a visual cue
> > > informing that the annotation has started for that symbol.
>  
> > It's probably because objdump takes long to process DWARF.  I think I
> > need to update this.
>  
> > https://lore.kernel.org/linux-perf-users/Z_gunJ9C3H25Uo9Q@google.com/
> 
> Humm, in this case I had explicitely asked for using objdump:
> 
> root@number:~# cat ~/.perfconfig 
> # this file is auto-generated.
> [annotate]
> 	disassemblers = objdump
> root@number:~# 
> 
> So, yeah, its objdump running but in my case there was no DWARF
> involved, it was just a big C++ app, so the ELF files were big and
> objdump takes a long time even without DWARF.

Oh, ok.  I had a problem with DWARF in the past, so assumed the same.

> 
> One way or the other, your patch switching to use objdump when 's' is
> pressed is a good one, please update it :-)

Sure, will do it soon.

Thanks,
Namhyung

> > 
> > > 
> > > This is the quick and most of the time improvement, but for some cases
> > > its better to improve on it by having a cancellable progress bar, which
> > > is now in my TODO list.
> > > 
> > > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > > Cc: Ian Rogers <irogers@google.com>
> > > Cc: Ingo Molnar <mingo@kernel.org>
> > > Cc: James Clark <james.clark@linaro.org>
> > > Cc: Jiri Olsa <jolsa@kernel.org>
> > > Cc: Kan Liang <kan.liang@linux.intel.com>
> > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > ---
> > >  tools/perf/ui/browsers/annotate.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> > > index cd1d452035a265d3..66ffeb96db29532c 100644
> > > --- a/tools/perf/ui/browsers/annotate.c
> > > +++ b/tools/perf/ui/browsers/annotate.c
> > > @@ -2,6 +2,7 @@
> > >  #include "../browser.h"
> > >  #include "../helpline.h"
> > >  #include "../ui.h"
> > > +#include "../util.h"
> > >  #include "../../util/annotate.h"
> > >  #include "../../util/debug.h"
> > >  #include "../../util/debuginfo.h"
> > > @@ -1016,6 +1017,7 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
> > >  		return -1;
> > >  
> > >  	if (not_annotated || !sym->annotate2) {
> > > +		ui__info_window("Annotating", sym->name);
> > >  		err = symbol__annotate2(ms, evsel, &browser.arch);
> > >  		if (err) {
> > >  			char msg[BUFSIZ];
> > > -- 
> > > 2.49.0
> > > 

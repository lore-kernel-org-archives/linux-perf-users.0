Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D9413EFF3;
	Fri,  6 Jun 2025 15:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749222124; cv=none; b=LCMtJdAo0kwEwe+SC2o8NWEvER7Aji4GS++L8HY7EkldteICS6k+pmbXJxIBz9bULcDlMb2y2AdPOqhy2HbvxOmn0OoD0vuhqavWqctQOPgOeIQSJWzloPn80mldsmLWkne0gohLKJeuWgDZG/2xTmMc/oKYWbyqp7zV7bxGQHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749222124; c=relaxed/simple;
	bh=O8kB7jya7MJUklWdBDfGyAbIfXaS0eU41lUunp/mlxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXk/GtOXcNTtB31+7yfdDAJBz62e3BeJ16K2GMI+CIwzMdlG1UdL+uqAFeO2Rg//+fOXRnPOyeDrji97EqAvx55rjM+zlKt3wfMbupZYf0hkIuwTXXD3A2buvRpjT809/3VcqMAEM+QuBMos1O44xDk5sQQHVbQmLbt+E0u52OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dkev1l3U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dkev1l3U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E514C4CEEB;
	Fri,  6 Jun 2025 15:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749222124;
	bh=O8kB7jya7MJUklWdBDfGyAbIfXaS0eU41lUunp/mlxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dkev1l3UmZlruTsci+pGK3iQ5QRzp0CffMyW+Xyk3TGHFzHNIQikq3gt4ohBsBHy2
	 ROTsG6QrCKXMRqkPC+5/isMlCadCLeL/DnbC9R6Z6EFlT5+e+KzGg2/n9ExCaGs+Zo
	 J66aQr4SEwJBkCBD/U6BMQjvRctm/MnhKHejdZj0YF0oCtvghT098E6S8ceSujM+yQ
	 fXT50Ri7ASBflKYQPVX9ntx6q+5l7oncvV/0GuqTfMPKu4FbYAd/5Xk9NzYWnJrnv3
	 sbFftXbjfEHBjSuBUvetFF6HcUrxteovFUwjzWd/SY2oBhOH/0qUXKesjwCw+cVFZg
	 boKBnkDbBe2eA==
Date: Fri, 6 Jun 2025 12:02:01 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@kernel.org>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1] perf top/report TUI: Provide visual cue when
 starting annotation
Message-ID: <aEMC6a3BCbSWfcuz@x1>
References: <aEIJJIiuRTVjPaPT@x1>
 <aEJdAs9P8m2ZiY5Y@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEJdAs9P8m2ZiY5Y@google.com>

On Thu, Jun 05, 2025 at 08:14:10PM -0700, Namhyung Kim wrote:
> On Thu, Jun 05, 2025 at 06:16:20PM -0300, Arnaldo Carvalho de Melo wrote:
> > Sometimes it takes a while for the annotation to be presented after
> > pressing 'a' in the 'perf top'/'report' TUI, provide a visual cue
> > informing that the annotation has started for that symbol.
 
> It's probably because objdump takes long to process DWARF.  I think I
> need to update this.
 
> https://lore.kernel.org/linux-perf-users/Z_gunJ9C3H25Uo9Q@google.com/

Humm, in this case I had explicitely asked for using objdump:

root@number:~# cat ~/.perfconfig 
# this file is auto-generated.
[annotate]
	disassemblers = objdump
root@number:~# 

So, yeah, its objdump running but in my case there was no DWARF
involved, it was just a big C++ app, so the ELF files were big and
objdump takes a long time even without DWARF.

One way or the other, your patch switching to use objdump when 's' is
pressed is a good one, please update it :-)

- Arnaldo
 
> Thanks,
> Namhyung
> 
> > 
> > This is the quick and most of the time improvement, but for some cases
> > its better to improve on it by having a cancellable progress bar, which
> > is now in my TODO list.
> > 
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: James Clark <james.clark@linaro.org>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Kan Liang <kan.liang@linux.intel.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/ui/browsers/annotate.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> > index cd1d452035a265d3..66ffeb96db29532c 100644
> > --- a/tools/perf/ui/browsers/annotate.c
> > +++ b/tools/perf/ui/browsers/annotate.c
> > @@ -2,6 +2,7 @@
> >  #include "../browser.h"
> >  #include "../helpline.h"
> >  #include "../ui.h"
> > +#include "../util.h"
> >  #include "../../util/annotate.h"
> >  #include "../../util/debug.h"
> >  #include "../../util/debuginfo.h"
> > @@ -1016,6 +1017,7 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
> >  		return -1;
> >  
> >  	if (not_annotated || !sym->annotate2) {
> > +		ui__info_window("Annotating", sym->name);
> >  		err = symbol__annotate2(ms, evsel, &browser.arch);
> >  		if (err) {
> >  			char msg[BUFSIZ];
> > -- 
> > 2.49.0
> > 

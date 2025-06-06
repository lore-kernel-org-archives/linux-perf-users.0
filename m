Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9C57E107;
	Fri,  6 Jun 2025 03:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749179653; cv=none; b=XznHxYYv+V3ZGkebVgPfhWrbM2vDCzSbstXpJgafdFwHfCIXwW8y09hwGwSQEDaKpTcbHT7Fhl7ypoXKM1QecbWUaMYfF4D8c4KtXH8vnG1Uy0FCKYMuMKLkYPQ8yG7pgSbxSLkSDDzPu16UJOUgFLv78iKdYNr44tI00XUEoHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749179653; c=relaxed/simple;
	bh=YTj89U0usWhIyY3loDz60ed6Le/WvIAdot5I7X+eiLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dSmrjHYcYhKw1uxfnUEMweR/+30dQAexZRl9mOn6UlF/U/uIlmP6q3LOMVsFK0Qm9U1kVYlNx8IauIyRPwDa0nqNB+RpQPJME5DWRW88WlEbsli3BhzlDhFyB4fXfpOrlSl+AnLYuzda1NFWuLwpendIKrm4os6ecY8g7MXU/Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDflqDzc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDflqDzc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9386DC4CEE7;
	Fri,  6 Jun 2025 03:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749179652;
	bh=YTj89U0usWhIyY3loDz60ed6Le/WvIAdot5I7X+eiLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WDflqDzcb4rwzKzG5GTivK8TEWH6CKQKEGQ4ZGkcbYco8lFGunLZDHQjVFSQ17x/2
	 BvTW/AyiZKoAUDsiQCU9nWcoynSaRXAoXAFafskhN6PkVIKbs2eMkMcHbnTUGOvS8K
	 AqybParMoMGmGFEUftFY5wsEXBAUBhb7QaeNlqJzvw1jSNNPnFbW844IEgZgGlxXPy
	 BKHlA3/JPneD7jDW9el58vPBF9jPc2ooVOUHrEa72JidD2wRIdAm9myq7aV0tCFHSz
	 3Kml21e/N0oPT6Gerr6Ul2oTTBEVIIrW24+akJD7gFwKFcgdHzlRssld7LkZcn1P83
	 MiS1Fp0sd+bfQ==
Date: Thu, 5 Jun 2025 20:14:10 -0700
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
Message-ID: <aEJdAs9P8m2ZiY5Y@google.com>
References: <aEIJJIiuRTVjPaPT@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aEIJJIiuRTVjPaPT@x1>

On Thu, Jun 05, 2025 at 06:16:20PM -0300, Arnaldo Carvalho de Melo wrote:
> Sometimes it takes a while for the annotation to be presented after
> pressing 'a' in the 'perf top'/'report' TUI, provide a visual cue
> informing that the annotation has started for that symbol.

It's probably because objdump takes long to process DWARF.  I think I
need to update this.

https://lore.kernel.org/linux-perf-users/Z_gunJ9C3H25Uo9Q@google.com/

Thanks,
Namhyung

> 
> This is the quick and most of the time improvement, but for some cases
> its better to improve on it by having a cancellable progress bar, which
> is now in my TODO list.
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/ui/browsers/annotate.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> index cd1d452035a265d3..66ffeb96db29532c 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c
> @@ -2,6 +2,7 @@
>  #include "../browser.h"
>  #include "../helpline.h"
>  #include "../ui.h"
> +#include "../util.h"
>  #include "../../util/annotate.h"
>  #include "../../util/debug.h"
>  #include "../../util/debuginfo.h"
> @@ -1016,6 +1017,7 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
>  		return -1;
>  
>  	if (not_annotated || !sym->annotate2) {
> +		ui__info_window("Annotating", sym->name);
>  		err = symbol__annotate2(ms, evsel, &browser.arch);
>  		if (err) {
>  			char msg[BUFSIZ];
> -- 
> 2.49.0
> 

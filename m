Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5001727CCF3;
	Thu,  5 Jun 2025 20:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749156385; cv=none; b=t2XKmvDTmyUVRrmNdo2DYTzBCJGSbyn0EHQWhrv5wpwAfPFpprvNMrK+2RYLgnCDktCAagZlsytDhjwqddGw19Jg80PaxDsX6ll42Za8I6kD55e86Gca2UHTjbMhj9dkdYjvOF+xDa6BV1TZrgW+dr0IaAi5dxEnE9EkuvWuhwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749156385; c=relaxed/simple;
	bh=RhS+dYphhpcSWi0JsY+hTBxvPmiMq57I7ulQCqHcYtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GszB3XuHhe2vLw0qqZjF4V1dbilFoR8kKYE3QuWRt9IxIC1sU3nE40rEPVSogDk4R6KHqB6loT+VQ72sPTfT9dLcOmexJEL+GStNdt/MdMgC5wVsXBVLjz+9/p+eX9+SXRA2crLsXROpgI0+q7Hmuo9CPMa696m19wvDV0wY1hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bphSqoGk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bphSqoGk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696F0C4CEE7;
	Thu,  5 Jun 2025 20:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749156384;
	bh=RhS+dYphhpcSWi0JsY+hTBxvPmiMq57I7ulQCqHcYtg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bphSqoGkSBE4IeXfpchn8TKiFn6MhafQEo1abiD07hOlq3uXmacGipw+vxj7GPh2V
	 6Ngs+s4ktbHdEdEOpSKesfthG86eqHxZgle3Xwu5A5BsrVbtchx5HnjsCe4fNubt1F
	 KS9p6upzuaGPyaFgqiaCQngxd8YP2/rS51Tm+X2o9MetZ9noS5diw3uHNew/UlghID
	 4fonQr3fYlyUdl/KYJg7+LcH4Mhsmid1V02TfjPEPdfyybKZoudOlw2L/Z/0Ph5gcP
	 143XeKy95J4HoFXYeUhGNQ0OISyAHHClZgZvdHt08dhCTvu8UQ7sQwjpc6LOn5WfxH
	 Yy8waysWhE3dQ==
Date: Thu, 5 Jun 2025 17:46:22 -0300
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
Message-ID: <aEICHsZPYbN5KWTa@x1>
References: <20250601065302.12531-1-namhyung@kernel.org>
 <20250601065302.12531-7-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250601065302.12531-7-namhyung@kernel.org>

On Sat, May 31, 2025 at 11:53:02PM -0700, Namhyung Kim wrote:
> Support data type display with a key press so that users can toggle the
> output dynamically on TUI.

'd', 'T', control+d, control+t are all available, why 'y'? :-)

Apart from these minor nits,

Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/ui/browsers/annotate.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> index 686fa54e545e275c..cd1d452035a265d3 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c
> @@ -827,7 +827,8 @@ static int annotate_browser__run(struct annotate_browser *browser,
>  		"b             Toggle percent base [period/hits]\n"
>  		"B             Branch counter abbr list (Optional)\n"
>  		"?             Search string backwards\n"
> -		"f             Toggle showing offsets to full address\n");
> +		"f             Toggle showing offsets to full address\n"
> +		"y             Toggle data type display\n");
>  			continue;
>  		case 'r':
>  			script_browse(NULL, NULL);
> @@ -947,6 +948,11 @@ static int annotate_browser__run(struct annotate_browser *browser,
>  		case 'f':
>  			annotation__toggle_full_addr(notes, ms);
>  			continue;
> +		case 'y':
> +			annotate_opts.code_with_type ^= 1;
> +			if (browser->dbg == NULL)
> +				browser->dbg = debuginfo__new(dso__long_name(map__dso(ms->map)));
> +			continue;
>  		case K_LEFT:
>  		case '<':
>  		case '>':
> @@ -1035,8 +1041,7 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
>  
>  	ret = annotate_browser__run(&browser, evsel, hbt);
>  
> -	if (annotate_opts.code_with_type)
> -		debuginfo__delete(browser.dbg);
> +	debuginfo__delete(browser.dbg);
>  	if(not_annotated)
>  		annotated_source__purge(notes->src);
>  
> -- 
> 2.49.0
> 

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216CD485CC8;
	Wed, 16 Sep 2026 21:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789594105; cv=none; b=a+sHkVK5fwBgklzZ+hEg1P0GAm0UqQCqsnIExkiVW80WTTvjeiJCqthKvNCI4qbb9MdxXJsO+qjW6AC6AFHk2MBsfuZIVIDc2Qctu9pzuXxQBkaj3Lc6ZHE8CSE5Um1krugPwZPdUMY8yjwqzGkaR2NUfIsISdsY/p6mJBrfsl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789594105; c=relaxed/simple;
	bh=jE19fiuZFl+KXtLybDqBvWbyLIg+wOKPnF15YnHvNSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oFifOuLWJzN0wYGacTbu3/8x35dTiaHWaO3ezkYjH9op037glEW3BkhizPLvtVpwPD09Su77slsanh8pWo/jE+FloZk0VuyhNQwI2zB8a2BciWmsaREUaSpKqfjapY8xNawYkNj/+3cnHnAPGBn41kF8S6HDCdQ15G7HQ+BBiFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xwubrvzs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xwubrvzs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E0B1F000FF;
	Wed, 16 Sep 2026 21:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789594092;
	bh=ijOhe4/JW3W7gbdgAnWh+tUqZl2nvh6DNnXgB54/nXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XwubrvzsYzmyOwUFA+PTJqsOPuRsK7ZZIW8pP2uS3whdPuqZLCcSG/D9SGVGQMcRc
	 XVnuGGGFOt1aYryeuvDo8R9YDy8lI3td5uIy7rBwpadptJYzzKbFTe3xSRN4DoWn1e
	 Cmar3nAA53zd8vJtUgnuQPZ8ge80Dvo6ysY8uUSdvtvu0yS90MOZQdjVzGVTvFOCbk
	 a9fbC3Nmz1FajcmbmIuxYECgSqWrNkxKB4VcAmz04QEs5bp5M2xgH6FK6fmMbH9XVv
	 lM2k15UcJ5frDuUpJuSmvA3H4NxxbEE7QjbmqwFtILrjLeKKHj8fcs/SBcSY/40K2N
	 Fw/vf3Xb8r/yg==
Date: Wed, 16 Sep 2026 14:28:10 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 07/12] perf annotate-data: Show the sample count in the
 data-type browser
Message-ID: <aqsJ6uQEEMBPtk-4@google.com>
References: <20260916114740.48230-1-acme@kernel.org>
 <20260916114740.48230-8-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260916114740.48230-8-acme@kernel.org>

On Wed, Sep 16, 2026 at 08:47:34AM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> The data-type browser has a samples view, selected with -n (or with
> annotate.show_nr_samples), in which browser__write_overhead() prints a
> local nr_samples variable that is initialized to zero and never
> updated, so every member is listed as having no samples while the
> period and percent columns for the same entry are filled in.
> 
> Print the histogram entry's own count instead.
> 
> This predates the load/store counter split, so fix it ahead of that
> patch: the split then only has to adapt a line that is already correct,
> and this fix can be picked on its own.
> 
> Fixes: d001c7a7f4736743 ("perf annotate-data: Add hist_entry__annotate_data_tui()")
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

This can be applied independently.

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/ui/browsers/annotate-data.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/ui/browsers/annotate-data.c b/tools/perf/ui/browsers/annotate-data.c
> index c6e07a9b64089ab5..a15608f6ee53335f 100644
> --- a/tools/perf/ui/browsers/annotate-data.c
> +++ b/tools/perf/ui/browsers/annotate-data.c
> @@ -374,7 +374,7 @@ static void browser__write_overhead(struct ui_browser *uib,
>  	u64 period = hist->period;
>  	double percent = total->period ? (100.0 * period / total->period) : 0;
>  	bool current = ui_browser__is_current_entry(uib, row);
> -	int nr_samples = 0;
> +	int nr_samples = hist->nr_samples;
>  
>  	ui_browser__set_percent_color(uib, percent, current);
>  
> -- 
> 2.55.0
> 

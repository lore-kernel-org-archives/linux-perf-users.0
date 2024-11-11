Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93E21A726B;
	Mon, 11 Nov 2024 17:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731346501; cv=none; b=pc2iafcNr5nd53FvOhI+Qa/GegwlKntpa56RdbiqrPROf38Jou9LvhqM0yJPv0dbK6fVcy/iCUqjt7aKJrTdqskT1qLnRNy4u9tcSoDjiHYRWsQ22sbwDABFzNeXx+UEh9mEkfEFiLoVUQAK+kVwjCeMO3rKgwawtrutRwe6F7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731346501; c=relaxed/simple;
	bh=okSRReGcLcZ5Qliubgiq/nJYK6QaaW6tB22G9TLNUQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjYvC+HThwHnYpcqkaUKiEOE69ZLUe0malytydZZI2YXmK7miSRviIFjUcesL8cRyA0enEdyT2/qitD3rXKJGyV8nXWOFBIo5iayAmueLcvq5JpfhDZ/Htfo9w5CMViZnyTi5zgzs8mFRksBX+fgoCqy1eaCemysmo0ZqMlKP+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6EXqNBC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6EXqNBC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD26C4CECF;
	Mon, 11 Nov 2024 17:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731346501;
	bh=okSRReGcLcZ5Qliubgiq/nJYK6QaaW6tB22G9TLNUQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g6EXqNBC4dGISGketvJBohyhJMOD42msb8zCYePHB7WN93fMha8e7rd4vS8qRQ4cX
	 iFo7SM21xfPLWT6an/Rmmcjkt+T8t46Wf3n48F5ROfUL0R4Czz2cZmuHLtotZWg8Lb
	 ddf8eH4dhYWvBRm+XlrQOo3Nmzvz6/m2+Rta3JkOwjEKZavCOwBSTZiS+pxlC//X/k
	 GPb4zd+4kLywsEaPsMj8IpZEgNF97jmTKoobA+mSykiMcNgDRS9zujwMZZcfkWWDjK
	 ZP6Po6ulswG3x/6GZygpZqggvJOQ8/gKcOLjegc+Y7FCAjeLjVTh+gK2VtM0HtRMWc
	 Y/YK1UvdWZJPQ==
Date: Mon, 11 Nov 2024 14:34:57 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
	Junhao He <hejunhao3@huawei.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf list: Fix topic and pmu_name argument order
Message-ID: <ZzJAQeHqFT_Z9JiW@x1>
References: <20241109025801.560378-1-irogers@google.com>
 <7676a058-e7ae-4c6b-a9f8-be450b64f5e1@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7676a058-e7ae-4c6b-a9f8-be450b64f5e1@linux.intel.com>

On Mon, Nov 11, 2024 at 09:48:41AM -0500, Liang, Kan wrote:
> 
> 
> On 2024-11-08 9:58 p.m., Ian Rogers wrote:
> > From: Jean-Philippe Romain <jean-philippe.romain@foss.st.com>
> > 
> > Fix function definitions to match header file declaration. Fix two
> > callers to pass the arguments in the right order.
> > 
> > On Intel Tigerlake, before:
> > ```
> > $ perf list -j|grep "\"Topic\""|sort|uniq
> >         "Topic": "cache",
> >         "Topic": "cpu",
> >         "Topic": "floating point",
> >         "Topic": "frontend",
> >         "Topic": "memory",
> >         "Topic": "other",
> >         "Topic": "pfm icl",
> >         "Topic": "pfm ix86arch",
> >         "Topic": "pfm perf_raw",
> >         "Topic": "pipeline",
> >         "Topic": "tool",
> >         "Topic": "uncore interconnect",
> >         "Topic": "uncore memory",
> >         "Topic": "uncore other",
> >         "Topic": "virtual memory",
> > $ perf list -j|grep "\"Unit\""|sort|uniq
> >         "Unit": "cache",
> >         "Unit": "cpu",
> >         "Unit": "cstate_core",
> >         "Unit": "cstate_pkg",
> >         "Unit": "i915",
> >         "Unit": "icl",
> >         "Unit": "intel_bts",
> >         "Unit": "intel_pt",
> >         "Unit": "ix86arch",
> >         "Unit": "msr",
> >         "Unit": "perf_raw",
> >         "Unit": "power",
> >         "Unit": "tool",
> >         "Unit": "uncore_arb",
> >         "Unit": "uncore_clock",
> >         "Unit": "uncore_imc_free_running_0",
> >         "Unit": "uncore_imc_free_running_1",
> > ```
> > 
> > After:
> > ```
> > $ perf list -j|grep "\"Topic\""|sort|uniq
> >         "Topic": "cache",
> >         "Topic": "floating point",
> >         "Topic": "frontend",
> >         "Topic": "memory",
> >         "Topic": "other",
> >         "Topic": "pfm icl",
> >         "Topic": "pfm ix86arch",
> >         "Topic": "pfm perf_raw",
> >         "Topic": "pipeline",
> >         "Topic": "tool",
> >         "Topic": "uncore interconnect",
> >         "Topic": "uncore memory",
> >         "Topic": "uncore other",
> >         "Topic": "virtual memory",
> > $ perf list -j|grep "\"Unit\""|sort|uniq
> >         "Unit": "cpu",
> >         "Unit": "cstate_core",
> >         "Unit": "cstate_pkg",
> >         "Unit": "i915",
> >         "Unit": "icl",
> >         "Unit": "intel_bts",
> >         "Unit": "intel_pt",
> >         "Unit": "ix86arch",
> >         "Unit": "msr",
> >         "Unit": "perf_raw",
> >         "Unit": "power",
> >         "Unit": "tool",
> >         "Unit": "uncore_arb",
> >         "Unit": "uncore_clock",
> >         "Unit": "uncore_imc_free_running_0",
> >         "Unit": "uncore_imc_free_running_1",
> > ```
> > 
> > Fixes: e5c6109f4813 ("perf list: Reorganize to use callbacks to allow honouring command line options")
> > Signed-off-by: Jean-Philippe Romain <jean-philippe.romain@foss.st.com>
> > Tested-by: Ian Rogers <irogers@google.com>
> 
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

> > ---
> > Note from Ian, I fixed the two callers and added it to
> > Jean-Phillippe's original change.

I think that in this case we need:

[ I fixed the two callers and added it to Jean-Phillippe's original change. ]
Signed-off-by: Ian Rogers <irogers@google.com>

Ok?

- Arnaldo

> > ---
> >  tools/perf/builtin-list.c | 4 ++--
> >  tools/perf/util/pfm.c     | 4 ++--
> >  tools/perf/util/pmus.c    | 2 +-
> >  3 files changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
> > index b8378ba18c28..9e7fdfcdd7ff 100644
> > --- a/tools/perf/builtin-list.c
> > +++ b/tools/perf/builtin-list.c
> > @@ -113,7 +113,7 @@ static void wordwrap(FILE *fp, const char *s, int start, int max, int corr)
> >  	}
> >  }
> >  
> > -static void default_print_event(void *ps, const char *pmu_name, const char *topic,
> > +static void default_print_event(void *ps, const char *topic, const char *pmu_name,
> >  				const char *event_name, const char *event_alias,
> >  				const char *scale_unit __maybe_unused,
> >  				bool deprecated, const char *event_type_desc,
> > @@ -354,7 +354,7 @@ static void fix_escape_fprintf(FILE *fp, struct strbuf *buf, const char *fmt, ..
> >  	fputs(buf->buf, fp);
> >  }
> >  
> > -static void json_print_event(void *ps, const char *pmu_name, const char *topic,
> > +static void json_print_event(void *ps, const char *topic, const char *pmu_name,
> >  			     const char *event_name, const char *event_alias,
> >  			     const char *scale_unit,
> >  			     bool deprecated, const char *event_type_desc,
> > diff --git a/tools/perf/util/pfm.c b/tools/perf/util/pfm.c
> > index 5ccfe4b64cdf..0dacc133ed39 100644
> > --- a/tools/perf/util/pfm.c
> > +++ b/tools/perf/util/pfm.c
> > @@ -233,7 +233,7 @@ print_libpfm_event(const struct print_callbacks *print_cb, void *print_state,
> >  	}
> >  
> >  	if (is_libpfm_event_supported(name, cpus, threads)) {
> > -		print_cb->print_event(print_state, pinfo->name, topic,
> > +		print_cb->print_event(print_state, topic, pinfo->name,
> >  				      name, info->equiv,
> >  				      /*scale_unit=*/NULL,
> >  				      /*deprecated=*/NULL, "PFM event",
> > @@ -267,8 +267,8 @@ print_libpfm_event(const struct print_callbacks *print_cb, void *print_state,
> >  				continue;
> >  
> >  			print_cb->print_event(print_state,
> > -					pinfo->name,
> >  					topic,
> > +					pinfo->name,
> >  					name, /*alias=*/NULL,
> >  					/*scale_unit=*/NULL,
> >  					/*deprecated=*/NULL, "PFM event",
> > diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> > index 107de86c2637..6d4c7c9ecf3a 100644
> > --- a/tools/perf/util/pmus.c
> > +++ b/tools/perf/util/pmus.c
> > @@ -501,8 +501,8 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
> >  			goto free;
> >  
> >  		print_cb->print_event(print_state,
> > -				aliases[j].pmu_name,
> >  				aliases[j].topic,
> > +				aliases[j].pmu_name,
> >  				aliases[j].name,
> >  				aliases[j].alias,
> >  				aliases[j].scale_unit,

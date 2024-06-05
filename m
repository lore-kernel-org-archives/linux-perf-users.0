Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BD4B661;
	Wed,  5 Jun 2024 00:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717548474; cv=none; b=vAHwtzt4AWab+HNCeWg6LTQ39SpX4wcyWvsyDnp4XJBFWZ7wMsvzYlxf8cqWk6gtj1ZaBfh4NSSlu+PzGUqwzUG2A+nYn/rkBA6vtATxxYWSAqrQ82KMdqkFh7vVCn7UbvJDdoNV0a6AWG889r44dLh7pv9eNO/dcMY2AbRI4IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717548474; c=relaxed/simple;
	bh=Rb9fRs1fRY7PqLEr1a5tc51LjHlXxZPxJzCWtBE+cjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4cLj5E7tWwpOW7nVEbm6lk6IafyB0+v4x08DKO8XaP+jV8pcjBwbhr4B4PA+u0WoAfoHvgGr3dmCqwuIsvKIjNRdDS0a+4C2GSRa1KTObtZ1u9RyPQxoE8eSXrLxBcS5RVPVSOuskVnJxJnArOOKlQ5euNojkc5AdxDc8+u1Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+V603xb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+V603xb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63AD1C2BBFC;
	Wed,  5 Jun 2024 00:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717548473;
	bh=Rb9fRs1fRY7PqLEr1a5tc51LjHlXxZPxJzCWtBE+cjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k+V603xbXy+ddD5x4x1akuQF+GoMV3wdY0TZxFtoA5yCcnv5hqmFmuhXzT6ChlyZq
	 BIgpe3obArTAsWIswIcFbRgbLYjR5Ca6kSJ82dXyeb7KsJHgqNks45t3/aIp4kpSHp
	 ENLZPm+c7KIRgrkERQW8ViF06uDJyRvchbomkNS2A1SSNdskEm/eISpYNxlDcSd/E6
	 DEZSrb03VWTfcPYPysej2db2BecBpZFWE2ni7yIsT4IVNyMDYqPpmU5etcqDvdBjj9
	 TvTqP4FS0XZnGgRvehEFv777yWJYWK+BYhdbLHx11c0Rh6KKAFb28f/QVJfsmbeMy5
	 gpzQd7tVW17PA==
Date: Tue, 4 Jun 2024 17:47:51 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/4] perf hist: Simplify __hpp_fmt() using hpp_fmt_data
Message-ID: <Zl-1t3t-3eUwDcdI@google.com>
References: <20240603224412.1910049-1-namhyung@kernel.org>
 <20240603224412.1910049-3-namhyung@kernel.org>
 <Zl8wVwNaKDXLTWbq@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zl8wVwNaKDXLTWbq@x1>

On Tue, Jun 04, 2024 at 12:18:47PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, Jun 03, 2024 at 03:44:10PM -0700, Namhyung Kim wrote:
> > The struct hpp_fmt_data is to keep the values for each group members so
> > it doesn't need to check the event index in the group.
> > 
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/ui/hist.c | 75 +++++++++++++++++++++-----------------------
> >  1 file changed, 36 insertions(+), 39 deletions(-)
> > 
> > diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
> > index e30fcb1e87e7..539978c95cfd 100644
> > --- a/tools/perf/ui/hist.c
> > +++ b/tools/perf/ui/hist.c
> > @@ -46,65 +46,62 @@ static int __hpp__fmt_print(struct perf_hpp *hpp, struct hists *hists, u64 val,
> >  	return hpp__call_print_fn(hpp, print_fn, fmt, len, val);
> >  }
> >  
> > +struct hpp_fmt_data {
> > +	struct hists *hists;
> > +	u64 val;
> > +	int samples;
> > +};
> 
> Can we try to avoid vague terms like 'data' and use a hopefully more
> clear 'hpp_fmt_value' instead?

Sure, I can do that.  I thought 'data' was better since it contains more
than a value like a pointer to hist and number of samples.  But it's not
a big deal, and I can make the change.

> 
> >  static int __hpp__fmt(struct perf_hpp *hpp, struct hist_entry *he,
> >  		      hpp_field_fn get_field, const char *fmt, int len,
> >  		      hpp_snprint_fn print_fn, enum perf_hpp_fmt_type fmtype)
> >  {
> > -	int ret;
> > +	int ret = 0;
> >  	struct hists *hists = he->hists;
> >  	struct evsel *evsel = hists_to_evsel(hists);
> > +	struct evsel *pos;
> >  	char *buf = hpp->buf;
> >  	size_t size = hpp->size;
> > +	int i, nr_members = 1;
> > +	struct hpp_fmt_data *data;
> 
> Here we then use:
> 
> 	struct hpp_fmt_value *values;

Yep, will change in v3.

Thanks,
Namhyung

> 
> > +
> > +	if (evsel__is_group_event(evsel))
> > +		nr_members = evsel->core.nr_members;
> > +
> > +	data = calloc(nr_members, sizeof(*data));
> > +	if (data == NULL)
> > +		return 0;
> 
> 
> > +
> > +	i = 0;
> > +	for_each_group_evsel(pos, evsel)
> > +		data[i++].hists = evsel__hists(pos);
> >  
> > -	ret = __hpp__fmt_print(hpp, hists, get_field(he), he->stat.nr_events,
> > -			       fmt, len, print_fn, fmtype);
> > +	data[0].val = get_field(he);
> > +	data[0].samples = he->stat.nr_events;
> >  
> >  	if (evsel__is_group_event(evsel)) {
> > -		int prev_idx, idx_delta;
> >  		struct hist_entry *pair;
> > -		int nr_members = evsel->core.nr_members;
> > -
> > -		prev_idx = evsel__group_idx(evsel);
> >  
> >  		list_for_each_entry(pair, &he->pairs.head, pairs.node) {
> > -			u64 period = get_field(pair);
> > -			u64 total = hists__total_period(pair->hists);
> > -			int nr_samples = pair->stat.nr_events;
> > -
> > -			if (!total)
> > -				continue;
> > +			for (i = 0; i < nr_members; i++) {
> > +				if (data[i].hists != pair->hists)
> > +					continue;
> >  
> > -			evsel = hists_to_evsel(pair->hists);
> > -			idx_delta = evsel__group_idx(evsel) - prev_idx - 1;
> > -
> > -			while (idx_delta--) {
> > -				/*
> > -				 * zero-fill group members in the middle which have
> > -				 * no samples, pair->hists is not correct but it's
> > -				 * fine since the value is 0.
> > -				 */
> > -				ret += __hpp__fmt_print(hpp, pair->hists, 0, 0,
> > -							fmt, len, print_fn, fmtype);
> > +				data[i].val = get_field(pair);
> > +				data[i].samples = pair->stat.nr_events;
> > +				break;
> >  			}
> > -
> > -			ret += __hpp__fmt_print(hpp, pair->hists, period, nr_samples,
> > -						fmt, len, print_fn, fmtype);
> > -
> > -			prev_idx = evsel__group_idx(evsel);
> >  		}
> > +	}
> >  
> > -		idx_delta = nr_members - prev_idx - 1;
> > -
> > -		while (idx_delta--) {
> > -			/*
> > -			 * zero-fill group members at last which have no sample.
> > -			 * the hists is not correct but it's fine like above.
> > -			 */
> > -			ret += __hpp__fmt_print(hpp, evsel__hists(evsel), 0, 0,
> > -						fmt, len, print_fn, fmtype);
> > -		}
> > +	for (i = 0; i < nr_members; i++) {
> > +		ret += __hpp__fmt_print(hpp, data[i].hists, data[i].val,
> > +					data[i].samples, fmt, len,
> > +					print_fn, fmtype);
> >  	}
> >  
> > +	free(data);
> > +
> >  	/*
> >  	 * Restore original buf and size as it's where caller expects
> >  	 * the result will be saved.
> > -- 
> > 2.45.1.288.g0e0cd299f1-goog

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7815F184E;
	Wed,  5 Jun 2024 00:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717548172; cv=none; b=eMe61sfmp7LPj/qmjCF4ckv/P78CLfHFRUKEwz4NDc0mpkHdDzrq8E3knw3XHMXe73WTTgixmjnWMQq4Ysr4Xvopsfwak3Rnm/mAM2uPtQOTE7/iwgVmGbPO/76e0RKdaX0jX8A8jH3HAprpUnAzh6DjN2HqGg6eUds3mINa4uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717548172; c=relaxed/simple;
	bh=o/9XA293ztzQotVbWDuq6SEmoKfFMzc7jf77BFoaTdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aluhuzm+gfTAfMwWvrp6LobbTzPzzRfasY09/r0ajP48IAeYbi/63sJBJok4eqOHx05210WQsv9J6701C1tJIzhSD7BBNbKd8sI2Cb2G1e3TklDTd4jug9Z4w+jzWLhr1AEWyN65zcfgQFGkjFmb7Fgme9ksQtQKpLx9+FtHRw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4FKaKEA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4FKaKEA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984A1C2BBFC;
	Wed,  5 Jun 2024 00:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717548171;
	bh=o/9XA293ztzQotVbWDuq6SEmoKfFMzc7jf77BFoaTdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C4FKaKEAK9jHS1pp+wRVnlGZ9SuZA24j/+tIvrhulO+YhDlHuceOhw+4wPiSenAJS
	 x6L4TCuXFHeA33qBGMmuiIC6ULqQp3Kj7wTyyxNHQw/CWWtAh6NmtI1NGK9uNND1M4
	 aFzTizTCvaAzelYADYQJ+NBDYPl6jkFVQvF0xZCBJj/J452dmYkmxcd/ykrNNSBBDv
	 2qRRjKlZ1M9kZIAAC7zm0ycFg0E7XgS9WXySvJd+z1D2bYhx1yhRm80AGa7RgMaZ32
	 CjzdQJjlGsY0UUHAaWh9JgkxiRi59Uj3qEsoYSppmNqiATJp2xu74ml05QnCIK24GO
	 w2jY8CIgfgm9w==
Date: Tue, 4 Jun 2024 17:42:50 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/4] perf hist: Factor out __hpp__fmt_print()
Message-ID: <Zl-0igwvs8EuzOMs@google.com>
References: <20240603224412.1910049-1-namhyung@kernel.org>
 <20240603224412.1910049-2-namhyung@kernel.org>
 <Zl8tvVPEfLM8_T_z@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zl8tvVPEfLM8_T_z@x1>

On Tue, Jun 04, 2024 at 12:07:41PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, Jun 03, 2024 at 03:44:09PM -0700, Namhyung Kim wrote:
> > Split the logic to print the histogram values according to the format
> > string.  This was used in 3 different places so it's better to move out
> > the logic into a function.
> 
> But are all really equivalent? I had difficulty following it, perhaps it
> would be better to introduce the function and then go on making one by
> one use it instead of doing it all at once?

Sorry, I agree the code looks confusing.  But they are equivalent and
just to print the value in a different way.

> 
> So in the end we have:
> 
> static int __hpp__fmt_print(struct perf_hpp *hpp, struct hists *hists, u64 val,
> 			    int nr_samples, const char *fmt, int len,
> 			    hpp_snprint_fn print_fn, enum perf_hpp_fmt_type fmtype)
> {
> 	if (fmtype == PERF_HPP_FMT_TYPE__PERCENT) {
> 		double percent = 0.0;
> 		u64 total = hists__total_period(hists);
> 
> 		if (total)
> 			percent = 100.0 * val / total;
> 
> 		return hpp__call_print_fn(hpp, print_fn, fmt, len, percent);
> 	}
> 	if (fmtype == PERF_HPP_FMT_TYPE__AVERAGE) {
> 		double avg = nr_samples ? (1.0 * val / nr_samples) : 0;
> 
> 		return hpp__call_print_fn(hpp, print_fn, fmt, len, avg);
> 	}
> 
> 	return hpp__call_print_fn(hpp, print_fn, fmt, len, val);
> }
> 
> I.e. we do something with the last arg for hpp__call_print_fn() for the
> PERF_HPP_FMT_TYPE__PERCENT and PERF_HPP_FMT_TYPE__AVERAGE fmtype's, but
> we don't check for those fmtypes on each of the places that we now call
> __hpp__fmt_print(), right?
> 
> That while (idx_delta--) cases is only interested in !=PERF_HPP_FMT_TYPE__RAW...
> 
> Nah, after trying to describe the confusion I think I clarified it,
> probably leave it as you did :-\

:)

The 'while (idx_delta--)' part is just to fill the gap for entries
without samples.  The value is always 0, so it only cares the data type
(double or u64) in the format string.  RAW needs u64 while PERCENT and
AVERAGE need double.

Thanks,
Namhyung

  
> > +++ b/tools/perf/ui/hist.c
> > @@ -23,35 +23,42 @@
> >  	__ret;							\
> >  })
> >  
> > -static int __hpp__fmt(struct perf_hpp *hpp, struct hist_entry *he,
> > -		      hpp_field_fn get_field, const char *fmt, int len,
> > -		      hpp_snprint_fn print_fn, enum perf_hpp_fmt_type fmtype)
> > +static int __hpp__fmt_print(struct perf_hpp *hpp, struct hists *hists, u64 val,
> > +			    int nr_samples, const char *fmt, int len,
> > +			    hpp_snprint_fn print_fn, enum perf_hpp_fmt_type fmtype)
> >  {
> > -	int ret;
> > -	struct hists *hists = he->hists;
> > -	struct evsel *evsel = hists_to_evsel(hists);
> > -	char *buf = hpp->buf;
> > -	size_t size = hpp->size;
> > -
> >  	if (fmtype == PERF_HPP_FMT_TYPE__PERCENT) {
> >  		double percent = 0.0;
> >  		u64 total = hists__total_period(hists);
> >  
> >  		if (total)
> > -			percent = 100.0 * get_field(he) / total;
> > +			percent = 100.0 * val / total;
> >  
> > -		ret = hpp__call_print_fn(hpp, print_fn, fmt, len, percent);
> > -	} else if (fmtype == PERF_HPP_FMT_TYPE__AVERAGE) {
> > -		double average = 0;
> > +		return hpp__call_print_fn(hpp, print_fn, fmt, len, percent);
> > +	}
> >  
> > -		if (he->stat.nr_events)
> > -			average = 1.0 * get_field(he) / he->stat.nr_events;
> > +	if (fmtype == PERF_HPP_FMT_TYPE__AVERAGE) {
> > +		double avg = nr_samples ? (1.0 * val / nr_samples) : 0;
> >  
> > -		ret = hpp__call_print_fn(hpp, print_fn, fmt, len, average);
> > -	} else {
> > -		ret = hpp__call_print_fn(hpp, print_fn, fmt, len, get_field(he));
> > +		return hpp__call_print_fn(hpp, print_fn, fmt, len, avg);
> >  	}
> >  
> > +	return hpp__call_print_fn(hpp, print_fn, fmt, len, val);
> > +}
> > +
> > +static int __hpp__fmt(struct perf_hpp *hpp, struct hist_entry *he,
> > +		      hpp_field_fn get_field, const char *fmt, int len,
> > +		      hpp_snprint_fn print_fn, enum perf_hpp_fmt_type fmtype)
> > +{
> > +	int ret;
> > +	struct hists *hists = he->hists;
> > +	struct evsel *evsel = hists_to_evsel(hists);
> > +	char *buf = hpp->buf;
> > +	size_t size = hpp->size;
> > +
> > +	ret = __hpp__fmt_print(hpp, hists, get_field(he), he->stat.nr_events,
> > +			       fmt, len, print_fn, fmtype);
> > +
> >  	if (evsel__is_group_event(evsel)) {
> >  		int prev_idx, idx_delta;
> >  		struct hist_entry *pair;
> > @@ -72,30 +79,16 @@ static int __hpp__fmt(struct perf_hpp *hpp, struct hist_entry *he,
> >  
> >  			while (idx_delta--) {
> >  				/*
> > -				 * zero-fill group members in the middle which
> > -				 * have no sample
> > +				 * zero-fill group members in the middle which have
> > +				 * no samples, pair->hists is not correct but it's
> > +				 * fine since the value is 0.
> >  				 */
> > -				if (fmtype != PERF_HPP_FMT_TYPE__RAW) {
> > -					ret += hpp__call_print_fn(hpp, print_fn,
> > -								  fmt, len, 0.0);
> > -				} else {
> > -					ret += hpp__call_print_fn(hpp, print_fn,
> > -								  fmt, len, 0ULL);
> > -				}
> > +				ret += __hpp__fmt_print(hpp, pair->hists, 0, 0,
> > +							fmt, len, print_fn, fmtype);
> >  			}
> >  
> > -			if (fmtype == PERF_HPP_FMT_TYPE__PERCENT) {
> > -				ret += hpp__call_print_fn(hpp, print_fn, fmt, len,
> > -							  100.0 * period / total);
> > -			} else if (fmtype == PERF_HPP_FMT_TYPE__AVERAGE) {
> > -				double avg = nr_samples ? (period / nr_samples) : 0;
> > -
> > -				ret += hpp__call_print_fn(hpp, print_fn, fmt,
> > -							  len, avg);
> > -			} else {
> > -				ret += hpp__call_print_fn(hpp, print_fn, fmt,
> > -							  len, period);
> > -			}
> > +			ret += __hpp__fmt_print(hpp, pair->hists, period, nr_samples,
> > +						fmt, len, print_fn, fmtype);
> >  
> >  			prev_idx = evsel__group_idx(evsel);
> >  		}
> > @@ -104,15 +97,11 @@ static int __hpp__fmt(struct perf_hpp *hpp, struct hist_entry *he,
> >  
> >  		while (idx_delta--) {
> >  			/*
> > -			 * zero-fill group members at last which have no sample
> > +			 * zero-fill group members at last which have no sample.
> > +			 * the hists is not correct but it's fine like above.
> >  			 */
> > -			if (fmtype != PERF_HPP_FMT_TYPE__RAW) {
> > -				ret += hpp__call_print_fn(hpp, print_fn,
> > -							  fmt, len, 0.0);
> > -			} else {
> > -				ret += hpp__call_print_fn(hpp, print_fn,
> > -							  fmt, len, 0ULL);
> > -			}
> > +			ret += __hpp__fmt_print(hpp, evsel__hists(evsel), 0, 0,
> > +						fmt, len, print_fn, fmtype);
> >  		}
> >  	}
> >  
> > -- 
> > 2.45.1.288.g0e0cd299f1-goog

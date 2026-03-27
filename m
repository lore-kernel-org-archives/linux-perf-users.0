Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E85433D6E3;
	Fri, 27 Mar 2026 18:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774634758; cv=none; b=l6qjz7g6CKWurffCATaf5uCAZOUvqfTtttbsI51hLPyWMcYiQQKhVDohzqx53Swiyk6Fh0MCxqKs6QSh+Q6ElgDHBcqXSU8xCfPatFPz93+N6MhzQGZV9YYQ6qzoWBfqFTMcgxUapGLHld7cHDC1TUUfSInG3X4Ju1hMSb4k7LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774634758; c=relaxed/simple;
	bh=f9lpmujYRmAYBc6nKFLnMG+gp/XoKx0LeQnP2wObzg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTSlhlTBwW/oF69Fk8F0BWjOnWP8Ik72o57wKA2W3o0+DNJOQcjHL2c69zAUHL/QsKPLp3MkjyKqg6JTeUKlg7HWqj7tWAVX5zD5VhF1P/C8G0YC4rDvooXPrxD2UPbI7U+ZMxkBp4GVpYQpNJJFEd5px/Q6lTi9rWqO85eLnps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fES7LvIz; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fES7LvIz"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F26EF35AA;
	Fri, 27 Mar 2026 10:57:09 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 898813F99C;
	Fri, 27 Mar 2026 10:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774634235; bh=f9lpmujYRmAYBc6nKFLnMG+gp/XoKx0LeQnP2wObzg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fES7LvIzyc/qPpQ+RFhpdoJRKZRdudA19bb5n2HOvVcjr6nF4ysLsDz2s08w/w/9h
	 Or1Vt0ZLVjzxT0s7wcl5Os2W2ngdcFSqbeoC5M2upJREU34BuDHldDu8qAfYKh8J3S
	 Go92DJ1SWR2Kw+RGfkbiR7skWFZqHnRG7Bz9ShFE=
Date: Fri, 27 Mar 2026 17:57:13 +0000
From: Leo Yan <leo.yan@arm.com>
To: Ian Rogers <irogers@google.com>
Cc: Breno Leitao <leitao@debian.org>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, Denis Yaroshevskiy <dyaroshev@meta.com>,
	Dmitry Ilvokhin <d@ilvokhin.com>
Subject: Re: [PATCH v2] perf stat: Fix crash on arm64
Message-ID: <20260327175713.GD356832@e132581.arm.com>
References: <20260325-perf_stat-v2-1-d986ef5b9327@debian.org>
 <20260325205914.GA356832@e132581.arm.com>
 <CAP-5=fWkbhffgL6BJjpiwRV6rD3yd=KkOz7-ODH2FnORBf70bQ@mail.gmail.com>
 <20260326163926.GB356832@e132581.arm.com>
 <CAP-5=fUy8Y1cQUC=HzrSpAKcYyxDOjq=JZk1kdgKH9udWA+R=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUy8Y1cQUC=HzrSpAKcYyxDOjq=JZk1kdgKH9udWA+R=g@mail.gmail.com>

On Thu, Mar 26, 2026 at 02:21:00PM -0700, Ian Rogers wrote:

[...]

> > On one of my board, I can see the log:
> >
> >   Events in 'frontend_bound' fully contained within 'retiring'
> >   Events in 'bad_speculation' fully contained within 'retiring'
> >   Events in 'backend_bound' fully contained within 'retiring'
> 
> I looked at nvidia/t410/metrics.json but I'm not clear on where the
> issue is coming from.

Digging a bit, all these metrics have syntax errors because #slots is
zero when returned from tool_pmu__cpu_slots_per_cycle().
See the log: https://termbin.com/e9ue

After that, executes parse_groups() treats all these problematic metrics
as being contained by "retiring".

I have sent a patch to make __add_metrics() respect the returned syntax
error, so the program can exit early.


> > In parse_groups(), when find a event is fully contained by a previous
> > event, it skips to call parse_ids(), as a result, m->pctx->ids is not
> > initialized.  Then, setup_metric_events() returns an empty metric
> > events, pick_display_evsel() consumes the returned metric_events and
> > feeds to metricgroup__lookup() with passing "evsel = NULL".
> 
> Fully contained groups exist on x86, why isn't this problem breaking
> whenever this happens? Stepping through "contained" examples, I see
> that the ids aren't initialized. I think something else must be
> happening.

If you change tool_pmu__cpu_slots_per_cycle() to always return zero,
this might can reproduce the issue.

[...]

> > @@ -1463,19 +1463,18 @@ static int parse_groups(struct evlist *perf_evlist,
> >                                 if (expr__subset_of_ids(n->pctx, m->pctx)) {
> >                                         pr_debug("Events in '%s' fully contained within '%s'\n",
> >                                                  m->metric_name, n->metric_name);
> > -                                       metric_evlist = n->evlist;
> > +                                       contained = n->evlist;
> >                                         break;
> >                                 }
> > -
> >                         }
> >                 }
> >                 if (!metric_evlist) {
> > +                       metric_evlist = contained ? contained : m->evlist;
> > +
> >                         ret = parse_ids(metric_no_merge, fake_pmu, m->pctx, m->modifier,
> > -                                       m->group_events, tool_events, &m->evlist);
> > +                                       m->group_events, tool_events, &metric_evlist);
> 
> Won't this match the behavior of metric_no_merge/--metric-no-merge,
> since for every metric the events for that metric are being appended
> to the evlist?

TBH, I still cannot understand well parse_groups().

The change above passes &metric_evlist to parse_ids(), as this will only
change the value of metric_evlist itself but not update m->evlist or
n->evlist, this is not right for metric_no_merge case ?

Here I am not sure how to use parse_ids() to parse "m->pctx" but avoid
to overwrite "n->evlist" for the fully contained case.

Thanks,
Leo

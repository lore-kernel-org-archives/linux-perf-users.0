Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C95524E4C4;
	Tue,  4 Nov 2025 03:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762227037; cv=none; b=PVNtmBNBrB2PZdiSqkQ3afgbRi+V4441Vq0tV4oR1UjIKBK+oBwIspNUtHZAYjiRxCPn7Q3xaq2SgkYaRvrM7aeureu1oK3H2GdAvUwxlCNoPxSxPYE2qrZIaBKfZ4MtbLAdBjlFvDTBQGZj0mDkyA3kccWPb5FAy5ot185jwbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762227037; c=relaxed/simple;
	bh=4gPZ3WPgXYu/qX6cajH2LAbb6Ia3H6T8qgD7eS8+lUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7cmE55sRQyUrh0uJljQEck/XwUgXN0AFwN6RpXVtaivizXMgE3AzmiUcogYv378AJf4QCpggy7bsUYlC2aKmveR/rjUjEhLVrBQ5YbB9qEt4x67d0F/T9MTDcHNEPaZmzEo2o5cUHVnAtysf3KJLBm1r9R3IDIruwQnd9UJ7yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfctogNa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfctogNa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB6BC16AAE;
	Tue,  4 Nov 2025 03:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762227036;
	bh=4gPZ3WPgXYu/qX6cajH2LAbb6Ia3H6T8qgD7eS8+lUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mfctogNaekzBOvO7j88AuPsq6hQh6qG8IgKww7SNappHgTclPsw9TgJ+LeNfjkDwA
	 4/vbbphSwdCkiBjmfRDM37BvMP+uE22WfvDUE4+3GwVdEBjstszhpJXnrNkigjymkD
	 edjIfzH+WmNQzXx+BTXdzysfAGb6kOJz3XoTLUm3S7J69+CpxZRvCPr+KJgOsNrJky
	 hw6rxE4bqskOzzSOgrVpbTe+Ypz3LDTeFEWlqx+eloj59FEUwWcUV8VxRfolqUSXPG
	 MF63jcysnJRAanjp6QZbcYeSYoRUdLFZh5Nl6gM7s6yLkVWBQ71wClU3vCE/5fvzO7
	 R8eqsDv9UAi+Q==
Date: Mon, 3 Nov 2025 19:30:34 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf pmu: Make pmu_alias_terms weak again
Message-ID: <aQlzWvieU5mBktx4@google.com>
References: <20251029222638.816100-1-irogers@google.com>
 <aQL70qlYohRT7cT8@google.com>
 <CAP-5=fU1pJ_7ewrxwCLUu_OkjZ2Z_bSzkaZxREG8uKnwop6JYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU1pJ_7ewrxwCLUu_OkjZ2Z_bSzkaZxREG8uKnwop6JYw@mail.gmail.com>

On Thu, Oct 30, 2025 at 08:08:02AM -0700, Ian Rogers wrote:
> On Wed, Oct 29, 2025 at 10:47 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi Ian,
> >
> > On Wed, Oct 29, 2025 at 03:26:37PM -0700, Ian Rogers wrote:
> > > The terms for a json event should be weak so they don't override
> > > command line options.
> >
> > Can you please give an example command line and the error?
> 
> Sure, it is also covered in the test.

Yep, but lazy maintainers want to see it in the commit message. :)

> 
> Before:
> ```
> $ perf record -vv -c 1000 -e uops_issued.any -o /dev/null true 2>&1
> |grep "{ sample_period, sample_freq }"
>  { sample_period, sample_freq }   200003
>  { sample_period, sample_freq }   2000003
>  { sample_period, sample_freq }   1000
> ```
> 
> After:
> ```
> $ perf record -vv -c 1000 -e uops_issued.any -o /dev/null true 2>&1
> |grep "{ sample_period, sample_freq }"
>  { sample_period, sample_freq }   1000
>  { sample_period, sample_freq }   1000
>  { sample_period, sample_freq }   1000
> ```

Thanks, it ignored command line options.  I can see the default period
is in the JSON description.

  $ perf list -j | grep -C 5 uops_issued.any
  	"Encoding": "cpu/event=0xb1,period=2000003,umask=0x10/"
  },
  {
  	"Unit": "cpu",
  	"Topic": "pipeline",
  	"EventName": "uops_issued.any",
  	"EventType": "Kernel PMU event",
  	"BriefDescription": "Uops that RAT issues to RS",
  	"PublicDescription": "Counts the number of uops that the Resource Allocation Table (RAT) issues to the Reservation Station (RS)",
  	"Encoding": "cpu/event=0xe,period=2000003,umask=1/"
  },

It'd be great if you could include this kind of info in the commit log
so that others can understand the problem clearly and test the patch
easily.

Thanks,
Namhyung

> > >
> > > Fixes: 84bae3af20d0 ("perf pmu: Don't eagerly parse event terms")
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/util/pmu.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > > index d597263fab4f..f14f2a12d061 100644
> > > --- a/tools/perf/util/pmu.c
> > > +++ b/tools/perf/util/pmu.c
> > > @@ -802,6 +802,7 @@ static int pmu_aliases_parse_eager(struct perf_pmu *pmu, int sysfs_fd)
> > >  static int pmu_alias_terms(struct perf_pmu_alias *alias, struct list_head *terms)
> > >  {
> > >       struct parse_events_terms alias_terms;
> > > +     struct parse_events_term *term;
> > >       int ret;
> > >
> > >       parse_events_terms__init(&alias_terms);
> > > @@ -812,6 +813,13 @@ static int pmu_alias_terms(struct perf_pmu_alias *alias, struct list_head *terms
> > >               parse_events_terms__exit(&alias_terms);
> > >               return ret;
> > >       }
> > > +     list_for_each_entry(term, &alias_terms.terms, list) {
> > > +             /*
> > > +              * Weak terms don't override command line options,
> > > +              * which we don't want for implicit terms in aliases.
> > > +              */
> > > +             term->weak = true;
> > > +     }
> > >       list_splice_init(&alias_terms.terms, terms);
> > >       parse_events_terms__exit(&alias_terms);
> > >       return 0;
> > > --
> > > 2.51.1.851.g4ebd6896fd-goog
> > >

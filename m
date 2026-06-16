Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4296F3D8114;
	Tue, 16 Jun 2026 18:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781634070; cv=none; b=bcBCxnvvKP4emJOpX3MaSM8KPgj5J445LEdZaWc/OstrC1OsIuzDuPGEtUFGV2KAyKELRynqjTu2HRNnGIYO4t1gII0PRlC6BOH2MPh6hmrMxyAzq7Cf744EK5STe3MZlsJkJv+/RYy+GVuhLu/ehIuoykG+XsQOyPTGsE6Y/74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781634070; c=relaxed/simple;
	bh=gaedAD2xhc02DJYcSfSLr7OHiqQbdYW9W2UISbH4lV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1j5uoe7FM2fi3GackiCIT506jU6OaKLA22MM+Chdy5c8ENTCuSw9isZahvuiJtgE1qg1fFSZYvZ3q1soAKoCPGfHNvU80+yj+M7yi335DTgDPkbASZ13oRdHC0dIAamhlmRGVjPYr9H1DRVx3uiRPAwfHWO4YowGDjfYbtedrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfXUUtbe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfXUUtbe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1C71F00A3A;
	Tue, 16 Jun 2026 18:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781634068;
	bh=GJ3Dhyld5q7etDyy4lt204VJMpdej6hdvMjFx1XdxLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IfXUUtbe6HCWBrHDOqXj2N9IQYIrhfQ9O9f+RLSKNuQfnHonil56YSDO26nNI0CaT
	 PglQuDLGWVSvTu2AYd52FUGAutLd6VUPMP35am3sJ1bWcQiSS00+xfx2U1Murgq+Nw
	 RJZOrgrk/ecIVw10T6ekqmD22SLCYgB/p4zFeT1AGDVlhX+2ofKR4GF2BFuGxVzz/Z
	 Ny7e7Er0QOpZmQIeP+9+wRNUpiGFYoAW1NGK5LheMtuGKIbkmxDiUdy36B1AF9wfRd
	 foZWxSzrr6Z6vqA+vAl7SeMEZ05cxTzceixKbWVKugj8H1fF/IoI/anwPuNFq9FU/Q
	 qGsrZq9w3XQCw==
Date: Tue, 16 Jun 2026 15:21:05 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v21 08/21] perf python: Use evsel in sample in pyrf_event
Message-ID: <ajGUESzXk801QQ3c@x1>
References: <20260616011543.4037138-9-irogers@google.com>
 <20260616015219.0BCC51F000E9@smtp.kernel.org>
 <ajFztSaBdZgJ6sJF@x1>
 <CAP-5=fXYGpO1T2zj0Gyr-FaOObiAA8G4Oraj44xPsmX0+Wj6QA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXYGpO1T2zj0Gyr-FaOObiAA8G4Oraj44xPsmX0+Wj6QA@mail.gmail.com>

On Tue, Jun 16, 2026 at 10:03:08AM -0700, Ian Rogers wrote:
> On Tue, Jun 16, 2026 at 9:03 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Tue, Jun 16, 2026 at 01:52:16AM +0000, sashiko-bot@kernel.org wrote:
> > > Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> > > - [High] Missing NULL check before calling evsel__get() on the result of evlist__id2evsel() leads to a potential crash.
> > > - [Medium] Missing perf_sample__exit() on the error path of guest_session__fetch() leaks the evsel reference.
> > > - [Medium] Missing perf_sample__exit() on the error path out of perf_mmap__read_event() loop in test__perf_time_to_tsc leaks the evsel reference.
> > > --
> > >
> > > commit c23db56d8fc8d40b59596916ce6b0537514263aa
> > > Author: Ian Rogers <irogers@google.com>
> > >
> > > perf python: Use evsel in sample in pyrf_event
> > >
> > > Avoid a duplicated evsel by using the one in sample. Add
> > > evsel__get/put to the evsel in perf_sample.
> > >
> > > > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > > > index ec759a11f7588..d79112cebb716 100644
> > > > --- a/tools/perf/util/evsel.c
> > > > +++ b/tools/perf/util/evsel.c
> > > > @@ -3365,7 +3365,7 @@ int __evsel__parse_sample(struct evsel *evsel, union perf_event *event,
> > > >     union u64_swap u;
> > > >
> > > >     perf_sample__init(data, /*all=*/true);
> > > > -   data->evsel = evsel;
> > > > +   data->evsel = evsel__get(evsel);
> > >
> > > [Severity: Medium]
> > > Does this new reference acquisition cause memory leaks in existing callers
> > > that do not expect sample.evsel to hold a reference on early errors?
> >
> > So this was something I wasn't expecting: patches for tools/perf/util/
> > inside a python binding series :-\
> 
> So this was the point of sending the RFC early:
> https://lore.kernel.org/linux-perf-users/20251029053413.355154-1-irogers@google.com/
> When working with the session API, copying evsels and evlists becomes
> painful; it's easier to hand references to the parts of the system
> that need them instead of copying and ensuring the copying is correct.

I like the whole series, its just that when coming back to look at it I
was expecting to see it separated into a "prep the env" followed to a
"use what was done before", but nah, I'll try merging it now.

> > > For example, in tools/perf/builtin-inject.c:guest_session__inject_events(),
> > > if guest_session__fetch() fails, it returns an error but the cleanup block
> > > checking if (ret && gs->fetched) prevents perf_sample__exit() from running,
> > > leaking the evsel reference.
> >
> > this looks valid, no?
> >
> > And while looking at it, there is another bug in that function, but now
> > I'm looking like sashiko ;-)
> >
> > Namely:
> >
> >  tools/perf/builtin-inject.c
> > ╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌
> >  1970        if (sample->cpu >= gs->vcpu_cnt) {
> >  1971          pr_err("Guest event with unknown VCPU %u\n",
> >  1972                 sample->cpu);
> >  1973 -        return -EINVAL;
> >  1973 +        ret = -EINVAL;
> >  1974 +        break;
> >  1975        }
> >  1976        /* Change to host CPU instead of guest VCPU */
> >  1977        sample->cpu = gs->vcpu[sample->cpu].cpu;
> >
> > But the comment for your patch seems actionable, i.e. it is an issue
> > introduced by your series, by calling that evsel__get(), no?
> 
> Hmm.. I checked that the tests were clean using leak sanitizer and
> reference count checking. There's no reference count checking on
> evsels as the scope of the fix is so large for that. I'll try to find
> other issues, and make a v22, but much of the Sashiko feedback has
> proven to cover things that are either pre-existing, or addressed
> later in this series. In this case the missing perf_sample__exit was
> pre-existing and we could have been leaking other values like sampled
> registers.

Fair enough, I'll ask Claude to track this for us, so that we don't lose
track of it and fix it eventually.

- Arnaldo
 
> Thanks,
> Ian
> 
> > > Similarly, in tools/perf/tests/perf-time-to-tsc.c:test__perf_time_to_tsc(),
> > > the CHECK__(evsel__parse_sample(...)) macro jumps to out_err on failure,
> > > bypassing perf_sample__exit(&sample) and permanently leaking the newly
> > > acquired evsel.
> > >
> > > >     data->cpu = data->pid = data->tid = -1;
> > > >     data->stream_id = data->id = data->time = -1ULL;
> > > >     data->period = evsel->core.attr.sample_period;
> > >
> > > [ ... ]
> > >
> > > > diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> > > > index 89d0f4cec6c7f..18af70488e07a 100644
> > > > --- a/tools/perf/util/session.c
> > > > +++ b/tools/perf/util/session.c
> > > > @@ -1874,7 +1875,11 @@ static int evlist__deliver_deferred_callchain(struct evlist *evlist,
> > > >             else
> > > >                     orig_sample.deferred_callchain = false;
> > > >
> > > > -           orig_sample.evsel = evlist__id2evsel(evlist, orig_sample.id);
> > > > +           new_evsel = evlist__id2evsel(evlist, orig_sample.id);
> > > > +           if (new_evsel != orig_sample.evsel) {
> > > > +                   evsel__put(orig_sample.evsel);
> > > > +                   orig_sample.evsel = evsel__get(new_evsel);
> > > > +           }
> > >
> > > [Severity: High]
> > > Can this cause a segmentation fault if the sample ID is unknown or corrupted?
> > >
> > > The evlist__id2evsel() function can return NULL for malformed perf.data files.
> > > If new_evsel is NULL, passing it directly to evsel__get(new_evsel) will
> > > dereference the NULL pointer when trying to increment its reference count.
> > >
> > > Could we add a NULL check here before calling evsel__get()?
> > >
> > > >             ret = evlist__deliver_sample(evlist, tool, de->event,
> > > >                                          &orig_sample, machine);
> > > >
> > > > @@ -1913,7 +1919,11 @@ static int session__flush_deferred_samples(struct perf_session *session,
> > > >             }
> > > >             sample.file_offset = de->file_offset;
> > > >
> > > > -           sample.evsel = evlist__id2evsel(evlist, sample.id);
> > > > +           new_evsel = evlist__id2evsel(evlist, sample.id);
> > > > +           if (new_evsel != sample.evsel) {
> > > > +                   evsel__put(sample.evsel);
> > > > +                   sample.evsel = evsel__get(new_evsel);
> > > > +           }
> > >
> > > [Severity: High]
> > > Similarly, could evlist__id2evsel() return NULL here and cause a crash when
> > > passed to evsel__get()?
> > >
> > > >             ret = evlist__deliver_sample(evlist, tool, de->event,
> > > >                                          &sample, machine);
> > > >
> > >
> > > --
> > > Sashiko AI review · https://sashiko.dev/#/patchset/20260616011543.4037138-1-irogers@google.com?part=8

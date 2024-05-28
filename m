Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C22176FB3;
	Tue, 28 May 2024 19:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716925468; cv=none; b=VAW+w7IHS1xnBX0Rc5l2XsLAr38Jijiwhi4Fh2X96MSB5NrnBOAdLix+NCMAEMbdrOjddCEhM5+a1QDBouxXz0Vah11DbAXOFefMiBXqg2lvsUCkx0VwhB+2q11JkIIwXe7WEXfGkAUA5Ax1FRm/l1FAQLpREFYGRU8Eqnnj52E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716925468; c=relaxed/simple;
	bh=Zfpe/d8xujPU7oFPiM38uFfQeSG19WZQPyurGbXN1iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vejc04JFb2GmoFv36x3rjDA9rCyyQK8FAMqDjTHdqqYCb+6qkt7BGZ6gWvW3aXkmRNUcQhdisr1mu9ItQB2GsvaOZ7c2WpSBYXPukMknhMPURnlO1F58fxYX1d4/Vz5XSE1zo+hzhuITrvAzungJUgI5GVSAn6dEnUpqnDQOYuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPBpC5w/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPBpC5w/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11EB8C3277B;
	Tue, 28 May 2024 19:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716925467;
	bh=Zfpe/d8xujPU7oFPiM38uFfQeSG19WZQPyurGbXN1iw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GPBpC5w/6VJV4uYhhO3Dc+esqjymfBN15mZb2EoVmTruGX5nh08bBw083PiCe/TZ6
	 LUL6jaSOp4QbmQqdJkQwlL9lVDgilYZPNyj9Hfa/h8yM/wAO0LC+JTRbhF5JuFsPzv
	 eEqSh95iFGbhLzxLxcijieemySz2dVsZDnbpC+IV582KjcT/lmZFZciCbCJZO6+8j1
	 fEbjk+2wBuvSkxQOGQiOCcceR/7pKVeKc/ixtwBI1CcwfQS0V83rnw40u2d0D0vRlE
	 MtoF6Ddth0YeAyoUomKVNYmKvGuTkB8wHyPXm1MLQqy9muV0X0w5my3J5wePfBKmW5
	 vgR1uG/y0eUqg==
Date: Tue, 28 May 2024 16:44:23 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Leo Yan <leo.yan@linux.dev>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@arm.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf evlist: Force adding default events only to core
 PMUs
Message-ID: <ZlY0F_lmB37g10OK@x1>
References: <20240525152927.665498-1-irogers@google.com>
 <CAHk-=wgYxi_+Q1OpZKg2F9=eem7VQjYnoqN6sA1+uUt-0JqQKQ@mail.gmail.com>
 <CAHk-=wi5Ri=yR2jBVk-4HzTzpoAWOgstr1LEvg_-OXtJvXXJOA@mail.gmail.com>
 <20240527105842.GB33806@debian-dev>
 <CAP-5=fXfidyF_e=yMNi26ScgY-VbJPfxN8M7OiK9ELa3qTfXPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXfidyF_e=yMNi26ScgY-VbJPfxN8M7OiK9ELa3qTfXPQ@mail.gmail.com>

On Mon, May 27, 2024 at 10:36:45PM -0700, Ian Rogers wrote:
> On Mon, May 27, 2024 at 3:58 AM Leo Yan <leo.yan@linux.dev> wrote:
> > On Sat, May 25, 2024 at 02:14:26PM -0700, Linus Torvalds wrote:
> > > On Sat, 25 May 2024 at 09:43, Linus Torvalds <torvalds@linux-foundation.org> wrote:

> > > > This makes 'perf record' work for me again.

> > > Oh, wait, no it doesn't.

> > > It makes just the plain "perf record" without any arguments work,
> > > which was what I was testing because I was lazy.

> > > So now

> > >     $ perf record sleep 1

> > > works fine. But

> > >     $ perf record -e cycles:pp sleep 1

> > > is still completely broken (with or without ":p" and ":pp").

> > Seems to me that this patch fails to check if a PMU is a core-attached
> > PMU that can support common hardware events. Therefore, we should
> > consider adding the following check.

> > +++ b/tools/perf/util/parse-events.c
> > @@ -1594,6 +1594,9 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
> >         while ((pmu = perf_pmus__scan(pmu)) != NULL) {
> >                 bool auto_merge_stats;
> >
> > +               if (hw_config != PERF_COUNT_HW_MAX && !pmu->is_core)
> > +                       continue;
> > +
> >                 if (parse_events__filter_pmu(parse_state, pmu))
> >                         continue;

> > To be clear, I only compiled this change but I have no chance to test
> > it. @Ian, could you confirm this?
 
> Hi Leo,
 
> so the code is working as intended. I believe it also agrees with what
> Arnaldo thinks.
 
> If you do:
 
> $ perf stat -e cycles ...
 
> and you have
 
> /sys/devices/pmu1/events/cycles
> /sys/devices/pmu2/events/cycles
 
> The output of perf stat should contain counts for pmu1 and pmu2. Were
> the event 'data_read' or 'inst_retired.any' we wouldn't be having the

Sure, what is being asked is to count events and if those two events in
those two PMUs can count, then do what the user asked.

For 'perf record' we're asking for sampling, if the event has the name
specified and can't be sampled, skip it, warn the user and even so
only if verbose mode is asked, something like:

  root@x1:~# perf record -e cycles -a sleep 1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 1.998 MB perf.data (4472 samples) ]
  root@x1:~# perf evlist
  cpu_atom/cycles/
  cpu_core/cycles/
  dummy:u
  root@x1:~#

Cool, there are two 'cycles' events, one in a PMU named 'cpu_atom',
another in a 'cpu_core' one, both can be sampled, my workload may
run/use resources on then, I'm interested, sample both.

But if we had some other PMU, to use a name Jiri uses in tests/fake
PMUs, the 'krava' PMU and it has a 'cycles' event, so 'krava/cycles/'
and for some reason it doesn't support sampling, skip it, then the
result should be the same as above.

If the user finds it strange after looking at sysfs that 'krava/cycles/'
isn't being sampled, the usual workflow is to ask perf for more
verbosity, using -v (or multiple 'v' letters to get increasing levels of
verbosity), in which case the user would see:

  root@x1:~# perf record -v -e cycles -a sleep 1
  WARNING: skipping 'krava/cycles/' event, it doesn't support sampling.
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 1.998 MB perf.data (4472 samples) ]
  root@x1:~# perf evlist

- Arnaldo

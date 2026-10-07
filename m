Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A772030A;
	Wed,  7 Oct 2026 00:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791332544; cv=none; b=jkdq/JuUzhz7xx9eB0CJ+D3NO4CTkAaac2TfTknk/dgtWW+MxSh84IPguTXayB9LUldbueCGlwlN+MLWoMfphARMZdpH6AOnwSuRpMHKsWXv76Dnt1LESPaskCUH7AoQ8ZLApumtmx9N0ecQFi5RRU1bJIBuXcVfJDTxblyJryg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791332544; c=relaxed/simple;
	bh=ZyfxtFK5yPZwq65qNoHdzEIzLaJ6K4O0qMxNvnbmL8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WGmN1fDi9hDwWNs3t8Pbj249IJGC2VK63HYRBVqDO1p9bbDTAk+rTa2izzkz2mh2YSoLjv+zhfHGVL+s+87xnBx2HKJUJq3LA8dRyO+VqsHL4lusbRNTDqmwjVkSwfttlGXrmq3sgsGc/Nz70pvLM+p6bXGq1n59HPTnAY/Onqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=haa/LI+e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="haa/LI+e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9939C1F0089B;
	Wed,  7 Oct 2026 00:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791332542;
	bh=mZX5cl0fSEX7TuGdNQcRePvMvtqvNTcBP1bE0N0tlIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=haa/LI+eCu+IzbvkOL3AB0XLKXjwI5OXNCO7fX4Qn4xQCuDC+muyZIt07t3ef7v6X
	 4FBWGSvKqLLyt/xd1SvTqQFoPIjiNxl8oNqvELR98rHof5nyNhJpcHXuykdltDuxEN
	 Tj9pU+vEvPoMDkg4u2lYFY4TKPVa7SFuSkQSJlbksDY9toQAKqSZiYc/lNz6YU0Q3X
	 N+A/LqLyKKkBN6JkgwOeF+g6XB9TVUJs57X9audQ39PxW7Ud5nWSY5crtbh1OThQr7
	 tjxoeDC7BaBFtsgQH1lgM6f63g5+liQ4662umdixOtqXPZG4GPxIrG4duy6gApjjcf
	 1kJha0AjNlTpA==
Date: Tue, 6 Oct 2026 17:22:21 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 0/6 v1] perf test attr: Fix the re-enabled test
Message-ID: <asWQvXRdqp_RK85c@google.com>
References: <20261006161309.3078488-1-acme@kernel.org>
 <asWLmvF-3YtoKJ7j@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <asWLmvF-3YtoKJ7j@google.com>

On Tue, Oct 06, 2026 at 05:00:26PM -0700, Namhyung Kim wrote:
> On Tue, Oct 06, 2026 at 06:13:03PM +0200, Arnaldo Carvalho de Melo wrote:
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > Hello all,
> > 
> > This series fixes the "Perf attribute expectations test" (perf test 82,
> > formerly "Setup struct perf_event_attr").
> > 
> > Patches 1-2 are Michael Petlan's prerequisite fixes that make the shell
> > wrapper propagate attr.py's return value and correct the
> > perf_event_attr size expectation after struct config4 was added.  They
> > are included at the start of the series so that it applies cleanly on
> > the current perf-tools-next (and for the review bots to verify the new
> > patches); the new fixes are patches 3-6.
> > 
> > With the test reporting failures again, several stale expectations
> > surfaced and are addressed here:
> > 
> > - test-record-graph-dwarf still expected PERF_SAMPLE_ADDR and
> >   PERF_SAMPLE_DATA_SRC for --call-graph dwarf.  Those were dropped by
> >   bdd051e249141c79 ("perf record: Split --data-mmap option"), which
> >   decoupled data MMAP recording from the sample address bits.
> > 
> > - The record and stat group tests expected cache-misses and
> >   instructions to be the legacy PERF_TYPE_HARDWARE events, but since
> >   b1c5efbfd92eb84d ("perf parse-events: Remove hard coded legacy
> >   hardware and cache parsing") they resolve to the core PMU sysfs/JSON
> >   events, so request the legacy encodings explicitly with the
> >   legacy-hardware-config term.
> > 
> > - The perf stat default metrics open their events in groups and the
> >   raw encodings of instructions, branch-misses, cpu-cycles and
> >   stalled-cycles-frontend/backend differ between Intel and AMD, so
> >   base-stat now accepts the standalone and group variants and
> >   test-stat-default/detailed-{1,2,3} gained the per-vendor raw
> >   encodings.
> > 
> > - attr.py no longer requires a recorded event to be in a group when
> >   the matching expectation does not declare one, allowing the stat
> >   tests to verify event attributes without encoding the metric
> >   grouping.  Expectations that declare a group are still verified in
> >   both directions.
> > 
> > The test passes with 'perf test -vv attribute' on x86_64.  The AMD
> > encodings come from the amd_pmu_event_map tables in
> > arch/x86/events/amd/core.c.
> 
> On my machine, the current tmp.perf-tools-next which contains these
> changes fails like this.
> 
>   $ tools/perf/perf test -v 82
>   ---- start ----
>   test child forked, pid 931585
>   /home/namhyung/project/linux/tools/perf/tests/shell/attr.sh: line 20: python: command not found
>   ---- end(-1) ----
>    82: Perf attribute expectations test                                                 : FAILED!
>   
>   === Test Summary ===
>   Passed main tests : 0
>   Passed subtests   : 0
>   Skipped tests     : 0
>   Failed tests      : 1
>   List of failed tests:
>      82: Perf attribute expectations test
> 
> The below patch fixes the problem.

Hmm.. even with the fix, it failed like this.

Thanks,
Namhyung


  $ tools/perf/perf test -v 82
  ---- start ----
  ...
  expected mmap=1, got 0
  expected comm=1, got 0
  expected freq=1, got 0
  expected enable_on_exec=1, got 0
  expected task=1, got 0
  expected sample_id_all=1, got 0
  expected branch_sample_type=16, got 0
  FAILED '/home/namhyung/project/linux/tools/perf/tests/shell/attr/test-record-branch-filter-any_call' - match failure
  ---- end(-1) ----
   82: Perf attribute expectations test                                                                      : FAILED!
  
  === Test Summary ===
  Passed main tests : 0
  Passed subtests   : 0
  Skipped tests     : 0
  Failed tests      : 1
  List of failed tests:
     82: Perf attribute expectations test


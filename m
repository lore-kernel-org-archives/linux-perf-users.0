Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3904A11;
	Wed, 12 Mar 2025 02:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741745808; cv=none; b=gMcQ92VgvhNY3NfrWNRemEkelw0jAfMLiP7yWsfz+ht0lgruDLnyOzUxTCEz3Xm9Fr1zMTlRUOi9NZmygvhinvXkCrtfpndYP7PvWUHM/nZB/AsZ3Ca/Mg5YgXTPB690xNWF2H8YyGi0YV5dvm5XAVhPq6WUVv4ylbwQteS7deo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741745808; c=relaxed/simple;
	bh=w3+u7zX/B0LEYX1mrYBjNhjsOVGs4fpYKClxoSt4KJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jRqXcBFGTvmyOkP6dZiLB20jdgBAuG8Fekl87ZQvzZmqhk2oUKynlAP7oSEDxyzqb98h+AAbdhw4o4hQm6AA1plhv9y4Sykj4xB+xYE40Liqhy2A5DyZJ7kaSf7CSqXW69qBJN5Bkw+SaxpITNg3T7qgTst98PrEpPy1gK4Fx6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/9uzZ9k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/9uzZ9k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DADA8C4CEE9;
	Wed, 12 Mar 2025 02:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741745808;
	bh=w3+u7zX/B0LEYX1mrYBjNhjsOVGs4fpYKClxoSt4KJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M/9uzZ9k3uqWL7g28m2Ab6LAtVwoFbNoi+pcbCcpR9p59TwXYK0qJFn0Lz9wHc58v
	 uw7J7S4m/1y0MQzOCOfrknJHlOj25WITXUmn77KCln7t9RoT1g+3H8iBD+s7CxR0ge
	 iMC7KEe8DnRb+qZWu6DkOaFK6+hhRhtSletzcbRW05tiN6/TRYeXmTNlOXA8XAqh2d
	 RU5Ps+mYEVa5ggPFekVrLlwiSBExr7tTm6wnR6aMfHjiI0TdS8tnR+YahWNgFaiibW
	 OvPc7YbpQmpIHrilNjH3etrl7+04Dt1n4DTwjoxXGCXnx2tx9+3eeBAVPu7ZcgH+gt
	 86RdTLZ45ZnTw==
Date: Tue, 11 Mar 2025 19:16:46 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [PATCH] perf report: Fix a memory leak for perf_env on AMD
Message-ID: <Z9DujuhfE19eeXEj@google.com>
References: <20250311000416.817631-1-namhyung@kernel.org>
 <CAP-5=fWSU8m1eae=5GFTpVTz1CPtwv=eDmivT1v14VjT40SptA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWSU8m1eae=5GFTpVTz1CPtwv=eDmivT1v14VjT40SptA@mail.gmail.com>

On Mon, Mar 10, 2025 at 05:49:48PM -0700, Ian Rogers wrote:
> On Mon, Mar 10, 2025 at 5:04 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The env.pmu_mapping can be leaked when it reads data from a pipe on AMD.
> > For a pipe data, it reads the header data including pmu_mapping from
> > PERF_RECORD_HEADER_FEATURE runtime.  But it's already set in:
> >
> >   perf_session__new()
> >     __perf_session__new()
> >       evlist__init_trace_event_sample_raw()
> >         evlist__has_amd_ibs()
> >           perf_env__nr_pmu_mappings()
> >
> > Then it'll overwrite that when it processes the HEADER_FEATURE record.
> > Here's a report from address sanitizer.
> >
> >   Direct leak of 2689 byte(s) in 1 object(s) allocated from:
> >     #0 0x7fed8f814596 in realloc ../../../../src/libsanitizer/lsan/lsan_interceptors.cpp:98
> >     #1 0x5595a7d416b1 in strbuf_grow util/strbuf.c:64
> >     #2 0x5595a7d414ef in strbuf_init util/strbuf.c:25
> >     #3 0x5595a7d0f4b7 in perf_env__read_pmu_mappings util/env.c:362
> >     #4 0x5595a7d12ab7 in perf_env__nr_pmu_mappings util/env.c:517
> >     #5 0x5595a7d89d2f in evlist__has_amd_ibs util/amd-sample-raw.c:315
> >     #6 0x5595a7d87fb2 in evlist__init_trace_event_sample_raw util/sample-raw.c:23
> >     #7 0x5595a7d7f893 in __perf_session__new util/session.c:179
> >     #8 0x5595a7b79572 in perf_session__new util/session.h:115
> >     #9 0x5595a7b7e9dc in cmd_report builtin-report.c:1603
> >     #10 0x5595a7c019eb in run_builtin perf.c:351
> >     #11 0x5595a7c01c92 in handle_internal_command perf.c:404
> >     #12 0x5595a7c01deb in run_argv perf.c:448
> >     #13 0x5595a7c02134 in main perf.c:556
> >     #14 0x7fed85833d67 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
> >
> > Let's free the existing pmu_mapping data if any.
> 
> Can we simplify `evlist__has_amd_ibs` as there seems no reason to be
> creating/parsing strings. For example:
> ```
> bool evlist__has_amd_ibs(struct evlist *evlist)
> {
>    return perf_pmus__find("ibs_op") != NULL ||
> perf_pmus__find("ibs_fetch") != NULL;
> }
> ```

I think the idea is to find the pmu from the recorded data file not 
at runtime. 


> Similarly the variables `ibs_fetch_type` and `ibs_op_type` can be
> found with `perf_pmus__find("ibs_op")->type` and
> `perf_pmus__find("ibs_op")->type` respectively. It probably makes more
> sense to just cache access to the PMUs rather than do the finds all
> the time.
> 
> I wonder there is a problem with the pmus alternative that currently
> the pmus are global and not part of say the session, not loaded from
> the perf.data file, etc. So use on a different machine than the
> recording could be broken by what I suggest. I guess then, just
> throwing in the free is simplest.

Agreed.  It could be saved in a session or env.

For now, let's free the string to fix the leak quickly.

Thanks,
Namhyung

> 
> 
> > Cc: Ravi Bangoria <ravi.bangoria@amd.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/header.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> > index 1900965f87527948..e3cdc3b7b4ab2409 100644
> > --- a/tools/perf/util/header.c
> > +++ b/tools/perf/util/header.c
> > @@ -2770,6 +2770,8 @@ static int process_pmu_mappings(struct feat_fd *ff, void *data __maybe_unused)
> >                 free(name);
> >                 pmu_num--;
> >         }
> > +       /* AMD may set it by evlist__has_amd_ibs() from perf_session__new() */
> > +       free(ff->ph->env.pmu_mappings);
> >         ff->ph->env.pmu_mappings = strbuf_detach(&sb, NULL);
> >         return 0;
> >
> > --
> > 2.49.0.rc0.332.g42c0ae87b1-goog
> >

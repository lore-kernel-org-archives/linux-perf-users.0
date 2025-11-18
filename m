Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BE02EFD8A;
	Tue, 18 Nov 2025 06:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763448416; cv=none; b=tKQxT0G+29vKXC4f31zFl224r9npZmWNppym6bVdgVqqIemjAL3SUwq+3Luyo2UGJ2RWvvYptdn37O2gGUrty5jR0LrWWa1QnhZQw8awCpZr882ewL/R4dxAft3CfZQNXoBnoVmFOqhwNVpBb3nT1vrCt1LbOy3gAmq9+tKeRNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763448416; c=relaxed/simple;
	bh=3uh+e0l8Wi/yXJXFe1e/PROr8kIk4J7uV1tzKPwDlmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPdvecnBzEbiImdCKs9WWsyAvJcUAS+GrrW+fqh21g+KqKUDMrWf0We2WZiZ0Ust7Nbb3vakQPGQQEaO1fQLnq9CA1hScCi52DA2NFFJ++4rG6HU1Td+Dq/BvTeX2q4uF8AE43BnnoK3Hw4u1pFa4UIJrYdEfzju3Gkjj/sYvts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOHICa6X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOHICa6X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C60C4CEFB;
	Tue, 18 Nov 2025 06:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763448415;
	bh=3uh+e0l8Wi/yXJXFe1e/PROr8kIk4J7uV1tzKPwDlmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kOHICa6XAni6Zo4ghMww45gwQuurPB6WfV8i9ZxAwp5XwH1uydg+d5rpAn9ywqAZq
	 c7Jmbxgz4shXJtce4FjnRwNoD85CWxSVZMVuUfv9iHkYbjDKC3U/VuNyQ64CRfnUaz
	 JpGOVtVCE9TSRnZyszU68GZNqE0IKrMJRsdWtyHQH8C0ESQOred9LcI6iqkeSQ9tVG
	 I1IkZyS6uYcDIIz5wPHg7i5pskWXiWINIC/c4rcW6Oe7cvCYL9EQD7RKms8giUCULL
	 7+gtodMZ+IugqyNNT6W64nWQBi1YiehJRENBpVv52paRw032u72oWaglRJ5bTQ/73Q
	 A2QKH4tFxiVJw==
Date: Mon, 17 Nov 2025 22:46:51 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Yang Li <yang.lee@linux.alibaba.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [PATCH v4 09/10] perf stat: Read tool events last
Message-ID: <aRwWWz3kNc5AkwX9@google.com>
References: <20251113180517.44096-1-irogers@google.com>
 <20251113180517.44096-10-irogers@google.com>
 <aRvbZbhcsjpCXiAU@google.com>
 <CAP-5=fVidOjNDZCX6Ain83KFp0Zk8aHTJX7_KgwfTY885DuPKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVidOjNDZCX6Ain83KFp0Zk8aHTJX7_KgwfTY885DuPKg@mail.gmail.com>

On Mon, Nov 17, 2025 at 08:38:15PM -0800, Ian Rogers wrote:
> On Mon, Nov 17, 2025 at 6:35 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Thu, Nov 13, 2025 at 10:05:15AM -0800, Ian Rogers wrote:
> > > When reading a metric like memory bandwidth on multiple sockets, the
> > > additional sockets will be on CPUS > 0. Because of the affinity
> > > reading, the counters are read on CPU 0 along with the time, then the
> > > later sockets are read. This can lead to the later sockets having a
> > > bandwidth larger than is possible for the period of time. To avoid
> > > this moving the reading of tool events to occur after all other events
> > > are read.
> >
> > Can you move this change before the affinity updates?  I think it's
> > straight-forward and can be applied independently.
> 
> It is straightforward but will require changes to
> read_counters_with_affinity. I can do a v5 once I know what to do with
> the other patches.

I plan to merge patch 1 to 7 first.  And I think it'd good to have this
one as well.

Thanks,
Namhyung

> >
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/builtin-stat.c | 29 ++++++++++++++++++++++++++++-
> > >  tools/perf/util/evlist.c  |  4 ----
> > >  2 files changed, 28 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > > index 947f11b8b106..aec93b91fd11 100644
> > > --- a/tools/perf/builtin-stat.c
> > > +++ b/tools/perf/builtin-stat.c
> > > @@ -379,6 +379,9 @@ static int read_counters_with_affinity(void)
> > >               if (evsel__is_bpf(counter))
> > >                       continue;
> > >
> > > +             if (evsel__is_tool(counter))
> > > +                     continue;
> > > +
> > >               if (!counter->err)
> > >                       counter->err = read_counter_cpu(counter, evlist_cpu_itr.cpu_map_idx);
> > >       }
> > > @@ -402,6 +405,24 @@ static int read_bpf_map_counters(void)
> > >       return 0;
> > >  }
> > >
> > > +static int read_tool_counters(void)
> > > +{
> > > +     struct evsel *counter;
> > > +
> > > +     evlist__for_each_entry(evsel_list, counter) {
> > > +             int idx;
> > > +
> > > +             if (!evsel__is_tool(counter))
> > > +                     continue;
> > > +
> > > +             perf_cpu_map__for_each_idx(idx, counter->core.cpus) {
> > > +                     if (!counter->err)
> > > +                             counter->err = read_counter_cpu(counter, idx);
> > > +             }
> > > +     }
> > > +     return 0;
> > > +}
> > > +
> > >  static int read_counters(void)
> > >  {
> > >       int ret;
> > > @@ -415,7 +436,13 @@ static int read_counters(void)
> > >               return ret;
> > >
> > >       // Read non-BPF and non-tool counters next.
> > > -     return read_counters_with_affinity();
> > > +     ret = read_counters_with_affinity();
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     // Read the tool counters last. This way the duration_time counter
> > > +     // should always be greater than any other counter's enabled time.
> > > +     return read_tool_counters();
> > >  }
> > >
> > >  static void process_counters(void)
> > > diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> > > index b6df81b8a236..fc3dae7cdfca 100644
> > > --- a/tools/perf/util/evlist.c
> > > +++ b/tools/perf/util/evlist.c
> > > @@ -368,10 +368,6 @@ static bool evlist__use_affinity(struct evlist *evlist)
> > >       struct perf_cpu_map *used_cpus = NULL;
> > >       bool ret = false;
> > >
> > > -     /*
> > > -      * With perf record core.user_requested_cpus is usually NULL.
> > > -      * Use the old method to handle this for now.
> > > -      */
> > >       if (!evlist->core.user_requested_cpus ||
> > >           cpu_map__is_dummy(evlist->core.user_requested_cpus))
> > >               return false;
> > > --
> > > 2.51.2.1041.gc1ab5b90ca-goog
> > >

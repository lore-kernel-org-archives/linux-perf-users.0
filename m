Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E420D5684;
	Wed, 12 Mar 2025 01:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741744385; cv=none; b=tAQKm5q1rKfsiAuUCr7gswbs8KjgXQhwFEEH3guCwJoKSGOMtGDe5XzXy6VZ3rzLOEVXj7muBQLx7QtwA5n9NqGhxjQE9DtygOaRhKO1JnpBAP04MOGOMr5EUJtsgmrVx35hojgIgs9gBlaPBtDihpW7JgJB+Hqm6kpmlzaFCNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741744385; c=relaxed/simple;
	bh=Z/KSnIL1/o7rcKnANxR3hR3GYWa5RGA/kviggramFs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqW30ZA17y9XtOb74DRVTkmxzEETTgAYpOv0PA8qFB0WS8qjLw/GlHVWGXgM9hXGtVLOYForF3lu0QG0KZ0UAf1/M9KuV4tEt254SPxTPyXCnQbnVoksgAMpBXYmWXJz1xYwVZegJuwPXxAlKWuJXfCyn6TdL8jtF28OPxX19ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=myIRvEH5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="myIRvEH5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4897C4CEE9;
	Wed, 12 Mar 2025 01:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741744384;
	bh=Z/KSnIL1/o7rcKnANxR3hR3GYWa5RGA/kviggramFs0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=myIRvEH5NIrQb8SmfbT5FACBEQsqRYRbuU+z7hL8/0xG8C1JxYNNNVghGEomlFQVq
	 FERRXJ3aG/ro6AxnSOfGC9JRx4i40nm4vVbffnRF9i/yk6mYJZ5CI8PILW4BsrM0l/
	 qbltiI10gRz9RFqqxDIsnOVw1KDXEiTxTl001H2Gr9v+i7gNS2hKW3qgJzNw3rSF1g
	 15IxIyQZi0Qv+s+MQ26JdswdUJhYyvgmpg+m0yo2BWXSGj9lNvb287ORNvTD1dIBUo
	 CitnkkPs9foygi22qmKtCMrH3QvFijaAaccUNspYGybxdKquZTt/1CYrA4Gl1ur42/
	 +CP2AHef9Xesg==
Date: Tue, 11 Mar 2025 18:53:01 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	James Clark <james.clark@linaro.org>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Levi Yun <yeoreum.yun@arm.com>, Ze Gao <zegao2021@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: Re: [PATCH v2 11/11] perf python tracepoint: Switch to using
 parse_events
Message-ID: <Z9Do_ZSHuuZde4eZ@google.com>
References: <20250228222308.626803-1-irogers@google.com>
 <20250228222308.626803-12-irogers@google.com>
 <Z89k6lWxRSBfCGvM@google.com>
 <CAP-5=fUV5yt4c-PrvTFqW6ehuudwkqdO7QuQpvbUBDm6aT6+dQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUV5yt4c-PrvTFqW6ehuudwkqdO7QuQpvbUBDm6aT6+dQ@mail.gmail.com>

On Mon, Mar 10, 2025 at 04:40:36PM -0700, Ian Rogers wrote:
> On Mon, Mar 10, 2025 at 3:17 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Fri, Feb 28, 2025 at 02:23:08PM -0800, Ian Rogers wrote:
> > > Rather than manually configuring an evsel, switch to using
> > > parse_events for greater commonality with the rest of the perf code.
> > >
> > > Reviewed-by: Howard Chu <howardchu95@gmail.com>
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/python/tracepoint.py | 23 +++++++++++------------
> > >  1 file changed, 11 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/tools/perf/python/tracepoint.py b/tools/perf/python/tracepoint.py
> > > index bba68a6d4515..38b2b6d11f64 100755
> > > --- a/tools/perf/python/tracepoint.py
> > > +++ b/tools/perf/python/tracepoint.py
> > > @@ -5,24 +5,23 @@
> > >
> > >  import perf
> > >
> > > -class tracepoint(perf.evsel):
> > > -    def __init__(self, sys, name):
> > > -        config = perf.tracepoint(sys, name)
> > > -        perf.evsel.__init__(self,
> > > -                            type   = perf.TYPE_TRACEPOINT,
> > > -                            config = config,
> > > -                            freq = 0, sample_period = 1, wakeup_events = 1,
> > > -                            sample_type = perf.SAMPLE_PERIOD | perf.SAMPLE_TID | perf.SAMPLE_CPU | perf.SAMPLE_RAW | perf.SAMPLE_TIME)
> > > -
> > >  def main():
> > > -    tp      = tracepoint("sched", "sched_switch")
> > >      cpus    = perf.cpu_map()
> > >      threads = perf.thread_map(-1)
> > > +    evlist = perf.parse_events("sched:sched_switch", cpus, threads)
> > > +    # Disable tracking of mmaps and similar that are unnecessary.
> > > +    for ev in evlist:
> > > +        ev.tracking = False
> > > +    # Configure evsels with default record options.
> > > +    evlist.config()
> >
> > I think the default option uses frequency of 4000 but tracepoints want
> > to use period of 1.  Also I'm not sure if it sets the proper sample type
> > bits namely PERF_SAMPLE_RAW.
> 
> I used trace to ensure they matched. Fwiw, the sample_period for a
> tracepoint is set to 1 in evsel__newtp_idx:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/evsel.c?h=perf-tools-next#n621
> and the evsel__config won't overwrite an already set sample_period:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/evsel.c?h=perf-tools-next#n1341

Ok, it only sets the default value and it will use the attr from
evsel__newtp_idx().  Thanks for checking this.

Thanks,
Namhyung

> >
> >
> > > +    # Simplify the sample_type and read_format of evsels
> > > +    for ev in evlist:
> > > +        ev.sample_type = ev.sample_type & ~perf.SAMPLE_IP
> > > +        ev.read_format = 0
> > >
> > > -    evlist = perf.evlist(cpus, threads)
> > > -    evlist.add(tp)
> > >      evlist.open()
> > >      evlist.mmap()
> > > +    evlist.enable();
> > >
> > >      while True:
> > >          evlist.poll(timeout = -1)
> > > --
> > > 2.48.1.711.g2feabab25a-goog
> > >

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDAD2F12C5;
	Tue, 18 Nov 2025 06:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763448623; cv=none; b=fWkWO5VHN7cexJNMA6sNt+2gsnPpkTRZsJxIPzzfaeKyMxK+JgY1rcRPfQAnDJXzCdQwjJJemi4YP6vt7uuYRQKefL8PA0eI78+WGOTIL8pQ7+kwnreoCZLaA+f673AQsKEoJiU/6Ez4XKuIvbnQEJASL/S6QgRl5HidslAyTkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763448623; c=relaxed/simple;
	bh=4YAcPvN5qtxecpZh9fXUCDPoMyUxrfJ0Xdtikv3lwpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4tXDQPUw6FnGop2PG3sFuWac4HzZY8OmnXLI/VPjH2lQwOxMQ2CbTXbffhvIS59BtSmNquE+pBfAHU8TPtyxE53jces10/cEzZJCpVpZbAazKGlSPD+CwO7ldlaaLTA4+iYu8b9K6Tf1mUUNOxqdkojGNtLiCwEHfwBBnTZ6Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rXPproFn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rXPproFn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3024CC4CEF1;
	Tue, 18 Nov 2025 06:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763448621;
	bh=4YAcPvN5qtxecpZh9fXUCDPoMyUxrfJ0Xdtikv3lwpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rXPproFn9wD3gF/Xo1VaasNNW1A1NW4Xi0G79IFCs2h5QV8OgidYFJtZZDYZhdgba
	 /Hz8rBnfSsz2TNwSfvK2rPQGwT0XCE4vkykh9YbMt0Q9PbCNxxUuWMlVUbLTjD1pzg
	 nfYgvRScz95mGWatPUbHmjYMEEFom1ypOKpDg7WaoWem0Kjsz8bbLcUzTlzPaEMlYL
	 NP57Q2gpav0V6G+Jvu8NuzPQY2DQp8uYgoIthuDdn5xYml8AdSX1/Jar1cPO91PNlO
	 8raSQxoox9l9fbUlyM1cXmTX/+7Vh0G4iRnV+j/HzNd/wlMKIY2QImYeZ+PhXc2a0C
	 3o8nGN+aXXKzw==
Date: Mon, 17 Nov 2025 22:50:18 -0800
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
Subject: Re: [PATCH v4 10/10] perf stat: Add no-affinity flag
Message-ID: <aRwXKgv7iUjfvny_@google.com>
References: <20251113180517.44096-1-irogers@google.com>
 <20251113180517.44096-11-irogers@google.com>
 <aRvcuMfbDRSBU87k@google.com>
 <CAP-5=fUF_GQKiBoKVx-z5SUZsmHdqhxzdD39iH9O=53xg2EuHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUF_GQKiBoKVx-z5SUZsmHdqhxzdD39iH9O=53xg2EuHQ@mail.gmail.com>

On Mon, Nov 17, 2025 at 08:32:20PM -0800, Ian Rogers wrote:
> On Mon, Nov 17, 2025 at 6:41 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Thu, Nov 13, 2025 at 10:05:16AM -0800, Ian Rogers wrote:
> > > Add flag that disables affinity behavior. Using sched_setaffinity to
> > > place a perf thread on a CPU can avoid certain interprocessor
> > > interrupts but may introduce a delay due to the scheduling,
> > > particularly on loaded machines. Add a command line option to disable
> > > the behavior. This behavior is less present in other tools like `perf
> > > record`, as it uses a ring buffer and doesn't make repeated system
> > > calls.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/Documentation/perf-stat.txt | 4 ++++
> > >  tools/perf/builtin-stat.c              | 6 ++++++
> > >  tools/perf/util/evlist.c               | 2 +-
> > >  tools/perf/util/evlist.h               | 1 +
> > >  4 files changed, 12 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
> > > index 1a766d4a2233..1ffb510606af 100644
> > > --- a/tools/perf/Documentation/perf-stat.txt
> > > +++ b/tools/perf/Documentation/perf-stat.txt
> > > @@ -382,6 +382,10 @@ color the metric's computed value.
> > >  Don't print output, warnings or messages. This is useful with perf stat
> > >  record below to only write data to the perf.data file.
> > >
> > > +--no-affinity::
> > > +Don't change scheduler affinities when iterating over CPUs. Disables
> > > +an optimization aimed at minimizing interprocessor interrupts.
> > > +
> > >  STAT RECORD
> > >  -----------
> > >  Stores stat data into perf data file.
> > > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > > index aec93b91fd11..fa42b08bd1df 100644
> > > --- a/tools/perf/builtin-stat.c
> > > +++ b/tools/perf/builtin-stat.c
> > > @@ -2415,6 +2415,7 @@ static int parse_tpebs_mode(const struct option *opt, const char *str,
> > >  int cmd_stat(int argc, const char **argv)
> > >  {
> > >       struct opt_aggr_mode opt_mode = {};
> > > +     bool no_affinity = false;
> > >       struct option stat_options[] = {
> > >               OPT_BOOLEAN('T', "transaction", &transaction_run,
> > >                       "hardware transaction statistics"),
> > > @@ -2543,6 +2544,8 @@ int cmd_stat(int argc, const char **argv)
> > >                       "don't print 'summary' for CSV summary output"),
> > >               OPT_BOOLEAN(0, "quiet", &quiet,
> > >                       "don't print any output, messages or warnings (useful with record)"),
> > > +             OPT_BOOLEAN(0, "no-affinity", &no_affinity,
> > > +                     "don't allow affinity optimizations aimed at reducing IPIs"),
> >
> > I know you want to add an option to disable the behaivor, but I think
> > it'd better to have a positive option like just '--affinity'.  Then we
> > will have '--no-affinity' for free. :)  The current form will allow
> > '--no-no-affinity'.
> >
> > Then the variable also can be 'enable_affinity' or so.
> >
> > You can mention --no-affinity in the help message and the man page
> > document so that users can discover the intention.
> 
> I was trying to keep the code the same as the flag. I don't want to
> have an affinity flag you need to set to true in say evlist, as that
> will need updating in all users of the evlist or become a behavioral
> change. We can have the evlist with no_affinity and invert the flag,
> it just looks awkward imo.

You can make the default to true and just update the users that want
different behaviors.

Thanks,
Namhyung


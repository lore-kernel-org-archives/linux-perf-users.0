Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C9313F43B;
	Mon, 24 Feb 2025 20:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740428305; cv=none; b=tOowTLS0mleXH8qxJvx2T5BBPelShDRJg8rXA4HE7GoBQIX3QG8XCSKkcMU8BaGHHFMpWBY/2Y3asfC5aQjzwzaM6gUjgMVnnC/OJ8qU2jFaCFXnZvUeD/8+Mc0iMsXb9KW9ZNXs92q5yVRGMk5KSot0H08eseXBefbw7eJ/fSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740428305; c=relaxed/simple;
	bh=1g9xLASHldpx7dH0s9gFHvkfuWIB1BBA0agbRxDRicE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+bvlGaFwrO4p1Wiw+bB8zLFDy0yC7cMbU8vHPVDKxda2hdw251zROQcRDBvUTfHojsgiVTKwVStMfR/lIteBzY5MZrXYBlvjqUbJAB534s4BQMVZlyUAh9Q7C0Z29rXaso2pQ6QRezodhkRY9G5YqonWuja5QJsHdZL/Emi92k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YiZuQPDU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YiZuQPDU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A54C4CED6;
	Mon, 24 Feb 2025 20:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740428305;
	bh=1g9xLASHldpx7dH0s9gFHvkfuWIB1BBA0agbRxDRicE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YiZuQPDULbpoaBAA/GVXAGVb90WdBtfdP1Krzb1RNuHqDF/K0uWTJKhWt6gM0qAak
	 JbFGoSTGty1/vPO8jblG9QkYgAZxiV+lBZucxirh50vhOcMTWxV8bMvA1toLILtOjf
	 8RsR8e6vjyymUyQbLTc9XZ7fFBFlMa+nyG0LQtfFWDyF0Iki6y6usQAjWASLHblcfa
	 V973X6f0OFZNDuLe9y68dM1GS99eCMC1kT1qksD88bRuzhgSzyadyPRHOatpzdYwQ+
	 69SA4Br0uO1MnycWL678Q4omDrEhJSwhhv5FLqCspVR2sdrMV1XnInN+vve8OD9LWR
	 +8l8jYCePFhRQ==
Date: Mon, 24 Feb 2025 12:18:23 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/2] perf stat: Use field separator in the metric header
Message-ID: <Z7zUDxho5vLa_2fF@google.com>
References: <20240627200353.1230407-1-namhyung@kernel.org>
 <CAP-5=fWSpM7NL7UjXZBN8WHNAE7hGe1ghQ6_DqFe2VjTCGoA7A@mail.gmail.com>
 <CAM9d7cibrW=K=GZB_zsURB1Ff6Eok7qy3rVt83VVM6pVhv+Agg@mail.gmail.com>
 <CAP-5=fVmybd=WTKS3kvsF+VU_Lrke9hEvNyBtunAHBw-6ViZig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVmybd=WTKS3kvsF+VU_Lrke9hEvNyBtunAHBw-6ViZig@mail.gmail.com>

On Mon, Feb 24, 2025 at 10:50:24AM -0800, Ian Rogers wrote:
> On Thu, Jun 27, 2024 at 3:24 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi Ian,
> >
> > On Thu, Jun 27, 2024 at 1:48 PM Ian Rogers <irogers@google.com> wrote:
> > >
> > > On Thu, Jun 27, 2024 at 1:03 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > It didn't use the passed field separator (using -x option) when it
> > > > prints the metric headers and always put "," between the fields.
> > > >
> > > > Before:
> > > >   $ sudo ./perf stat -a -x : --per-core -M tma_core_bound --metric-only true
> > > >   core,cpus,%  tma_core_bound:     <<<--- here: "core,cpus," but ":" expected
> > > >   S0-D0-C0:2:10.5:
> > > >   S0-D0-C1:2:14.8:
> > > >   S0-D0-C2:2:9.9:
> > > >   S0-D0-C3:2:13.2:
> > > >
> > > > After:
> > > >   $ sudo ./perf stat -a -x : --per-core -M tma_core_bound --metric-only true
> > > >   core:cpus:%  tma_core_bound:
> > > >   S0-D0-C0:2:10.5:
> > > >   S0-D0-C1:2:15.0:
> > > >   S0-D0-C2:2:16.5:
> > > >   S0-D0-C3:2:12.5:
> > > >
> > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > ---
> > > >  tools/perf/util/stat-display.c | 37 ++++++++++++++++++++++++++--------
> > > >  1 file changed, 29 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> > > > index 91d2f7f65df7..e8673c9f6b49 100644
> > > > --- a/tools/perf/util/stat-display.c
> > > > +++ b/tools/perf/util/stat-display.c
> > > > @@ -47,16 +47,27 @@ static int aggr_header_lens[] = {
> > > >  };
> > > >
> > > >  static const char *aggr_header_csv[] = {
> > > > -       [AGGR_CORE]     =       "core,cpus,",
> > > > -       [AGGR_CACHE]    =       "cache,cpus,",
> > > > -       [AGGR_DIE]      =       "die,cpus,",
> > > > -       [AGGR_SOCKET]   =       "socket,cpus,",
> > > > -       [AGGR_NONE]     =       "cpu,",
> > > > -       [AGGR_THREAD]   =       "comm-pid,",
> > > > -       [AGGR_NODE]     =       "node,",
> > > > +       [AGGR_CORE]     =       "core%scpus%s",
> > > > +       [AGGR_CACHE]    =       "cache%scpus%s",
> > > > +       [AGGR_DIE]      =       "die%scpus%s",
> > > > +       [AGGR_SOCKET]   =       "socket%scpus%s",
> > > > +       [AGGR_NONE]     =       "cpu%s",
> > > > +       [AGGR_THREAD]   =       "comm-pid%s",
> > > > +       [AGGR_NODE]     =       "node%s",
> > > >         [AGGR_GLOBAL]   =       ""
> > > >  };
> > > >
> > > > +static int aggr_header_num[] = {
> > > > +       [AGGR_CORE]     =       2,
> > > > +       [AGGR_CACHE]    =       2,
> > > > +       [AGGR_DIE]      =       2,
> > > > +       [AGGR_SOCKET]   =       2,
> > > > +       [AGGR_NONE]     =       1,
> > > > +       [AGGR_THREAD]   =       1,
> > > > +       [AGGR_NODE]     =       1,
> > > > +       [AGGR_GLOBAL]   =       0,
> > > > +};
> > > > +
> > > >  static const char *aggr_header_std[] = {
> > > >         [AGGR_CORE]     =       "core",
> > > >         [AGGR_CACHE]    =       "cache",
> > > > @@ -1185,8 +1196,18 @@ static void print_metric_headers_csv(struct perf_stat_config *config,
> > > >  {
> > > >         if (config->interval)
> > > >                 fputs("time,", config->output);
> > > > -       if (!config->iostat_run)
> > > > +       if (config->iostat_run)
> > > > +               return;
> > > > +
> > >
> > > Having a static count of commas seems somewhat error prone, perhaps:
> > > ```
> > > const char *header = aggr_header_csv[config->aggr_mode];
> > > if (config->csv_sep == ',' || !strchr(header, ',')) {
> > >   fputs(config->output, header);
> > > } else {
> > >   char *tmp = strdup(header);
> > >   char *p = tmp;
> > >    while (p && *p) {
> > >       if (p == ',')
> > >         *p = config->csv_sep;
> > >      p++;
> > >    }
> > >   fputs(config->output, tmp);
> > >   free(tmp);
> > > }
> > > ```
> >
> > Looks good.  But I think we should handle longer separators like -x ":::".
> > Will do in v2.
> 
> Hi Namhyung,
> 
> It looks like this has been forgotten. Did you have a v2?

It's merged to v6.11, please see

https://lore.kernel.org/linux-perf-users/171994580797.2905908.17252651084023923233.b4-ty@kernel.org/

Thanks,
Namhyung


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF98B663;
	Thu, 10 Oct 2024 00:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728521980; cv=none; b=hQkyI4PIM1XQkHm/PZ/sCprZE6pazOKyXWeSvjMLTxFBqhC8pNv0Li165Gmgk3K8+TYSEMgpeJphTAsD7lOQBGHQDZRCEELMkWCuG7rhAsMkK9CbiruR5wVqyyrtkBuWBjI9bLWqGRF5zeiV6SxI+qVup11oQihi7VsAFnzeoDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728521980; c=relaxed/simple;
	bh=5HiOaXway9j6RVOALfB8fIBHanllp481Y52QUV0BwtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTGIqrJXAI63W+pfiJQ8eSQ9NjaSqdYcLSziCJZ7YqV4hW5TuHpOR0bbu5SLyUZ6dt3KMCut2yv0j/b9GyElFdVgrcLwj0HbvcezR/HSb9tBdp5cPg5muIQG8BUdHn4AQuBYpW95FvZQ/mHaIDnMkPkp6tw6ORVY2t5Tjl+IvDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejarvUAe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejarvUAe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DDE6C4CEC3;
	Thu, 10 Oct 2024 00:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728521979;
	bh=5HiOaXway9j6RVOALfB8fIBHanllp481Y52QUV0BwtA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ejarvUAeXnQLS3FvsEfTDcnXnigYg+tD/8DoaQ5nTIe7tfwitRB7CC08TEGs4a4vc
	 8+Kbi7tkzxoCLdE6SMx0H4uGVCtz0Ezz7zmJzafFrVtbAjOaN447CFOgW5Ar9q8Orv
	 4FGUx0B0if0ARNUK1m0TYs+EmbPwe8e9KP8Sirp7xr675uCddM38LwZsLiL1GsSRWg
	 v0AlteLl6S1R05UBlmf7uGKhDFrMsfLYIisCaBT5nqM8vE9v1eF4f/K1yemAzMsZK0
	 5q3lCWMpSj7gEwnWZx3tfzzStrRAvHjv0fPE/y5gPXQAlf6Ceuuu/jefYdR2Y6ktND
	 5n6Pp5p60ME0Q==
Date: Wed, 9 Oct 2024 17:59:37 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/8] CSV/JSON metric thresholds, fix printf modifiers
Message-ID: <Zwcm-SHp6BcVCfPb@google.com>
References: <20241004234120.1495209-1-irogers@google.com>
 <ZwW2m5D2cnIabE_z@google.com>
 <CAP-5=fV80pNi=jh48uq+99pSHV9aeE1X7LvDi=bY9sGQ0JVwkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fV80pNi=jh48uq+99pSHV9aeE1X7LvDi=bY9sGQ0JVwkg@mail.gmail.com>

On Tue, Oct 08, 2024 at 04:40:19PM -0700, Ian Rogers wrote:
> On Tue, Oct 8, 2024 at 3:47 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi Ian,
> >
> > On Fri, Oct 04, 2024 at 04:41:12PM -0700, Ian Rogers wrote:
> > > Metric thresholds are being computed for CSV and JSON output but not
> > > displayed. Rename the color that encodes the threshold as enum values
> > > and use to generate string constants in a CSV column or json
> > > dictionary value.
> >
> > IIUC it'd show "good" or "bad" when the metric defines a threshold and
> > show "good", "less good", "nearly bad" or "bad" for the legacy shadow
> > stats?  Anyway it's nice to show if the value is good or not.
> 
> Correct. I'm open to suggestions for the names. The alternative to
> showing the metric thresholds would be to drop them for CSV and JSON
> output, which would reduce the number of events. With this approach
> the thresholds can still be dropped with --metric-no-threshold.

Ok, I don't have better idea for the naming.

Thanks,
Namhyung

> 
> > >
> > > Add printf attribute to functions in color.h that could support
> > > it. Fix bad printf format strings that this detected.
> > >
> > > Ian Rogers (8):
> > >   perf color: Add printf format checking and resolve issues
> > >   perf stat: Fix/add parameter names for print_metric
> > >   perf stat: Display "none" for NaN with metric only json
> > >   perf stat: Drop metric-unit if unit is NULL
> > >   perf stat: Change color to threshold in print_metric
> > >   perf stat: Display metric threshold value in CSV output
> > >   perf stat: Add metric-threshold to json output
> > >   perf stat: Disable metric thresholds for CSV/JSON metric-only mode
> >
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
> >
> > Thanks,
> > Namhyung
> >
> > >
> > >  tools/perf/Documentation/perf-stat.txt        |   1 +
> > >  tools/perf/arch/x86/util/iostat.c             |   2 +-
> > >  tools/perf/builtin-sched.c                    |   2 +-
> > >  tools/perf/builtin-script.c                   |   6 +-
> > >  tools/perf/builtin-stat.c                     |   8 ++
> > >  tools/perf/builtin-trace.c                    |   2 +-
> > >  .../tests/shell/lib/perf_json_output_lint.py  |   5 +-
> > >  tools/perf/tests/shell/stat+csv_output.sh     |  24 ++--
> > >  tools/perf/util/arm-spe.c                     |   2 +-
> > >  tools/perf/util/color.h                       |   9 +-
> > >  tools/perf/util/intel-bts.c                   |   2 +-
> > >  tools/perf/util/intel-pt.c                    |   2 +-
> > >  tools/perf/util/s390-cpumsf.c                 |   2 +-
> > >  tools/perf/util/s390-sample-raw.c             |   6 +-
> > >  tools/perf/util/stat-display.c                |  85 +++++++++---
> > >  tools/perf/util/stat-shadow.c                 | 128 ++++++++++--------
> > >  tools/perf/util/stat.h                        |  16 ++-
> > >  17 files changed, 191 insertions(+), 111 deletions(-)
> > >
> > > --
> > > 2.47.0.rc0.187.ge670bccf7e-goog
> > >

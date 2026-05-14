Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1365639891C;
	Thu, 14 May 2026 23:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778802915; cv=none; b=tgr7d3gYV47dNVTQghezf2nZkhVSRToJkStWCsKIm/u9cJsMuWG52nU+e+Dbg4RhDd7HzgF4yc78bAjWa1LJbHdmv+v2sO5b7Y/kpTbv9LefXmvmmKqhHJVV/wOD0Yt0O1OFIbcNH6u02+IWfRm0wYpwJqln6nO04E9zccSGBso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778802915; c=relaxed/simple;
	bh=/M7Nn4exc7ZqqMS41ZPzksWkiF5DmBL+ydCNX/0zWGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGUSgn+zJw1HRUqe5nrUpg5kBUlgOak0MBAGRJ7hX0kjyyCn3QBucPXNTqluw2qukdVFF7Q3k9vDGfKr0gSsqoHZDQt0XQFCQz1kdX+V8QcHTQDyrNt7eN65CtS2QNAtBBz3SlQtJpz2gAy67C8KDawl4/mKcZ6fBf4DHS0aBQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGkrchUV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGkrchUV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D9D7C2BCB3;
	Thu, 14 May 2026 23:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778802914;
	bh=/M7Nn4exc7ZqqMS41ZPzksWkiF5DmBL+ydCNX/0zWGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fGkrchUVkd3kW97wsbNl+n1niXBNzup4WCt9VaJH1RdF9fjjUNGTJRBMPM7+Q4h1h
	 mB0AyEgrB3uTYrko2BNc4MRwJHiWeVSN/TApICiAsBQ1E9Mg3QEW78GyxtIjkPrup4
	 a2OKcB2Q50lMpHRri9HSTirRMlxvlOc8FMHaO5GfeMV37gcc57BSlbIXgmVPnOXlkd
	 I/NfMOQUVklQovcqQNBsoMFlkm1C9LCw7O3MI+mD/0dBp67bCFp9d3X0MjKfXKs6qT
	 mTVSV6XYilPR438yK9QSeVNtDjhLJlmq9tVt+Ji/Z2MZdk+T3X3SedEobC2jN15a6u
	 QqkR+yxtaDXwQ==
Date: Thu, 14 May 2026 20:55:11 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Sandipan Das <sandipan.das@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf pmu-events AMD: Switch l2_itlb_misses to
 bp_l1_tlb_miss_l2_tlb_miss.all
Message-ID: <agZg3xXkkpK089T5@x1>
References: <20260414175855.2089482-1-irogers@google.com>
 <a33a42ae-253b-41ce-8a2d-9d9ae58372d2@amd.com>
 <CAP-5=fUMC-vWFvt3S0aNCqqSB=ka1FisUgRbJwBhoBKMYt_-nw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUMC-vWFvt3S0aNCqqSB=ka1FisUgRbJwBhoBKMYt_-nw@mail.gmail.com>

On Thu, May 14, 2026 at 10:48:23AM -0700, Ian Rogers wrote:
> On Tue, Apr 14, 2026 at 11:03 PM Sandipan Das <sandipan.das@amd.com> wrote:
> >
> > On 14-04-2026 23:28, Ian Rogers wrote:
> > > l2_itlb_misses is a valid legacy cache event name, hence allowing it
> > > in all_events in metric.py. l2_itlb_misses was also a json event for
> > > AMD zen1, zen2 and zen3. For zen4, zen5 and zen6 the checking that
> > > metric events are within the json was skipping l2_itlb_misses as it is
> > > a valid legacy event, however, the PMU driver lacks the event mapping
> > > causing it to be a bad event when used in the metric. Add
> > > bp_l1_tlb_miss_l2_tlb_miss.all as the l2 itlb miss event (bp = branch
> > > predictor, the AMD way to say itlb), so that is used in preference to
> > > l2_itlb_misses when the event exists. Remove l2_itlb_misses from
> > > metric.py as the legacy event isn't used by any metrics and having it
> > > is error prone for newer AMD zen models.
> > >
> > > Fixes: e596f329668e ("perf jevents: Add itlb metric group for AMD")
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/pmu-events/amd_metrics.py | 2 +-
> > >  tools/perf/pmu-events/metric.py      | 1 -
> > >  2 files changed, 1 insertion(+), 2 deletions(-)
> > >
> > > diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
> > > index 63e5098606c4..ee5381646a8d 100755
> > > --- a/tools/perf/pmu-events/amd_metrics.py
> > > +++ b/tools/perf/pmu-events/amd_metrics.py
> > > @@ -287,7 +287,7 @@ def AmdDtlb() -> Optional[MetricGroup]:
> > >  def AmdItlb():
> > >      global _zen_model
> > >      l2h = Event("bp_l1_tlb_miss_l2_tlb_hit", "bp_l1_tlb_miss_l2_hit")
> > > -    l2m = Event("l2_itlb_misses")
> > > +    l2m = Event("bp_l1_tlb_miss_l2_tlb_miss.all", "l2_itlb_misses",)
> > >      l2r = l2h + l2m
> > >
> > >      itlb_l1_mg = None
> > > diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
> > > index 0c41a502cf21..c1931b2a5170 100644
> > > --- a/tools/perf/pmu-events/metric.py
> > > +++ b/tools/perf/pmu-events/metric.py
> > > @@ -25,7 +25,6 @@ def LoadEvents(directory: str) -> None:
> > >        "cycles",
> > >        "duration_time",
> > >        "instructions",
> > > -      "l2_itlb_misses",
> > >    }
> > >    for file in os.listdir(os.fsencode(directory)):
> > >      filename = os.fsdecode(file)
> >
> > Reviewed-by: Sandipan Das <sandipan.das@amd.com>
> 
> Ping.

Thanks, applied to perf-tools-next, for v7.2.

- Arnaldo

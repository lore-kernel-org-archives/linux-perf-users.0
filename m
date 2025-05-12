Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E66224FBFF;
	Mon, 12 May 2025 16:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747068058; cv=none; b=GOUvFf+fzqQIFIblAG8PhfkF7qPqkFxfEOUeojhUSVN570vtKkXiDpd+Cw3pprt8qOua+LCEfZQcbkkCbmegiaL+MHBJ6B1M1vWzTRGcg/NO+zD+ynWNTPQa9RN101PHKrCy08WI0Asy1hSHE9bGh+InJ66iyVggk/YPV42QAUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747068058; c=relaxed/simple;
	bh=Lk3Qyi2Jh3RaX5DGTgnwgbgZSVy/HqI9XT5UMipzj5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4Br3H/PGoe0lu07lcAAQAbwcv5czYviMd+u1dPSGbHoN3OEOwhOvBUm8pLb/HjGj10UcdcNwiQB1vKWHCQ28NAkcyS/b/ePLoGDinhi5mVbsCG6yeZHWYhpYSRx9zR6rpyGKf3G/NmwctzZo/Evlju+q2xs9o85EZAN5ktzK28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GIccRPeW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIccRPeW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA6FC4CEE7;
	Mon, 12 May 2025 16:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747068058;
	bh=Lk3Qyi2Jh3RaX5DGTgnwgbgZSVy/HqI9XT5UMipzj5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GIccRPeWg0aFmGv36OjxR1Je8Xz8005GkV1MiRXcGRuacClhZ8za4rZNegZ1aGjdT
	 hckPEeZ/ho7aaj7+BGNKvJuOYOTtARvQxHHDzxvixrVcu1ur/6Fcqi7pmHu4nmvK3x
	 rC0tzGnpgkHE760j/6wbmwN3xLjh+c/YiWRXg6mY23Q0zpzjTytzfAxquohonCkS5s
	 RR26/9PnlyEO3gXW/0shIRGJZbeHTiwjSccyXsgwp+hfke6xq2k3W+h7W3bGC664g1
	 LJ/7Z2ul3dnMS+EGx9ZCPLkGEIvSHOIuwfdSBEx7pLk6orvVQgHU/7+Gb4Lt8BCIJl
	 oU1EFzL6o4rlA==
Date: Mon, 12 May 2025 13:40:55 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>,
	John Garry <john.g.garry@oracle.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Weilin Wang <weilin.wang@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] Metric related performance improvements
Message-ID: <aCIkl8Skof--Of99@x1>
References: <20250410044532.52017-1-irogers@google.com>
 <Z_dp7E2wtSek-KHo@z2>
 <CAP-5=fU6NM4LZWt9SdTFX9JKTgfghwAVvtXc-qBuUb0vpUeTQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU6NM4LZWt9SdTFX9JKTgfghwAVvtXc-qBuUb0vpUeTQA@mail.gmail.com>

On Wed, Apr 23, 2025 at 01:48:22PM -0700, Ian Rogers wrote:
> On Wed, Apr 9, 2025 at 11:49 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi Ian,
> >
> > On Wed, Apr 09, 2025 at 09:45:29PM -0700, Ian Rogers wrote:
> > > The "PMU JSON event tests" have been running slowly, these changes
> > > target improving them with an improvement of the test running 8 to 10
> > > times faster.
> > >
> > > The first patch changes from searching through all aliases by name in
> > > a list to using a hashmap. Doing a fast hashmap__find means testing
> > > for having an event needn't load from disk if an event is already
> > > present.
> > >
> > > The second patch switch the fncache to use a hashmap rather than its
> > > own hashmap with a limited number of buckets. When there are many
> > > filename queries, such as with a test, there are many collisions with
> > > the previous fncache approach leading to linear searching of the
> > > entries.
> > >
> > > The final patch adds a find function for metrics. Normally metrics can
> > > match by name and group, however, only name matching happens when one
> > > metric refers to another. As we test every "id" in a metric to see if
> > > it is a metric, the find function can dominate performance as it
> > > linearly searches all metrics. Add a find function for the metrics
> > > table so that a metric can be found by name with a binary search.
> > >
> > > Before these changes:
> > > ```
> > > $ time perf test -v 10
> > >  10: PMU JSON event tests                                            :
> > >  10.1: PMU event table sanity                                        : Ok
> > >  10.2: PMU event map aliases                                         : Ok
> > >  10.3: Parsing of PMU event table metrics                            : Ok
> > >  10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
> > >  10.5: Parsing of metric thresholds with fake PMUs                   : Ok
> > >
> > > real    0m18.499s
> > > user    0m18.150s
> > > sys     0m3.273s
> > > ```
> > >
> > > After these changes:
> > > ```
> > > $ time perf test -v 10
> > >  10: PMU JSON event tests                                            :
> > >  10.1: PMU event table sanity                                        : Ok
> > >  10.2: PMU event map aliases                                         : Ok
> > >  10.3: Parsing of PMU event table metrics                            : Ok
> > >  10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
> > >  10.5: Parsing of metric thresholds with fake PMUs                   : Ok
> > >
> > > real    0m2.338s
> > > user    0m1.797s
> > > sys     0m2.186s
> > > ```
> >
> > Great, I also see the speedup on my machine from 32s to 3s.
> >
> > Tested-by: Namhyung Kim <namhyung@kernel.org>
> 
> Ping.

I'll try to fix up it later, if you don't beat me to it, will continue
with the other patches you listed to get the ones that applies merged:

Total patches: 3
---
Cover: ./20250409_irogers_metric_related_performance_improvements.cover
 Link: https://lore.kernel.org/r/20250410044532.52017-1-irogers@google.com
 Base: not specified
       git am ./20250409_irogers_metric_related_performance_improvements.mbx
⬢ [acme@toolbx perf-tools-next]$        git am ./20250409_irogers_metric_related_performance_improvements.mbx
Applying: perf pmu: Change aliases from list to hashmap
error: patch failed: tools/perf/util/pmu.c:532
error: tools/perf/util/pmu.c: patch does not apply
Patch failed at 0001 perf pmu: Change aliases from list to hashmap
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"
⬢ [acme@toolbx perf-tools-next]$ 
⬢ [acme@toolbx perf-tools-next]$ git am --abort
⬢ [acme@toolbx perf-tools-next]$ patch -p1 < ./20250409_irogers_metric_related_performance_improvements.mbx
patching file tools/perf/tests/pmu-events.c
patching file tools/perf/util/hwmon_pmu.c
patching file tools/perf/util/pmu.c
Hunk #3 succeeded at 417 (offset 11 lines).
Hunk #4 succeeded at 451 (offset 11 lines).
Hunk #5 FAILED at 541.
Hunk #6 succeeded at 657 (offset 41 lines).
Hunk #7 succeeded at 1146 (offset 41 lines).
Hunk #8 succeeded at 1238 (offset 41 lines).
Hunk #9 succeeded at 1259 (offset 41 lines).
Hunk #10 succeeded at 2018 (offset 48 lines).
Hunk #11 succeeded at 2033 (offset 48 lines).
Hunk #12 succeeded at 2502 (offset 59 lines).
Hunk #13 succeeded at 2522 (offset 59 lines).
1 out of 13 hunks FAILED -- saving rejects to file tools/perf/util/pmu.c.rej
patching file tools/perf/util/pmu.h
Hunk #3 succeeded at 295 (offset 5 lines).
patching file tools/perf/util/tool_pmu.c
Hunk #1 succeeded at 502 (offset 6 lines).
patching file tools/perf/util/fncache.c
patching file tools/perf/util/fncache.h
patching file tools/perf/util/srccode.c
patching file tools/perf/builtin-stat.c
Hunk #1 succeeded at 1854 (offset -2 lines).
Hunk #2 succeeded at 1888 (offset -2 lines).
Hunk #3 succeeded at 1978 (offset -2 lines).
patching file tools/perf/pmu-events/empty-pmu-events.c
Hunk #1 succeeded at 449 (offset 6 lines).
Hunk #2 succeeded at 495 (offset 6 lines).
Hunk #3 succeeded at 552 (offset 6 lines).
patching file tools/perf/pmu-events/jevents.py
Hunk #1 succeeded at 972 (offset 6 lines).
Hunk #2 succeeded at 1018 (offset 6 lines).
Hunk #3 succeeded at 1075 (offset 6 lines).
patching file tools/perf/pmu-events/pmu-events.h
Hunk #1 succeeded at 74 (offset 3 lines).
Hunk #2 succeeded at 89 (offset 3 lines).
Hunk #3 succeeded at 105 (offset 3 lines).
patching file tools/perf/util/metricgroup.c
patching file tools/perf/util/metricgroup.h
⬢ [acme@toolbx perf-tools-next]$

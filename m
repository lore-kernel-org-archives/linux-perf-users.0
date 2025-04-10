Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA08E2046A4;
	Thu, 10 Apr 2025 06:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744267758; cv=none; b=usHig9c0HaVkzKtJiIOVicOjt30kiismR7fmuc42s2rH950QUPXj5hhVFUKV3exbwysBcQmIplAr+3WGE8FpG7m7T9H7GovAWuRfpiNfaJllkHICEWgtB7CMdbTekkv3mXZ51dpLfwknOmOUyZVfBjQWuzLoxpgCGYFguDoOzME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744267758; c=relaxed/simple;
	bh=nz4enF8Jz59Sf6Vavxspe3ycCjV1pMiLTmu1sO5NYe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AfClMY+6TadcEnH845XTkmeq/j4UE406IfsyTEijaGYXlb89Ei2xG4g6fAB/V6myV9IQ+oJOSolghGEnKRK8a694dXvpTIst3ofwHyFMyi4t/y7F4EJ2lmyrV6gVWdIqGD40F4aZyoc4QHxaTNcXFcvayja6TuKHVcPEYm3kmCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f80D4EnV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f80D4EnV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE25CC4CEED;
	Thu, 10 Apr 2025 06:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744267758;
	bh=nz4enF8Jz59Sf6Vavxspe3ycCjV1pMiLTmu1sO5NYe4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f80D4EnV36LeKziBuUUGIcnLVQ0ynTBEhcgG8uvQFGYq5tEQLCoBTuxKX3Xp/LJJR
	 Y54H9W1vnUz4+lIzaIbkgsRq50P+dN8mfBdw0SPnJLwD+G+IgdpBlJ4R70BOY2LCEY
	 ArjP7KX3DON9JpdbmcYygn4bnhE8KRm6w0sLt9xvXGIpHLXHZJMe6OYXqVSvV+VK4d
	 3NLTCnvpk3pU3eO+gEAAdVE7e+YiywWXslDu0qOf4D6yqy3Cbj0zgJXJ6dPO9dEvF8
	 HC7f44j8D+pShfpasgV4U5oKZhEZ3+d5D4ep8a+c0Dmn6jI9Vc5FYrPctFDastqj6C
	 9E26wAi47imhA==
Date: Wed, 9 Apr 2025 23:49:16 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
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
Message-ID: <Z_dp7E2wtSek-KHo@z2>
References: <20250410044532.52017-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250410044532.52017-1-irogers@google.com>

Hi Ian,

On Wed, Apr 09, 2025 at 09:45:29PM -0700, Ian Rogers wrote:
> The "PMU JSON event tests" have been running slowly, these changes
> target improving them with an improvement of the test running 8 to 10
> times faster.
> 
> The first patch changes from searching through all aliases by name in
> a list to using a hashmap. Doing a fast hashmap__find means testing
> for having an event needn't load from disk if an event is already
> present.
> 
> The second patch switch the fncache to use a hashmap rather than its
> own hashmap with a limited number of buckets. When there are many
> filename queries, such as with a test, there are many collisions with
> the previous fncache approach leading to linear searching of the
> entries.
> 
> The final patch adds a find function for metrics. Normally metrics can
> match by name and group, however, only name matching happens when one
> metric refers to another. As we test every "id" in a metric to see if
> it is a metric, the find function can dominate performance as it
> linearly searches all metrics. Add a find function for the metrics
> table so that a metric can be found by name with a binary search.
> 
> Before these changes:
> ```
> $ time perf test -v 10
>  10: PMU JSON event tests                                            :
>  10.1: PMU event table sanity                                        : Ok
>  10.2: PMU event map aliases                                         : Ok
>  10.3: Parsing of PMU event table metrics                            : Ok
>  10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
>  10.5: Parsing of metric thresholds with fake PMUs                   : Ok
> 
> real    0m18.499s
> user    0m18.150s
> sys     0m3.273s
> ```
> 
> After these changes:
> ```
> $ time perf test -v 10
>  10: PMU JSON event tests                                            :
>  10.1: PMU event table sanity                                        : Ok
>  10.2: PMU event map aliases                                         : Ok
>  10.3: Parsing of PMU event table metrics                            : Ok
>  10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
>  10.5: Parsing of metric thresholds with fake PMUs                   : Ok
> 
> real    0m2.338s
> user    0m1.797s
> sys     0m2.186s
> ```

Great, I also see the speedup on my machine from 32s to 3s.

Tested-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> 
> Ian Rogers (3):
>   perf pmu: Change aliases from list to hashmap
>   perf fncache: Switch to using hashmap
>   perf metricgroup: Binary search when resolving referred to metrics
> 
>  tools/perf/builtin-stat.c                |   6 +-
>  tools/perf/pmu-events/empty-pmu-events.c |  66 ++++++++-
>  tools/perf/pmu-events/jevents.py         |  66 ++++++++-
>  tools/perf/pmu-events/pmu-events.h       |  23 +++-
>  tools/perf/tests/pmu-events.c            | 129 +++++++++--------
>  tools/perf/util/fncache.c                |  69 +++++-----
>  tools/perf/util/fncache.h                |   1 -
>  tools/perf/util/hwmon_pmu.c              |  43 +++---
>  tools/perf/util/metricgroup.c            | 102 ++++++--------
>  tools/perf/util/metricgroup.h            |   2 +-
>  tools/perf/util/pmu.c                    | 167 +++++++++++++++--------
>  tools/perf/util/pmu.h                    |   4 +-
>  tools/perf/util/srccode.c                |   4 +-
>  tools/perf/util/tool_pmu.c               |  17 +--
>  14 files changed, 430 insertions(+), 269 deletions(-)
> 
> -- 
> 2.49.0.504.g3bcea36a83-goog
> 

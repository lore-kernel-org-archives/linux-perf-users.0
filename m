Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB4C1E47C5;
	Fri, 11 Apr 2025 23:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744412948; cv=none; b=FrR8BUqKp6OdIlHws99u83eR8itVzo66FL+qpZpF7mMSqTyq+nhzfmyPSFQEMnVeOQVo14XGc9stVrmpfiTSQVcRG7cx8xzIvcIkETJDmn6el8+W6ySScQtVxJUPnAmvbk4ckfxluslvsRyr6UFwzh1AAySIStBdYT6sX6fc1IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744412948; c=relaxed/simple;
	bh=c7UxXBtne8skLpO72LdJxHRQelC/35DaBCxhVZhPcBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfyY0tLCbcUCWfMDR6p2Lo5TT37KNAjsirZYjDS/OVzSYo4/WWox2GTggH7ob0b4X2Ckt8zXIwXYSVOzwsHK8mrmU/S4bq3Q3GlFDz0/C006KkhhTci7BzqpxpODZqnLu5vbayIZnyTmQcVwCGQ6eNVmA7mWSYOMwp2fwOj4n30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJDl/dWI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJDl/dWI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27BD2C4CEE2;
	Fri, 11 Apr 2025 23:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744412947;
	bh=c7UxXBtne8skLpO72LdJxHRQelC/35DaBCxhVZhPcBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IJDl/dWIhxvzyXHqkbb6wsWFH97RcHXIR0gvQmOhFzCyd1B8EkO6/VLPbd4M1LHKo
	 6O/BLPWjafWhMYkZVjII67kr90ajDslhqRd76g7DsUdO7rxYca4+GEWoGs+8DcVpUp
	 hyct5EzY7Dxl8FpXGYPuFOtqGyt7XsVxrRVTbH+q44wMkRRJ9iyl2IKKycpb0JzUUk
	 bC4FqQAKh9foP1cIpxJfhnWm7DLgwC2SuxD5/Nlq3v+WDHNlM/J7v9a+tOqkq0bpDL
	 CNRFvhWPxqk8yTxRjuB5njtIrSRYrBXqqImF61ysTdvXp+bfZL4Y6mrI3v16CtTgj/
	 TZR07JfYM/06w==
Date: Fri, 11 Apr 2025 16:09:05 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Weilin Wang <weilin.wang@intel.com>,
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>,
	John Garry <john.g.garry@oracle.com>,
	Howard Chu <howardchu95@gmail.com>, Levi Yun <yeoreum.yun@arm.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/16] Intel TPEBS min/max/mean/last support
Message-ID: <Z_mhEc5GAWM5cUTh@z2>
References: <20250409061043.700792-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250409061043.700792-1-irogers@google.com>

On Tue, Apr 08, 2025 at 11:10:27PM -0700, Ian Rogers wrote:
> The patches add support to computing the min, max, mean or last
> retirement latency and then using that value as the basis for metrics.
> When values aren't available, support is added to use the retirement
> latency as recorded for an event in the perf json.
> 
> Support is added for reading the retirement latency from the forked
> perf command more than once. To avoid killing the process commands are
> sent through the control fd. Some name handling is changed to make it
> more robust.
> 
> Rather than retirement latency events having issues with perf record,
> make it so that the retirement latency modifier enables sample
> weights.
> 
> v4: Don't use json min/max in retirement latency stats as they will
>     never update afterwards. Warn once if json data is used when TPEBS
>     recording was requested.
> 
> v3: Two fixes from Kan Liang. Ensure min/max statistics don't vary
>     when real samples are encountered.
> 
> v2: Addition of header cleanup patch originally posted:
>     https://lore.kernel.org/lkml/20241210191823.612631-1-irogers@google.com/
>     as there are no arch specific reasons not to build this code.
>     Fix bug in "perf pmu-events: Add retirement latency to JSON events
>     inside of perf" where "t->stats.n != 0" should have been
>     "t->stats.n == 0".
>     Add patch so that perf record of a retirement latency event
>     doesn't crash but instead enables sample weights for the event.
> 
> Ian Rogers (16):
>   perf intel-tpebs: Cleanup header
>   perf intel-tpebs: Simplify tpebs_cmd
>   perf intel-tpebs: Rename tpebs_start to evsel__tpebs_open
>   perf intel-tpebs: Separate evsel__tpebs_prepare out of
>     evsel__tpebs_open
>   perf intel-tpebs: Move cpumap_buf out of evsel__tpebs_open
>   perf intel-tpebs: Reduce scope of tpebs_events_size
>   perf intel-tpebs: Inline get_perf_record_args
>   perf intel-tpebs: Ensure events are opened, factor out finding
>   perf intel-tpebs: Refactor tpebs_results list
>   perf intel-tpebs: Add support for updating counts in evsel__tpebs_read
>   perf intel-tpebs: Add mutex for tpebs_results
>   perf intel-tpebs: Don't close record on read
>   perf intel-tpebs: Use stats for retirement latency statistics
>   perf stat: Add mean, min, max and last --tpebs-mode options
>   perf pmu-events: Add retirement latency to JSON events inside of perf
>   perf record: Retirement latency cleanup in evsel__config

I have a nitpick but otherwise looks good to me.

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> 
>  tools/perf/Documentation/perf-stat.txt   |   7 +
>  tools/perf/builtin-stat.c                |  29 +-
>  tools/perf/pmu-events/empty-pmu-events.c | 216 +++----
>  tools/perf/pmu-events/jevents.py         |   6 +
>  tools/perf/pmu-events/pmu-events.h       |   3 +
>  tools/perf/util/Build                    |   2 +-
>  tools/perf/util/evlist.c                 |   1 -
>  tools/perf/util/evsel.c                  |  22 +-
>  tools/perf/util/evsel.h                  |   6 +
>  tools/perf/util/intel-tpebs.c            | 682 ++++++++++++++---------
>  tools/perf/util/intel-tpebs.h            |  40 +-
>  tools/perf/util/parse-events.c           |   4 +
>  tools/perf/util/pmu.c                    |  52 +-
>  tools/perf/util/pmu.h                    |   3 +
>  14 files changed, 666 insertions(+), 407 deletions(-)
> 
> -- 
> 2.49.0.504.g3bcea36a83-goog
> 

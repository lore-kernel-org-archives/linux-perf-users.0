Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06CD2D94AF;
	Mon, 14 Sep 2026 01:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789348632; cv=none; b=NzyciDtbd9zeHctTbtYt19/QQIX71pjpZsZeXVUFlUTLYA6nP7GAAhcILVXMNavizbZKOeEInj3c7MMCcByJV+RDNcukGKVn6oeYzBYkbQg0rDQMwn0a3+vOYkhHSopfloQAHXyoLrApKl6evJbYZetnsZCAiQJ/WzQ+9RyLJ7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789348632; c=relaxed/simple;
	bh=yaS7ARHyhCJQ5O/dVyDdhqWsOUNVVb3p0svU8JYNqME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXW9oxPwJZ4t3jx29C+A3RGnd0MthTZHB/LHEUKPMPw+KLkk6HDiVRPesvOjExe8h9x02PoRFfyW1vgtPz49SCrOfgjMlojbiHfl7/dOuPf/znkTlA7hD9i/Gid0JzUCRFldFxMqfeIjWw+tKBcdLJXQ03HzBbIpA8K3dNgcw/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z71TbIzT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z71TbIzT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDAB21F000FF;
	Mon, 14 Sep 2026 01:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789348630;
	bh=CxNE9VhML03EVnMjcv9cl9hUaRqHKkzyMHIH5zs2+Mw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z71TbIzTwvppbu9XQkljgc1auny1M6YBlOr8ZQahB5hMXjrrHO2mYPFIZYuxOrIy9
	 XxkQOisIQNumk9Ro5npv0NGtW8aXqk4B2eXXuXxfAUPMgZl74sKS8VVL64hLKu4Dr4
	 Diqb8X7DeEDXW/21AWvaH5TuUvCZ6hrBHiTXdJTga6po9K8jlN836zMryYMOPzqK7A
	 Ced225RRVswQnkr1fG/XdKWBKwTj1GI+Yxlcv5mJhUkGmZrdBOW0Kaa5PcJTqVEDcI
	 LhMx3Sh3fK7L0gvVJ7zmYqObflj1a3iKec9N6KdrbuKsvwiBq1ro4Tabo+SSnInoGK
	 txFErcSl6Uk9Q==
Date: Sun, 13 Sep 2026 18:17:08 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Hui Su <sh_def@163.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf evsel: Restrict incremental open error unwind
Message-ID: <aqdLFApaxDgj1mtZ@google.com>
References: <20260912031112.1814574-1-sh_def@163.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260912031112.1814574-1-sh_def@163.com>

On Sat, Sep 12, 2026 at 12:11:10PM +0900, Hui Su wrote:
> evsel__open_cpu(), evsel__tool_pmu_open() and
> evsel__hwmon_pmu_open() support opening a subrange of a CPU map, bounded
> by [start_cpu_map_idx, end_cpu_map_idx).
> 
> Their error paths, however, unwind using "while (--idx >= 0)" all the way
> back to CPU index 0 regardless of start_cpu_map_idx. If lower CPU indices
> were opened by an earlier invocation, a later incremental open failure
> therefore closes those existing file descriptors and overwrites their
> slots with -1.
> 
> Before this fix, running the new incremental open test demonstrates this
> corruption:
> 
>   $ perf test -v "Tool PMU"
>    12: Tool PMU:
>    12.1: Tool PMU                                                      : Ok
>    12.2: Tool PMU leader                                               : Ok
>    12.3: Incremental open error unwind boundary:
>      FAILED: CPU 0 FD overwritten: FD(evsel, 0, 0)=-1, expected 4
>   FAILED!
> 
> Stop the unwind at start_cpu_map_idx so that only file descriptors
> opened by the current invocation are rolled back.
> 
> After this fix:
> 
>   $ perf test -v "Tool PMU"
>    12: Tool PMU:
>    12.1: Tool PMU                                                      : Ok
>    12.2: Tool PMU leader                                               : Ok
>    12.3: Incremental open error unwind boundary                        : Ok
> 
> Fixes: 4804e0111662 ("perf stat: Use affinity for opening events")
> Fixes: 240505b2d0ad ("perf tool_pmu: Factor tool events into their own PMU")
> Fixes: 53cc0b351ec9 ("perf hwmon_pmu: Add a tool PMU exposing events from hwmon in sysfs")

Maybe we just need to last one?

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> Signed-off-by: Hui Su <sh_def@163.com>
> ---
>  tools/perf/tests/tool_pmu.c | 79 +++++++++++++++++++++++++++++++++++++
>  tools/perf/util/evsel.c     |  2 +-
>  tools/perf/util/hwmon_pmu.c |  2 +-
>  tools/perf/util/tool_pmu.c  |  2 +-
>  4 files changed, 82 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/tests/tool_pmu.c b/tools/perf/tests/tool_pmu.c
> index c6c5ebf0e935..667160f9e2cd 100644
> --- a/tools/perf/tests/tool_pmu.c
> +++ b/tools/perf/tests/tool_pmu.c
> @@ -1,8 +1,16 @@
>  // SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <internal/xyarray.h>
> +#include "cpumap.h"
>  #include "debug.h"
>  #include "evlist.h"
> +#include "evsel.h"
>  #include "parse-events.h"
>  #include "tests.h"
> +#include "thread_map.h"
>  #include "tool_pmu.h"
>  
>  static int do_test(enum tool_pmu_event ev, bool with_pmu)
> @@ -100,9 +108,80 @@ static int test__tool_pmu_with_pmu(struct test_suite *test __maybe_unused,
>  	return TEST_OK;
>  }
>  
> +static int test__tool_pmu_incremental_open_unwind(struct test_suite *test __maybe_unused,
> +						  int subtest __maybe_unused)
> +{
> +	struct evlist *evlist = evlist__new();
> +	struct parse_events_error err;
> +	struct perf_cpu_map *cpus = NULL;
> +	struct perf_thread_map *threads = NULL;
> +	struct evsel *evsel;
> +	int ret = TEST_FAIL, fd0 = -1;
> +
> +	if (!evlist)
> +		return TEST_FAIL;
> +
> +	parse_events_error__init(&err);
> +	if (parse_events(evlist, "tool/user_time/", &err)) {
> +		parse_events_error__exit(&err);
> +		evlist__put(evlist);
> +		return TEST_FAIL;
> +	}
> +	parse_events_error__exit(&err);
> +
> +	evsel = evlist__first(evlist);
> +	cpus = perf_cpu_map__new("0,1");
> +	threads = thread_map__new_by_tid(getpid());
> +	if (!cpus || !threads)
> +		goto out;
> +
> +	/* Step 1: Open CPU index 0 successfully */
> +	if (evsel__open_per_cpu_and_thread(evsel, cpus, 0, threads) < 0) {
> +		pr_debug("Failed to open CPU index 0\n");
> +		goto out;
> +	}
> +
> +	fd0 = (*(int *)xyarray__entry(evsel->core.fd, 0, 0));
> +	if (fd0 < 0 || fcntl(fd0, F_GETFD) < 0) {
> +		pr_debug("CPU index 0 FD is invalid (%d)\n", fd0);
> +		goto out;
> +	}
> +
> +	/* Step 2: Intentionally trigger failure on CPU index 1 */
> +	evsel->core.attr.sample_period = 1; /* Not supported for tool PMU -> -EINVAL */
> +	if (evsel__open_per_cpu_and_thread(evsel, cpus, 1, threads) >= 0) {
> +		pr_debug("Unexpected success opening CPU index 1 with sample_period=1\n");
> +		goto out;
> +	}
> +
> +	/*
> +	 * Step 3: Check that CPU index 0's FD was NOT destroyed by CPU index 1's unwind.
> +	 */
> +	if ((*(int *)xyarray__entry(evsel->core.fd, 0, 0)) != fd0) {
> +		pr_debug("FAILED: CPU 0 FD overwritten: FD(evsel, 0, 0)=%d, expected %d\n",
> +			 (*(int *)xyarray__entry(evsel->core.fd, 0, 0)), fd0);
> +		goto out;
> +	}
> +
> +	if (fcntl(fd0, F_GETFD) < 0) {
> +		pr_debug("FAILED: CPU 0 FD %d was closed by error unwind! errno=%d (%s)\n",
> +			 fd0, errno, strerror(errno));
> +		goto out;
> +	}
> +
> +	ret = TEST_OK;
> +out:
> +	evsel__close(evsel);
> +	perf_cpu_map__put(cpus);
> +	perf_thread_map__put(threads);
> +	evlist__put(evlist);
> +	return ret;
> +}
> +
>  static struct test_case tests__tool_pmu[] = {
>  	TEST_CASE("Parsing without PMU name", tool_pmu_without_pmu),
>  	TEST_CASE("Parsing with PMU name", tool_pmu_with_pmu),
> +	TEST_CASE("Incremental open error unwind boundary", tool_pmu_incremental_open_unwind),
>  	{	.name = NULL, }
>  };
>  
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index d4cb455f4a7d..eb429087ebfe 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -3127,7 +3127,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>  			FD(evsel, idx, thread) = -1;
>  		}
>  		thread = nthreads;
> -	} while (--idx >= 0);
> +	} while (--idx >= start_cpu_map_idx);
>  	errno = old_errno;
>  out:
>  	if (err)
> diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
> index ed544dca70c3..96aeb379e169 100644
> --- a/tools/perf/util/hwmon_pmu.c
> +++ b/tools/perf/util/hwmon_pmu.c
> @@ -803,7 +803,7 @@ int evsel__hwmon_pmu_open(struct evsel *evsel,
>  			FD(evsel, idx, thread) = -1;
>  		}
>  		thread = nthreads;
> -	} while (--idx >= 0);
> +	} while (--idx >= start_cpu_map_idx);
>  	close(dir);
>  	return err;
>  }
> diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
> index 5c30854b4644..d2f7591747d9 100644
> --- a/tools/perf/util/tool_pmu.c
> +++ b/tools/perf/util/tool_pmu.c
> @@ -349,7 +349,7 @@ int evsel__tool_pmu_open(struct evsel *evsel,
>  			FD(evsel, idx, thread) = -1;
>  		}
>  		thread = nthreads;
> -	} while (--idx >= 0);
> +	} while (--idx >= start_cpu_map_idx);
>  	errno = old_errno;
>  	return err;
>  }
> -- 
> 2.55.0
> 

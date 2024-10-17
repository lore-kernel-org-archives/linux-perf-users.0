Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAE01DED44;
	Thu, 17 Oct 2024 18:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729189220; cv=none; b=BXReezfh+LPHWq6tpzhrFdajWAdI6pfd7+KG6ukwlKFbZ6MI2255f7t5lHG8iQcPqKUURlSwCqzorfBs40knkVSgV2AwcJy5Cjf9Kb8kfXLoAQtwlhMI2tsBD/sUk/yTMmXWvDRG0CK1s0IhHd1lpQCpmqIQ0ffbCf0vsMqBZGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729189220; c=relaxed/simple;
	bh=ivkBgESkuHQeUA+hxdWGTQLdKw0exukVJcksX9LbMxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MdvUidEA6eZR1tFDwDjmrPjXUVXf370fKw4QGeQBydHtsBqFz/NyIZKMc4LEkJSs/M/3XeungL4WNdNJglT0Iac84C36MJTExfhj24zuDfnA8+L3NRDeS5Y/GPCHjXLgDgFtWuqIoLl5SMfiogeqOHEs22UEIxUiCMDdG1viFOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovBq+K/H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovBq+K/H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89230C4CECD;
	Thu, 17 Oct 2024 18:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729189220;
	bh=ivkBgESkuHQeUA+hxdWGTQLdKw0exukVJcksX9LbMxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ovBq+K/H7+b8B/o7XLNJQRdTJ2nu0ua/et6QA9Md3FGAoQhaYijMmhpJtLAwAUITB
	 ZvDjvgyf9I+KLJdc3Nu2FxQL9ATakg541vOUOKvUtpgfHJ/LAOkLM3f4aayQwMsiyh
	 Muw24OtqMe1xkwvKpi58IBzVQmrutKBuDOK3xnJBRffkBNmFd1KjzJOzALdmItxz6X
	 rfrDEDFuxnrgAqoh5PXA2EJGnxbYUVqcKnAMReVi1uw3YKcve6HHcVF2EH/h7Xgus8
	 EWU5MCYER8q/42OX1QhVBfMCmsnH1FBVGzB6a+QU4G9ibZ6OpeM+j+8UNZjj0q/oiE
	 aXav1LWXIQEAA==
Date: Thu, 17 Oct 2024 11:20:18 -0700
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
	Tim Chen <tim.c.chen@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Weilin Wang <weilin.wang@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/7] CSV/JSON metric thresholds, fix printf modifiers
Message-ID: <ZxFVYvDTtmz_JbMU@google.com>
References: <20241017175356.783793-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241017175356.783793-1-irogers@google.com>

Hi Ian,

On Thu, Oct 17, 2024 at 10:53:49AM -0700, Ian Rogers wrote:
> Metric thresholds are being computed for CSV and JSON output but not
> displayed. Rename the color that encodes the threshold as enum values
> and use to generate string constants for a json dictionary
> value. Disable metric thresholds with CSV output.
> 
> Add printf attribute to functions in color.h that could support
> it. Fix bad printf format strings that this detected.

Thanks for the quick fix, I'll take this.

> 
> v5. Switch some u64 printf flags to PRIx64 rather than llx (kernel
>     convention) to resolve 32-bit build issues.
> v4. Drop CSV metric thresholds due to formatting variation on
>     hypervisors (broken counters) and not as detected by
>     tests/shell/stat+csv_output.sh.

I'm ok with dropping CSV support for now, but could you explain
a bit more detail about the problem?  Is it possible to see the
same problem on host if it has a unsupported event?

Thanks,
Namhyung


> v3. Rebase.
> v2. Don't display metric-value for json output if there is no unit.
> 
> Ian Rogers (7):
>   perf color: Add printf format checking and resolve issues
>   perf stat: Fix/add parameter names for print_metric
>   perf stat: Display "none" for NaN with metric only json
>   perf stat: Drop metric-unit if unit is NULL
>   perf stat: Change color to threshold in print_metric
>   perf stat: Add metric-threshold to json output
>   perf stat: Disable metric thresholds for CSV and JSON metric-only mode
> 
>  tools/perf/arch/x86/util/iostat.c             |   2 +-
>  tools/perf/builtin-sched.c                    |   2 +-
>  tools/perf/builtin-script.c                   |   6 +-
>  tools/perf/builtin-stat.c                     |   8 ++
>  tools/perf/builtin-trace.c                    |   2 +-
>  .../tests/shell/lib/perf_json_output_lint.py  |   5 +-
>  tools/perf/util/arm-spe.c                     |   2 +-
>  tools/perf/util/color.h                       |   9 +-
>  tools/perf/util/intel-bts.c                   |   2 +-
>  tools/perf/util/intel-pt.c                    |   2 +-
>  tools/perf/util/s390-cpumsf.c                 |   2 +-
>  tools/perf/util/s390-sample-raw.c             |   8 +-
>  tools/perf/util/stat-display.c                |  73 +++++++---
>  tools/perf/util/stat-shadow.c                 | 128 ++++++++++--------
>  tools/perf/util/stat.h                        |  16 ++-
>  15 files changed, 170 insertions(+), 97 deletions(-)
> 
> -- 
> 2.47.0.105.g07ac214952-goog
> 

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CA52185A7;
	Tue,  8 Oct 2024 22:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728427677; cv=none; b=eaqo3Qk4byhKcgss/Pj/rU1WbRLQPeYkw/7RyioLtmq6CxL+FUYVqd5LFQi49SInkuje/0gBPptzARQf6I5SI1LZW0GV+ja0rt1zEH6e5oJBOrdTGmUCV430U2q9F5keSUtZJUM4nJa5+f0FWlv7sma7S9zE3fbEXP/j7uA1/8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728427677; c=relaxed/simple;
	bh=+BXdZ3zQPkkzxjR3ggrkQdPNF82eoHjHNOvZ+K+Qy7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DArqGrWtWSB3mZAVBWxOhn3Oy0OrRc9CHzrA7Rz/jUw5ijbFLS+lV4qARw8l/nXe3lYT/xps5V3BtqtkeZZ37dxMXinevAtTtAmgz5sjtBcyXUIF+ZINvQxrfjmoYDfUZfS7Rs73EAfHBNtxcJ+Ix2eB6O9xQDP2Rh0ISzFGW5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2LBx9qQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2LBx9qQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A57C4CEC7;
	Tue,  8 Oct 2024 22:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728427677;
	bh=+BXdZ3zQPkkzxjR3ggrkQdPNF82eoHjHNOvZ+K+Qy7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b2LBx9qQlzGk5HT0/EaId6Nl17KJ8wByd/CNG+XpZmkQaMFJwiH5CboYsPOvaV6q6
	 WmpblW3zjSlG4/f0ih2u9oO60edERC2Fxrk1GMO6kFAYR3wLr0kc1zQ0NJCAPmA/ts
	 L0u7BtT0cFthfolfeUfpeoyc8Hq3wy2w83dpoP3scpUwPxwVxMHuZiD+HOpzSaLG2b
	 xIFbzf1q5zPrawxj4zfgZWyRC9lBBTbsnoezGmnoVDcxRebvESrpey4XNv259KKWn3
	 YSkH6nL56Pkh1Kz7rV1CPvNTAAPMJrufqXJTS6J/zPeu/tFMlCTuSJWnhgFQOg8HQe
	 7+RFI8Swbu7+w==
Date: Tue, 8 Oct 2024 15:47:55 -0700
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
Message-ID: <ZwW2m5D2cnIabE_z@google.com>
References: <20241004234120.1495209-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241004234120.1495209-1-irogers@google.com>

Hi Ian,

On Fri, Oct 04, 2024 at 04:41:12PM -0700, Ian Rogers wrote:
> Metric thresholds are being computed for CSV and JSON output but not
> displayed. Rename the color that encodes the threshold as enum values
> and use to generate string constants in a CSV column or json
> dictionary value.

IIUC it'd show "good" or "bad" when the metric defines a threshold and
show "good", "less good", "nearly bad" or "bad" for the legacy shadow
stats?  Anyway it's nice to show if the value is good or not.

> 
> Add printf attribute to functions in color.h that could support
> it. Fix bad printf format strings that this detected.
> 
> Ian Rogers (8):
>   perf color: Add printf format checking and resolve issues
>   perf stat: Fix/add parameter names for print_metric
>   perf stat: Display "none" for NaN with metric only json
>   perf stat: Drop metric-unit if unit is NULL
>   perf stat: Change color to threshold in print_metric
>   perf stat: Display metric threshold value in CSV output
>   perf stat: Add metric-threshold to json output
>   perf stat: Disable metric thresholds for CSV/JSON metric-only mode

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> 
>  tools/perf/Documentation/perf-stat.txt        |   1 +
>  tools/perf/arch/x86/util/iostat.c             |   2 +-
>  tools/perf/builtin-sched.c                    |   2 +-
>  tools/perf/builtin-script.c                   |   6 +-
>  tools/perf/builtin-stat.c                     |   8 ++
>  tools/perf/builtin-trace.c                    |   2 +-
>  .../tests/shell/lib/perf_json_output_lint.py  |   5 +-
>  tools/perf/tests/shell/stat+csv_output.sh     |  24 ++--
>  tools/perf/util/arm-spe.c                     |   2 +-
>  tools/perf/util/color.h                       |   9 +-
>  tools/perf/util/intel-bts.c                   |   2 +-
>  tools/perf/util/intel-pt.c                    |   2 +-
>  tools/perf/util/s390-cpumsf.c                 |   2 +-
>  tools/perf/util/s390-sample-raw.c             |   6 +-
>  tools/perf/util/stat-display.c                |  85 +++++++++---
>  tools/perf/util/stat-shadow.c                 | 128 ++++++++++--------
>  tools/perf/util/stat.h                        |  16 ++-
>  17 files changed, 191 insertions(+), 111 deletions(-)
> 
> -- 
> 2.47.0.rc0.187.ge670bccf7e-goog
> 

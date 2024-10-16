Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BB218732A;
	Wed, 16 Oct 2024 17:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729099568; cv=none; b=mr5V3DsYthtGC6dnqvd+XkSs+mJY65j6qQz8uqWS9Qh9PPhWHvwBga8pbst3+4yXGnt0aUVpA6JAJfWeTSEIMrLoco0YVKbuKiVecHjK7abzyjyqMlsWbrTENuIpKLFk+5dNWDj/UYx6LpZ1RJAqW8RKs1c/0tMAvaJOPhXT5fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729099568; c=relaxed/simple;
	bh=JmG73EjKhrWQK4DhqDSu6LYhggekl2fr/XqENXD+2dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7+8ZFWsB1zS0UuD9q533PdoRdpMRchmagmBWfa5M8QGgajS8KVdHc9X+SLTcYTrai3N/NIoROmwvBJDWlJnLuG8zUubARc70AnGfUlZsw0temUPG2wjv78nSgVKOR+0uMxuq4y1XrRJpyfuJXfEKoZRYRruReVOL4m21JGz6U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQNqQa+b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQNqQa+b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7888AC4CEC5;
	Wed, 16 Oct 2024 17:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729099568;
	bh=JmG73EjKhrWQK4DhqDSu6LYhggekl2fr/XqENXD+2dk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DQNqQa+bDRvUMrCVF4Vg/jCWFjXArJ0JLhoYkrbPC0kWpWumHGhLt9rJseIb2TLkU
	 dZnPoKjzN/NFg1sjYu/yLKu5+S+i0ngLl36PZxewFM1UXl5T79EzcIckB8BInY7g5y
	 yV2eiC7kDugDvPfE22eBSoAvW/B2a/ggwTRScJrzlVTatyf6vieGdEn5rfuRpEaLuF
	 BsClK4j6VMkWEBYTNisaYA5t/lPlZ1diweDIs2HuN/l9UnrsJjksMV/hZfIwTu29EP
	 EGjS4NH/moQSpbMESpphMVTcwP0yEyLQXcnUS3Gr8WIiEIcCnj1MnpGcKbsU+I+Tg6
	 6BBH/ZbUBHcJw==
Date: Wed, 16 Oct 2024 10:26:06 -0700
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
Subject: Re: [PATCH v2 0/8] CSV/JSON metric thresholds, fix printf modifiers
Message-ID: <Zw_3LkoCBPXMxR0_@google.com>
References: <20241010012135.1272535-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241010012135.1272535-1-irogers@google.com>

On Wed, Oct 09, 2024 at 06:21:26PM -0700, Ian Rogers wrote:
> Resend. The first send cut-off patches 7 and 8. Sorry.
> 
> Metric thresholds are being computed for CSV and JSON output but not
> displayed. Rename the color that encodes the threshold as enum values
> and use to generate string constants in a CSV column or json
> dictionary value.
> 
> Add printf attribute to functions in color.h that could support
> it. Fix bad printf format strings that this detected.
> 
> v2. Don't display metric-value for json output if there is no unit.
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

It doesn't apply to the current perf-tools-next.  Can you please rebase?

  Applying: perf color: Add printf format checking and resolve issues
  Patch failed at 0001 perf color: Add printf format checking and resolve issues
  error: patch failed: tools/perf/util/color.h:37
  error: tools/perf/util/color.h: patch does not apply

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
> 2.47.0.rc1.288.g06298d1525-goog
> 

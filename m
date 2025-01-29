Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D18D5672;
	Wed, 29 Jan 2025 05:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738127116; cv=none; b=cJYgf64sYM1rCEspWgkxzTwFrJaH2dRvP7THYp+IEOydq27bUtvlQCM1Da6esYZX6l8rlDvrTI1y7SO7FMaCwoxWp1oQN9X9a4S3Mz0M2lRdjz9Es8yd1twMBB6dGgSk4DE9bA7o7DcQKHF5zDYJ62PDgCtE470KKhayMenrfeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738127116; c=relaxed/simple;
	bh=Cn2/Tcz0mdC7muCzzFJkp6Q+hEMzq3RnEMqbwK7sI3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVqmTNO9eP1CHLfVDdksuzKnX4L7FGk2jYWrhuu272uniYhHEUQXUtofZ+t+WD2DRD/Zf8TAytciViFGvf7HmCV7Y1hOIdt38C7zP3pWnTNXoKPXEyiGPo2XNRzp/g7UGr2OI8kQsOOIzR6jZcFAoVzmIbCMH8NLvm9nLWSbxIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r99tIQ+l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r99tIQ+l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ACAAC4CED3;
	Wed, 29 Jan 2025 05:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738127115;
	bh=Cn2/Tcz0mdC7muCzzFJkp6Q+hEMzq3RnEMqbwK7sI3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r99tIQ+lUYgK3YCqmuCwqtjCRH+a/xM4A8lKrpCCUYeGlc7O4dLQ6RUAd3JVwOoej
	 P9s66MtRKoxrpbITDAa6lgol+HG8Bx/XCe94/CH8QSEiuift0SRahmV5NbQb8f53c5
	 ZLFKUG1kczhrh1Rrt7xIMG1lPwTOoOMU+xze4vnPNJ+d2It0eGfo3f0pGeSfTMt9GC
	 tww7ZhPf+/fvXyYrnd+H5nGcHlXe9x4uS/U/0+fHz0uEnUBssvxpFZLuK6eqDd0gIz
	 kD1c4ZX+WLtljp85FixD0kR+P1165bZ1P5FZoKuWVJWfi+xYiq+4w8FZqqhUKZKQGb
	 zLSY59w9jVpgg==
Date: Tue, 28 Jan 2025 21:05:14 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: irogers@google.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v3 0/7] perf report: Add latency and parallelism profiling
Message-ID: <Z5m3Co6TEnUiIQkG@google.com>
References: <cover.1737971364.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1737971364.git.dvyukov@google.com>

On Mon, Jan 27, 2025 at 10:58:47AM +0100, Dmitry Vyukov wrote:
> There are two notions of time: wall-clock time and CPU time.
> For a single-threaded program, or a program running on a single-core
> machine, these notions are the same. However, for a multi-threaded/
> multi-process program running on a multi-core machine, these notions are
> significantly different. Each second of wall-clock time we have
> number-of-cores seconds of CPU time.
> 
> Currently perf only allows to profile CPU time. Perf (and all other
> existing profilers to the be best of my knowledge) does not allow to
> profile wall-clock time.
> 
> Optimizing CPU overhead is useful to improve 'throughput', while
> optimizing wall-clock overhead is useful to improve 'latency'.
> These profiles are complementary and are not interchangeable.
> Examples of where latency profile is needed:
>  - optimzing build latency
>  - optimizing server request latency
>  - optimizing ML training/inference latency
>  - optimizing running time of any command line program
> 
> CPU profile is useless for these use cases at best (if a user understands
> the difference), or misleading at worst (if a user tries to use a wrong
> profile for a job).
> 
> This series add latency and parallelization profiling.
> See the added documentation and flags descriptions for details.
> 
> Brief outline of the implementation:
>  - add context switch collection during record
>  - calculate number of threads running on CPUs (parallelism level)
>    during report
>  - divide each sample weight by the parallelism level
> This effectively models that we were taking 1 sample per unit of
> wall-clock time.
> 
> We still default to the CPU profile, so it's up to users to learn
> about the second profiling mode and use it when appropriate.
> 
> Changes in v3:
>  - rebase and split into patches
>  - rename 'wallclock' to 'latency' everywhere
>  - don't enable latency profiling by default,
>    instead add record/report --latency flag

Thanks for doing this, much better now.  I've added some comments in
the thread.

Thanks,
Namhyung

> 
> Dmitry Vyukov (7):
>   perf report: Add machine parallelism
>   perf report: Add parallelism sort key
>   perf report: Switch filtered from u8 to u16
>   perf report: Add parallelism filter
>   perf report: Add latency output field
>   perf report: Add --latency flag
>   perf report: Add latency and parallelism profiling documentation
> 
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Ian Rogers <irogers@google.com>
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
>  .../callchain-overhead-calculation.txt        |  5 +-
>  .../cpu-and-latency-overheads.txt             | 85 ++++++++++++++++++
>  tools/perf/Documentation/perf-report.txt      | 49 ++++++----
>  tools/perf/Documentation/tips.txt             |  3 +
>  tools/perf/builtin-record.c                   | 20 +++++
>  tools/perf/builtin-report.c                   | 39 ++++++++
>  tools/perf/ui/browsers/hists.c                | 27 +++---
>  tools/perf/ui/hist.c                          | 64 +++++++++----
>  tools/perf/util/addr_location.c               |  1 +
>  tools/perf/util/addr_location.h               |  7 +-
>  tools/perf/util/event.c                       | 11 +++
>  tools/perf/util/events_stats.h                |  2 +
>  tools/perf/util/hist.c                        | 90 +++++++++++++++----
>  tools/perf/util/hist.h                        | 26 +++++-
>  tools/perf/util/machine.c                     |  7 ++
>  tools/perf/util/machine.h                     |  6 ++
>  tools/perf/util/session.c                     | 12 +++
>  tools/perf/util/session.h                     |  1 +
>  tools/perf/util/sort.c                        | 69 ++++++++++++--
>  tools/perf/util/sort.h                        |  3 +-
>  tools/perf/util/symbol.c                      | 34 +++++++
>  tools/perf/util/symbol_conf.h                 |  8 +-
>  22 files changed, 498 insertions(+), 71 deletions(-)
>  create mode 100644 tools/perf/Documentation/cpu-and-latency-overheads.txt
> 
> 
> base-commit: 91b7747dc70d64b5ec56ffe493310f207e7ffc99
> -- 
> 2.48.1.262.g85cc9f2d1e-goog
> 

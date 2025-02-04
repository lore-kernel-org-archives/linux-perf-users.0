Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C817D18858A;
	Tue,  4 Feb 2025 04:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738642860; cv=none; b=FSRvWnAfpsRLGHcuBYAbDUaq+5Oi4hVrgEL3XG2soXhW8mGd4n2EJDtPOn3WE1frFYhH4/W9mPh0mokQfLoDDrSo3g5oNgD7QY/QxC/HT7DVA41GA3CujPMMyJPL9Ori++OPFsLFJjqyXe/bn0DBM1ZSUzT5o3YxYHVqTWQFZNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738642860; c=relaxed/simple;
	bh=0pNlDjHI/WM4tL2SHod2G6uUP9d2cfcqtyb5Y2yYT3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H30kuPg9cRsklzg9QTi+bdJyYW9MNmWZEzkHMpQWTtBwaNq5ahFBYXJe4KwbAfdkJqUBVCsG/duKdUGHtfgcgj8k8xMlH10mbTB9LoC7vfyXknU1F++5GuL+c426Pb1JyiDJ7sHgRYwGccLQfd+bgrJWuc4ou4RJhmh/Ao+PFFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6Gz6vxV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6Gz6vxV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF918C4CEDF;
	Tue,  4 Feb 2025 04:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738642860;
	bh=0pNlDjHI/WM4tL2SHod2G6uUP9d2cfcqtyb5Y2yYT3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a6Gz6vxVSxLy/7q6RQ0t6drnuT64UoGNyGufjFZAQGGljwc/Uzzv9TktgrHeqeEdY
	 Ug4QOGTNbuRiOO++xW1zpJr5dz2gNrOuqurUTHlqPQjMiMffrdDJKtioQ6qmRXH8eD
	 uTr5isz4anH5pzEgwcS+F9fjRTe3EDBKcprOfGdCbAOEC9ZHjBc0+4H7DmeLjyn5KE
	 irkkrtpVeQoBAnUHHQr3UPno99p0BgnvZ1Ab60kj3lbyM3wVUIveNxlz/8xph68Fqa
	 mggFZThuHtx7jRGIYxBxVNaOuFhrUHP003+05V8BaC3BVtWMGAKCep6k/ocYRTUuTD
	 fSoVYpPia/C2g==
Date: Mon, 3 Feb 2025 20:20:58 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: irogers@google.com, acme@kernel.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/8] perf report: Add latency and parallelism profiling
Message-ID: <Z6GVqh6detN8rbKV@google.com>
References: <cover.1738592865.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1738592865.git.dvyukov@google.com>

Hello,

On Mon, Feb 03, 2025 at 03:30:35PM +0100, Dmitry Vyukov wrote:
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
> Changes in v4:
>  - added "Shrink struct hist_entry size" commit
>  - rebased to perf-tools-next HEAD
> 
> Changes in v3:
>  - rebase and split into patches
>  - rename 'wallclock' to 'latency' everywhere
>  - don't enable latency profiling by default,
>    instead add record/report --latency flag
> 
> Dmitry Vyukov (8):
>   perf report: Add machine parallelism
>   perf report: Add parallelism sort key
>   perf report: Switch filtered from u8 to u16
>   perf report: Add parallelism filter
>   perf report: Add latency output field
>   perf report: Add --latency flag
>   perf report: Add latency and parallelism profiling documentation
>   perf hist: Shrink struct hist_entry size

I found that stdio output is broken that latency is too high.  TUI is fine.

  $ ./perf report --latency -s dso --stdio
  ...
  #
  #  Latency  Overhead  Shared Object       
  # ........  ........  ....................
  #
     57669.15%    57.67%  [kernel.kallsyms]   
     42330.85%    42.33%  ld-linux-x86-64.so.2

Thanks,
Namhyung

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
>  tools/perf/util/hist.h                        | 32 +++++--
>  tools/perf/util/machine.c                     |  7 ++
>  tools/perf/util/machine.h                     |  6 ++
>  tools/perf/util/sample.h                      |  2 +-
>  tools/perf/util/session.c                     | 12 +++
>  tools/perf/util/session.h                     |  1 +
>  tools/perf/util/sort.c                        | 69 ++++++++++++--
>  tools/perf/util/sort.h                        |  3 +-
>  tools/perf/util/symbol.c                      | 34 +++++++
>  tools/perf/util/symbol_conf.h                 |  8 +-
>  23 files changed, 502 insertions(+), 75 deletions(-)
>  create mode 100644 tools/perf/Documentation/cpu-and-latency-overheads.txt
> 
> 
> base-commit: 8ce0d2da14d3fb62844dd0e95982c194326b1a5f
> -- 
> 2.48.1.362.g079036d154-goog
> 

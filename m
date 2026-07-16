Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D8A1DED42;
	Thu, 16 Jul 2026 22:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784242141; cv=none; b=Z1nG6o8a4HAPJ+Qy1J+S9zw7uiuUxRb4dlcQUiZoMd8OBh9uuSTIICBEXweSPHsig4DBhJcDsu98EtPMc5RBH4j2EnwbSdQZ0z72foVWOxzc3EpM0uYffmVpH/0q9q6ofDPSL46gSjaQCuFV+dlNm8n/81Zmb030vmXIEwbxtb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784242141; c=relaxed/simple;
	bh=tR2jF5Jk1sVc9VnnP0q6NNOOFA1GFoBwoiae4dLgtEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRxN53hbSn8d/zsXJtKCORHTtiUkQbKck5VOAQas2B3dgMW1tyMHhftaaGbeQXO+WXpTAJ4mF5S3oXt0BdHRx1vLwPC6eizVIGz3frfH49tH8MT8nId/vidh6c8Wvzalv23w+3l4tMjwraWGKgqtNUwPsZiMfZmI+bTlYZ13NmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QktEfQRH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QktEfQRH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 586A61F000E9;
	Thu, 16 Jul 2026 22:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784242139;
	bh=Ufnfn5E95S8aHyHHGlfMlRAIvMOsYoHF0r/K+1SVKmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QktEfQRHn0ccHUw3rmflIROXm8DKoum60iNyJKn0qq//ZTkG/c59Unn7VjQW8S+Fq
	 ecjYI6IPKy/n/j5+5sBJEXBEaSL/MAruFr3V3cOO3f9V1n2aYuObFQJmlzwnYHBbkS
	 5sxz2DFIIMFS2W5ABlSlOBP7mITuNgShUXIQgUaFjhXEj2NkIBH2v/xURaR9FevaNP
	 ETBQwqMuMPtDkUfUGL+eTM2+P+0+mViHEaAaf7YeLDeB0o2EP7o1ymXpvKD8JokWJi
	 Zf0J69vKDMzgWAV+2hlScsjnJbMCRKfKpFOSj44M3a08vZPbo98uWY6kbpFWCn2tqb
	 XXf/tBOIypxGA==
Date: Thu, 16 Jul 2026 15:48:58 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, ctshao@google.com, adrian.hunter@intel.com,
	james.clark@linaro.org, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org
Subject: Re: [PATCH v4 00/14] perf stat: Decouple and modularize display
 formatting
Message-ID: <allf2kCJcc72HTRo@google.com>
References: <20260716043223.388233-1-irogers@google.com>
 <20260716070303.507066-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260716070303.507066-1-irogers@google.com>

On Thu, Jul 16, 2026 at 12:02:49AM -0700, Ian Rogers wrote:
> This patch set decouples and modularizes `perf stat` metric and event
> counter display processing into a unified traversal engine supporting
> pluggable, format-specific callbacks for standard (STD), CSV, and JSON
> outputs via the new `--new` flag.

Thanks for working on this!

I'm not sure the goal is to produce the exactly same output or not.
If so, we need to verify that by comparing outputs before and after.
Probably you can use perf stat record and report.

If not, please show the output here.

Actually I cannot say I like the name of the flag, but it's ok if we
want to keep it for a short period time and eventually get rid of it.

Thanks,
Namhyung

> 
> Changes in v4:
> - Squash all multi-metric column padding, zero-skip logic, and formatting
>   fixes directly into their introducing commits for a perfectly bisectable,
>   pristine Git history.
> - Avoid newlines before signed-off-by, assisted-by, and acked-by tags,
>   organizing all contributor tags into a single, contiguous block for strict
>   checkpatch and LKML compliance.
> - Introduce strict, grid-based column padding to perfectly align multi-metric
>   events (e.g. TopdownL1) across both standard and metric-only CSV rows, guaranteeing
>   perfect 6-comma and 7-comma parsing compliance by external DataFrame engines.
> - Refactor the PMU and hybrid metric event printer to propagate identical zero-counter
>   skipping semantics in alignment with the legacy abs_printout path.
> - Re-run all STD, JSON, and CSV linter test suites to achieve 100% passing status.
> 
> Ian Rogers (14):
>   perf stat: Introduce core generic print traversal engine and header
>     stubs
>   perf stat: Implement standard console (STD) formatting callbacks
>   perf stat: Extend STD output linter to test basic New API checks
>   perf stat: Extend STD output linter to test core aggregation checks
>   perf stat: Extend STD output linter to test advanced PMU checks
>   perf stat: Extend STD output linter to test metric-only checks
>   perf stat: Implement CSV formatting callbacks
>   perf stat: Extend CSV output linter to test core aggregation checks
>   perf stat: Extend CSV output linter to test advanced PMU and
>     metric-only checks
>   perf stat: Implement streaming JSON formatting callbacks
>   perf stat: Extend JSON output linter to test core aggregation checks
>   perf stat: Extend JSON output linter to test advanced PMU and
>     metric-only checks
>   perf stat: Add --new support to PMU metrics Python validator
>   perf stat: Extend PMU metrics value linter to validate --new outputs
> 
>  tools/perf/builtin-stat.c                     |  96 +-
>  .../tests/shell/lib/perf_metric_validation.py |  12 +-
>  tools/perf/tests/shell/stat+csv_output.sh     |  19 +
>  tools/perf/tests/shell/stat+json_output.sh    |  74 +-
>  tools/perf/tests/shell/stat+std_output.sh     |  18 +
>  tools/perf/tests/shell/stat_metrics_values.sh |  22 +-
>  tools/perf/util/Build                         |   4 +
>  tools/perf/util/stat-display.c                |  12 +-
>  tools/perf/util/stat-print-csv.c              | 677 ++++++++++++++
>  tools/perf/util/stat-print-json.c             | 339 +++++++
>  tools/perf/util/stat-print-std.c              | 854 ++++++++++++++++++
>  tools/perf/util/stat-print.c                  | 500 ++++++++++
>  tools/perf/util/stat-print.h                  | 137 +++
>  tools/perf/util/stat.h                        |   6 +
>  14 files changed, 2688 insertions(+), 82 deletions(-)
>  create mode 100644 tools/perf/util/stat-print-csv.c
>  create mode 100644 tools/perf/util/stat-print-json.c
>  create mode 100644 tools/perf/util/stat-print-std.c
>  create mode 100644 tools/perf/util/stat-print.c
>  create mode 100644 tools/perf/util/stat-print.h
> 
> -- 
> 2.55.0.141.g00534a21ce-goog
> 

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BCB19AD5C;
	Sat, 18 Jul 2026 05:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784352794; cv=none; b=uf6taypEwJOGFPNl6WTSz3V0DsKHw+hK01pqpDPhq78tJ8hmqg4EvA5dN62QyhFITj+8ql3Mo+h2sG9iPQOZ1L4U4/CuftPE8bqtxTq7wEJ5xCZE0+HQRW59Gm91T3Cj5Pj2MA00EgCdD48nMm1/4dKrZQPygzvYZyLIFWujGV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784352794; c=relaxed/simple;
	bh=aUuTKjkxHSXGN2i2cBRo1c5Xla8t40XKXJi/Ezt+nGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfwkA8uCZvrsk62tqpP78B+eZ1RNipbC7n3+SO1AmMHbzA/CyWS5xivseCxEtowkgiwdaODUmbHWkQ1l7DRcaLe6s+w+km5wM4VcRdlEh30p5lFy08O8wWtGDUusWntW9zflgg2zDoYXg4DtAeY/XgbxFlZDMhHofCX+XuLpuCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYwz79E2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYwz79E2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F3D1F00A3D;
	Sat, 18 Jul 2026 05:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784352792;
	bh=gkY/b4sVyFzEvjdgLG/EueliL67b0soROY+VNJK6s8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NYwz79E2KrbqtmSo2tSXcNrdEz3YAULr6q7A1rn7Vhd2L/cVvazWgfblxVT8RpWMH
	 qvtnC9lcDTnEIsnhx7GC9aAvKSmc+8YGjJNmfkXyWoRwRgeJgxnV3mmrNivq3eiT58
	 azytsL/Dx+z01zPE919A4kMor2UbPWdhgmKLycnFjmZ7/jUW2MYCJxw/KAA/SdzJax
	 O5mt4KN12aCAQMY2LiuTUFIi7Tqqw3e5s36cqkZ1QfjkKkygbMfg2PK5yuHs1MFMmi
	 +Vt80NtTSxM9TC7wJBVe4qXzQzZKBfE8UhfyQ7JuywVELY1K18/bTUlwfY+iYkn38j
	 A4JS7S7YQLM9w==
Date: Fri, 17 Jul 2026 22:33:10 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	james.clark@linaro.org, howardchu95@gmail.com, neelx@suse.com,
	chjohnst@mail.com, sean@ashe.io, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf stat: Add --hide-zero-events option to suppress
 zero-count events
Message-ID: <alsQFlmM9tl8ySH4@google.com>
References: <20260718011039.278310-1-atomlin@atomlin.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260718011039.278310-1-atomlin@atomlin.com>

On Fri, Jul 17, 2026 at 09:10:39PM -0400, Aaron Tomlin wrote:
> When monitoring a large number of events (e.g., with wildcards such as
> --event 'syscalls:sys_enter_*'), many matched events will return a count
> of zero. This clutters the output, making it difficult to spot the
> active events.
> 
> Add a new option --hide-zero-events to suppress printing events that
> have a count of zero.
> 
> To prevent formatting and diagnostic issues, the zero-skipping logic
> implements the following rules:
> 
>     1. In metric-only mode (i.e., --metric-only), columns must remain
>        aligned in the output grid. We evaluate config->metric_only first
>        to avoid skipping zero-valued columns, preventing values from
>        shifting left and aligning under incorrect headers
> 
>     2. For explicitly requested events, we ensure they are not silently
>        hidden if they are unsupported. We only hide a zero-count event
>        if counter->supported is true, ensuring that unsupported explicit
>        events still report "<not supported>"
> 
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> ---
> Changes since v1:
> 
>  - Add shell test coverage for --hide-zero-events and --metric-only
>    in stat.sh

Unfortunately the test was updated recently.  Can you please rebase?

Thanks,
Namhyung

> 
>  - Linked to v1: https://lore.kernel.org/lkml/20260717023134.272578-1-atomlin@atomlin.com/
> ---
>  tools/perf/Documentation/perf-stat.txt |  3 ++
>  tools/perf/builtin-stat.c              |  2 ++
>  tools/perf/tests/shell/stat.sh         | 46 ++++++++++++++++++++++++++
>  tools/perf/util/stat-display.c         |  3 ++
>  tools/perf/util/stat.h                 |  1 +
>  5 files changed, 55 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
> index b72a29c9223c..f334aabdc809 100644
> --- a/tools/perf/Documentation/perf-stat.txt
> +++ b/tools/perf/Documentation/perf-stat.txt
> @@ -162,6 +162,9 @@ null run - Don't start any counters.
>  This can be useful to measure just elapsed wall-clock time - or to assess the
>  raw overhead of perf stat itself, without running any counters.
>  
> +--hide-zero-events::
> +Do not show events with a zero count.
> +
>  -v::
>  --verbose::
>          be more verbose (show counter open errors, etc)
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index a04466ea3b0a..8d340c2ae76c 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -2493,6 +2493,8 @@ int cmd_stat(int argc, const char **argv)
>  			"display details about each run (only with -r option)"),
>  		OPT_BOOLEAN('n', "null", &stat_config.null_run,
>  			"null run - dont start any counters"),
> +		OPT_BOOLEAN(0, "hide-zero-events", &stat_config.hide_zero,
> +			"Do not show events with a zero count"),
>  		OPT_INCR('d', "detailed", &detailed_run,
>  			"detailed run - start a lot of events"),
>  		OPT_BOOLEAN('S', "sync", &sync_run,
> diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
> index 1e17bee026bd..cf7a35fac871 100755
> --- a/tools/perf/tests/shell/stat.sh
> +++ b/tools/perf/tests/shell/stat.sh
> @@ -535,6 +535,51 @@ test_stat_delay() {
>    echo "stat -D test [Success]"
>  }
>  
> +test_hide_zero_events_stat() {
> +  echo "Hide zero events stat test"
> +  if ! perf stat -e context-switches,cpu-migrations true > "${stat_output}" 2>&1
> +  then
> +    echo "Hide zero events stat test [Skipped event parsing failed]"
> +    return
> +  fi
> +
> +  zero_event=""
> +  if grep -q -E "[[:space:]]+0[[:space:]]+context-switches" "${stat_output}"; then
> +    zero_event="context-switches"
> +  elif grep -q -E "[[:space:]]+0[[:space:]]+cpu-migrations" "${stat_output}"; then
> +    zero_event="cpu-migrations"
> +  fi
> +
> +  if [ -z "$zero_event" ]; then
> +    echo "Hide zero events stat test [Skipped - no zero count event found]"
> +    return
> +  fi
> +
> +  if ! perf stat --hide-zero-events -e context-switches,cpu-migrations true > "${stat_output}" 2>&1
> +  then
> +    echo "Hide zero events stat test [Failed - command failed]"
> +    err=1
> +    return
> +  fi
> +
> +  if grep -q -E "$zero_event" "${stat_output}"
> +  then
> +    echo "Hide zero events stat test [Failed - zero event $zero_event was not hidden]"
> +    err=1
> +    return
> +  fi
> +
> +  # Check that --metric-only works with --hide-zero-events
> +  if ! perf stat --hide-zero-events --metric-only -e instructions,cycles true > "${stat_output}" 2>&1
> +  then
> +    echo "Hide zero events stat test [Failed - metric-only command failed]"
> +    err=1
> +    return
> +  fi
> +
> +  echo "Hide zero events stat test [Success]"
> +}
> +
>  test_default_stat
>  test_null_stat
>  test_offline_cpu_stat
> @@ -551,6 +596,7 @@ test_stat_detailed
>  test_stat_repeat
>  test_stat_pid
>  test_stat_delay
> +test_hide_zero_events_stat
>  
>  cleanup
>  exit $err
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 0a5750bb59fa..1579e3e2c445 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -907,6 +907,9 @@ static bool should_skip_zero_counter(struct perf_stat_config *config,
>  	/* Metric only counts won't be displayed but the metric wants to be computed. */
>  	if (config->metric_only)
>  		return false;
> +
> +	if (config->hide_zero && counter->supported)
> +		return true;
>  	/*
>  	 * Skip value 0 when enabling --per-thread globally,
>  	 * otherwise it will have too many 0 output.
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index 4bced233d2fc..e3598037a6aa 100644
> --- a/tools/perf/util/stat.h
> +++ b/tools/perf/util/stat.h
> @@ -69,6 +69,7 @@ struct perf_stat_config {
>  	bool			 interval_clear;
>  	bool			 metric_only;
>  	bool			 null_run;
> +	bool			 hide_zero;
>  	bool			 ru_display;
>  	bool			 big_num;
>  	bool			 hybrid_merge;
> -- 
> 2.54.0
> 

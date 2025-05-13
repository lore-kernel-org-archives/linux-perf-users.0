Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFC61EB5CB;
	Tue, 13 May 2025 20:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747167945; cv=none; b=gvTn/RBOCnAziiD8EcwbIi22H3y5ACAB3YUDuEkhDGM1Z281XC56J6UhcTyHWnnM4BHC36fO1CUhQ38qQBUpdwH5ggLKxX1/RcGTcCx00PXSEYim+1XX4Gv9QR7ObC7JjoDyKJBVshe5+XyGrkMX0sSzc3sbCbbzeT24UPIe0Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747167945; c=relaxed/simple;
	bh=0MKuDY/6Amoi1YM1St5qTbrAf/RVeMjzPu/o1T55q68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZPemUm2E2NZTSDJTPmtyYG6oDKtOFTZEhvmdi8IzioNBX5zOr4IpcDiQThlnzL9klMnhlUN3FF4VBxyeKsWGRO5L5jlabdOds6G6xabgI7aUemLPcPXA/y/mTj7I1egjypQD1itJrTYl21T+nNwNHn8LfynEYYFR1cR9BGnxQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyXdIM8l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyXdIM8l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44E2C4CEE4;
	Tue, 13 May 2025 20:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747167945;
	bh=0MKuDY/6Amoi1YM1St5qTbrAf/RVeMjzPu/o1T55q68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KyXdIM8lW/Fz/OS1iSgShRZC6HD8y1wZPX6NKUd6ZxV+M3BOdHNeJz7RiXuI9GZZ7
	 afWWRjC/RUyYGvqqMMzP2mrG1PBZcjo89oENhXt92rp+Iaf5P821SNH44s6kVbQtJR
	 dsEJTJRWyR8DXwVBA4PbVgfhwuc8En8n7yWXDxbuS264OS6/8pwHeOTxmjfOFSKuII
	 eW23utU8oNa0/yHlOGkaUBjKk4SKoc1JqOJl8TsSLGVNrKqyD8kIgxaoCy+7uFzv/e
	 jayLWkSkLPaOyUeIEwphQoLa1WU4VY8OLJG58fD7bsIS6yel/4VrlcTzqgx8iM2y6b
	 Iac+/B2Li44Pg==
Date: Tue, 13 May 2025 17:25:42 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Weilin Wang <weilin.wang@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf list: Display the PMU name associated with a
 perf metric in json
Message-ID: <aCOqxtOqVHF1XRN_@x1>
References: <20250512184700.11691-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512184700.11691-1-irogers@google.com>

On Mon, May 12, 2025 at 11:46:59AM -0700, Ian Rogers wrote:
> The perf stat --cputype option can be used to filter which metrics
> will be applied, for this reason the json metrics have an associated
> PMU. List this PMU name in the perf list output in json mode so that
> tooling may access it.
> 
> An example of the new field is:
> ```
> {
>         "MetricGroup": "Backend",
>         "MetricName": "tma_core_bound",
>         "MetricExpr": "max(0, tma_backend_bound - tma_memory_bound)",
>         "MetricThreshold": "tma_core_bound > 0.1 & tma_backend_bound > 0.2",
>         "ScaleUnit": "100%",
>         "BriefDescription": "This metric represents fraction of slots where ...
>         "PublicDescription": "This metric represents fraction of slots where ...
>         "Unit": "cpu_core"
> },
> ```

Tried testing this but the Intel system I have (14700k) while hybrid
doesn't have this "unit"  field in its JSON files :-)

Anyway, applying the patches.

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-list.c      | 12 ++++++++++--
>  tools/perf/util/metricgroup.c  |  5 ++++-
>  tools/perf/util/print-events.h |  3 ++-
>  3 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
> index fed482adb039..e9b595d75df2 100644
> --- a/tools/perf/builtin-list.c
> +++ b/tools/perf/builtin-list.c
> @@ -197,7 +197,8 @@ static void default_print_metric(void *ps,
>  				const char *long_desc,
>  				const char *expr,
>  				const char *threshold,
> -				const char *unit __maybe_unused)
> +				const char *unit __maybe_unused,
> +				const char *pmu_name __maybe_unused)
>  {
>  	struct print_state *print_state = ps;
>  	FILE *fp = print_state->fp;
> @@ -433,7 +434,8 @@ static void json_print_event(void *ps, const char *topic, const char *pmu_name,
>  static void json_print_metric(void *ps __maybe_unused, const char *group,
>  			      const char *name, const char *desc,
>  			      const char *long_desc, const char *expr,
> -			      const char *threshold, const char *unit)
> +			      const char *threshold, const char *unit,
> +			      const char *pmu_name)
>  {
>  	struct json_print_state *print_state = ps;
>  	bool need_sep = false;
> @@ -483,6 +485,12 @@ static void json_print_metric(void *ps __maybe_unused, const char *group,
>  				   long_desc);
>  		need_sep = true;
>  	}
> +	if (pmu_name) {
> +		fix_escape_fprintf(fp, &buf, "%s\t\"Unit\": \"%S\"",
> +				   need_sep ? ",\n" : "",
> +				   pmu_name);
> +		need_sep = true;
> +	}
>  	fprintf(fp, "%s}", need_sep ? "\n" : "");
>  	strbuf_release(&buf);
>  }
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 126a631686b0..43d35f956a33 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -396,6 +396,7 @@ struct mep {
>  	const char *metric_expr;
>  	const char *metric_threshold;
>  	const char *metric_unit;
> +	const char *pmu_name;
>  };
>  
>  static int mep_cmp(struct rb_node *rb_node, const void *entry)
> @@ -476,6 +477,7 @@ static int metricgroup__add_to_mep_groups(const struct pmu_metric *pm,
>  			me->metric_expr = pm->metric_expr;
>  			me->metric_threshold = pm->metric_threshold;
>  			me->metric_unit = pm->unit;
> +			me->pmu_name = pm->pmu;
>  		}
>  	}
>  	free(omg);
> @@ -551,7 +553,8 @@ void metricgroup__print(const struct print_callbacks *print_cb, void *print_stat
>  				me->metric_long_desc,
>  				me->metric_expr,
>  				me->metric_threshold,
> -				me->metric_unit);
> +				me->metric_unit,
> +				me->pmu_name);
>  		next = rb_next(node);
>  		rblist__remove_node(&groups, node);
>  	}
> diff --git a/tools/perf/util/print-events.h b/tools/perf/util/print-events.h
> index 445efa1636c1..8f19c2bea64a 100644
> --- a/tools/perf/util/print-events.h
> +++ b/tools/perf/util/print-events.h
> @@ -25,7 +25,8 @@ struct print_callbacks {
>  			const char *long_desc,
>  			const char *expr,
>  			const char *threshold,
> -			const char *unit);
> +			const char *unit,
> +			const char *pmu_name);
>  	bool (*skip_duplicate_pmus)(void *print_state);
>  };
>  
> -- 
> 2.49.0.1045.g170613ef41-goog

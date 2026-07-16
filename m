Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A643014F112
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 04:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784177198; cv=none; b=AgaJFFhXtNZi8EjBua/ykE2rwk2+eIz+RXJiOumpLihN/A0OsOs/xgiUTcbUUr2CymvKJgwvpdf0yJtCttSHFWPmp3HiCOYiICkg2jFR4uXS6Brnd492zUNxddH5FI0hVRZ5RMIvhrWqiWOiIlO32Nv5HglkrpHK7GkqrrswOEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784177198; c=relaxed/simple;
	bh=UQsjEx9VbsqIyKTWvGGpVTmnsOyIsyvUTtt75plBx4k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hm3xJmq8MOpaapIwpFHk6Fggmk9g8AfXfotf7ukIDhc4TuyFoVtSMx/+SCjqb0D0PuAGsJp4P5EiWWcYhY5Qw9C4FXk7dSA7opDy6LG+zPg4sIyrjjm4NQRUBpigSF0vDoZ8o+sKI7m2PwphxUh6GonKPxfdWJzYbgGYwSR+qyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h03wypv4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h03wypv4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166871F000E9;
	Thu, 16 Jul 2026 04:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784177197;
	bh=25SOIrPZ69unamt0XTIixc6/ztfja3aqAffEpv1uIOI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h03wypv4LM9JgmjWJPcXPgHJ1jKhAJsdMjVAxv31yC/0DEXk0hzYnIaeC3XU+A2Cu
	 ER2/7yKGVtQsYwyd8vhegeTjBqWSgmOSbbBGy2/ukJ+K0R7m/0/+pFUCP6hlj36e0l
	 MUnf0A6uoQbDAHHDnjI0LjnKDkkcHRuFQibLqCUCGBSO9bNcXk8LgwE9y4KYCQiEfz
	 Unc2f2RvgfZtHnnfJfqeNv5R3CX/gf/jo5riIQFOas86s7dkJ3o8FZ8ExSg6LrP8kl
	 aMMLCZEsFZFrpfezXYQa7QdAP2MyVI5W6LIeI8Fmj68NfLoDRqttzJfj4m6ewRnkX/
	 gcgc191WWsQtQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/14] perf stat: Implement streaming JSON formatting
 callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260716043223.388233-11-irogers@google.com>
References: <20260525231900.3527228-1-irogers@google.com>
 <20260716043223.388233-1-irogers@google.com>
 <20260716043223.388233-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 04:46:36 +0000
Message-Id: <20260716044637.166871F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Metric-only mode ignores the provided `evsel` and instead extracts=
 aggregation topology from an unrelated first event in the evlist.
- [High] Unchecked array access into `ps_evsel->aggr` using a potentially n=
egative `aggr_idx`.
- [Medium] The metric unit parameter is ignored, and the metric name is err=
oneously printed as the unit in JSON normal mode.
- [Low] Missing explicit header inclusions for standard POSIX types (`struc=
t timespec` and `bool`), violating musl libc compatibility rules.
--

--- Patch [10]: [PATCH v3 10/14] perf stat: Implement streaming JSON format=
ting callbacks ---
commit 93c595bb0466fb8a1bacc41beea604151270788e
Author: Ian Rogers <irogers@google.com>

perf stat: Implement streaming JSON formatting callbacks
   =20
This patch implements streaming JSON formatting callbacks in=20
util/stat-print-json.c to optimize JSON output. It bypasses dynamic queues
in favor of streaming objects directly to the output. It uses centralized
aggregation helpers and supports interval-mode timestamps.

> diff --git a/tools/perf/util/stat-print-json.c b/tools/perf/util/stat-pri=
nt-json.c
> index 4690c4286fd2a..f168dca70ee09 100644
> --- a/tools/perf/util/stat-print-json.c
> +++ b/tools/perf/util/stat-print-json.c
> @@ -1,13 +1,330 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include "stat-print.h"
> +#include <errno.h>
> +#include <inttypes.h>
> +#include <math.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +
>  #include <linux/compiler.h>
> +#include <linux/kernel.h>

[Severity: Low]
Does this missing explicit inclusion of <time.h> and <stdbool.h> cause
build failures on musl libc systems? The file uses struct timespec
and bool later on, which require these headers under strict POSIX standard
compliance.

[ ... ]

> +static int json_print_metric(void *ctx, const struct perf_stat_config *c=
onfig, struct evsel *evsel,
> +			     int aggr_idx, const char *name, const char *unit __maybe_unused,
> +			     double val, enum metric_threshold_classify thresh)
> +{
> +	struct json_print_state *ps =3D ctx;
> +	FILE *output =3D config->output;
> +	u64 run =3D 0, ena =3D 0;
> +	double enabled_percent =3D 100.0;
> +	struct perf_stat_evsel *ps_evsel =3D evsel->stats;
> +
> +	if (ps_evsel && ps_evsel->aggr) {
> +		run =3D ps_evsel->aggr[aggr_idx].counts.run;
> +		ena =3D ps_evsel->aggr[aggr_idx].counts.ena;
> +	}

[Severity: High]
Can this cause an out-of-bounds memory read? If perf stat runs with a
global aggregation mode like AGGR_GLOBAL, aggr_idx can be passed as -1.

A later check in this same function confirms that aggr_idx can legitimately
be negative:

    if (config->aggr_map && aggr_idx >=3D 0) {

Is it possible to check that aggr_idx >=3D 0 before indexing into
ps_evsel->aggr?

> +
> +	fprintf(output, "{");
> +
> +	/* Print interval timestamp first if configured */
> +	if (config->interval && ps && ps->timestamp[0])
> +		fprintf(output, "%s", ps->timestamp);
> +
> +	/* Print aggregation JSON fields if configured */
> +	if (config->aggr_map && aggr_idx >=3D 0) {
> +		struct aggr_cpu_id id =3D config->aggr_map->map[aggr_idx];
> +		int aggr_nr =3D 0;
> +
> +		if (evsel->stats && evsel->stats->aggr)
> +			aggr_nr =3D evsel->stats->aggr[aggr_idx].nr;
> +
> +		print_aggr_id_json(config, output, evsel, id, aggr_nr);
> +	}
> +
> +	if (run !=3D ena)
> +		enabled_percent =3D 100.0 * run / ena;
> +	fprintf(output, "\"event-runtime\" : %" PRIu64 ", \"pcnt-running\" : %.=
2f", run,
> +		enabled_percent);
> +	fprintf(output, ", \"metric-value\" : \"%f\"", val);
> +	if (name && name[0])
> +		fprintf(output, ", \"metric-unit\" : \"%s\"", name);

[Severity: Medium]
Is this printing the metric name instead of the metric unit?

The function parameter for unit is marked as __maybe_unused, and the
string interpolated for "metric-unit" is the name variable.

> +	if (thresh !=3D METRIC_THRESHOLD_UNKNOWN) {
> +		fprintf(output, ", \"metric-threshold\" : \"%s\"",
> +			metric_threshold_classify__str(thresh));
> +	}
> +	fprintf(output, "}\n");
> +
> +	return 0;
> +}

[ ... ]

> +static int json_metric_only_print_metric(void *ctx,
> +					 const struct perf_stat_config *config __maybe_unused,
> +					 struct evsel *evsel __maybe_unused, int aggr_idx,
> +					 const char *name, const char *unit, double val,
> +					 enum metric_threshold_classify thresh __maybe_unused)
> +{
> +	struct json_metric_only_print_state *ps =3D ctx;
> +	FILE *output =3D ps->fp;
> +
> +
> +	if (aggr_idx !=3D ps->last_aggr_idx) {
> +		if (ps->last_aggr_idx !=3D -2)
> +			fprintf(output, "}\n");
> +		fprintf(output, "{");
> +		if (config->interval && ps->timestamp[0])
> +			fprintf(output, "%s", ps->timestamp);
> +		if (config->aggr_map && aggr_idx >=3D 0) {
> +			struct aggr_cpu_id id =3D config->aggr_map->map[aggr_idx];
> +			struct evsel *mock_evsel =3D list_first_entry(&ps->evlist->core.entri=
es,
> +								    struct evsel, core.node);
> +			int aggr_nr =3D 0;
> +
> +			if (mock_evsel->stats && mock_evsel->stats->aggr)
> +				aggr_nr =3D mock_evsel->stats->aggr[aggr_idx].nr;
> +
> +			print_aggr_id_json(config, output, mock_evsel, id, aggr_nr);

[Severity: High]
Does this ignore the provided evsel associated with the metric?

This code grabs the first entry in the evlist as a mock_evsel and passes
it to print_aggr_id_json(). If the evlist contains heterogeneous events with
different thread maps or aggregation stat arrays, could accessing them
with the current aggr_idx cause an out-of-bounds read?

> +		}
> +		ps->last_aggr_idx =3D aggr_idx;
> +		ps->first_in_group =3D true;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716043223.3882=
33-1-irogers@google.com?part=3D10

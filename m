Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475BD14AD20
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 04:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784177088; cv=none; b=L1kd1hDYFK+QgFf+itPlTyfQwh+SFgMa0y0IwHzR1fMTFpNQslkB7sT/UJZT54rCMo/aPZHjE6G6cFwE0N2vUNiCebsGEtT+txi1/x1cFDLq+xN521Ue9HykmL2/CmtELOjTVGw72aEZqjgZczqO4rufMQx2N2XVHl5ANKDDV2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784177088; c=relaxed/simple;
	bh=kAP4HjZIX583GGlU04jxjaar5xmkdgDeHFKhzS/GKRg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DrxtOa1j6X1EC7/k+R6QF9nqyjT3AKosAkDIoYDWvHIO7v0zM6RgvkjH942EtrNNZPykh+VCoZyUGCdjtC1UjVh9EU18Pj1Leg38thw75fWP5O9fzM9lutpzch1ACJOrGiwzroQgkGWYH0stEq/JqF1IjZRSgMWTJVVcg81oRxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJNKV65L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJNKV65L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB991F000E9;
	Thu, 16 Jul 2026 04:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784177086;
	bh=7bBuzbRpMDbWk+i4cftzFJX2hoxH+rUy1M1j/TSwn1w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VJNKV65LoNwivVRnOm1IgPfNyDhT/lHk5HEOw80nlADTdNKVuzkdOUIQcMgF4h9/3
	 FYeSqZLFhAmyh2b+IOZfpuHOkBtcK5BlMrZ+9FROlom86boOOLUzQBBfgvXrm1LAYq
	 ncmPZRRnI71OPpQwvWZpKQrr54H8tFCc3ytXIAl5mIPvlEuYN6R0OTMWAEwyt3jPyR
	 05uUd1qAiaOCWnSv7yE+jkBnIaXNsa3rntXrj78Rf2jR0I9p+odCg6L3qOa17W+8bt
	 cWz0eNr96k0xQ8U7tk/4rnIj1pyvne5EtWC2LT8sqFyF7pysfC1R1HwZFlO+uKzI8V
	 s6mVFkb5OSqfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/14] perf stat: Implement standard console (STD)
 formatting callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260716043223.388233-3-irogers@google.com>
References: <20260525231900.3527228-1-irogers@google.com>
 <20260716043223.388233-1-irogers@google.com>
 <20260716043223.388233-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 04:44:46 +0000
Message-Id: <20260716044446.ACB991F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] In metric-only mode, `std_metric_only_print_end` arbitrarily uses =
the first `evsel` (`mock_evsel`) to format all aggregation IDs, causing pot=
ential out-of-bounds accesses.
- [Low] Missing explicit inclusion of `<time.h>`, `<sys/time.h>`, `<sys/res=
ource.h>`, and `<stdbool.h>` for musl compatibility.
- [Low] Negative width parameter in `fprintf` causes massive incorrect padd=
ing.

Pre-existing issues:
- [High] Uninitialized stack variable `unit` is passed to metric formatting=
 callbacks.
--

--- Patch [2]: [PATCH v3 02/14] perf stat: Implement standard console (STD)=
 formatting callbacks ---
commit be046d24ddd91343fbf91452501c8366f0f6e34b
Author: Ian Rogers <irogers@google.com>

perf stat: Implement standard console (STD) formatting callbacks

This patch implements standard console formatting callbacks inside
util/stat-print-std.c to replace empty stubs. It introduces
queued_event and queued_metric structures to buffer traversal streams.
It also utilizes centralized aggregation helpers for CPU and thread
prefixes.

> diff --git a/tools/perf/util/stat-print-std.c b/tools/perf/util/stat-prin=
t-std.c
> --- a/tools/perf/util/stat-print-std.c
> +++ b/tools/perf/util/stat-print-std.c
> @@ -1,13 +1,828 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include "stat-print.h"
> +#include <errno.h>
> +#include <math.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +
> +#include <linux/compiler.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>

[Severity: Low]
Does this code compile on musl libc systems?

The timeval2double() function dereferences struct timeval, and
print_footer_std() accesses struct rusage, but <sys/time.h>,
<sys/resource.h>, <time.h>, and <stdbool.h> are not explicitly included.

[ ... ]

> +static int std_print_metric(void *ctx, const struct perf_stat_config *co=
nfig __maybe_unused,
> +			    struct evsel *evsel __maybe_unused, int aggr_idx __maybe_unused,
> +			    const char *name, const char *unit, double val,
> +			    enum metric_threshold_classify thresh)
> +{
> +	struct std_print_state *ps =3D ctx;
> +	struct queued_metric *b;
> +
> +	if (!ps->current_event)
> +		return 0;

[ ... ]

> +	b->name =3D strdup(name);
> +	if (!b->name) {
> +		free(b);
> +		return -ENOMEM;
> +	}
> +
> +	if (unit && unit[0]) {
> +		b->unit =3D strdup(unit);

[Severity: High]
This is a pre-existing issue, but does this function occasionally receive
an uninitialized stack pointer?

In tools/perf/util/stat-print.c:calculate_and_print_metric():

    char *unit;
    ...
    if (perf_pmu__convert_scale(metric_unit, &unit, &scale) >=3D 0)
        ratio *=3D scale;
    ...
    cb->print_metric(..., unit, ...);

If perf_pmu__convert_scale() fails (e.g., -ENOMEM from parse_double), it
returns a negative value without initializing the unit pointer. This
callback might then call strdup(unit) or dereference unit[0] on
uninitialized stack memory.

[ ... ]

> +static int std_print_end(void *ctx, const struct perf_stat_config *confi=
g)
> +{

[ ... ]

> +		/* 2. Print event value (scaled) or spaces if metricgroup */
> +		if (is_metricgroup) {
> +			if (!skip_header) {
> +				int n =3D fprintf(out, " %*s", EVNAME_LEN, full_name);
> +
> +				fprintf(out, "%*s", MGROUP_LEN + config->unit_width + 2 - n, "");

[Severity: Low]
Can this cause incorrect padding in the console output?

If the metricgroup or PMU name length causes n to be greater than
MGROUP_LEN + config->unit_width + 2, the calculated width passed to
fprintf() will be negative.

[ ... ]

> +static int std_metric_only_print_end(void *ctx, const struct perf_stat_c=
onfig *config)
> +{

[ ... ]

> +	/* Print values */
> +	list_for_each_entry_safe(b, tmp, &ps->queued_metrics, list) {
> +		if (b->aggr_idx !=3D current_aggr) {
> +			if (current_aggr !=3D -2)
> +				fprintf(out, "\n");
> +			current_aggr =3D b->aggr_idx;
> +			if (config->interval && ps->timestamp[0])
> +				fprintf(out, "%s", ps->timestamp);
> +			if (config->aggr_map && current_aggr >=3D 0) {
> +				struct aggr_cpu_id id =3D config->aggr_map->map[current_aggr];
> +				struct evsel *mock_evsel =3D list_first_entry(
> +					&ps->evlist->core.entries,
> +					struct evsel, core.node);
> +				int aggr_nr =3D 0;
> +
> +				if (mock_evsel->stats && mock_evsel->stats->aggr)
> +					aggr_nr =3D mock_evsel->stats->aggr[current_aggr].nr;
> +
> +				print_aggr_id_std(config, out, mock_evsel, id, aggr_nr);

[Severity: High]
Could this lead to an out-of-bounds access?

In metric-only mode with AGGR_THREAD aggregation, we arbitrarily use the
first evsel (mock_evsel) to format all aggregation IDs. If the actual
metric was generated by a different event that has more threads than this
system-wide dummy mock_evsel, print_aggr_id_std() could extract an
id.thread_idx that exceeds mock_evsel->core.threads->nr.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716043223.3882=
33-1-irogers@google.com?part=3D2

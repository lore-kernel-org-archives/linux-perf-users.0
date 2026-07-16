Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A633876A1
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 04:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784177254; cv=none; b=KFyUOvPD7aHemtlbxkvk1VyLYGwU4mC1UJxGn1Uq6wIGL0t9xUzFTWY0TAHLYGu0YKiGIq7vXMRiRHzA8JMh7ifCcS/DVANQm+wpzAsX4mq7dhc0a8LImZ0wsomHbOB4RFmJz+mXBdjzEcUXc/etdQAOHFQzvXJ5isS55KzdzMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784177254; c=relaxed/simple;
	bh=cWfRZ17QfmtC6MUEeqPIm53TcQM8iMmV8b+607cD/4c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DH7TWc5xmXMtNKspnJiVG/DFmLoZOE4SMLPLuBPoS8fKK6XhtjXwfljavMSXaBW4nMTMFSgZ5cC0KVQrya0j6S7jnYXLRUtyQ04A35N9RhsAgm3wKA0AvU4YDiZACaTA+SaGDRdQkXudN75maKbR6dolddAq0jPLrTrpl2Xqoa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yslvuda7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yslvuda7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431A31F000E9;
	Thu, 16 Jul 2026 04:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784177252;
	bh=ku+H5nKMOceN0hpOFLP/CeU1SquMABlM+r6rd9O5PLA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Yslvuda7igG9tYDF17H8JPS6a6PPjnxbEFYXLqYjh3ouiMr+sVRXhKE11BUIaWghI
	 MsoWF3x9Of0lBaT3y8oRNO1BBttGdz1UrTHxdblJplExpGjo0yUG2x1KJeo6ZlmZKA
	 /bTkDqmUVi0ZMeJ5cOWaKrjSZbb8i6wwwk21FWf36ysnkyHBZqKlxP/PW/8OHrV5Nb
	 2mAPwcNhF6JoD7d5DqYGX36b8NbJ81CZN2iAKZxkC9AJvIlDwVGT2VShrDfrrmcYcw
	 dK9v4bunPQecjcTKwmqw2zBjzaoL2iCc15o2C6w4yzu5bJbY57wT1Wpj0xj1PmrEHw
	 w2qbjKIwmRCgg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/14] perf stat: Introduce core generic print
 traversal engine and header stubs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260716043223.388233-2-irogers@google.com>
References: <20260525231900.3527228-1-irogers@google.com>
 <20260716043223.388233-1-irogers@google.com>
 <20260716043223.388233-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 04:47:31 +0000
Message-Id: <20260716044732.431A31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] Crash in `is_basic_shadow_metric` if `mexp->metric_name` is NULL.
- [High] NULL pointer dereferences in metric calculation when `config->aggr=
_map` is NULL.
- [High] The new `is_basic_shadow_metric` filter erroneously drops all cust=
om user metrics in standard output mode.
- [Medium] The core display traversal driver completely omits `should_skip_=
zero_counter()` logic, resulting in massive log spam.
- [Low] Manual forward declaration of standard POSIX type `struct timespec`=
 violates musl compatibility guidelines.

Pre-existing issues:
- [High] Uninitialized pointer `unit` is passed to `cb->print_metric()` if =
`perf_pmu__convert_scale()` fails.
--

--- Patch [1]: [PATCH v3 01/14] perf stat: Introduce core generic print tra=
versal engine and header stubs ---
commit 82eac7a69c1cb36c36fa86107ab3ce1a2fd91c7d
Author: Ian Rogers <irogers@google.com>

perf stat: Introduce core generic print traversal engine and header stubs

This patch introduces the initial infrastructure for decoupling the perf st=
at
printing API. It declares the struct perf_stat_print_callbacks interface
and the generic traversal driver perf_stat__print_cb() alongside format-agn=
ostic
shared helpers.

> diff --git a/tools/perf/util/stat-print.c b/tools/perf/util/stat-print.c
> new file mode 100644
> index 0000000000000..0fff50dce80be
> --- /dev/null
> +++ b/tools/perf/util/stat-print.c
[ ... ]
> +static bool tool_pmu__is_time_event(const struct perf_stat_config *confi=
g,
> +				    const struct evsel *evsel, int *tool_aggr_idx)
> +{
> +	enum tool_pmu_event event =3D evsel__tool_event(evsel);
> +	int aggr_idx;
> +
> +	if (event !=3D TOOL_PMU__EVENT_DURATION_TIME && event !=3D TOOL_PMU__EV=
ENT_USER_TIME &&
> +	    event !=3D TOOL_PMU__EVENT_SYSTEM_TIME)
> +		return false;
> +
> +	if (config) {
> +		cpu_aggr_map__for_each_idx(aggr_idx, config->aggr_map) {

[Severity: High]
Can this dereference a NULL config->aggr_map?

In perf_stat__print_cb(), there is a fallback path where config->aggr_map is
NULL. It calls perf_stat_print_metrics(..., 0), which calls prepare_metric(=
).
When prepare_metric() invokes tool_pmu__is_time_event(), the macro
cpu_aggr_map__for_each_idx() appears to dereference aggr_map->nr without
checking if the map is NULL.

[ ... ]
> +static int prepare_metric(const struct perf_stat_config *config, const s=
truct metric_expr *mexp,
> +			  struct evsel *evsel, struct expr_parse_ctx *pctx, int aggr_idx)
> +{
[ ... ]
> +		if (!ps || !metric_events[i]->supported) {
> +			val =3D NAN;
> +			source_count =3D 0;
> +		} else {
> +			struct perf_stat_aggr *aggr =3D
> +				&ps->aggr[is_tool_time ? tool_aggr_idx : aggr_idx];
> +
> +			if (aggr->counts.run =3D=3D 0) {

[Severity: High]
Does this code dereference a NULL pointer when config->aggr_map is NULL?

If we reach this path from the fallback branch in perf_stat__print_cb() whe=
re
config->aggr_map is NULL, ps->aggr will also be NULL.

[ ... ]
> +static int calculate_and_print_metric(const struct perf_stat_config *con=
fig,
> +				      const struct perf_stat_print_callbacks *cb, void *outer_ctx,
> +				      struct metric_expr *mexp, struct evsel *evsel, int aggr_idx)
> +{
[ ... ]
> +			char *unit;
> +
> +			if (metric_threshold &&
> +			    expr__parse(&threshold, pctx, metric_threshold) =3D=3D 0 &&
> +			    !isnan(threshold)) {
> +				thresh =3D fpclassify(threshold) =3D=3D FP_ZERO ? METRIC_THRESHOLD_G=
OOD :
> +									    METRIC_THRESHOLD_BAD;
> +			}
> +
> +			if (metric_unit && metric_name) {
> +				if (perf_pmu__convert_scale(metric_unit, &unit, &scale) >=3D 0)
> +					ratio *=3D scale;
> +
> +				ret =3D cb->print_metric(outer_ctx, config, evsel, aggr_idx,
> +						       metric_name, unit, ratio, thresh);

[Severity: High]
This is a pre-existing issue, but does this pass an uninitialized unit poin=
ter
to print_metric() if perf_pmu__convert_scale() fails?

If perf_pmu__convert_scale() returns a negative value, unit will remain
uninitialized. The call to cb->print_metric() sits outside the success chec=
k,
so it seems we'll pass whatever happens to be on the stack.

> +			} else {
> +				ret =3D cb->print_metric(outer_ctx, config, evsel, aggr_idx,
> +						       metric_name ?: (evsel->name ?: ""), NULL,
> +						       ratio, thresh);
> +			}
> +		}
> +	}
> +
> +	expr__ctx_free(pctx);
> +	return ret;
> +}
> +
> +/**
> + * perf_stat_print_metricgroup - Traverse metrics for an event.
> + *
> + * Returns 0 on success, or a negative error code on failure.
> + */
> +static bool is_basic_shadow_metric(const char *name)
> +{
> +	static const char *const basic_metrics[] =3D {
> +		"insn_per_cycle",   "branch_miss_rate",	      "branch_frequency",
> +		"cycles_frequency", "page_faults_per_second", "migrations_per_second",
> +		"cs_per_second",    "CPUs_utilized",
> +	};
> +	for (size_t i =3D 0; i < ARRAY_SIZE(basic_metrics); i++) {
> +		if (!strcmp(basic_metrics[i], name))

[Severity: High]
Can this strcmp() trigger a segmentation fault if name is NULL?

In calculate_and_print_metric() just above, metric_name is handled as
potentially NULL. If mexp->metric_name is NULL here, we might crash.

> +			return true;
> +	}
> +	return false;
> +}
> +
> +static int perf_stat_print_metricgroup(const struct perf_stat_config *co=
nfig,
> +				       const struct perf_stat_print_callbacks *cb, void *outer_ctx,
> +				       struct evsel *evsel, int aggr_idx)
> +{
> +	struct metric_event *me;
> +	struct metric_expr *mexp;
> +	struct rblist *metric_events =3D &evsel->evlist->metric_events;
> +	int ret;
> +
> +	me =3D metricgroup__lookup(metric_events, evsel, false);
> +	if (me =3D=3D NULL)
> +		return 0;
> +
> +	list_for_each_entry(mexp, &me->head, nd) {
> +		if (!config->metric_only &&
> +		    (!evsel->default_metricgroup || evsel->default_show_events)) {
> +			if (!is_basic_shadow_metric(mexp->metric_name))
> +				continue;

[Severity: High]
Does this logic erroneously filter out all custom user metrics?

When a user specifies a custom metric, evsel->default_metricgroup is false.
Unless running in --metric-only mode, the condition evaluates to true, and
is_basic_shadow_metric() will return false for the custom metric, causing t=
he
loop to drop it entirely.

> +		}
> +
> +		ret =3D calculate_and_print_metric(config, cb, outer_ctx, mexp, evsel,=
 aggr_idx);
> +		if (ret)
> +			return ret;
> +	}
> +	return 0;
> +}
[ ... ]
> +int perf_stat__print_cb(struct evlist *evlist, const struct perf_stat_co=
nfig *config,
> +			const struct target *target __maybe_unused,
> +			const struct timespec *ts __maybe_unused, int argc __maybe_unused,
> +			const char **argv __maybe_unused,
> +			const struct perf_stat_print_callbacks *cb, void *ctx)
> +{
[ ... ]
> +		if (config->aggr_map) {
> +			cpu_aggr_map__for_each_idx(aggr_idx, config->aggr_map) {
> +				evlist__for_each_entry(evlist, counter) {
[ ... ]
> +					if (cb->print_event) {
> +						double stdev_pct =3D 0.0;
> +
> +						if (ps && ps->res_stats.n > 1) {
> +							stdev_pct =3D rel_stddev_stats(
> +								stddev_stats(&ps->res_stats), val);
> +						}
> +						ret =3D cb->print_event(ctx, config, counter,
> +								      aggr_idx, val, ena, run,
> +								      stdev_pct);

[Severity: Medium]
Will this omission of should_skip_zero_counter() logic result in log spam?

The loop iterates over all counters and unconditionally calls print_event()
for them, even if they have zero counts and shouldn't be printed for this C=
PU
map, which could break legacy output expectations by printing irrelevant un=
core
events.

> +						if (ret)
> +							goto out;
> +					}
[ ... ]
> diff --git a/tools/perf/util/stat-print.h b/tools/perf/util/stat-print.h
> new file mode 100644
> index 0000000000000..a86414f325841
> --- /dev/null
> +++ b/tools/perf/util/stat-print.h
> @@ -0,0 +1,133 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __PERF_STAT_PRINT_H
> +#define __PERF_STAT_PRINT_H
> +
> +#include <linux/types.h>
> +
> +#include "stat.h"
> +
> +#define CNTR_NOT_SUPPORTED "<not supported>"
> +#define CNTR_NOT_COUNTED "<not counted>"
> +
> +struct evlist;
> +struct perf_stat_config;
> +struct target;
> +struct timespec;

[Severity: Low]
Is this manual forward declaration of struct timespec going to cause build
failures on musl libc systems?

According to POSIX compatibility guidelines for musl, standard libc types
should not be forward declared manually. Instead, the appropriate header
should be explicitly included.

> +struct evsel;
> +struct aggr_cpu_id;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716043223.3882=
33-1-irogers@google.com?part=3D1

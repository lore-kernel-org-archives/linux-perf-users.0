Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76963546F6
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 07:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784186209; cv=none; b=bTk8RqRBvPrAraoZTD6MlTA8PC577oWa/nV5fZUkBkgZQ0HoA50jaU3KUdB2hADQB9s6ySxT/ByeOELkQ/h+lrbRxzudwJy+aO0OHxTk0KH8BZcbJNr4h78k89JHDQ5b+O01pKsYpo/eM1HP2a5RcXMohNyL2z2vUo4S6i66Wdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784186209; c=relaxed/simple;
	bh=DbDPoZGeJAwtjMZJE/0C6/r8PqV+G/C1prmMjz1dpns=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Wd1++2W45hjSFWurOvbegJk7YZeFO3OpVamictiOCzQC2Vmd5or2R8m0RroAZkCwdODzusQDM3sBaME6rgK5R2T4rSeQlWNYJ5dsvlhRisqJbPE4zH2aDEfIbITcuo0+i4t9ff4T6wN10hEdAkMKSnJ+S5aaFwNRmTVm44c8NZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPhsP5Ie; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPhsP5Ie"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 139AC1F00A3A;
	Thu, 16 Jul 2026 07:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784186207;
	bh=bKT56aqxixZo9isACKeqgZPHbUtxbHPuO1kx/d4igyc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JPhsP5IePocruaORZHcz6DW9JEvE8ndPnCkTKUiA8CYLODWRksWAp9dzYvQrtAFCL
	 Tx6dd1Vv8GJ+UWGe+CfN3d+rliSQiD9HVcfjRjGIeIgUH0HwpDtlPdvMdsrsX6SYJ2
	 XYPXBhWTSZG1Z3uPYZ/hmnGp4QOnmxTDk348WVilSS/IaEu09BHSoUBtO5JPgfVP3k
	 dhZwA/iBIe+zdkrza4N7DXl+I07oPQfTQhoN/zG3Zrc84U4n3lrKiB17NsSyL3/KFJ
	 jVI0Sr1aTejZReaMLQI9+Xhxvd+UKArrFFzpxAOgzpyPnf4WUTYgkllGjVrwUA+gCE
	 uRWoMu3ocI8zA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/14] perf stat: Introduce core generic print
 traversal engine and header stubs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260716070303.507066-2-irogers@google.com>
References: <20260716043223.388233-1-irogers@google.com>
 <20260716070303.507066-1-irogers@google.com>
 <20260716070303.507066-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 07:16:46 +0000
Message-Id: <20260716071647.139AC1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] The traversal loops in `perf_stat__print_cb()` incorrectly group `=
AGGR_NONE` and `AGGR_THREAD` under the `aggr_idx` outer loop, structurally =
inverting legacy output ordering.
- [Medium] The function `is_basic_shadow_metric()` is defined but never cal=
led, leaving the intended metric allowlist filtering completely unimplement=
ed.
- [Medium] The new traversal engine `perf_stat__print_cb()` omits the `shou=
ld_skip_zero_counter()` check, which will cause it to incorrectly emit unwa=
nted zero-valued and unsupported counters once the formatting callbacks are=
 implemented.
- [Medium] `perf_stat__get_aggr_id_char()` unconditionally writes to `buf[0=
]` in its default fallback path without validating if `buf_size > 0`.
- [Medium] The newly added `--new` command-line flag silently suppresses al=
l performance counter output.
--

--- Patch [1]: [PATCH v4 01/14] perf stat: Introduce core generic print tra=
versal engine and header stubs ---
commit 0d5894df730b71c5e2e9d44337a7acb89dd22010
Author: Ian Rogers <irogers@google.com>

perf stat: Introduce core generic print traversal engine and header stubs

This patch introduces the initial infrastructure for decoupling the perf st=
at
printing API. It implements the generic traversal driver and format-agnostic
shared helpers, and adds empty format-specific stubs.

> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index a04466ea3b0a0..6768ba256a5a2 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
[ ... ]
> @@ -1091,7 +1094,10 @@ static void print_counters(struct timespec *ts, in=
t argc, const char **argv)
>  	if (quiet)
>  		return;
> =20
> -	evlist__print_counters(evsel_list, &stat_config, &target, ts, argc, arg=
v);
> +	if (use_perf_stat_print)
> +		perf_stat__print(evsel_list, &stat_config, &target, ts, argc, argv);

[Severity: Medium]
The --new command-line flag routes execution to the new perf_stat__print() =
API,
which currently relies on empty stubs like perf_stat__print_std() that
immediately return 0. If a user runs perf stat --new, will the tool execute
the workload but silently print absolutely no counter statistics?

> +	else
> +		evlist__print_counters(evsel_list, &stat_config, &target, ts, argc, ar=
gv);
>  }
[ ... ]
> diff --git a/tools/perf/util/stat-print.c b/tools/perf/util/stat-print.c
> new file mode 100644
> index 0000000000000..419fecfd91988
> --- /dev/null
> +++ b/tools/perf/util/stat-print.c
[ ... ]
> +int perf_stat__get_aggr_id_char(const struct perf_stat_config *config, s=
truct evsel *evsel,
> +				struct aggr_cpu_id id, char *buf, size_t buf_size)
> +{
> +	switch (config->aggr_mode) {
[ ... ]
> +	case AGGR_GLOBAL:
> +	case AGGR_UNSET:
> +	case AGGR_MAX:
> +	default:
> +		break;
> +	}
> +	buf[0] =3D '\0';

[Severity: Medium]
In the default fallback path, buf[0] is written unconditionally without
verifying if buf_size > 0. If a caller passes buf_size =3D=3D 0 or buf =3D=
=3D NULL,
could this lead to an out-of-bounds write or a NULL pointer dereference?

> +	return -1;
> +}
[ ... ]
> +static bool __maybe_unused is_basic_shadow_metric(const char *name)
> +{

[Severity: Medium]
The commit message mentions implementing the basic metrics allowlist filter
using is_basic_shadow_metric(), but the function is marked static, silenced
with __maybe_unused, and never called in the traversal logic. Will this
leave the intended filtering logic completely unimplemented?

> +	static const char *const basic_metrics[] =3D {
> +		"insn_per_cycle",   "branch_miss_rate",	      "branch_frequency",
> +		"cycles_frequency", "page_faults_per_second", "migrations_per_second",
> +		"cs_per_second",    "CPUs_utilized",
> +	};
[ ... ]
> +int perf_stat__print_cb(struct evlist *evlist, struct perf_stat_config *=
config,
> +			const struct target *target __maybe_unused,
> +			const struct timespec *ts __maybe_unused, int argc __maybe_unused,
> +			const char **argv __maybe_unused,
> +			const struct perf_stat_print_callbacks *cb, void *ctx)
> +{
[ ... ]
> +	switch (config->aggr_mode) {
> +	case AGGR_GLOBAL:
> +	case AGGR_NONE:
> +	case AGGR_SOCKET:
> +	case AGGR_DIE:
> +	case AGGR_CLUSTER:
> +	case AGGR_CACHE:
> +	case AGGR_CORE:
> +	case AGGR_THREAD:
> +	case AGGR_NODE:
> +		if (config->aggr_map) {
> +			cpu_aggr_map__for_each_idx(aggr_idx, config->aggr_map) {
> +				evlist__for_each_entry(evlist, counter) {

[Severity: High]
In the legacy implementation, AGGR_NONE and AGGR_THREAD modes iterate over
the events in the outer loop and the CPUs/threads in the inner loop,
grouping the output by event.

Here, they are grouped under the same block as AGGR_CORE, placing CPUs/thre=
ads
in the outer loop and events in the inner loop.

Will this structurally invert the output ordering and break backward
compatibility for tools parsing the standard or CSV output?

> +					struct perf_stat_evsel *ps =3D counter->stats;
> +					u64 val =3D 0, ena =3D 0, run =3D 0;
[ ... ]
> +					if (perf_stat__skip_metric_event(counter))
> +						continue;
> +
> +					if (cb->print_event) {

[Severity: Medium]
The legacy implementation uses should_skip_zero_counter() to suppress
output for zero-valued counters that are disabled, unsupported, or explicit=
ly
hidden. In the new perf_stat__print_cb() engine, this check appears to be
missing before calling cb->print_event().

Could this cause the output to be polluted with zeroes and '<not counted>'
strings once the callbacks are implemented?

> +						double stdev_pct =3D 0.0;
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716070303.5070=
66-1-irogers@google.com?part=3D1

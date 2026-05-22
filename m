Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B90D280CE5
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 22:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779490487; cv=none; b=WfT1Yd2NOMStCAsqDTkQroYYtFaldART8/l54OFDirs3h5bcA9kMfzYQZ1zr+YjoiWaWVed/LfI1d7z34ERbNGUN5LoqMIUHrLf+zsxpqIKNLAWoepLh0/vJvI5k+iMQQyj3XgqD6C5oaJDLV1zRHs20kNjcPStUFffgZNAh7yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779490487; c=relaxed/simple;
	bh=hTmZl57x9YUdP6+pKNa1miABzHxQG65IdcdReAec77k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=If+2ACBkOHjdFNog4gNmWsmjobjcIwXZ7k3W/ZtpmscaZdr88H8vilC5594xnsahlyX3mWkXMgIup2nCSCTikvPDYzMmYnO3AwrQcGUR5kEhBTFuqUpV23hibk/5u9WWSYuVkoStqiZMGcKK8d9dyDhOlQaEyapPz0rFbitA9EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHwG36gC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHwG36gC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C60A1F000E9;
	Fri, 22 May 2026 22:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779490486;
	bh=mbOaBS2mFnlBczX9uBKlVLGaZB/IYekoG2rCRdbEQBc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NHwG36gCCgLN5aW+FLXnfljrpDt8JTOU7b0P/867bq7gUDl/YqpCSDQ6laim2PhX4
	 t6QMyHxsOgjzWOAjp2pxLYdERtBAY5grtaCR5U0SUZuDL5MKNiIwd8WZ6+Zm3US/Tt
	 XEBv4FwP2ZAvLmvDIzEdsjYuxGXGw7SSEs7NrOlXWEaigjQbZrvY0A7g2PBWq2Qm2V
	 EKVeJwl7uGnNxDIfhRU1bHDv3dnxiMp1bfC/VQTa74VYGs0v7EOK8XIY7R+cQr/9aC
	 NpLiaAWi1y9WmbGkR9KtO36Z76KexYbZRwI8saZ9Qe75qHOapPfieVuopDL+TY22Dz
	 KU50KXrLLSSMA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 02/14] perf stat: Implement standard console
 (STD) formatting callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260522223342.2393553-3-irogers@google.com>
References: <20260522223342.2393553-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 22:54:45 +0000
Message-Id: <20260522225446.1C60A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Skipping a zero-valued counter leaves a stale `current_event` poin=
ter, causing a false temporal coupling violation and aborting the printing =
process.
- [High] Unchecked `aggr_idx` parameter in `should_skip_zero_counter` can l=
ead to an out-of-bounds array access.
- [Medium] Queued events and metrics are leaked if the traversal callback c=
hain fails early.
- [Medium] In interval mode with `--metric-only`, metric column headers are=
 repeatedly printed for every interval.
--

commit 574c7c40ab2b1b89dd11b7fbe55c2b8a5b292b35
Author: Ian Rogers <irogers@google.com>

perf stat: Implement standard console (STD) formatting callbacks

This patch implements standard console formatting callbacks inside
util/stat-print-std.c. It uses buffered DOM nodes for streams and
centralizes aggregation helpers for prefixes and interval-mode timestamp
support.

> diff --git a/tools/perf/util/stat-print-std.c b/tools/perf/util/stat-prin=
t-std.c
> index 83987e97c8895..0aa4e2669bbaa 100644
> --- a/tools/perf/util/stat-print-std.c
> +++ b/tools/perf/util/stat-print-std.c

[ ... ]

> +static bool should_skip_zero_counter(const struct perf_stat_config *conf=
ig, struct evsel *counter,
> +				     int aggr_idx)
> +{
> +	struct perf_cpu cpu;
> +	unsigned int idx;
> +	struct aggr_cpu_id id;
> +
> +	if (verbose =3D=3D 0 && counter->skippable && !counter->supported)
> +		return true;
> +
> +	if (config->metric_only)
> +		return false;
> +
> +	if (config->aggr_mode =3D=3D AGGR_THREAD && config->system_wide)
> +		return true;
> +
> +	if (!config->aggr_map || !config->aggr_get_id)
> +		return false;
> +
> +	id =3D config->aggr_map->map[aggr_idx];

[Severity: High]
Can this result in an out-of-bounds array access?

When using global aggregation modes or unaggregated events, aggr_idx can
be -1. If so, config->aggr_map->map[aggr_idx] would read before the array
base.

> +
> +	if (evsel__is_tool(counter)) {
> +		struct aggr_cpu_id own_id =3D config->aggr_get_id((struct perf_stat_co=
nfig *)config,

[ ... ]

> +static int std_print_event(void *ctx, const struct perf_stat_config *con=
fig, struct evsel *evsel,
> +			   int aggr_idx, u64 val, u64 ena, u64 run, double stdev_pct)
> +{
> +	struct std_print_state *ps =3D ctx;
> +	struct queued_event *ev;
> +
> +	/* Skip zero counters locally in STD callbacks if they qualify */
> +	if (val =3D=3D 0 && should_skip_zero_counter(config, evsel, aggr_idx))
> +		return 0;

[Severity: High]
Does returning early here leave ps->current_event pointing to the
previous event?

If the traversal driver synchronously invokes std_print_metric() for this
skipped event, it will compare the passed evsel against the old
ps->current_event->evsel, triggering the temporal coupling violation
error and aborting the print.

> +
> +	ev =3D malloc(sizeof(*ev));
> +	if (!ev)
> +		return -ENOMEM;

[ ... ]

> +static int std_metric_only_print_end(void *ctx, const struct perf_stat_c=
onfig *config)
> +{
> +	struct std_metric_only_print_state *ps =3D ctx;
> +	struct queued_metric *b, *tmp;
> +	FILE *out =3D ps->fp;
> +	int first_aggr =3D -1;
> +	int current_aggr =3D -1;
> +	const char *color;
> +	char *str;
> +	int mlen;
> +	int ret =3D 0;
> +	int err;
> +
> +	if (list_empty(&ps->queued_metrics))
> +		return 0;
> +
> +	/* Print the formatted header prefix */
> +	if (!config->interval)
> +		print_header_std(config, ps->target, ps->argc, ps->argv);
> +
> +	first_aggr =3D list_first_entry(&ps->queued_metrics, struct queued_metr=
ic, list)->aggr_idx;
> +
> +	/* Print headers */
> +	list_for_each_entry(b, &ps->queued_metrics, list) {

[Severity: Medium]
Is it intended for the metric column headers to print unconditionally here?

In interval mode, perf_stat__print_cb() calls this end callback
repeatedly, which appears to cause the header row to print before every
interval's row of values instead of just once at the beginning.

> +		if (b->aggr_idx =3D=3D first_aggr) {
> +			char *header_name;
> +			if (b->unit && b->unit[0]) {

[ ... ]

> +int perf_stat__print_std(struct evlist *evlist, const struct perf_stat_c=
onfig *config,
> +			 const struct target *target, const struct timespec *ts, int argc,
> +			 const char **argv)
> +{
> +	struct std_print_state ps =3D {
> +		.fp =3D config->output,
> +		.target =3D target,
> +		.argc =3D argc,
> +		.argv =3D argv,
> +	};
> +
> +	if (config->metric_only) {
> +		struct std_metric_only_print_state mops =3D {
> +			.fp =3D config->output,
> +			.target =3D target,
> +			.argc =3D argc,
> +			.argv =3D argv,
> +		};
> +		if (config->interval && ts) {
> +			scnprintf(mops.timestamp, sizeof(mops.timestamp), "%6lu.%09lu ",
> +				  (unsigned long)ts->tv_sec, ts->tv_nsec);
> +		} else {
> +			mops.timestamp[0] =3D '\0';
> +		}
> +		return perf_stat__print_cb(evlist, config, target, ts, argc, argv,
> +					   &std_metric_only_print_callbacks, &mops);

[Severity: Medium]
Does this leak the queued events and metrics if perf_stat__print_cb()
returns an error?

The local state structures contain linked lists buffering dynamically
allocated items. If the callback chain fails early (e.g., from an ENOMEM
or EINVAL), the function returns here without executing a cleanup path.

> +	} else {
> +		if (config->interval && ts) {
> +			scnprintf(ps.timestamp, sizeof(ps.timestamp), "%6lu.%09lu ",
> +				  (unsigned long)ts->tv_sec, ts->tv_nsec);
> +		} else {
> +			ps.timestamp[0] =3D '\0';
> +		}
> +		return perf_stat__print_cb(evlist, config, target, ts, argc, argv,
> +					   &std_print_callbacks, &ps);

[Severity: Medium]
Similarly, does this leak the queued events in ps.events_list if
perf_stat__print_cb() returns an error?

> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522223342.2393=
553-1-irogers@google.com?part=3D2

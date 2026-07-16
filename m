Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794133B4EB5
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 07:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784186662; cv=none; b=PEGzOymQIh91umXTaSx7yLFGTLAM9jZlJcD7PR4kMtcjeNtEPuWbSVoX0W7rCSSKJl0J3MAaWjCIiduqzLEGSv1w3DKHT5fccFxI2csQ/eV830HBW10uP8HMFTxSpnN8nyf/+/iRlabYVNc9MRY704rzoKe8NpynKhFYxjN/zM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784186662; c=relaxed/simple;
	bh=u3P/Xn5P6CRh7ZhjGbbcN7E5N+BIebNnzBPtKLt9sMA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nKEVuKZ7XxusThC/LMqoqvtb98OKk3QcU7HR7err/nN9IuR0uH8M95g084c5Lu5xaKbDtoirETl07gHryzSyqOWd4VyVdz+er1eK+18jc0+igZZJZyalhtXyC5lMU5gUrx0qZt9K/PuBRRXWeTf4fsc3+RVh1sfai5CZHxy9FDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRoJDuIY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRoJDuIY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9DA1F00A3E;
	Thu, 16 Jul 2026 07:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784186654;
	bh=MVdvTcBbNwUPmqLlYHNqpF9MYac1kPZFTaIuZhGGgP8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GRoJDuIYofDXfEv3IzpCVShGWN3YaZSDnb4N+piX4FcHIe91v1m3yXZfS5qxyHo58
	 1YSoRcHGk43+pvy7JETKutAW8jOSh8UztdToFjZcsOZiHumcMumMEUJP0iBuMmKzNZ
	 rpysb4U4IbpWODxTT5FI7eMGogc2sRmqZtvYCRi3+GWd48wRF4h9iuee6XkbkeqWyk
	 JsiqANS0lbU9cDRsxRPJEn6aAM4P7b4ZQyIQ3jtRJO0vDPquF2an62JyDrPpvBBSkg
	 038xVtpE1n0H/o3i1v1ZGyqnSgO67WCw0DAOhmLm3ME9f8pjAYVbiDevdnLAL5syy6
	 7m9YvYCEV9Y3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/14] perf stat: Implement standard console (STD)
 formatting callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260716070303.507066-3-irogers@google.com>
References: <20260716043223.388233-1-irogers@google.com>
 <20260716070303.507066-1-irogers@google.com>
 <20260716070303.507066-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 07:24:13 +0000
Message-Id: <20260716072413.DA9DA1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Out-of-bounds array access and NULL pointer dereference when print=
ing aggregation headers.
- [Low] Uninitialized struct fields in dynamically allocated memory.
- [Low] Redundant and inverted multiplexing scaling logic acts as dead code.
--

--- Patch [2]: [PATCH v4 02/14] perf stat: Implement standard console (STD)=
 formatting callbacks ---
commit 42fd504b1ec9248fe9557a917da5fa2928b1bb6b
Author: Ian Rogers <irogers@google.com>

perf stat: Implement standard console (STD) formatting callbacks

This patch implements standard console formatting callbacks inside
util/stat-print-std.c, replacing the empty stubs introduced in Commit 1.
Introduces the format-private queued_event and queued_metric DOM nodes to
buffer traversal streams.

> diff --git a/tools/perf/util/stat-print-std.c b/tools/perf/util/stat-prin=
t-std.c
> index a1311f950559b..d83410ae3385a 100644
> --- a/tools/perf/util/stat-print-std.c
> +++ b/tools/perf/util/stat-print-std.c
[ ... ]
> +static int std_print_event(void *ctx, struct perf_stat_config *config,
> +			   struct evsel *evsel, int aggr_idx, u64 val, u64 ena,
> +			   u64 run, double stdev_pct, const char *cgrp)
> +{
> +	struct std_print_state *ps =3D ctx;
> +	struct queued_event *ev;
[ ... ]
> +	ev =3D malloc(sizeof(*ev));
> +	if (!ev)
> +		return -ENOMEM;
> +
> +	ev->name =3D strdup(evsel__name(evsel));

[Severity: Low]
Are all fields in struct queued_event initialized after allocation? It looks
like ev->is_metricgroup remains uninitialized here.

[ ... ]
> +static int std_print_metric(void *ctx, struct perf_stat_config *config _=
_maybe_unused,
> +			    struct evsel *evsel __maybe_unused, int aggr_idx __maybe_unused,
> +			    const char *name, const char *unit, double val,
> +			    enum metric_threshold_classify thresh)
> +{
> +	struct std_print_state *ps =3D ctx;
> +	struct queued_metric *b;
[ ... ]
> +	b =3D malloc(sizeof(*b));
> +	if (!b)
> +		return -ENOMEM;
> +
> +	b->name =3D strdup(name);

[Severity: Low]
Similarly, are all fields in struct queued_metric initialized? It appears
b->evsel and b->aggr_idx remain uninitialized here.

[ ... ]
> +static int std_print_end(void *ctx, struct perf_stat_config *config)
> +{
[ ... ]
> +			if (ev->run =3D=3D 0 || ev->ena =3D=3D 0) {
> +				fprintf(out, "%*s ", COUNTS_LEN, bad_count);
> +			} else {
> +				double scaled =3D (double)ev->val;
> +				double avg;
> +
> +				if (ev->ena < ev->run)
> +					scaled =3D (double)ev->val * ev->run / ev->ena;

[Severity: Low]
Is this scaling logic correct?

It looks like the condition ev->ena < ev->run is inverted, as an event cann=
ot
physically run longer than it was enabled, making this dead code.

Additionally, if the condition were corrected, wouldn't this double-scale t=
he
value, as ev->val is already scaled by perf_counts_values__scale() during
counter processing?

[ ... ]
> +static int std_metric_only_print_end(void *ctx, struct perf_stat_config =
*config)
> +{
[ ... ]
> +		if (config->aggr_map && first_aggr >=3D 0 &&
> +		    config->aggr_mode !=3D AGGR_GLOBAL) {
> +			int len =3D aggr_header_lens[config->aggr_mode];

[Severity: High]
Can a corrupted or maliciously crafted perf.data file provide an arbitrary
config->aggr_mode here?

Since perf_event__read_stat_config() directly assigns the value to
stat_config.aggr_mode without validation, indexing aggr_header_lens with
it could lead to an out-of-bounds read or NULL pointer dereference when
processing untrusted input.

[ ... ]
> +int perf_stat__print_std(struct evlist *evlist, struct perf_stat_config =
*config,
> +			 const struct target *target, const struct timespec *ts,
> +			 int argc, const char **argv)
> +{
[ ... ]
> +	} else {
> +		if (config->interval && !config->headers_printed) {
> +			FILE *output =3D config->output;
> +
> +			if (config->aggr_mode =3D=3D AGGR_GLOBAL) {
> +				fprintf(output, "#%*s %*s %*s events\n",
> +					15 - 2, "time", 18, "counts",
> +					config->unit_width, "unit");
> +			} else {
> +				fprintf(output,
> +					"#%*s %-*s ctrs %*s %*s events\n",
> +					15 - 2, "time",
> +					aggr_header_lens[config->aggr_mode],
> +					aggr_header_std[config->aggr_mode],
> +					18, "counts", config->unit_width,
> +					"unit");
> +			}

[Severity: High]
Could the same out-of-bounds indexing occur here with config->aggr_mode?

Unvalidated indexing into statically sized arrays for interval headers might
trigger a crash if aggr_mode exceeds the array bounds.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716070303.5070=
66-1-irogers@google.com?part=3D2

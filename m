Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B0A82866
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 23:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779490895; cv=none; b=qDACCwN19S1UusKKrkyb1M709Ykqdep78INfNZhZE4ruOd44Q8VIxEqDRcnTfRy/ANURGtHOIbbpGMIdAGFBjqRgGcVOmIwlJgs1yIQurzNerSRKKx3Lwgg0SkjoBsNTixZuKN8dCQ/s+uZGBCUD4ZJjbyKsd5xIrqTYbD+efMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779490895; c=relaxed/simple;
	bh=MGxYLwmchUS/XD0WDbuHpCXs12+QkccqZsfwJZvB4F8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lWWSi2lLco+Sg0s+y8Fh64r4LFJMeX+ePa8PNZeOgesCbFuJo639SD4zHGkByQB+xTiIlHeE+zVGcYY9lrjboFFDoNFNL4HGCuCtg5a65seTe7RRoOtEk21gHIOb+3cerYhUXDjG2L+eBTWbrT8Gu5lwGPzcR5CC3UdNPgYl5Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8I8Q6Jv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8I8Q6Jv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 939C21F000E9;
	Fri, 22 May 2026 23:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779490893;
	bh=plHW6ps1QTxnUqa1H6f2T/ShDt6Ev1ZGch6BN9tCcoQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j8I8Q6JvkR/BYMDNu+t2aibDM/XqBbt0G/02Iwq5eT/fBYpaHHSOGSQKeflKWaX47
	 6CipQ2cY9zsmiT9EL/3+VH+2Hk1IU2CBXNbNyo/9M9u/1gPNciKDYuMG8Xs2CWfebO
	 DOv2IzRDpFNutqrJ/3j+lIaHpjQ3wIYhoaoZBNg6fSremtfPIu1VoQL7+sCPSTOgn1
	 xK3TLoYl8cHP6tucXNusYNtHHsfP3JoD/psb/pxnbDzbrhSDiAp7P+ID+FI5dZpE0B
	 xKM4q78CaR2l8sgMS01FQ25Rebg9dab8SkvrugKQqyIGJvV3OLOjzC5/6NXkcJ67Nz
	 GOsRfVyk6JqEw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 07/14] perf stat: Implement CSV formatting
 callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260522223342.2393553-8-irogers@google.com>
References: <20260522223342.2393553-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 23:01:32 +0000
Message-Id: <20260522230133.939C21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The CSV metric-only mode outputs dynamic data values (timestamps=
 and aggregation IDs) instead of static column labels in the header row, an=
d prints this header unconditionally on every interval.
- [Medium] The data row prefix (timestamp and aggregation ID) is completely=
 skipped for the first row if its aggregation index is -1, causing column m=
isalignment.
--

commit 93e85eab3ddfd8a1be43f26569da0f314f8e2adc
Author: Ian Rogers <irogers@google.com>

perf stat: Implement CSV formatting callbacks

This commit implements CSV output formatting callbacks in stat-print-csv.c.
It defines queued DOM nodes to buffer traversal streams and encapsulates CSV
lists lifecycle. It also incorporates interval-mode timestamp printing
support.

> diff --git a/tools/perf/util/stat-print-csv.c b/tools/perf/util/stat-prin=
t-csv.c
> --- a/tools/perf/util/stat-print-csv.c
> +++ b/tools/perf/util/stat-print-csv.c
[ ... ]
> +static int csv_metric_only_print_end(void *ctx, const struct perf_stat_c=
onfig *config)
> +{
> +	struct csv_metric_only_print_state *ps =3D ctx;
> +	FILE *output =3D ps->fp;
> +	const char *sep =3D ps->sep;
> +	struct queued_metric *b, *tmp;
> +	int first_aggr =3D -1;
> +	int current_aggr =3D -1;
> +	int ret =3D 0;
> +	int err;
> +
> +	if (list_empty(&ps->queued_metrics))
> +		return 0;
> +
> +	first_aggr =3D list_first_entry(&ps->queued_metrics, struct queued_metr=
ic, list)->aggr_idx;
> +
> +	/* Print interval timestamp header if configured */
> +	if (config->interval && ps->timestamp[0])
> +		fprintf(output, "%s", ps->timestamp);
> +
> +	/* Print aggregation prefix header in CSV metric-only mode */
> +	if (config->aggr_map && first_aggr >=3D 0) {
> +		struct aggr_cpu_id id =3D config->aggr_map->map[first_aggr];
> +		struct evsel *mock_evsel =3D
> +			list_first_entry(&ps->evlist->core.entries, struct evsel, core.node);
> +		int aggr_nr =3D 0;
> +
> +		if (mock_evsel->stats && mock_evsel->stats->aggr)
> +			aggr_nr =3D mock_evsel->stats->aggr[first_aggr].nr;
> +
> +		print_aggr_id_csv(config, output, mock_evsel, id, aggr_nr);
> +	}

[Severity: Medium]
Does this output dynamic data values, such as current timestamps and
runtime aggregation IDs, into the header row instead of static column
labels like time or core?

Also, since this header block runs every time csv_metric_only_print_end()
is called, will the header row be unconditionally printed on every interval
rather than just once at the start?

> +
> +	/* Print headers */
> +	list_for_each_entry(b, &ps->queued_metrics, list) {
[ ... ]
> +	}
> +	fprintf(output, "\n");
> +
> +	/* Print values */
> +	list_for_each_entry_safe(b, tmp, &ps->queued_metrics, list) {
> +		if (b->aggr_idx !=3D current_aggr) {
> +			if (current_aggr !=3D -1)
> +				fprintf(output, "\n");
> +			current_aggr =3D b->aggr_idx;
> +			if (config->interval && ps->timestamp[0])
> +				fprintf(output, "%s", ps->timestamp);
> +			if (config->aggr_map && current_aggr >=3D 0) {

[Severity: Medium]
Since current_aggr is initialized to -1, what happens if the first
metric's aggr_idx is also -1, such as with global aggregation?

It appears the condition checking if b->aggr_idx !=3D current_aggr would
evaluate to false, completely bypassing this block.

Could this cause the interval timestamp and aggregation ID prefix to be
skipped for the data row, leading to permanent column misalignment since
the timestamp was already printed in the header?

> +				struct aggr_cpu_id id =3D config->aggr_map->map[current_aggr];

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522223342.2393=
553-1-irogers@google.com?part=3D7

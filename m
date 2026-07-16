Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF1339021E
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 07:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784185901; cv=none; b=XEzOfZCm8Jod2ETP0z2HJsWOYwlPN6xZeRgg8wO5oxZUsROz4QUOmFPT0cwvVZTMD1zxtPYQPAFdla/C79l3JRnKnPbqivREooMwPY7VbaV7T08RRFPN7XjKrQD1+uILGJ3Q/8mPWTmONn+wneqPxc1Q1qCfSWGGmIWz2RtE/U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784185901; c=relaxed/simple;
	bh=Ms6P+QFme3Xh092xyLsKN+phjqoS737QY6fi5tHh6bY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kj1TPsQjRP5JM1BDPeFWxpitBrY7D1l8cl9S60sCzZwk4hO9WaM8tKW0dab+rrbUSlYEanYQMKBNsaZQpwn2ubqSaIKY7Kxnp3bw96GB3McNrIOoODhYSS6aqsktbZar5P6QDGMznLsUoILLovEO/7edggSN8QMgzA7xRdj60SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpK8BYuQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpK8BYuQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F59C1F000E9;
	Thu, 16 Jul 2026 07:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784185893;
	bh=x3GprSgh5Ts0wn9IwxBgC+pnrKkAzHsd0Dhl3cKCgw8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lpK8BYuQizuKZ5wGsrsiKbid86nwL4sahMJwvaKCYV241/zBkTPsMFyei/n56TAJP
	 clcmBGC80/Qy7HE5IkE0dzbE0GSSI56HZ4Ohd7Wz4SBuAsp24FGB8BUStAf5EDBtxG
	 JBzWskOiRec/OUOibdGZdyQfEaT3vam6WfH4H1sgTqMEPYuFJb0PLQEg2czXZbKX5p
	 LnRv9yLjakbybhI9XzxweVDc6G9we26RC2joj6+hK2mXMumRQV66APuF4W38UQdF+M
	 a3xPh9FNZNzk1Ixl/FJC7N8nRdCFfDY3pkDUf2eofdPRW+M/uOJ9w6XyagWGQ5IrCg
	 jEyvBJ3DYDYjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/14] perf stat: Implement CSV formatting callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260716070303.507066-8-irogers@google.com>
References: <20260716043223.388233-1-irogers@google.com>
 <20260716070303.507066-1-irogers@google.com>
 <20260716070303.507066-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 07:11:32 +0000
Message-Id: <20260716071133.0F59C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Incorrect `realloc` error handling in `csv_metric_only_print_end=
` leads to a memory leak and segmentation fault.
- [Medium] The buffered cgroup name is silently dropped in `csv_print_end()=
`, breaking cgroup reporting in CSV mode.
--

--- Patch [7]: [PATCH v4 07/14] perf stat: Implement CSV formatting callbac=
ks ---
commit 20a60f8e4c4914f0bb470217a8770175ba0dfe51
Author: Ian Rogers <irogers@google.com>
Subject: perf stat: Implement CSV formatting callbacks

This commit implements CSV output formatting callbacks in util/stat-print-c=
sv.c.
It defines structures to buffer traversal streams and encapsulates CSV queu=
ed
lists lifecycle inside the print start and end functions. It also incorpora=
tes
full interval-mode timestamp printing support.

> diff --git a/tools/perf/util/stat-print-csv.c b/tools/perf/util/stat-prin=
t-csv.c
> index ee86d07636ea6..f93ca1885d468 100644
> --- a/tools/perf/util/stat-print-csv.c
> +++ b/tools/perf/util/stat-print-csv.c

[ ... ]

> +static int csv_print_end(void *ctx, struct perf_stat_config *config)
> +{
> +	struct csv_print_state *ps =3D ctx;
> +	struct queued_event *ev, *tmp_ev;
> +	struct queued_metric *met, *tmp_met;
> +	FILE *output =3D ps->fp;
> +	const char *sep =3D ps->sep;
> +	bool has_metrics;
> +
> +	list_for_each_entry_safe(ev, tmp_ev, &ps->events_list, list) {
> +		struct evsel *evsel =3D ev->evsel;
> +		bool ok =3D (ev->run !=3D 0 && ev->ena !=3D 0);
> +		const char *bad_count =3D ev->supported ? CNTR_NOT_COUNTED : CNTR_NOT_=
SUPPORTED;
> +		double enabled_percent =3D 100;
> +
> +		/* Print interval timestamp first if configured */
> +		if (config->interval && ps->timestamp[0])
> +			fprintf(output, "%s", ps->timestamp);

[ ... ]

> +		/* 2. Print Runtime and Enabled Percentage (Columns 4, 5) */
> +		if (ev->run !=3D ev->ena)
> +			enabled_percent =3D 100.0 * ev->run / ev->ena;
> +		fprintf(output, "%s%" PRIu64 "%s%.2f", sep, ev->run, sep,
> +			enabled_percent);
> +

[Severity: Medium]
Does this code silently drop the buffered cgroup name from the CSV output?

The cgroup string is correctly duplicated and stored in ev->cgrp during
csv_print_event(), but it doesn't appear to be printed here along with the
other core event properties before the ev struct is freed at the end of the
loop.

> +		/* 3. Print Metrics (Columns 6, 7) */
> +		has_metrics =3D false;
> +		list_for_each_entry_safe(met, tmp_met, &ev->metrics_list, list) {

[ ... ]

> +static int csv_metric_only_print_end(void *ctx, struct perf_stat_config =
*config)
> +{
> +	struct csv_metric_only_print_state *ps =3D ctx;

[ ... ]

> +		if (!found_metric) {
> +			if (num_unique >=3D unique_alloc) {
> +				unique_alloc =3D unique_alloc ? unique_alloc * 2 : 16;
> +				unique_names =3D realloc(unique_names,
> +						       unique_alloc * sizeof(char *));
> +				if (!unique_names) {
> +					ret =3D -ENOMEM;
> +					goto cleanup_grid;
> +				}
> +			}

[Severity: Medium]
Can this cause a memory leak and a segmentation fault if realloc() fails?

If realloc() fails, it returns NULL and directly overwrites the unique_names
pointer, which loses the reference to the previously allocated memory block.

Later, at the cleanup_grid label:

> +cleanup_grid:
> +	for (i =3D 0; i < num_unique; i++)
> +		free(unique_names[i]);

The code will dereference the now-NULL unique_names array, which would caus=
e an
immediate crash.=20

This same pattern also appears just below this for the unique_aggrs allocat=
ion:

> +			if (num_aggrs >=3D aggr_alloc) {
> +				aggr_alloc =3D aggr_alloc ? aggr_alloc * 2 : 16;
> +				unique_aggrs =3D realloc(unique_aggrs,
> +						       aggr_alloc * sizeof(int));
> +				if (!unique_aggrs) {
> +					ret =3D -ENOMEM;
> +					goto cleanup_grid;
> +				}
> +			}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716070303.5070=
66-1-irogers@google.com?part=3D7

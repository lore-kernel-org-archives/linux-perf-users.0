Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500BB1DE4EF
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 05:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780205772; cv=none; b=mDVAogAu8OdIF1IbXuyuFerJ/MzG+00vJo7M6+dMPnPAxiio7V73oLYDqSvEYGG7XZpf0IbvD5cHFcqPXvpplUGV0RQjzOPHM7VML1x22gLHxk5qcZ7ny5Ah/QmDOGLzZPeiJFlkN3W9c63HGNevpIYah1VI5eE3wfcGPIDBCYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780205772; c=relaxed/simple;
	bh=2HzmJnxwgkupbT4tlVIeMkcqWWQJ0n443a2IJT3un9Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ji6LrzV2rcyzhiBIlhzfokWIRFmZff+fAHJVGM+/JizEc1jwoqh8XyNsmQ/k46k4MVeAt9Q5QBHNQl2RCMIJkTpez6F655hIK8IBpnQIiMhVBSJ0AHHQyGykiv2wyIm4REQogax/NCtOMK6vDIrqJlHohJUZ48cxM8Mc94nTe+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9a0OQ3W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9a0OQ3W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A211F00893;
	Sun, 31 May 2026 05:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780205770;
	bh=F0kjyUo/cLBfwXDT0/JsHv6bZNSmxoiOc6nksgNS5pk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n9a0OQ3Wa5L56sv/LXgtFrQV7QN4+5caWH+ifQgUIhuigt/8rm52jDvc0iDan3cEU
	 XHkjDhr95JrGUFDpOcBN2RMWIOYJrqmbmmbFndyXWpSGM+bbYDVccxayJ4kVBsBWef
	 OhmF7WIes7a7Q62NjTwsovyW/GxjG5x1HKqXl1vNeKyKnjU6mK3YmOb6onOoGugVG6
	 5h2CnT5OydP9/hYqIIBxVPfTNcMJoz7QNbqUN/7rsnX4+T8mPNgjwEa/Oa95J4kKva
	 Cq1on0WFqrFM3SdpRt7CxC2uMPvdZwwTTMQgYnYHdmM51gCRlVv0KMEcUg6qeHGM21
	 3ZzDF5Vvh+iOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/14] perf pmu-events: Add API to get metric table
 name and iterate tables
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260531052740.796087-3-irogers@google.com>
References: <20260531052740.796087-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2026 05:36:10 +0000
Message-Id: <20260531053610.A3A211F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] pmu_metrics_table__for_each_table iterates over CPU mappings rat=
her than unique metric tables, resulting in duplicate callback invocations =
for identical tables.
--

commit 06009cc5aa38d92e8977305257f6dc0825137ac8
Author: Ian Rogers <irogers@google.com>

perf pmu-events: Add API to get metric table name and iterate tables

This patch adds a name field to struct pmu_metrics_table and functions to
retrieve the name and iterate over all known metric tables. This functional=
ity
is intended to break apart slow metric tests per table.

> diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-ev=
ents/empty-pmu-events.c
> index 628e488ecc73c..718a541bd940f 100644
> --- a/tools/perf/pmu-events/empty-pmu-events.c
> +++ b/tools/perf/pmu-events/empty-pmu-events.c
[ ... ]
> @@ -5988,6 +5991,35 @@ int pmu_for_each_sys_metric(pmu_metric_iter_fn fn,=
 void *data)
>  	return 0;
>  }
> =20
> +const char *pmu_metrics_table__name(const struct pmu_metrics_table *tabl=
e)
> +{
> +	return table ? table->name : NULL;
> +}
> +
> +int pmu_metrics_table__for_each_table(
> +	int (*fn)(const struct pmu_metrics_table *table, void *data),
> +	void *data)
> +{
> +	size_t i;
> +	int ret;
> +
> +	for (i =3D 0; pmu_events_map[i].cpuid; i++) {
> +		if (!pmu_events_map[i].metric_table.pmus)
> +			continue;
> +		ret =3D fn(&pmu_events_map[i].metric_table, data);

[Severity: Medium]
Since multiple CPU IDs can map to the same architecture metrics directory
(for example, multiple ARM cores mapped to cortex-a53), pmu_events_map can
contain multiple elements that share the identical underlying metrics array=
 and
name.

Will this loop invoke the callback redundantly for these identical tables,
potentially causing identical tests to be generated and run multiple times?

> +		if (ret)
> +			return ret;
> +	}
[ ... ]
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jev=
ents.py
> index 356ac1324be05..0a6db29b8f0ff 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
[ ... ]
> @@ -807,12 +813,45 @@ static const struct pmu_events_map pmu_events_map[]=
 =3D {
>  	.arch =3D 0,
>  	.cpuid =3D 0,
>  	.event_table =3D { 0, 0 },
> -	.metric_table =3D { 0, 0 },
> +	.metric_table =3D { 0 },
>  }
>  };
>  """)
> =20
> =20
> +def print_metric_table_functions() -> None:
> +  _args.output_file.write("""
> +const char *pmu_metrics_table__name(const struct pmu_metrics_table *tabl=
e)
> +{
> +	return table ? table->name : NULL;
> +}
> +
> +int pmu_metrics_table__for_each_table(
> +	int (*fn)(const struct pmu_metrics_table *table, void *data),
> +	void *data)
> +{
> +	size_t i;
> +	int ret;
> +
> +	for (i =3D 0; pmu_events_map[i].cpuid; i++) {
> +		if (!pmu_events_map[i].metric_table.pmus)
> +			continue;
> +		ret =3D fn(&pmu_events_map[i].metric_table, data);

[Severity: Medium]
This python generator creates the same pmu_metrics_table__for_each_table()
implementation shown above. Might it be beneficial to include deduplication
logic here to prevent identical metric tables from being passed to the
callback?

> +		if (ret)
> +			return ret;
> +	}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260531052740.7960=
87-1-irogers@google.com?part=3D2

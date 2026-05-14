Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53413ADB94
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 11:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778758964; cv=none; b=lZxOjfr5yhknbF4pUjTRXLQXzv6w+j5gs1wbK5W1J9ODdXZsLiVZDzNuBPuSwQy74z0FKsMOQCRYhKWNPHS6Ow/QbOrTACP46M2kiqIJsXfK9TwP5zeZNrAjO+RUQOUV5dxjJpYbNvOGb0+0coNwqHznBGfW6rGqFpZbAOnIu5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778758964; c=relaxed/simple;
	bh=A0/SQIq+12U/t5WV1scy+LO7cRlMwhsHjt/1SOCVozk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BDvW33Uj8VPTySTVF+XSqom0i+0R0sJ/g3nldI3VznU+VJHF1zULHIF6JCktZR4C7pMMvbwlxrclqMG9ZJ7Ug9ZAKVvvYtlD/Ude/qOgpvVsCrLKDefZUG2fWPGtjbBe7pa8dFJz6cE6LHmDnVm76Nu/q1FP/xJKaau7kmHFN10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dls3asc5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dls3asc5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4320FC2BCB8;
	Thu, 14 May 2026 11:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778758964;
	bh=A0/SQIq+12U/t5WV1scy+LO7cRlMwhsHjt/1SOCVozk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=dls3asc58dLTIMslmCfY1u3/F2yclhWs4w1KPcLl3t3AWS4TyFTESAjFx7vYICU6p
	 Kb91SDMjylUVoVbnFAiDgLAU3uPmubWfyD//7/K18PGO+HVKCdGCNn05jXGiRckaCC
	 hinQMgh+7JNny7CLlRXyO3NZI6oiLAaBuuOBxAnikxmqjneDctO78GgNY8b7quLLvx
	 6CHiIMoDujA7ETllHFZNveE00uWXxDmHMWTqm8o4JddqA0fJtU7yOq0CFgdk7gV/na
	 kYLfW/HfdAqx5/43UdFsavN6prI/lpdnP1so01FxSV3bvJeZVpC1oUFQknNhahNT9y
	 GDXbk41UIB8Ug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 02/14] perf pmu-events: Add API to get metric table
 name and iterate tables
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260513230450.529380-3-irogers@google.com>
References: <20260513230450.529380-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 11:42:43 +0000
Message-Id: <20260514114244.4320FC2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The `.name` field in `pmu_metrics_table` is erroneously initiali=
zed to the string literal "NULL" instead of a null pointer for CPUs without=
 metrics.
- [Medium] The `pmu_metrics_table__for_each_table()` API yields duplicate m=
etric tables when multiple CPU IDs share the same architecture.
--

commit d5de54c2353e5ad926b97d677ee122277c30d0b2
Author: Ian Rogers <irogers@google.com>

perf pmu-events: Add API to get metric table name and iterate tables

This commit adds a name field to struct pmu_metrics_table and populates it
in generated tables. It introduces functions to retrieve the table name and
to iterate over all known metric tables.

> diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-ev=
ents/empty-pmu-events.c
> index 322e6c2d58cb0..f51062ef25d3f 100644
> --- a/tools/perf/pmu-events/empty-pmu-events.c
> +++ b/tools/perf/pmu-events/empty-pmu-events.c

[ ... ]

> @@ -5992,6 +5995,35 @@ int pmu_for_each_sys_metric(pmu_metric_iter_fn fn,=
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

Are duplicate metric tables yielded here when multiple CPU IDs share the sa=
me
architecture?

In architectures like ARM64 and x86, multiple CPU mappings can point to the
exact same metric definitions. Because struct pmu_metrics_table is embedded
directly into each element of the pmu_events_map array, each duplicate CPU
mapping yields a unique memory address (&pmu_events_map[i].metric_table)
while containing identical .pmus pointers.

As this makes trivial pointer deduplication impossible for callers, consume=
rs
of this API could generate redundant operations for identical tables.

[ ... ]

> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jev=
ents.py
> index 7d325604f04db..a74c5e828bd15 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py

[ ... ]

> @@ -796,6 +799,7 @@ static const struct pmu_events_map pmu_events_map[] =
=3D {
>  		.num_pmus =3D {event_size}
>  	}},
>  	.metric_table =3D {{
> +		.name =3D "{metric_tblname.replace('pmu_metrics__', '')}",
>  		.pmus =3D {metric_tblname},
>  		.num_pmus =3D {metric_size}
>  	}}

If metric_tblname is the string 'NULL' for architectures that have mapped
events but lack an associated metric table, will this evaluate to
.name =3D "NULL"?

This writes a 4-character string literal into the generated C code instead
of a true null pointer. Callers attempting to perform null checks like
if (table->name) would then erroneously evaluate to true.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513230450.5293=
80-1-irogers@google.com?part=3D2

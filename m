Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F5524A05D
	for <linux-perf-users@vger.kernel.org>; Sat,  6 Jun 2026 20:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780777417; cv=none; b=Vg2LvIdB8w2SbjhFUVXXHb1CMDC15WhXsizo0vC+SbKH6eL9j4xAd+nl37y/Az04ZT9wVWJZRhiLXOkN5NjWB4vkvYpUlN8zgeZP8/b6oXldbZxDDCkCijHENClJmAfo4d2BUioxMMlaUUefP9b5pcvxV7aqZuth/doHyzhB8YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780777417; c=relaxed/simple;
	bh=DBUhhY0IKpfeZtY56sNAqtEm0+l488OaY1WYem/B3mk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h4pEiOAAD7HX2bjXNXtE8KV6pJaI/aFh/SMSVqHEAeYm/nlgUSo+BLFcnKzH+80w3Hly2EWXmzE3pk5IxoNt0y5AI5qRNOGg81Wqb40scxs2fo+ciRAzmRJNVC28bd4dCUxBl7OGmYDp1hIfoPzFsJw3YlE6ocqQktx5c6RsitY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lf4PKHHL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lf4PKHHL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9321F00893;
	Sat,  6 Jun 2026 20:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780777416;
	bh=cMguoVX1QKpLgzbNeAzpcyizYfmC4hAI6VtbFhCjDUo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lf4PKHHL12rw2YrnwS0dImUqbOvJiKosx5lUy40eIg3d+ORJ2vuhXP7JnMUbvDcxf
	 rpFU0b37yIQJRAuFfuupjWDsxKvPPggjwO0k6hIulJZy7xtR6t20Uuas/3sCkbIJNP
	 MfTliZNtThYwccFKCRVf5Yuj4A8P6d5gL21dnRyn16vC7pSgrPm6Hc1YSOILdBv7ki
	 R/E8xTqtxWTvuwKF+opuVGd07jCqWGIve4oBwvSWwLXmNu9Hn2wwu4yLrNe1OB+E2K
	 42dtPUYqZlySGVSWkfoslSfN2uuVq8uGFmz0XvxyXORDLBWh99p5Oers12HOya/mtm
	 8AI9UeqF2sLCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/7] perf stat: Introduce perf_env__get_cpu_topology()
 to guard NULL env->cpu
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260606200601.1861227-3-acme@kernel.org>
References: <20260606200601.1861227-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 20:23:35 +0000
Message-Id: <20260606202336.0F9321F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing bounds validation for the untrusted `sample->cpu` index wh=
en accessing the dynamically allocated `env->cpu` array in `machine__resolv=
e()`.
--

commit 50d04a9b8194c04adf66854548c5855bbd4c23f4
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf stat: Introduce perf_env__get_cpu_topology() to guard NULL env->cpu

This commit introduces a safe accessor, perf_env__get_cpu_topology(), to
prevent NULL pointer dereferences when accessing env->cpu on older
perf.data files. It also updates several topology aggregation callbacks
in builtin-stat.c to use this new accessor.

> diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
> index 7621d1f73b83a..7acca39b42ff3 100644
> --- a/tools/perf/util/env.h
> +++ b/tools/perf/util/env.h

[ ... ]

> @@ -187,6 +187,20 @@ const char *perf_env__pmu_mappings(struct perf_env *=
env);
> =20
>  int perf_env__read_cpu_topology_map(struct perf_env *env);
> =20
> +/*
> + * Safe accessor for env->cpu[] topology array.  env->cpu can be NULL wh=
en
> + * reading old-format perf.data that predates topology information =E2=
=80=94
> + * process_cpu_topology() in header.c frees it while nr_cpus_avail remai=
ns
> + * set, so callers must not index env->cpu[] without this check.
> + */
> +static inline struct cpu_topology_map *
> +perf_env__get_cpu_topology(struct perf_env *env, struct perf_cpu cpu)
> +{
> +	if (env->cpu && cpu.cpu >=3D 0 && cpu.cpu < env->nr_cpus_avail)
> +		return &env->cpu[cpu.cpu];
> +	return NULL;
> +}

[Severity: High]
This is a pre-existing issue, but I noticed that tools/perf/util/event.c
accesses the dynamically allocated env->cpu array without validation.

In machine__resolve():

	if (al->cpu >=3D 0) {
		struct perf_env *env =3D machine->env;

		if (env && env->cpu)
			al->socket =3D env->cpu[al->cpu].socket_id;
	}

Since al->cpu is derived from the untrusted perf.data file payload,
can this trigger an out-of-bounds heap read on env->cpu[] if the
file provides an artificially large CPU index?

Would it make sense to update machine__resolve() to use this new
perf_env__get_cpu_topology() helper to ensure proper validation against
env->nr_cpus_avail?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260606200601.1861=
227-1-acme@kernel.org?part=3D2

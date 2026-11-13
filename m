Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794603908;
	b=OrJIdTkZK5/9O7VRjt9TBcFRn5fe+NN92/lH2gi4A+1QFeqC7TCAu4YhvGCanaPEqR+z
	 tcDlIASmcSg9KnZVc5sAAeBcS7GfNVtVK4Qq+YUMyWm6se022zqMUkARt3EaFpor9VEvH
	 OskWC9GjKUh2iaXe56uFJ3LOePDmvpEorW5QBsoT3eC4QB+6U2UqIKbQ8slmHntRj7U/l
	 y6Ri5xLT8oVCfMFr5/CfmNQLFBMTLxwQAl0gGUtap745QheXEjhLVFiqNLVT9rZxJ78g0
	 OVFdFb0AZYVsKSNcHzWQOYslGXRpoK6xKeWKZXbkT9EEYv1C5pRsdVnK3xoFbEKCC5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794603908;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Jbq1KlcC23l8K3eiUCCiu3as+w9HeADN+7P0Eq9a7iQ=;
	b=WjV6uTl3d1q/eXS0Y2RhV6UkfaFUyBjKu51ih4T3M18WYeVfaGMcVaQut5dha+4toKef
	 icTqP+nAoSgEleIprzf/IKFDOauN4ycUp359gwnzegfH95FlgmalQrC5h7Wv+qjpyqhxG
	 bCQGG/sn/fW/NhWcKaae6lz6+wTltDxrf7a3iDYw3pigvFOVH5dUTRNrcdw8XYJVL7mxm
	 tjG3ko+E5R+uRWJnu2fEboT7QAWqT8DjhxAiWiJQlWFkciJknKk/9Xu3CrmvTTvNQshTq
	 H2gbAUuRsLr+VZeNU9I2j6QhFKuKxa/ZSDC3H8jbXGvz8Isvtz9+8qyY40lSJDYibZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nr8QMCEy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8515E606A327
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nr8QMCEy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A541F000C4;
	Fri, 13 Nov 2026 21:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794603908;
	bh=Jbq1KlcC23l8K3eiUCCiu3as+w9HeADN+7P0Eq9a7iQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nr8QMCEyicTQFic5edtp0RuaexEw6dbdgXIvXfgMSdD89pDKVUpxaR6Qq+v497lRs
	 rmlA4hXT7cjU3ltJfPPVeAHAiBsrvOIUkdIPS+69h6/9r1mkdy1ARei0Gyqvn9hkb7
	 trwZKAvyeFheiXvfZ6TC+gkCCwU0+FFcpNA68FPnw42nVZ9Ow4Cv35dtMJFQZdcSeK
	 rB9ft6uFEzqf3YYF1Lu+EesaR85UiLIoc2KeLCfL14DRORPoZRJqMB3AY3pzASjHO6
	 n8EH13KmKn1QZ/wOZfoq8xAL+yxIxz0aCQxILd9iLVFtr1SfHagdbCLbRhDGnpXkEt
	 tcranRROVwPEQ==
Message-ID: <sashiko-outbox-213689@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 25/30] perf pmus: Add perf_pmus__read_from_env()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113195335.2865725-26-irogers@google.com>
References: <20261113195335.2865725-1-irogers@google.com>
 <20261113195335.2865725-26-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 21:05:07 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] perf pmus: empty core_pmus in perf_pmus__read_from_env()
  without cpu caps
- [Medium] perf pmus: broken event config name lookup in
  env_pmu_find_or_add()
--

commit 62379d346fd8a3e273dd7df18d358ca721a7bc84
Author: Ian Rogers <irogers@google.com>

perf pmus: Add perf_pmus__read_from_env()

This commit adds perf_pmus__read_from_env() and perf_pmu__add_cap() to
reconstruct core and other PMU lists and capabilities from perf.data
header metadata, and lazily populates env->pmus in perf_env__pmus().

> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> index 6d68371107aa1..b924ff6180e41 100644
> --- a/tools/perf/util/pmus.c
> +++ b/tools/perf/util/pmus.c

[ ... ]

> @@ -981,3 +984,234 @@ struct perf_pmu *perf_pmus__fake_pmu(void)
> =20
>  	return &fake;
>  }

[ ... ]

> +	pmu->pmus =3D pmus;
> +	pmu->sysfs_aliases_loaded =3D true;
> +	pmu->caps_initialized =3D true;
> +	pmu->max_precise =3D -1;
> +	pmu->is_core =3D env_is_pmu_core(name, env);
> +	pmu->auxtrace =3D !strcmp(name, "intel_pt") ||
> +			!strcmp(name, "intel_bts") ||
> +			!strcmp(name, "cs_etm") ||
> +			strstarts(name, "arm_spe") ||
> +			strstarts(name, "hisi_ptt");
> +	pmu->is_uncore =3D !pmu->is_core && !pmu->auxtrace &&
> +			 !perf_pmu__is_software(pmu) &&
> +			 (perf_pmu__kind(pmu) =3D=3D PERF_PMU_KIND_PE ||
> +			  pmu->type =3D=3D PERF_PMU_TYPE_FAKE);
> +
> +	if (!strcmp(name, "software") || !strcmp(name, "tool"))
> +		pmu->events_table =3D perf_pmu__default_core_events_table();
> +	else if (core_table && (pmu->is_core || pmu->is_uncore))
> +		pmu->events_table =3D core_table;

[Severity: Medium]
Does setting pmu->events_table on an env-backed PMU while leaving
pmu->format empty break perf_pmu__name_from_config() and leak help_msg?

When print_event_desc() or evsel__fprintf() calls
perf_event_attr__fprintf() with perf_env__pmus(env),
perf_pmu__for_each_name_from_config() loads the JSON aliases from
pmu->events_table via pmu_add_cpu_aliases() and calls
perf_pmu__parse_terms_to_attr() -> pmu_config_term() with err =3D=3D NULL on
each alias.  Because pmu->format is empty, pmu_find_format() returns NULL
for every format term (such as event=3D or umask=3D):

tools/perf/util/pmu.c:pmu_config_term() {
    ...
	format =3D pmu_find_format(&pmu->format, term->config);
	if (!format) {
		char *pmu_term =3D pmu_formats_string(&pmu->format);
		char *unknown_term;
		char *help_msg;
    ...
		help_msg =3D parse_events_formats_error_string(pmu_term);
		if (err) {
			parse_events_error__handle(err, term->err_term,
						   unknown_term,
						   help_msg);
		} else {
			pr_debug("%s (%s)\n", unknown_term, help_msg);
			free(unknown_term);
		}
		free(pmu_term);
		return -EINVAL;
	}
    ...
}

As a result, perf_pmu__name_from_config() fails to resolve format-based
event names, and every alias iteration leaks help_msg in the !err branch.

[ ... ]

> +int perf_pmus__read_from_env(struct perf_pmus *pmus, struct perf_env *en=
v)
> +{
> +	const struct pmu_events_table *core_table =3D NULL;
> +	struct perf_pmu *pmu;
> +
> +	if (!pmus || !env)
> +		return -EINVAL;
> +
> +	perf_pmus__exit(pmus);
> +	pmus->read_pmu_types =3D PERF_TOOL_PMU_TYPE_ALL_MASK;

[ ... ]

> +	if (env->nr_cpu_pmu_caps > 0 && env->cpu_pmu_caps) {
> +		pmu =3D pmu_find(pmus, "cpu");
> +		if (!pmu && !list_empty(&pmus->core_pmus)) {
> +			/* Match the writer's perf_pmus__find_core_pmu() order. */
> +			list_sort(NULL, &pmus->core_pmus, pmus_cmp);
> +			pmu =3D list_first_entry(&pmus->core_pmus, struct perf_pmu, list);
> +			if (pmu->nr_caps > 0)
> +				pmu =3D NULL;
> +		} else if (!pmu) {
> +			pmu =3D env_pmu_find_or_add(pmus, "cpu", PERF_TYPE_RAW,
> +						  env, core_table);
> +		}
> +		if (pmu)
> +			env_pmu_add_caps_strings(pmu, env->nr_cpu_pmu_caps, env->cpu_pmu_caps=
);
> +	}

[Severity: Medium]
Can perf_pmus__read_from_env() leave pmus->core_pmus empty when
env->nr_cpu_pmu_caps is 0?

Unlike pmu_read_sysfs(), which always creates a placeholder core PMU when
pmus->core_pmus is empty, the fallback env_pmu_find_or_add(pmus, "cpu",
PERF_TYPE_RAW, ...) here only runs when env->nr_cpu_pmu_caps > 0.  If a
perf.data file has HEADER_PMU_MAPPINGS or HEADER_PMU_CAPS without CPU PMU
capabilities and no PMU name matches env_is_pmu_core() (for example, a VM
recording with only software and tracepoint PMUs), pmus->core_pmus stays
empty while pmus->read_pmu_types is set to PERF_TOOL_PMU_TYPE_ALL_MASK,
preventing pmu_read_sysfs() from creating the placeholder.
perf_pmus__find_core_pmu() and evsel__find_pmu() then return NULL for
PERF_TYPE_HARDWARE, PERF_TYPE_HW_CACHE, and PERF_TYPE_RAW events.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113195335.2865=
725-1-irogers@google.com?part=3D25

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795214523;
	b=BdqhwHd63ij+0KXCp6KK0qZF5bEJijHYyHF+B5hVlMyle6LgLpzJ4KPyl8XOWA1wICPc
	 PsYY3kLSPnxvPwRVR863fo91f/3igVWxHiLVHJHCQmFcQm9+EPTKpyd16KaLSEKwfS+eG
	 EamQocRAbylJQ7g5V+UNkMfx/dgZ1l1hBUvkH4wnFsD3n5UDav7SIIiEHNwgKAofGOO7z
	 GuUZRYCbuITsilFDz93JaN0/uqa5EDs+A+mIEkhlg8rTrCd9jb74/cvp1jtuEjKp1K9sX
	 /8FbkA1Eb83xi+7wE67Z6wrPT1NLIXcWswyL62GMecAYS5jyQzHMowaF1nZm3a+WcuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795214523;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Llm/E6/VOvlgSVw8MYwwZ3K3GxKhAUCkE71A/icbZmw=;
	b=GG/weie7ZPUQC4l3+xNWJkJ6tvWvvs9sKDLexBpA7mQI012lwydOA8midj4da65h8peO
	 k+0h/MidJpQBLGqaWzMNIhASjgqiMueEqsOWbtUhhUNIZH/swch97KzVt0XtT/ZI1gJLn
	 ij720cEM/NKXuPWf9V54e8RmQ9N6ACVZV8QskKdeA5fLfmZkl4UWV0GTalKKX2eL1KED9
	 QHbrhFE7dnLejHkaSywPCQS2ZX0PwUhcwmbs3XyXr0LZak5WfGmpiwLvnU8fsAiGLJ3+Z
	 LwO8ZixgC3jDMo+52gok4brzsqkJrVHV/PkdUgT+X0peAoubhPxkoqTyvFnEZsIttkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RdNrHdBz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E39606A6AF
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 22:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RdNrHdBz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A871F000C0;
	Fri, 20 Nov 2026 22:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795214522;
	bh=Llm/E6/VOvlgSVw8MYwwZ3K3GxKhAUCkE71A/icbZmw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RdNrHdBzLbdrp9/Gny01dmOZAoTYt1mOtX01c3wKtHybZ6P1xVvQDXYenn3MOEycj
	 n1vQa3/VZ8YwhNL4p2hCTYb2mMGRhDPyphJN7HxANFGrfOkxXlB0zuwcu4ycTLyQOk
	 0SAV7jdpL9tou2R42MawNjE5IH6XaNfC93HsbhcIBNhZVu0K7n+IDGpe5zzxC4Lo56
	 t45gxb+IQZb5v8ntizNjl2dFRFnLpO0viECfj0SgAIwxvWMgzbbSR5Qw4S/JtzJN3s
	 cnx/G55IhMXQGygr6F13jhYymT47a1P6SsyiYDeWh4ObvkMx2sKa0JVSDCORztUBLT
	 4DvAsUngZ2XuQ==
Message-ID: <sashiko-outbox-226290@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 25/30] perf pmus: Add perf_pmus__read_from_env()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261120221332.2245191-26-irogers@google.com>
References: <20261120221332.2245191-1-irogers@google.com>
 <20261120221332.2245191-26-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 22:42:01 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] perf pmus: env_pmu_find_or_add() misclassifies s390 cpum_sf
  as a core PMU
--

commit 2ae904f73f222b4be1d180a1e277ffff84418c59
Author: Ian Rogers <irogers@google.com>

perf pmus: Add perf_pmus__read_from_env()

This commit adds perf_pmus__read_from_env() and perf_pmu__add_cap() to
reconstruct PMU lists and capabilities from perf.data header metadata and
lazily populate env->pmus in perf_env__pmus().

> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> index 1c3cb53c3d4ff..c5ef22ef00dc0 100644
> --- a/tools/perf/util/pmus.c
> +++ b/tools/perf/util/pmus.c
[ ... ]
> @@ -1004,3 +1007,247 @@ struct perf_pmu *perf_pmus__fake_pmu(void)
[ ... ]
> +static struct perf_pmu *env_pmu_find_or_add(struct perf_pmus *pmus,
> +					    const char *name, __u32 type,
> +					    struct perf_env *env,
> +					    const struct pmu_events_table *core_table)
> +{
> +	struct perf_pmu *pmu =3D pmu_find(pmus, name);
> +
> +	if (type =3D=3D PERF_PMU_TYPE_FAKE) {
> +		if (!strcmp(name, "software"))
> +			type =3D PERF_TYPE_SOFTWARE;
> +		else if (!strcmp(name, "tracepoint"))
> +			type =3D PERF_TYPE_TRACEPOINT;
> +		else if (!strcmp(name, "breakpoint"))
> +			type =3D PERF_TYPE_BREAKPOINT;
> +		else if (!strcmp(name, "tool"))
> +			type =3D PERF_PMU_TYPE_TOOL;
> +	}
> +
> +	if (pmu) {
> +		if (pmu->type =3D=3D PERF_PMU_TYPE_FAKE && type !=3D PERF_PMU_TYPE_FAK=
E) {
> +			pmu->type =3D type;
> +			if (!pmu->is_core && type =3D=3D PERF_TYPE_RAW) {
> +				pmu->is_core =3D true;
> +				list_move_tail(&pmu->list, &pmus->core_pmus);
> +			}
> +			pmu->is_uncore =3D !pmu->is_core && !pmu->auxtrace &&
> +					 !perf_pmu__is_software(pmu) &&
> +					 perf_pmu__kind(pmu) =3D=3D PERF_PMU_KIND_PE;
> +			if (!pmu->is_core && !pmu->is_uncore &&
> +			    pmu->events_table =3D=3D core_table) {
> +				pmu->events_table =3D NULL;
> +			} else if (!pmu->events_table && (pmu->is_core || pmu->is_uncore) &&
> +				   pmu_events_table__num_events(core_table, pmu) > 0) {
> +				pmu->events_table =3D core_table;
> +			}
> +		}
> +		return pmu;
> +	}
> +
> +	pmu =3D zalloc(sizeof(*pmu));
> +	if (!pmu)
> +		return NULL;
> +
> +	if (perf_pmu__init(pmu, type, name, /*from_env=3D*/true) !=3D 0) {
> +		perf_pmu__delete(pmu);
> +		return NULL;
> +	}
> +
> +	pmu->pmus =3D pmus;
> +	pmu->sysfs_aliases_loaded =3D true;
> +	pmu->caps_initialized =3D true;
> +	pmu->max_precise =3D -1;
> +	pmu->is_core =3D type =3D=3D PERF_TYPE_RAW || env_is_pmu_core(name, env=
);

[Severity: Medium]
Does treating type =3D=3D PERF_TYPE_RAW as a core PMU misclassify s390's cp=
um_sf
PMU?

On s390, cpum_cf is the core counter facility PMU (registered with a dynamic
type and matched by env_is_pmu_core()), while cpum_sf is the non-core
sampling facility PMU registered with PERF_TYPE_RAW (arch/s390/kernel/
perf_cpum_sf.c).  When reading HEADER_PMU_MAPPINGS from an s390 perf.data
file, marking any PERF_TYPE_RAW PMU as pmu->is_core puts both cpum_cf and
cpum_sf on pmus->core_pmus.  That makes perf_pmus__num_core_pmus() return 2
and perf_pmus__supports_extended_type() return true, causing s390 recordings
to be treated as hybrid systems.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120221332.2245=
191-1-irogers@google.com?part=3D25

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9453534250E
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 19:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792264535; cv=none; b=P39sGXiIwf0TqAHCw3yxhmO1ELxxa+6bjKgFl1qB5Hq3NlpRcmYF7SsOT261gNX5tV9/e7ji2qmigBtmGrdg7ACQL6NJwBbnRjmrM4x6VV0Y1MDeR0PLC5qszIAk07/9Rhr2Cn3JaLn7CY5G5ankdRYhlcEf89gCVsIFqoB8/30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792264535; c=relaxed/simple;
	bh=jw0etg028Kc5UTYPe595jJ1oRXalie/NtDPJmqZcP1o=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=W/EIcDxNtHJndikWrKVcJvkF6wLlyQ4T6yevOOITi4JsZZzpeiCFMPa7YGSKGuE/Fh7iZpZz6cBHpSLmW8lZj4aMSbCz1XirVmO2ckecJOjQDJCc3juhwGwJE3Diaf+cviLCTPxo61fZh8nWsEpxCe5PmXewwO4P8R+062GzCj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbFzhNlO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbFzhNlO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB6B1F000C4;
	Sat, 17 Oct 2026 19:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792264533;
	bh=7NNV5EfIbocsKSBAkxeRPb1QX8FT5S8HoNtRDkG5ueY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nbFzhNlOyATvu3lfRC2RG2SQXEpHQ4o/wJB73cVqp6ovOTHrSVeIHBCJUOVLyfUad
	 W4OFhjQLU1/qnQrazLjemwOrBydmdOMlw28G0gaGJ68K6Cm5pVYqmno2w0WR65g7ki
	 YHJmnFRl7D0AWmvtaIWMxRGgHfVEyJ4Tx6+BXef0QIpUjJ7bWoyovtg2Bz2a9ps5/n
	 9StFaS5DIr8AXO6t79gd4jBHlUsffQpDD9JB9AavmFQnaOM7EYRtS0HI2O2S8UFrAG
	 1wBC6oCXSTdJtUjts/hrvbEqHD4VZV3vaMTXh+jvFJXYkVrdm8gg0R56+npKr0LeV5
	 u7Ni525dMlfDg==
Message-ID: <sashiko-outbox-175774@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 2/9] perf pmus: Add perf_pmus__read_from_env()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261017185442.2137623-3-irogers@google.com>
References: <20261016213258.945737-1-irogers@google.com>
 <20261017185442.2137623-1-irogers@google.com>
 <20261017185442.2137623-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 19:15:33 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] perf pmus: stale core PMU cache and host probing in perf_pmus__r=
ead_from_env()
- [Medium] perf pmu: out-of-bounds container_of() read on from_env drm and =
hwmon PMUs
- [Medium] perf pmus: broken x86 and cross-arch CPUID lookup in perf_pmus__=
read_from_env()
- [Medium] perf pmus: env_pmu_find_or_add() misclassifies non-'uncore_' unc=
ore PMUs
--

commit d0c91f9e30f93d2ae73777064d63c0d94f79c0b9
Author: Ian Rogers <irogers@google.com>

perf pmus: Add perf_pmus__read_from_env()

This commit adds perf_pmus__read_from_env() and perf_pmu__add_cap() to
reconstruct core_pmus and other_pmus lists and their capabilities from
a perf.data header environment.

> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> index 1355b317f3eda..ea727d577c89d 100644
> --- a/tools/perf/util/pmus.c
> +++ b/tools/perf/util/pmus.c
[ ... ]
> @@ -916,3 +919,205 @@ struct perf_pmu *perf_pmus__fake_pmu(void)
[ ... ]
> +static struct perf_pmu *env_pmu_find_or_add(const char *name, __u32 type,
> +					    struct perf_env *env,
> +					    const struct pmu_events_table *core_table)
> +{
> +	struct perf_pmu *pmu =3D pmu_find(name);
> +
> +	if (pmu) {
> +		if (pmu->type =3D=3D PERF_PMU_TYPE_FAKE && type !=3D PERF_PMU_TYPE_FAK=
E)
> +			pmu->type =3D type;
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
> +	pmu->sysfs_aliases_loaded =3D true;

[Severity: Medium]
Can allocating a plain struct perf_pmu here trigger an out-of-bounds read v=
ia
container_of() when type belongs to a DRM or HWMON PMU?

When HEADER_PMU_MAPPINGS contains drm_* or hwmon_* PMUs (with type in
PERF_PMU_TYPE_DRM_START..PERF_PMU_TYPE_DRM_END or
PERF_PMU_TYPE_HWMON_START..PERF_PMU_TYPE_HWMON_END), env_pmu_find_or_add()
allocates only sizeof(struct perf_pmu) with pmu->from_env =3D true and
pmu->sysfs_aliases_loaded =3D true.

Unlike perf_pmu__have_event() or perf_pmu__delete(), perf_pmu__config_terms=
()
and perf_pmu__check_alias() in tools/perf/util/pmu.c do not check
!pmu->from_env before dispatching on perf_pmu__is_drm() and
perf_pmu__is_hwmon():

tools/perf/util/pmu.c:perf_pmu__config_terms() {
	if (perf_pmu__is_hwmon(pmu))
		return hwmon_pmu__config_terms(pmu, attr, terms, err);
	if (perf_pmu__is_drm(pmu))
		return drm_pmu__config_terms(pmu, attr, terms, err);
}

tools/perf/util/pmu.c:perf_pmu__check_alias() {
	if (perf_pmu__is_hwmon(pmu)) {
		ret =3D hwmon_pmu__check_alias(head_terms, info, err);
		goto out;
	}
	if (perf_pmu__is_drm(pmu)) {
		ret =3D drm_pmu__check_alias(pmu, head_terms, info, err);
		goto out;
	}
}

drm_pmu__check_alias() and drm_pmu__config_terms() cast pmu via
container_of(pmu, struct drm_pmu, pmu) and read drm->num_events and
drm->events past the end of struct perf_pmu. Similarly,
hwmon_pmu__config_terms() casts pmu via container_of(pmu, struct hwmon_pmu,
pmu), sees pmu->sysfs_aliases_loaded =3D=3D true in hwmon_pmu__read_events(=
), and
reads hwm->events out-of-bounds in hwmon_pmu__config_term().

Should perf_pmu__config_terms() and perf_pmu__check_alias() also guard the
DRM and HWMON paths with !pmu->from_env?

> +	pmu->caps_initialized =3D true;
> +	pmu->max_precise =3D -1;
> +	pmu->is_core =3D env_is_pmu_core(name, env);
> +	pmu->is_uncore =3D strstarts(name, "uncore_");
> +
> +	if (!strcmp(name, "software") || !strcmp(name, "tool"))
> +		pmu->events_table =3D perf_pmu__default_core_events_table();
> +	else if (core_table && (pmu->is_core || pmu->is_uncore))
> +		pmu->events_table =3D core_table;

[Severity: Medium]
Does checking strstarts(name, "uncore_") leave non-"uncore_" uncore PMUs
without pmu->is_uncore and pmu->events_table?

Many uncore and package PMUs whose JSON events are compiled into core_table=
 by
jevents.py do not have names starting with "uncore_" in sysfs and
HEADER_PMU_MAPPINGS, such as amd_l3, amd_df, and amd_umc_<N> on AMD x86,
hisi_sccl<N>_ddrc<M> / hisi_sccl<N>_hha<M> / hisi_sccl<N>_l3c<M> on arm64, =
and
pai_crypto / pai_ext on s390.

Because pmu->is_uncore is false for these PMUs, env_pmu_find_or_add() leaves
pmu->events_table as NULL, and perf_pmu___name_match() in
tools/perf/util/pmu.c takes the !pmu->is_uncore exact-match branch:

tools/perf/util/pmu.c:perf_pmu___name_match() {
	...
	if (!pmu->is_uncore) {
		/*
		 * PMU isn't core or uncore, some kind of broken CPU mask
		 * situation. Only match exact name.
		 */
		return is_same;
	}
	return pmu->is_core ?
		perf_pmu__match_ignoring_suffix(pmu_name, to_match) :
		(wildcard_match ?
		 perf_pmu__match_wildcard_uncore(pmu_name, to_match) :
		 perf_pmu__match_ignoring_suffix_uncore(pmu_name, to_match));
}

As a result, perf_pmu__num_events(), perf_pmu__for_each_event(), and
perf_pmu__have_event() miss all JSON events for these uncore PMUs.

> +
> +	list_add_tail(&pmu->list, pmu->is_core ? &core_pmus : &other_pmus);
> +	return pmu;
> +}
[ ... ]
> +int perf_pmus__read_from_env(struct perf_env *env)
> +{
> +	const struct pmu_events_table *core_table =3D NULL;
> +	struct perf_pmu *pmu;
> +
> +	if (!env)
> +		return -EINVAL;
> +
> +	perf_pmus__destroy();
> +	read_pmu_types =3D PERF_TOOL_PMU_TYPE_ALL_MASK;

[Severity: Medium]
When perf_pmus__read_from_env() destroys and replaces core_pmus, how are the
cached states in perf_pmus__num_core_pmus() and
perf_pmus__supports_extended_type() handled?

First, perf_pmus__num_core_pmus() caches the core PMU count in a function-l=
ocal
static variable that is not reset by perf_pmus__destroy():

tools/perf/util/pmus.c:perf_pmus__num_core_pmus() {
	static int count;

	if (!count) {
		struct perf_pmu *pmu =3D NULL;

		while ((pmu =3D perf_pmus__scan_core(pmu)) !=3D NULL)
			count++;
	}
	return count;
}

If perf_pmus__num_core_pmus() is called before perf_pmus__read_from_env() (=
or
after a later perf_pmus__destroy()), it returns the stale count to callers
such as evsel__is_hybrid(), perf_pmu__auto_merge_stats(),
perf_env__read_core_pmu_caps(), and hybrid_topology__new() that use it to
detect hybrid topologies and size heap allocations before iterating
perf_pmus__scan_core().

Second, perf_pmus__supports_extended_type() caches
perf_pmus__do_support_extended_type via pthread_once, and
__perf_pmus__supports_extended_type() probes the live host kernel via
is_event_supported():

tools/perf/util/pmus.c:__perf_pmus__supports_extended_type() {
	struct perf_pmu *pmu =3D NULL;

	if (perf_pmus__num_core_pmus() <=3D 1)
		return false;

	while ((pmu =3D perf_pmus__scan_core(pmu)) !=3D NULL) {
		if (!is_event_supported(PERF_TYPE_HARDWARE, PERF_COUNT_HW_CPU_CYCLES | ((=
__u64)pmu->type << PERF_PMU_TYPE_SHIFT)))
			return false;
	}

	return true;
}

When analyzing a hybrid perf.data on a non-hybrid or cross-architecture host
(or when a hybrid PMU reconstructed from HEADER_HYBRID_TOPOLOGY has
PERF_PMU_TYPE_FAKE), is_event_supported() fails against the host kernel.
Consequently, perf_pmus__find_by_attr() and evsel__find_pmu() skip resolving
attr->config >> PERF_PMU_TYPE_SHIFT and assign PERF_TYPE_HARDWARE and
PERF_TYPE_HW_CACHE events to the first core PMU.

> +
> +	if (env->cpuid) {
> +		const char *arch =3D perf_env__arch(env);
> +		char cpuid_str[128];
> +		char vendor[32];
> +		unsigned int family, model, step;
> +		char extra;
> +
> +		core_table =3D find_core_events_table(arch, env->cpuid);
> +		/*
> +		 * x86 HEADER_CPUID stores "vendor,family,model,step" in decimal
> +		 * while pmu-events tables match "vendor-family-HEXMODEL[-HEXSTEP]".
> +		 */
> +		if (!core_table && !strcmp(arch, "x86") &&
> +		    sscanf(env->cpuid, "%31[^,],%u,%u,%u%c",
> +			   vendor, &family, &model, &step, &extra) =3D=3D 4) {
> +			snprintf(cpuid_str, sizeof(cpuid_str), "%s-%u-%X-%X",
> +				 vendor, family, model, step);
> +			core_table =3D find_core_events_table(arch, cpuid_str);
> +			if (!core_table) {
> +				snprintf(cpuid_str, sizeof(cpuid_str), "%s-%u-%X",
> +					 vendor, family, model);
> +				core_table =3D find_core_events_table(arch, cpuid_str);
> +			}
> +		}
> +	}

[Severity: Medium]
Does calling find_core_events_table(arch, env->cpuid) with the unformatted =
x86
env->cpuid emit error messages and misbehave across architectures?

On x86, HEADER_CPUID is recorded as comma-separated "vendor,family,model,st=
ep"
with no '-' characters. Passing raw env->cpuid into find_core_events_table()
calls x86's strcmp_cpuid_str() against every x86 entry in pmu_events_map. W=
hen
it reaches 3-dash map entries such as GenuineIntel-6-55-[56789ABCDEF],
full_mapcpuid is true while full_cpuid is false:

tools/perf/arch/x86/util/header.c:strcmp_cpuid_str() {
	...
	if (full_mapcpuid && !full_cpuid) {
		pr_info("Invalid CPUID %s. Full CPUID is required, "
			"vendor-family-model-stepping\n", id);
		return 1;
	}
}

This prints "Invalid CPUID ... Full CPUID is required,
vendor-family-model-stepping" to stderr on every x86 perf.data file before =
the
sscanf() conversion runs, and the 3-field "%s-%u-%X" fallback triggers the
same message again if the 4-field lookup does not find a match (while x86's
strcmp_cpuid_str() already strips stepping when !full_mapcpuid && full_cpui=
d).

In addition, find_core_events_table() calls the host binary's
strcmp_cpuid_str() rather than matching according to the target architecture
in arch:

tools/perf/arch/arm64/util/header.c:strcmp_cpuid_str() {
	u64 map_id =3D strtoull(mapcpuid, NULL, 16);
	char map_id_variant =3D FIELD_GET(MIDR_VARIANT_MASK, map_id);
	char map_id_revision =3D FIELD_GET(MIDR_REVISION_MASK, map_id);
	u64 id =3D strtoull(idstr, NULL, 16);
	...
}

When an arm64 host binary inspects an x86 perf.data file, arm64's
strcmp_cpuid_str() parses both non-hex x86 CPUID strings as 0 via strtoull()
and falsely matches the first x86 table entry. Conversely, on a host using =
the
default __weak strcmp_cpuid_str(), 4-field "%s-%u-%X-%X" strings do not str=
ip
the stepping to match 3-field x86 table entries.

[ ... ]

> +}

([ ... ])

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017185442.2137=
623-1-irogers@google.com?part=3D2

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AABD369997
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 21:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792187791; cv=none; b=Fy2Un4jTv3h0V/8Y0j7a7t/PW4m9Gf+oVVLHBdVtsDt+v26w773OzVPlimgaRGgPfsY3lQTBqJ+zGzHEjI458ef+Ymw/4b7n7z9cG0NZfheyXM1SiYVohEZh6Tt0PTn14JE0vVKXsUrIsSgHRPAJh8xNVMniz3zhc8lCYcXSrqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792187791; c=relaxed/simple;
	bh=7p/DKvudO8n1JpAKUJDMR+YONrD5I2QYQ4uCmQh5Zzw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Fcobc8JpISDtbGvBatA/aTRtOQxZ0hiuFlfaQ5Ir+C+zEwcsAMSipRGEGGjFiX/XfnGIC2Jvr+2IeltfrzdOmHZf5JXBGTnS0kBqDFHpAEiLETf4GZMJwyx5/KK/1o6ipvM0XhsxNMghOTU7CAHtSIZGXrO6+2BSZwr5S3fKlQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZblTeIiE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZblTeIiE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE021F000C4;
	Fri, 16 Oct 2026 21:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792187789;
	bh=qxchHrlYaqiuEbv1VkSo8jAK3bOTpxp5OyCqx6c3uPQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZblTeIiEhIjLILP7px2KnBnu5I1uB4hhyOlUj7o86xEZ2j01iBv8YdNG8d8NaujPU
	 7Qop1M9+q45zaWOaqsn6+1huj7EG+Z07aSZE9fteQdKOjd0WfKaYTMvDsJrc51wnS0
	 gnL8UYxAO/OVJD9x+tB2qkb8137MsygG55ZpOcmjSoMWVBOMHHaL+q+hmynHShhO0V
	 7Pssw2mSxPXwBumVcfoCQR6CrOM56lBFtlG1QAbG4ROy6doep5fC+N233KsTFqIVvJ
	 RNvJe9KqYHBSp1f0wjdau/9MSmsx9TRSqAc2ozzPzFDja1G6H30g3/sGisTwGyg2Q9
	 fyWfUtUHgrVjQ==
Message-ID: <sashiko-outbox-174979@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 1/2] perf pmus: Add PMU environment loading and
 live capability probing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016213258.945737-2-irogers@google.com>
References: <20261016213258.945737-1-irogers@google.com>
 <20261016213258.945737-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 21:56:28 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] perf pmus: out-of-bounds container_of() access in env_pmu_find_or_=
add()
- [Medium] perf pmus: broken CPUID matching in perf_pmus__read_from_env()
- [Medium] perf pmu: broken bulk and callchain probing in probe_sample_type=
s()
- [Medium] perf pmu: fixed-counter ref-cycles in GP probe in perf_pmu__prob=
e()
- [Medium] perf pmu: duplicate legacy XMM and SIMD probing in probe_pmu_reg=
s_one()
- [Medium] perf pmu: unchecked CPU_SET() index in probe_group_limits()
--

commit 73f853dff74bd3f7177753b6ce1c952979dbfcbb
Author: Ian Rogers <irogers@google.com>

perf pmus: Add PMU environment loading and live capability probing

This commit adds helpers to reconstruct PMU lists and capabilities from
perf_env headers, exposes duplicate uncore PMU scanning and mem-events
formatting helpers, and adds perf_pmu__probe() to probe live PMU
capabilities via perf_event_open().

> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 01753d5c69d13..0d1c5ba7d426d 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c

[ ... ]

> @@ -2798,9 +2844,1935 @@ void perf_pmu__delete(struct perf_pmu *pmu)

[ ... ]

> +static void probe_group_limits(const struct perf_event_attr *attrs, size=
_t nr_attrs,
> +			       pid_t pid, int cpu, unsigned long flags,
> +			       int *max_open, bool *open_capped,
> +			       int *max_active, bool *active_capped)
> +{
> +	struct perf_event_attr leader_attr;
> +	int leader_fd;
> +	int fds[MAX_PROBE_GROUP_SIZE];
> +	int nr_followers =3D 0;
> +	bool has_time_read =3D true;
> +	bool active_ok =3D true;
> +	enum rlimit_action set_rlimit =3D NO_CHANGE;
> +	cpu_set_t saved_affinity, probe_affinity;
> +	bool affinity_changed =3D false;
> +
> +	*max_open =3D 0;
> +	*open_capped =3D false;
> +	*max_active =3D 0;
> +	*active_capped =3D false;
> +
> +	if (!attrs || nr_attrs =3D=3D 0)
> +		return;
> +
> +	if (pid =3D=3D 0 && cpu >=3D 0) {
> +		CPU_ZERO(&saved_affinity);
> +		if (sched_getaffinity(0, sizeof(saved_affinity), &saved_affinity) =3D=
=3D 0) {
> +			CPU_ZERO(&probe_affinity);
> +			CPU_SET(cpu, &probe_affinity);

[Severity: Medium]
Can CPU_SET(cpu, &probe_affinity) write out of bounds on the stack here when
cpu >=3D CPU_SETSIZE?

In perf_pmu__probe() -> probe_group_limits(), cpu comes from
select_probe_cpu(pmu), which returns the first online CPU in pmu->cpus
without bounding it to CPU_SETSIZE.

Unlike probe_mmap_caps() and probe_pmu_skid() later in this file, which both
check pmu_cpu < CPU_SETSIZE before calling CPU_SET(), probe_group_limits()
only checks cpu >=3D 0. On systems with CPU IDs >=3D 1024, this can write p=
ast
probe_affinity on libcs without bounds checking (such as musl) or produce an
empty affinity mask on glibc.

> +			if (sched_setaffinity(0, sizeof(probe_affinity), &probe_affinity) =3D=
=3D 0)
> +				affinity_changed =3D true;
> +		}
> +	}

[ ... ]

> +static void probe_sample_types(struct perf_pmu *pmu,
> +			       const struct perf_event_attr *base_attr,
> +			       pid_t pid, int cpu, unsigned long flags)
> +{
> +	u64 reg_bit =3D BIT_ULL(perf_arch_reg_ip(EM_HOST)) ?: 1ULL;
> +	u64 bulk_mask =3D PERF_SAMPLE_IP | PERF_SAMPLE_TID | PERF_SAMPLE_TIME |
> +			PERF_SAMPLE_ADDR | PERF_SAMPLE_READ | PERF_SAMPLE_CALLCHAIN |
> +			PERF_SAMPLE_ID | PERF_SAMPLE_CPU | PERF_SAMPLE_PERIOD |
> +			PERF_SAMPLE_STREAM_ID | PERF_SAMPLE_RAW | PERF_SAMPLE_REGS_USER |
> +			PERF_SAMPLE_STACK_USER | PERF_SAMPLE_WEIGHT | PERF_SAMPLE_DATA_SRC |
> +			PERF_SAMPLE_IDENTIFIER | PERF_SAMPLE_TRANSACTION |
> +			PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_AUX | PERF_SAMPLE_CGROUP |
> +			PERF_SAMPLE_DATA_PAGE_SIZE | PERF_SAMPLE_CODE_PAGE_SIZE |
> +			PERF_SAMPLE_WEIGHT_STRUCT;
> +	struct perf_event_attr b_attr =3D *base_attr;
> +	int b_fd;
> +
> +	b_attr.disabled =3D 1;
> +	b_attr.sample_period =3D base_attr->sample_period ?: 10000;
> +	b_attr.sample_type =3D bulk_mask;
> +	b_attr.sample_regs_user =3D reg_bit;
> +	b_attr.sample_regs_intr =3D reg_bit;
> +	b_attr.sample_stack_user =3D 64;
> +	b_attr.inherit =3D 0;
> +	b_fd =3D sys_perf_event_open(&b_attr, pid, cpu, -1, flags);
> +	if (b_fd >=3D 0) {
> +		close(b_fd);
> +		pmu->probed.sample_types |=3D bulk_mask;
> +	}
> +
> +	for (unsigned int shift =3D 0; (1ULL << shift) < PERF_SAMPLE_MAX; shift=
++) {
> +		u64 bit =3D 1ULL << shift;
> +		struct perf_event_attr attr =3D *base_attr;
> +		int fd;
> +
> +		if (pmu->probed.sample_types & bit)
> +			continue;
> +
> +		attr.disabled =3D 1;
> +		attr.sample_period =3D base_attr->sample_period ?: 10000;
> +		attr.sample_type =3D bit;
> +
> +		switch (bit) {
> +		case PERF_SAMPLE_BRANCH_STACK:
> +			attr.branch_sample_type =3D PERF_SAMPLE_BRANCH_ANY |
> +				(attr.exclude_kernel ? PERF_SAMPLE_BRANCH_USER : 0);
> +			break;
> +		case PERF_SAMPLE_REGS_USER:
> +			attr.sample_regs_user =3D reg_bit;
> +			break;
> +		case PERF_SAMPLE_REGS_INTR:
> +			attr.sample_regs_intr =3D reg_bit;
> +			break;
> +		case PERF_SAMPLE_STACK_USER:
> +			attr.sample_stack_user =3D 64;
> +			break;
> +		case PERF_SAMPLE_READ:
> +			attr.inherit =3D 0;
> +			break;
> +		default:
> +			break;
> +		}
> +
> +		fd =3D sys_perf_event_open(&attr, pid, cpu, -1, flags);

[Severity: Medium]
There appear to be two issues in probe_sample_types():

First, bulk_mask sets both PERF_SAMPLE_WEIGHT and PERF_SAMPLE_WEIGHT_STRUCT
(as well as PERF_SAMPLE_AUX without an AUX group leader). In
kernel/events/core.c:perf_copy_attr():

	if ((attr->sample_type & PERF_SAMPLE_WEIGHT) &&
	    (attr->sample_type & PERF_SAMPLE_WEIGHT_STRUCT))
		return -EINVAL;

Doesn't this cause the bulk sys_perf_event_open(&b_attr, ...) fast-path to
always fail with -EINVAL?

Second, in the per-bit fallback loop, when base_attr->exclude_kernel =3D=3D=
 1
(for example, when running unprivileged with perf_event_paranoid >=3D 1),
probing PERF_SAMPLE_CALLCHAIN leaves attr.exclude_callchain_kernel =3D=3D 0=
. In
kernel/events/core.c:SYSCALL_DEFINE5(perf_event_open):

	if (!attr.exclude_kernel ||
	    ((attr.sample_type & PERF_SAMPLE_CALLCHAIN) &&
	     !attr.exclude_callchain_kernel)) {
		err =3D perf_allow_kernel();
		if (err)
			return err;
	}

When perf_allow_kernel() denies kernel profiling, won't the kernel reject
PERF_SAMPLE_CALLCHAIN with -EACCES and cause pmu->probed.can_callchain to be
falsely reported as false unless attr.exclude_callchain_kernel =3D
attr.exclude_kernel is set?

> +		if (fd < 0 && bit =3D=3D PERF_SAMPLE_BRANCH_STACK) {
> +			attr.branch_sample_type =3D PERF_SAMPLE_BRANCH_ANY;
> +			fd =3D sys_perf_event_open(&attr, pid, cpu, -1, flags);
> +		}

[ ... ]

> +static void probe_pmu_regs_one(const struct perf_pmu *pmu,
> +			       const struct perf_event_attr *base_attr,
> +			       pid_t pid, int cpu, unsigned long flags,
> +			       int max_precise, bool intr,
> +			       u64 *out_mask, int *out_abi,
> +			       u64 *out_simd_mask, u64 *out_pred_mask)
> +{

[ ... ]

> +	if (EM_HOST =3D=3D EM_X86_64 || EM_HOST =3D=3D EM_386) {
> +		int host_abi =3D 0;
> +		u64 host_mask =3D intr ? perf_intr_reg_mask(EM_HOST, &host_abi) :
> +				       perf_user_reg_mask(EM_HOST, &host_abi);
> +
> +		if ((host_abi & PERF_SAMPLE_REGS_ABI_SIMD) && (host_mask & ~gpr_mask))=
 {
> +			u64 egpr_masks[] =3D { GENMASK_ULL(39, 24), BIT_ULL(40) };

[ ... ]

> +				if (fd >=3D 0) {
> +					close(fd);
> +					mask |=3D egpr_masks[i];
> +					abi |=3D PERF_SAMPLE_REGS_ABI_SIMD;
> +				}
> +			}
> +		}
> +	}
> +
> +	if (!(abi & PERF_SAMPLE_REGS_ABI_SIMD)) {
> +		u64 ext_mask =3D GENMASK_ULL(63, 32) & ~gpr_mask;
> +		struct perf_event_attr x_attr =3D *base_attr;
> +		bool batch_ok =3D false;

[Severity: Medium]
On x86_64 systems that support the SIMD register sampling ABI
(sample_simd_regs_enabled =3D 1) for XMM/YMM/ZMM registers but do not have =
APX
or CET SSP, won't this probe both legacy PEBS XMM bits (32..47) in *out_mask
and the XMM register class in *out_simd_mask?

In tools/perf/util/perf-regs-arch/perf_regs_x86.c:__perf_reg_mask_x86(),
PERF_SAMPLE_REGS_ABI_SIMD is only set in host_abi when APX (R16-R31) or CET
(SSP) is supported. Because the legacy bit 32..63 probe here checks
!(abi & PERF_SAMPLE_REGS_ABI_SIMD) before probing the SIMD vector/predicate
register classes (*out_simd_mask and *out_pred_mask) below, abi is still 0
when APX and SSP are absent, causing XMM registers to be recorded in both
intr_regs_mask and intr_simd_mask.

> +
> +		x_attr.disabled =3D 1;
> +		x_attr.sample_period =3D base_attr->sample_period ?: 10000;
> +		x_attr.sample_type =3D sample_type;
> +		if (intr && max_precise > 0)
> +			x_attr.precise_ip =3D 1;

[ ... ]

> +void perf_pmu__probe(struct perf_pmu *pmu)
> +{

[ ... ]

> +	/*
> +	 * On core PMUs, cycles/instructions may use fixed counters in addition
> +	 * to general-purpose (GP) programmable counters. Probe a GP-only event
> +	 * group rotating through distinct GP events to determine the GP limit.
> +	 */
> +	if (pmu->is_core) {
> +		static const char * const gp_events[] =3D {
> +			"branches",
> +			"branch-misses",
> +			"cache-misses",
> +			"cache-references",
> +			"bus-cycles",
> +			"stalled-cycles-frontend",
> +			"stalled-cycles-backend",
> +			"ref-cycles",
> +		};
> +		static const int gp_configs[] =3D {
> +			PERF_COUNT_HW_BRANCH_INSTRUCTIONS,
> +			PERF_COUNT_HW_BRANCH_MISSES,
> +			PERF_COUNT_HW_CACHE_MISSES,
> +			PERF_COUNT_HW_CACHE_REFERENCES,
> +			PERF_COUNT_HW_BUS_CYCLES,
> +			PERF_COUNT_HW_STALLED_CYCLES_FRONTEND,
> +			PERF_COUNT_HW_STALLED_CYCLES_BACKEND,
> +			PERF_COUNT_HW_REF_CPU_CYCLES,
> +		};

[Severity: Medium]
Should ref-cycles / PERF_COUNT_HW_REF_CPU_CYCLES be excluded from the GP-on=
ly
probe list in perf_pmu__probe()?

On Intel core PMUs (arch/x86/events/intel/core.c,
FIXED_EVENT_CONSTRAINT(0x0300, 2)), both sysfs cpu/ref-cycles/
(event=3D0x00,umask=3D0x03) and PERF_COUNT_HW_REF_CPU_CYCLES map to
pseudo-encoding 0x0300, which is constrained exclusively to Fixed Counter 2
rather than a general-purpose counter. Including it in gp_events[] and
gp_configs[] causes Fixed Counter 2 to be allocated during the GP group
probe, inflating max_gp_group_size and max_active_gp_group_size by 1 on Int=
el
CPUs with >=3D 5 GP counters.

> +		struct perf_event_attr gp_attrs[MAX_PROBE_GROUP_SIZE];
> +		size_t nr_gp_attrs =3D 0;

[ ... ]

> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> index 1355b317f3eda..44f24e3a177a9 100644
> --- a/tools/perf/util/pmus.c
> +++ b/tools/perf/util/pmus.c

[ ... ]

> @@ -916,3 +940,198 @@ struct perf_pmu *perf_pmus__fake_pmu(void)

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
> +	if (perf_pmu__init(pmu, type, name) !=3D 0) {
> +		perf_pmu__delete(pmu);
> +		return NULL;
> +	}

[Severity: High]
Can this trigger an out-of-bounds container_of() access and invalid free wh=
en
HEADER_PMU_MAPPINGS contains hwmon or drm PMUs?

When HEADER_PMU_MAPPINGS is written by write_pmu_mappings() or populated by
perf_env__read_pmu_mappings(), perf_pmus__scan() includes hwmon PMUs (type =
in
PERF_PMU_TYPE_HWMON_START..PERF_PMU_TYPE_HWMON_END) and drm PMUs (type in
PERF_PMU_TYPE_DRM_START..PERF_PMU_TYPE_DRM_END).

In perf_pmus__read_from_env() -> env_pmu_find_or_add(), pmu is allocated as=
 a
plain struct perf_pmu via zalloc(sizeof(*pmu)) with pmu->type set to the raw
type from env->pmu_mappings. Because perf_pmu__is_hwmon() and
perf_pmu__is_drm() only check whether pmu->type falls in those ranges,
subsequent calls to perf_pmu__delete() (for example from
perf_pmus__destroy()):

	if (perf_pmu__is_hwmon(pmu))
		hwmon_pmu__exit(pmu);
	else if (perf_pmu__is_drm(pmu))
		drm_pmu__exit(pmu);

as well as perf_pmu__num_events(), perf_pmu__for_each_event(), and
perf_pmu__have_event() will dispatch to hwmon_pmu__* / drm_pmu__*, which use
container_of() to cast pmu to struct hwmon_pmu or struct drm_pmu and read or
free fields past the end of the struct perf_pmu allocation.

> +
> +	pmu->sysfs_aliases_loaded =3D true;
> +	pmu->caps_initialized =3D true;
> +	pmu->max_precise =3D -1;
> +	pmu->is_core =3D env_is_pmu_core(name, env);
> +	pmu->is_uncore =3D strstarts(name, "uncore_");

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
> +
> +	if (env->cpuid) {
> +		char cpuid_str[128];
> +		char vendor[32];
> +		unsigned int family, model, step;
> +		const char *cpuid =3D env->cpuid;
> +
> +		/*
> +		 * x86 HEADER_CPUID stores "vendor,family,model,step" in decimal
> +		 * while pmu-events tables match "vendor-family-HEXMODEL-HEXSTEP".
> +		 */
> +		if (sscanf(env->cpuid, "%31[^,],%u,%u,%u",
> +			   vendor, &family, &model, &step) =3D=3D 4) {
> +			snprintf(cpuid_str, sizeof(cpuid_str), "%s-%u-%X-%X",
> +				 vendor, family, model, step);
> +			cpuid =3D cpuid_str;
> +		}
> +		core_table =3D find_core_events_table(perf_env__arch(env), cpuid);
> +	}

[Severity: Medium]
Does this CPUID conversion break core_table lookup on s390 and on cross-arch
analysis of x86 perf.data files?

On s390, get_cpuid() in tools/perf/arch/s390/util/header.c formats
HEADER_CPUID as "manufacturer,type,model,version,authorization" (for exampl=
e,
"IBM,2964,702,3.5,002f"). Because the sscanf() call does not check that the
architecture is x86 or that the string ends after the 4th field, s390 CPUIDs
match all 4 specifiers and get rewritten to "IBM-2964-2BE-3", which fails to
match the s390 regexes in tools/perf/pmu-events/arch/s390/mapfile.csv.

Additionally, when analyzing an x86 perf.data file on a non-x86 host,
find_core_events_table() uses the generic strcmp_cpuid_str() in
tools/perf/util/header.c:

	if (match) {
		size_t match_len =3D (pmatch[0].rm_eo - pmatch[0].rm_so);

		/* Verify the entire string matched. */
		if (match_len =3D=3D strlen(cpuid))
			return 0;
	}

Since most x86 entries in tools/perf/pmu-events/arch/x86/mapfile.csv are
3-field patterns without stepping (such as GenuineIntel-6-CF), won't a
4-field "%s-%u-%X-%X" string fail the match_len =3D=3D strlen(cpuid) check =
unless
there is a 3-field "%s-%u-%X" fallback when find_core_events_table() returns
NULL?

> +
> +	/* 1. Populate from HEADER_PMU_MAPPINGS */
> +	if (env->nr_pmu_mappings > 0 && env->pmu_mappings) {

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016213258.9457=
37-1-irogers@google.com?part=3D1

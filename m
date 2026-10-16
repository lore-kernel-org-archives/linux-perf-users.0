Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4673BBFBA
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 21:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792187107; cv=none; b=OkGb+4BVo7+XGK3aUsi4O6qJ3uOqelelw9ntvgSPu4Tv3CJarT6OCjt5vungv1D14Ggpy8OLOGNcU8XaFvJCrkNp9yykhCevqYHpOCEnUJPTu73V0Wd66jHbIKPpCUpjO+tLiwG9Kl1g+SHRV6h8i7272/SDOro9VQdBqVQ3Zu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792187107; c=relaxed/simple;
	bh=A3f7sMwc3Vmyb9OLhXSLlZsrgeqSPbLammHHNP8Z0iE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=o3uWktiaWZtQMksan2uAxjmVzlYDfuBvOHOfxMLp32f5QiyFsHiRcdUCJkTyRuVfFdNgKl2M1R6GeNPkF/cXQft1APGvGb9zh6xH116ubZ0QFS2LIDLatJyLx3wMzy1rWbt5QicBb8B6rzEknFpSKeBsd1psiJxL3jMxE+BBOMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dS1yOhy1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dS1yOhy1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715351F000C4;
	Fri, 16 Oct 2026 21:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792187105;
	bh=cYqa2vRYxJCi454g3pmMmQvp32/Me1E+9sPujEupPi4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dS1yOhy1WgBpIbtMi1wLW64YMdt4I8w1a/QFOqUmprCvYZydFH7vV1toSWSAlcYKF
	 /0AbvVrNqXp5YldCe6lNOk8Nrfy9JRuCPB+83u68DNcCRtUCk9s1P8pNW3UyOw5u2p
	 IvOt/kJgPT5+jzj2Pan2Nw2YytufaDFpudZdoPxjCrLKRTmf+hYJyFDs6FXu7rieLK
	 FoO5WmGCU7bJk/v7rtTtYC9DZIhhjETPw718l1qvec4pvsL8oQaM2sLnjVPfkjVzVc
	 iVM8/XqSzze/KwYvBp5xuga+tErQa/s8ca242GH0g9WL58uDQdcdfnRpQrboewmzYH
	 C9nOTw/PrwX9A==
Message-ID: <sashiko-outbox-174975@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 2/2] perf sysinfo: Add sysinfo subcommand,
 documentation, and test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016213258.945737-3-irogers@google.com>
References: <20261016213258.945737-1-irogers@google.com>
 <20261016213258.945737-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 21:45:05 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf sysinfo: broken perf.data metrics lookup in print_system_su=
mmary()
- [Medium] perf sysinfo: inaccurate mem_events detection in print_system_su=
mmary()
--

commit eeafacdf44b45876a713b51b3eacc1d62e8dae1a
Author: Ian Rogers <irogers@google.com>

perf sysinfo: Add sysinfo subcommand, documentation, and test

This commit adds the perf sysinfo subcommand to display and probe PMU and
system performance monitoring capabilities on a live system or from a
perf.data file.

> diff --git a/tools/perf/builtin-sysinfo.c b/tools/perf/builtin-sysinfo.c
> new file mode 100644
> index 0000000000000..8bc13f3dedb0b
> --- /dev/null
> +++ b/tools/perf/builtin-sysinfo.c
> @@ -0,0 +1,1958 @@

[ ... ]

> +static void print_system_summary(FILE *fp, const struct perf_session *se=
ssion,
> +				 bool probed, bool leading_newline)
> +{
> +	const struct pmu_metrics_table *mtable;

[ ... ]

> +	while ((pmu =3D perf_pmus__scan_skip_duplicates(pmu)) !=3D NULL) {
> +		size_t pmu_events =3D perf_pmu__num_events(pmu);
> +		size_t sysfs_ev =3D pmu->sysfs_aliases;
> +		size_t json_ev =3D pmu_events > sysfs_ev ? pmu_events - sysfs_ev : 0;
> +
> +		total_pmus++;
> +		total_events +=3D pmu_events;
> +		total_sysfs_events +=3D sysfs_ev;
> +		total_json_events +=3D json_ev;
> +
> +		if (pmu->is_core) {
> +			struct perf_pmu_caps *br_cap;
> +
> +			add_pmu_display_name(core_pmus, pmu);
> +			perf_pmu__caps_parse(pmu);
> +			br_cap =3D perf_pmu__get_cap(pmu, "branches");
> +			if (br_cap && br_cap->value) {
> +				int depth =3D atoi(br_cap->value);
> +
> +				if (depth > max_br_depth)
> +					max_br_depth =3D depth;
> +			}
> +			if (probed && pmu->probed.checked && pmu->probed.open_supported) {
> +				if (pmu->probed.can_sample)
> +					core_can_sample =3D true;
> +				if (pmu->probed.max_precise > 0) {
> +					core_precise =3D true;
> +					if (pmu->probed.max_precise > max_precise)
> +						max_precise =3D pmu->probed.max_precise;
> +				}
> +				if (pmu->probed.can_user_rdpmc)
> +					core_rdpmc =3D true;
> +				if (pmu->probed.can_branch_stack)
> +					core_branch_stack =3D true;
> +				if (pmu->probed.mem_events_mask)
> +					core_mem_events =3D true;
> +				if (pmu->probed.can_leader_sampling)
> +					core_leader_sampling =3D true;
> +			} else {
> +				core_can_sample =3D true;
> +				if (pmu->max_precise > 0) {
> +					core_precise =3D true;
> +					if (pmu->max_precise > max_precise)
> +						max_precise =3D pmu->max_precise;
> +				}
> +				if (max_br_depth > 0)
> +					core_branch_stack =3D true;
> +				if (pmu->mem_events)
> +					core_mem_events =3D true;
> +			}

[Severity: Medium]
Can this misreport core_mem_events in print_system_summary()?

On AMD x86 and ARM64 systems, pmu->mem_events is attached to non-core PMUs
(ibs_op and arm_spe_*, where pmu->is_core is false), while the core PMU has
pmu->mem_events =3D=3D NULL. Checking mem_events only inside the if (pmu->i=
s_core)
block causes the summary to always report memory profiling events as missing
on those architectures.

Conversely, in the unprobed else branch, checking if (pmu->mem_events)
without calling perf_pmu__mem_events_init_pmu(pmu) (unlike
print_mem_events_static()) will set core_mem_events =3D true whenever
perf_pmu__arch_init() assigns a static perf_mem_events array to a core PMU,
even if none of the events (such as events/mem-loads or events/mem-stores)
are actually supported in sysfs.

> +		} else if (pmu->type =3D=3D PERF_TYPE_SOFTWARE) {
> +			if (!probed || !pmu->probed.checked || pmu->probed.can_sample)
> +				has_sw_sampling =3D true;
> +		}
> +
> +		if (pmu->auxtrace)
> +			add_pmu_display_name(aux_pmus, pmu);
> +		if (is_mem_bw_pmu_name(pmu->name))
> +			add_pmu_display_name(mem_bw_pmus, pmu);
> +		if (is_io_bw_pmu_name(pmu->name))
> +			add_pmu_display_name(io_bw_pmus, pmu);
> +	}
> +
> +	if (session && session->header.env.arch && session->header.env.cpuid)
> +		mtable =3D find_core_metrics_table(session->header.env.arch,
> +						 session->header.env.cpuid);
> +	else
> +		mtable =3D pmu_metrics_table__find();

[Severity: Medium]
Will find_core_metrics_table() fail to match the metrics table when reading
from a perf.data file here?

session->header.env.arch contains the raw uts.machine string from
HEADER_ARCH (such as "x86_64", "aarch64", or "ppc64le"), whereas
pmu_events_map[].arch uses the normalized architecture name returned by
perf_env__arch(&session->header.env) ("x86", "arm64", "powerpc", etc.).

In addition, on x86, session->header.env.cpuid stores "vendor,family,model,=
step"
in decimal, whereas pmu_events_map and strcmp_cpuid_str() expect the
"vendor-family-HEXMODEL-HEXSTEP" format. In perf_pmus__read_from_env() in
tools/perf/util/pmus.c, both conversions are performed before calling
find_core_events_table():

	if (env->cpuid) {
		char cpuid_str[128];
		char vendor[32];
		unsigned int family, model, step;
		const char *cpuid =3D env->cpuid;

		if (sscanf(env->cpuid, "%31[^,],%u,%u,%u",
			   vendor, &family, &model, &step) =3D=3D 4) {
			snprintf(cpuid_str, sizeof(cpuid_str), "%s-%u-%X-%X",
				 vendor, family, model, step);
			cpuid =3D cpuid_str;
		}
		core_table =3D find_core_events_table(perf_env__arch(env), cpuid);
	}

Also, if session is non-NULL (-i perf.data) but either arch or cpuid is NULL
in the header, falling into the else branch calls pmu_metrics_table__find(),
which queries the live host CPU's metrics table instead of treating the
recorded environment as having no core metrics table.

[ ... ]

> +	while ((pmu =3D show_all ? perf_pmus__scan(pmu) :
> +				 perf_pmus__scan_skip_duplicates(pmu)) !=3D NULL) {
> +		if (!pmu_matches_filters(pmu, argc, argv))
> +			continue;
> +
> +		if (do_probe && !input_name &&
> +		    (show_pmus || pmu->is_core || pmu->type =3D=3D PERF_TYPE_SOFTWARE))
> +			perf_pmu__probe(pmu);

[Severity: Medium]
Related to the core_mem_events check in print_system_summary(), when
show_pmus is false, should this condition also probe PMUs that have
pmu->mem_events !=3D NULL so that non-core memory profiling PMUs (such as
ibs_op and arm_spe_*) are probed for the default summary output?

[ ... ]

> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016213258.9457=
37-1-irogers@google.com?part=3D2

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEA43A9879
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 19:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792264444; cv=none; b=iUQU9wxxIjhjjwyFv1WSelgK1TOT6dG3+IUBgBeMG8A/6BQ3rNRZwlaQpdXwKhwBJsKyT4v5amlkDcHXnG5A59LG95LwrSgrNuo972Lep2VGkoiLO415KspGUQvqoSOpCSw44imKuGX/O9wHCLazd9Ch1TrMGzMjtyyw2ui2rfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792264444; c=relaxed/simple;
	bh=rFjH/htglmfJyi4AG8jWsWd4zaOOYaehSH8kcuDKgts=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=pFJqJ0U9m9+ty3il+ZiRClJ/2ga+iF2KwWrtPJDiTwYI2U5XifgTdjMbTZmInKaxWWRPN9xxIWuGOP9BX2UA2Y0DXhIBAGTkkrwtLwHqibD9Holg0acIn+UrHxaurAA7CuuiGHxJrMPM394jbWrKBfgbd85g5TfW6xCpS+TyLwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhQ7ViKv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhQ7ViKv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 042161F000C4;
	Sat, 17 Oct 2026 19:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792264443;
	bh=KTgQl24nryXAKGsdmkDZV3rBQqiyvARqvJkd56tlTpE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NhQ7ViKvlss8rumCYemcqNttxCuumqtNNoROIJMYaQ1vJzGbiEWiL0rG4lE45DDE5
	 ATpDIuvAyvZGZQPz3mkVNgq622LfIQwgKHF9TH5lZ9NCfFV1lWap3y+Sk1Zyqda4Y/
	 ASMBvq7eTU44U/pe5sLdpCpn+Bj5y8ABiwMU349K87GeABwHHSP5PxNDHGAixMXnCn
	 N+BFCI2VBEW42hrmJbTrPrggL9ukl2JCCljy3sXozdEWsMLOfMHXwz8BeaW76Mv7GE
	 BJjExRCnu5B+qMIE4eoH9YhHFQw+ZDZE8RNxYJzzRWyDBzS4xWLnYoYJIru5057NZj
	 sB4TaJ658brdg==
Message-ID: <sashiko-outbox-175772@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 7/9] perf sysinfo: Add sysinfo subcommand
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261017185442.2137623-8-irogers@google.com>
References: <20261016213258.945737-1-irogers@google.com>
 <20261017185442.2137623-1-irogers@google.com>
 <20261017185442.2137623-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 19:14:02 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf sysinfo: non-first numbered PMU instances skipped in cmd_sy=
sinfo() filter
- [Medium] perf sysinfo: unchecked open_supported in print_system_summary()
--

commit e12f0b6dfa1f94c66afcbf3ca5d231990fbac509
Author: Ian Rogers <irogers@google.com>

perf sysinfo: Add sysinfo subcommand

This commit adds the perf sysinfo subcommand to display and probe PMUs and
system performance monitoring capabilities on the running system or from a
perf.data file.

> diff --git a/tools/perf/builtin-sysinfo.c b/tools/perf/builtin-sysinfo.c
> new file mode 100644
> index 0000000000000..ea544b3d70a04
> --- /dev/null
> +++ b/tools/perf/builtin-sysinfo.c
> @@ -0,0 +1,2010 @@

[ ... ]

> +static void print_system_summary(FILE *fp, const struct perf_session *se=
ssion,
> +				 bool probed, bool leading_newline)
> +{

[ ... ]

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
> +			}

[ ... ]

> +		if (probed) {
> +			fprintf(fp, "    User-space counter reading (rdpmc): ");
> +			color_fprintf(fp, core_rdpmc ? PERF_COLOR_GREEN : PERF_COLOR_YELLOW,
> +				      "%s", core_rdpmc ? "supported" : "missing/disabled");
> +			fputc('\n', fp);
> +			if (!core_rdpmc)
> +				strlist__add(missing, "user-space counter reading (rdpmc)");
> +
> +			fprintf(fp, "    Leader sampling: ");
> +			color_fprintf(fp,
> +				      core_leader_sampling ? PERF_COLOR_GREEN : PERF_COLOR_RED,
> +				      "%s",
> +				      core_leader_sampling ? "supported" : "missing");
> +			fputc('\n', fp);
> +		}

[ ... ]

> +	color_fprintf(fp, PERF_COLOR_BOLD, "  System rating:");
> +	if (nr_core =3D=3D 0) {
> +		const char *min_desc =3D
> +			"no hardware core PMU; profiling limited to software timer events";
> +
> +		fprintf(fp, " ");
> +		color_fprintf(fp, PERF_COLOR_RED, "Minimal");
> +		fprintf(fp, " (%s)\n", min_desc);
> +	} else if (core_precise && core_branch_stack && (!probed || core_rdpmc)=
 &&
> +		   !strlist__empty(mem_bw_pmus) && max_drill_lvl >=3D 2) {

[Severity: Medium]
What happens in print_system_summary() when probing is enabled (probed =3D=
=3D
true), but perf_event_open() fails on the core PMUs (for example, when
kernel.perf_event_paranoid > 2 or in an unprivileged container)?

In perf_pmu__probe(), failure to open any candidate event sets
pmu->probed.open_supported =3D false and returns early without probing
can_user_rdpmc or can_leader_sampling.

In the PMU scan loop above, print_system_summary() checks
pmu->probed.open_supported and falls back to static sysfs properties for
core_can_sample, core_precise, core_branch_stack, and core_mem_events,
leaving core_rdpmc and core_leader_sampling false.

However, the summary output and rating checks here only test probed rather
than whether any core PMU had open_supported =3D=3D true. Should this track
whether core PMU probing actually succeeded so that rdpmc and leader
sampling are not reported as missing (and the system rating is not
downgraded) when perf_event_open() is unavailable?

[ ... ]

> +int cmd_sysinfo(int argc, const char **argv)
> +{

[ ... ]

> +	while ((pmu =3D show_all ? perf_pmus__scan(pmu) :
> +				 perf_pmus__scan_skip_duplicates(pmu)) !=3D NULL) {
> +		if (!pmu_matches_filters(pmu, argc, argv))
> +			continue;

[Severity: Medium]
When a user passes a filter argument matching a non-first numbered uncore
PMU instance (such as uncore_imc_1 or "*_1") without specifying -a/--all
or -v/--verbose, will cmd_sysinfo() fail to match it?

When show_all is false, perf_pmus__scan_skip_duplicates() visits only the
first instance (e.g., uncore_imc_0) and skips all subsequent instances
sharing the same base prefix before pmu_matches_filters() can inspect
their pmu->name:

tools/perf/builtin-sysinfo.c:pmu_matches_filters() {
	...
	for (int i =3D 0; i < argc; i++) {
		const char *pat =3D argv[i];

		if (perf_pmu__wildcard_match(pmu, pat))
			return true;
		if (pmu->name && (strglobmatch(pmu->name, pat) || !strcmp(pmu->name, pat)=
))
			return true;
	...
}

As a result, running perf sysinfo uncore_imc_0 matches and prints the
collapsed PMU group, whereas perf sysinfo uncore_imc_1 produces no output.

> +
> +		if (do_probe && !input_name &&
> +		    (show_pmus || pmu->is_core || pmu->mem_events ||
> +		     pmu->type =3D=3D PERF_TYPE_SOFTWARE))
> +			perf_pmu__probe(pmu);

[ ... ]

> +}

[ ... ]

=E5=AE=8C=E7=BE=8E=E7=BB=93=E6=9D=9F=EF=BC=8C=E7=A1=AE=E4=BF=9D=E6=9C=80=E5=
=90=8E=E6=9C=89=E4=B8=80=E4=B8=AA=E7=A9=BA=E8=A1=8C=E3=80=82]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017185442.2137=
623-1-irogers@google.com?part=3D7

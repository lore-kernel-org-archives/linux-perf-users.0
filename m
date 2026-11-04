Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793778630;
	b=404/1nw/Mvi23fUGNJ+8s6PHgJKaXH3lnu4EvIalPe8YfDMJdfXfvhptntEdFMvG4oMe
	 fy5SeUCYiuvQdJZed1mTNMvMV7bbHvNYulk6TQAGpyi7ap4tlNreeszSoVsWFyNcACXvv
	 1fHbLgbkSz9XF1ZD7e/8OBBZUqusX+W3vlO0beTRCAJhQizLo+1wlJp+cNXMnCxCfywR6
	 WQ26ohwDnJlbPgqENj4KEbJQXxwAUVOpx5jd2jpe8GYh/Uli8x8XGuPUhGtnIQmb/1PUh
	 7pO+i9ca7bfASJYKL9pOi3bYWB25ImuAagvh8tz1RqTEtWXFM9fkfNjhZUxtN6ymUfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793778630;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QWEXLw6X4dj8uDfDR2SBW+NakWNbhWvlR3hco7tvwB4=;
	b=Iz5LtQ7tcGEbdNQ79pClMU3/tChB2ERWUcQqdNCWC8fjOyhRcg1f+LSbID9XbESdDw7f
	 S5Cj8UZo/wUOSmQt6iloZ4hdF6YllyrL5imcWBKh/lfMFeU7B0v4z31dM+cL0SN6l5QPt
	 OmVS/Ogw5DbfLQRwlCCHn5Np2solgcuwTQUKUa0HNSPKizKYHmLCWqm9onUS9LeWzx5oJ
	 YyVgBCsU9qlqvv0jOY6WAMbGQZHbLtMOaPD3WLClP6a1jirMPdBmKGDDfnImkb1ODazTJ
	 NFwvM8iP3FHYfvUVsZBZwaKP6pFO/JyE4fpG72NosmsEixt+XtBFqljPiz1gaHTEX4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WYnbJrqs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C2F606A32D
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 07:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WYnbJrqs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F5C1F0093A;
	Wed,  4 Nov 2026 07:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793778629;
	bh=QWEXLw6X4dj8uDfDR2SBW+NakWNbhWvlR3hco7tvwB4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=WYnbJrqs9FbfJjuu1YOkJrAWXQoMgje1P2MOQpduHwKd/K1nvCHTCqpYNEkvs/Sjw
	 6JEOFHpgSKJkUb9fWalbWyfENiWf5Uwe146QsIo6isXwBPhn+67HNS7VxGGdlXLnSr
	 S2q9U9aPOOzli1kZhLXLz5Ig0apYez9lOyDokIBgHvf3gPX5W/bPyxICLraXN9O947
	 EG3KK9MvxllUJH7atb5dlaiG3ruaMCYRzMqpdGV3D0EeYyqMKkH9nm0SqjwnOWDSV0
	 wJ+JNh9WnBJ8Olj4vlR4AIsQk1+VOHbhztW5t/3FcwODCsBpg+WmMHcgCRtI8FV9Wm
	 MkUZxsZ1lPyuQ==
Message-ID: <sashiko-outbox-196830@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 39/41] perf sysinfo: Add sysinfo subcommand
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261103234502.1008382-40-irogers@google.com>
References: <20261103234502.1008382-1-irogers@google.com>
 <20261103234502.1008382-40-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 07:50:28 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf sysinfo: precise-only regs duplicated in print_pmu_json()
- [Medium] perf sysinfo: cmd_sysinfo() collapses heterogeneous core PMUs
--

commit 137020466c84fe37ed29fa37c240863bb116831f
Author: Ian Rogers <irogers@google.com>

perf sysinfo: Add sysinfo subcommand

This commit adds the perf sysinfo subcommand to display and probe PMU and
system performance monitoring capabilities on a running system or from a
perf.data file, supporting both text and JSON output modes.

> diff --git a/tools/perf/builtin-sysinfo.c b/tools/perf/builtin-sysinfo.c
> new file mode 100644
> index 0000000000000..afc4648098dd8
> --- /dev/null
> +++ b/tools/perf/builtin-sysinfo.c
> @@ -0,0 +1,2022 @@

[ ... ]

> +static bool evsel_matches_pmu(const struct evsel *evsel,
> +			      const struct perf_pmu *pmu, bool show_all)
> +{
> +	struct perf_pmu *ev_pmu =3D evsel__find_pmu(evsel);
> +	const char *ev_pmu_name;
> +
> +	if (ev_pmu =3D=3D pmu)
> +		return true;
> +
> +	if (ev_pmu) {
> +		if (!show_all && !pmu->is_core && pmu->name && ev_pmu->name) {
> +			size_t base_len =3D pmu_name_len_no_suffix(pmu->name);
> +
> +			if (pmu_name_len_no_suffix(ev_pmu->name) =3D=3D base_len &&
> +			    !strncmp(pmu->name, ev_pmu->name, base_len))
> +				return true;
> +		}
> +		return false;
> +	}

[ ... ]

> +static void print_pmu_json(FILE *fp, const struct perf_pmu *pmu,
> +			   const struct perf_session *session, bool show_all)
> +{

[ ... ]

> +			print_probed_regs(fp, &buf, "UserRegisters",
> +					  p->user_regs_mask, p->user_regs_abi,
> +					  p->user_simd_mask, p->user_pred_mask,
> +					  /*intr=3D*/false, /*json=3D*/true);
> +			print_probed_regs(fp, &buf, "IntrRegisters",
> +					  p->intr_regs_mask, p->intr_regs_abi,
> +					  p->intr_simd_mask, p->intr_pred_mask,
> +					  /*intr=3D*/true, /*json=3D*/true);
> +			print_probed_regs(fp, &buf, "IntrRegistersPreciseOnly",
> +					  p->intr_regs_precise_mask, p->intr_regs_abi,
> +					  p->intr_simd_precise_mask, p->intr_pred_precise_mask,
> +					  /*intr=3D*/true, /*json=3D*/true);

[Severity: Medium]
In probe_pmu_regs_one() in tools/perf/util/pmu.c, when an interrupt register
or SIMD/predicate register class can only be sampled with precise_ip > 0, i=
ts
bit is set in both intr_regs_mask (or intr_simd_mask / intr_pred_mask) and
intr_regs_precise_mask (or intr_simd_precise_mask / intr_pred_precise_mask).

In print_pmu_text(), the Intr registers output masks out the precise-only
subsets before printing Intr registers (precise sampling only):

	print_probed_regs(fp, NULL, "Intr registers",
			  p->intr_regs_mask & ~p->intr_regs_precise_mask,
			  p->intr_regs_abi,
			  p->intr_simd_mask & ~p->intr_simd_precise_mask,
			  p->intr_pred_mask & ~p->intr_pred_precise_mask,
			  /*intr=3D*/true, /*json=3D*/false);
	print_probed_regs(fp, NULL, "Intr registers (precise sampling only)",
			  p->intr_regs_precise_mask, p->intr_regs_abi,
			  p->intr_simd_precise_mask, p->intr_pred_precise_mask,
			  /*intr=3D*/true, /*json=3D*/false);

Should print_pmu_json() also mask out intr_regs_precise_mask,
intr_simd_precise_mask, and intr_pred_precise_mask when emitting
IntrRegisters, so that precise-only registers (such as x86 PEBS-only XMM
registers) are not duplicated in both IntrRegisters and
IntrRegistersPreciseOnly?

[ ... ]

> +static void add_pmu_display_name(struct strlist *list, const struct perf=
_pmu *pmu)
> +{
> +	size_t num_inst =3D perf_pmu__num_duplicates(pmu);
> +	char buf[128];
> +
> +	if (!pmu->name)
> +		return;
> +	if (num_inst > 1) {
> +		size_t base_len =3D pmu_name_len_no_suffix(pmu->name);
> +
> +		snprintf(buf, sizeof(buf), "%.*s", (int)base_len, pmu->name);
> +		strlist__add(list, buf);
> +	} else {
> +		strlist__add(list, pmu->name);
> +	}
> +}
> +
> +static void print_system_summary(FILE *fp, const struct perf_session *se=
ssion,
> +				 bool probed, bool leading_newline)
> +{

[ ... ]

> +	while ((pmu =3D perf_pmus__scan_skip_duplicates(pmus, pmu)) !=3D NULL) {
> +		size_t pmu_events, sysfs_ev, json_ev;
> +
> +		pmu_event_counts(pmu, &pmu_events, &sysfs_ev, &json_ev);

[ ... ]

> +int cmd_sysinfo(int argc, const char **argv)
> +{

[ ... ]

> +	while ((pmu =3D show_all ? perf_pmus__scan(pmus, pmu) :
> +				 perf_pmus__scan_skip_duplicates(pmus, pmu)) !=3D NULL) {
> +		if (!pmu_matches_filters(pmu, show_all, argc, argv))
> +			continue;

[Severity: Medium]
On heterogeneous or big.LITTLE systems where distinct core PMUs share a base
prefix before a decimal or 3+ hex-digit suffix (such as armv8_cortex_a53 and
armv8_cortex_a57/a72, or armv8_pmuv3_0 and armv8_pmuv3_1),
pmu_name_len_no_suffix() strips those suffixes and treats the core PMUs as
duplicates.

When running without -v or -a, won't perf_pmus__scan_skip_duplicates() in
cmd_sysinfo() and print_system_summary() skip all but the first core PMU,
while perf_pmu__num_duplicates() in print_pmu_text(), print_pmu_json(), and
add_pmu_display_name() strips the CPU suffix from the displayed core PMU na=
me
(reporting armv8_cortex or armv8_pmuv3) and counts the system as having only
a single core PMU in the summary?

In addition, because evsel_matches_pmu() guards its prefix match with
!pmu->is_core, recorded events belonging to the skipped core PMUs will not
match the first core PMU either and will be omitted from Recorded events.

Should core PMUs be excluded from duplicate skipping and suffix stripping
(similar to how pmu_deduped_name_len() in tools/perf/util/pmu.c handles
pmu->is_core)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103234502.1008=
382-1-irogers@google.com?part=3D39

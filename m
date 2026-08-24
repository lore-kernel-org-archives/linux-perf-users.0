Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD77E3E172D
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 06:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787554358; cv=none; b=syc9t3wGiW7o//qe3V6eaBsFW5VfInWdkYQxNqIqmdPNEW3iYU++guIaT+T1Cja57CmwF0/SYPIBfMS4Mq/Bh1ImL8Mmh7ptSyy/NiaA2H4A6zhK92AoD+b2/0b7nIVtUVIxANb7WBjHuKzCXIQaym+9zE0X4bGoMPFxaIT60JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787554358; c=relaxed/simple;
	bh=QQRN0RMP4Uk5Vuu/UCHVP8KdfVGe3GVzfMLblosyVJs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oa7PwItAM1tFb9ZFOrzZvC0JCfXmyJ2RTmiDzxbBpCUwzBvVmAr4vkmgoTTKKoMU3cYeG+nUOF62StN7jA8moV+mXpB8ox3Dgm93n/KOmiEHFOQkOzL8DAnXi05PQqQpzduNubq9NXyxJ3+dIwvd1m+iWb6mIRj81hU5cna0gi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVqnfWtT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVqnfWtT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4729C1F000E9;
	Mon, 24 Aug 2026 06:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787554356;
	bh=3MfvY+8l89Nnv8SDaI9pxV0H8oqsZMHICh9CiMolLpo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kVqnfWtTSjKdRQIJc5B4lTrm+jqZFP4oTYI7a3qMbNdgslvFgYowMZ9HuQAhiXbse
	 KYWP1PB2mENtC+0rBOzs16cEhlPu+E8KdtDBIwcXHkKbH6sceVKmTlWkbxDg30W5kv
	 1Nz0+Huj2TfG6pS/9gaflA/ZTOatm7x0vEnrC1af+9kObAqPe9MECIW0941CbwFap6
	 Obck3N6ZxoohlpqI3EB9MF/vN/zNYroAZkj1W8sZdOrgxRn/aKm4OTkXtNPK3L6dz5
	 oPCeIyXRhknrzIbIvFhC/qrWVplVbUBHHLGxGVEbfqzr/laNmnWoF93p32KrTYCpb+
	 mvp8/rDhJWcgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 4/7] perf tools: Expose opt-in --hybrid-merge
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260824063744.1533837-5-irogers@google.com>
References: <20260813132519.4099508-1-andi@firstfloor.org>
 <20260824063744.1533837-1-irogers@google.com>
 <20260824063744.1533837-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 06:52:35 +0000
Message-Id: <20260824065236.4729C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] `perf top --hybrid-merge` fails to enable events on non-leader h=
ybrid PMUs (e.g., e-cores) when a target is specified, resulting in zero sa=
mples from those PMUs.
- [Medium] The `--hybrid-merge` option relies on the host's sysfs to detect=
 hybrid PMUs, breaking cross-platform offline analysis in `perf report`.
--

--- Patch [4]: [PATCH v1 4/7] perf tools: Expose opt-in --hybrid-merge ---
commit 81cddf1e4d0d6711f1be8b496730e2ec2a6af8cd
Author: Ian Rogers <irogers@google.com>

perf tools: Expose opt-in --hybrid-merge
   =20
Add --hybrid-merge flag to explicitly trigger event merging non-interactive=
ly
for both perf-top and perf-report.

> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 60d1f166629e0..2fc81f4517e9d 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -1113,6 +1113,10 @@ static int __cmd_report(struct report *rep)
>  	evlist__for_each_entry(session->evlist, pos)
>  		rep->nr_entries +=3D evsel__hists(pos)->nr_entries;
> =20
> +	if (symbol_conf.hybrid_merge && evlist__can_merge_hybrid(session->evlis=
t)) {

[Severity: Medium]
Will this break cross-platform offline analysis for perf report?

When a user runs perf report --hybrid-merge on a non-hybrid host to analyze
data recorded on a hybrid host, evlist__can_merge_hybrid() calls
perf_pmus__num_core_pmus(). That function scans the host machine's sysfs
instead of the perf.data topology:

tools/perf/util/pmus.c:perf_pmus__num_core_pmus() {
    ...
    while ((pmu =3D perf_pmus__scan_core(pmu)) !=3D NULL)
        count++;
    ...
}

Because this relies on host sysfs rather than dynamically inspecting the
perf_env from the session, it seems it will return 1 on non-hybrid hosts,
causing the merge to be skipped entirely.

> +		evlist__merge_hybrid(session->evlist, false);
> +	}
> +
>  	if (use_browser =3D=3D 0) {
>  		if (verbose > 3)
>  			perf_session__fprintf(session, stdout);

[ ... ]

> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index 570410599f1b3..cf7ac2712696e 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1321,6 +1321,9 @@ static int __cmd_top(struct perf_top *top)
>  	if (ret)
>  		return ret;
> =20
> +	if (symbol_conf.hybrid_merge && evlist__can_merge_hybrid(top->evlist))
> +		evlist__merge_hybrid(top->evlist, false);
> +

[Severity: Medium]
Does merging events here cause e-core events to remain disabled when a targ=
et
is specified?

If a target is specified (like -p <pid>), events are initially opened in a
disabled state. When evlist__merge_hybrid() logically reparents e-core even=
ts
to the p-core event leader in user-space, they lose their leader status.

Later in __cmd_top(), evlist__enable() is called, which relies on
__evlist__enable():

tools/perf/util/evlist.c:__evlist__enable() {
    ...
    if (!evsel__is_group_leader(pos) || !pos->core.fd)
        continue;
    ...
}

Since the e-core event is no longer a group leader in user-space, it gets
skipped. Because PMU events cannot cross PMU boundaries in the same hardware
group, the p-core's enable ioctl won't enable the e-core event, meaning we
could drop all samples from the e-cores.

>  	top->session->evlist =3D top->evlist;
>  	perf_session__set_id_hdr_size(top->session);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824063744.1533=
837-1-irogers@google.com?part=3D4

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81C51A3166
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 02:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776046029; cv=none; b=QFGAvkEdtOgzNQ16Rxn8xXV24kOa0jJG+oawh6Q8DvdDnP6rX9rlDR1D5HL9P0U7OvzCwCXOtwbZ9eImL2bBato/iHEgL1CkNAiNfqOSVG4pkHsaySOSvF1wvjWW4Ykvo6KIilHIBhKPfduHrINi/pf6AmRgT9dWsSpYwB/9fUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776046029; c=relaxed/simple;
	bh=kmtztinpVMS8RhffFBS7rcEvXNuZhTgYBuRbUpTynhA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=obsMcJvShn+WZWmMbvjiGLT3L3LM64Cl5SEBGPwUKphvKg5m4UhuLLAjdl65O16BBNjL4ZcmQp99G3bGd8FUjmhemXgY2U4h5LQSMCzg+P+0O3+4bWvEV6K+3yH8oAWdUGhdP0/La8JJdR7Lq4MyYuH9hA9BYFrXLqEaWkdYEXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nlq1GuIL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nlq1GuIL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4511FC19424;
	Mon, 13 Apr 2026 02:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776046029;
	bh=kmtztinpVMS8RhffFBS7rcEvXNuZhTgYBuRbUpTynhA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Nlq1GuIL3P18YZ5c9GTZw/t5tBaTHs7LDPkPEDTel2M80DOHxjFnIjMzROX1Udbi4
	 U4eBXbdSLT83+EPESf/N24Ntia0IJmgM8DusocFttwS61/4itatnU/5NZZwzZ9o2Id
	 vudvcubcvJ8ubmjAdtUqWZDmdexebOWhxpxhpPpmkY+GZwGGIF881eI4jIBTYKhXCF
	 wxp/0m6+ix1P/AzMDZ3B0tDnaz8ouP7NBnd+kwwlDIB9J/hav0ZvKy1hupLuOqLufl
	 YTZCaCyCmsphZWjCbQ5B6rmm7Jwvg0kEVKrFA4H02odp8HfODID2AGM8he+bYIzq0m
	 U/jmVl5hxC0Fg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 30/33] perf timechart: Bounds check CPU
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260413012227.1089445-31-irogers@google.com>
References: <20260413012227.1089445-31-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Apr 2026 02:07:08 +0000
Message-Id: <20260413020709.4511FC19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Returning `-1` on out-of-bounds CPU IDs causes the entire perf ses=
sion processing to abort silently.
- [High] Out-of-bounds read on the `topology_map` array when offline CPUs a=
re present.
--

commit 2d402e787962a036968ba2be4ac85bf8a877dbe3
Author: Ian Rogers <irogers@google.com>

perf timechart: Bounds check CPU

This commit adds bounds checking for CPU IDs across multiple sample
processing callbacks in perf timechart to prevent out-of-bounds memory
accesses when updating CPU state arrays.

> diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechar=
t.c
> index 64f69bd67c6b7..64903b54e8a73 100644
> --- a/tools/perf/builtin-timechart.c
> +++ b/tools/perf/builtin-timechart.c

[ ... ]

> @@ -607,6 +607,10 @@ process_sample_cpu_idle(struct timechart *tchart __m=
aybe_unused,
>  	u32 state  =3D perf_sample__intval(sample, "state");
>  	u32 cpu_id =3D perf_sample__intval(sample, "cpu_id");
> =20
> +	if (cpu_id >=3D MAX_CPUS) {
> +		pr_debug("Out-of-bounds cpu_id %u\n", cpu_id);
> +		return -1;

Does returning -1 here cause the entire perf session processing to abort?=20

In the perf tool subsystem, returning a negative error code from a trace
handler propagates up to perf_session__process_events(), which aborts
parsing the rest of the trace file.

Should this log a warning and return 0 instead to skip the invalid sample,
so that a single corrupted sample or an unsupported high CPU ID does not
prevent the generation of SVG output for the valid samples?=20

Additionally, using pr_debug() hides the out-of-bounds notification from
the user unless verbose mode is enabled.

[ ... ]

> @@ -1517,6 +1544,8 @@ static int process_header(struct perf_file_section =
*section __maybe_unused,
>  	switch (feat) {
>  	case HEADER_NRCPUS:
>  		tchart->numcpus =3D ph->env.nr_cpus_avail;
> +		if (tchart->numcpus > MAX_CPUS)
> +			tchart->numcpus =3D MAX_CPUS;
>  		break;
> =20
>  	case HEADER_CPU_TOPOLOGY:

Does capping tchart->numcpus here fully prevent out-of-bounds reads when
offline CPUs are present?

While this bounds tchart->numcpus to MAX_CPUS, tchart->numcpus is
initialized to ph->env.nr_cpus_avail. The topology_map is allocated in
svg_build_topology_map() based on env->nr_cpus_online. On systems with
offline CPUs, nr_cpus_avail is strictly greater than nr_cpus_online.

Will iterating up to tchart->numcpus during rendering result in cpu2y()
accessing the topology_map[] array out of bounds?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260413012227.1089=
445-1-irogers@google.com?part=3D30

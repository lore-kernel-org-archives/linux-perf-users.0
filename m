Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793770750;
	b=J1+Cqtj2mn0PdGskb252S2J1JpeSwgzd42vGV7iUH9IpakzkUQLbR+Of5//OYc4JVgGq
	 S6FVQmEfKWuyOsrAg6fgAuFI+MXOSYkZpp6Cd/MMzpdd2/kDW5Ug1Qdwxtsrxw2gyBvQI
	 SCz0Led+X5igbSxrpvv9zCpz8+uhCBlR3SdZvvXwVtAmZ3zifaj3m31l++o9tMIro8YC1
	 8Xh0IiDR6C2EvSIOOthoM+vu6n1o+ycR8stU2ec9bkqyhKmBrizXyuP1BHk6INDd9A9Ku
	 /BYfs0UzoJ5Q7pl6qB6VP/boC6IOzdkbbFSQtmTARbCZF46nYvAN051r3c5hC7rSLaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793770750;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mYlgO0UH5l8CTCHqhigTjlr+Kjgw+6etWKXSuirKey4=;
	b=EQ9YCV8J8zjel3RZwDB50+gQ1rJT8mhsmHwgdxdi68CK0mrgVGM20NHeXadagFY1xefV
	 FiX3CKtEj0+1fsjjKCPE+b1tw8+qkR0u+y9VrZob/MDZsvYCKuGWAgjI/+xusPjBzoyLm
	 6O1fprDrBdgg/mhikA2+MAip0KwUsoukwUSWyJ1h8XwbCDKxWwN7USXbBKiRS2x+QZkGj
	 +9CeqPQEfX98LU47c8945uqcN1BPmO2ynMDbPsQbAgVMMUWQ2iERdfdzS8RCwIUAs3bcy
	 swztC1/Q3UvSbGWXZDRZn2wNEdnEqBIwXZU1PIuZuiBMMx2fML0LL2EUxf+Q7+DMtUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="gI7R3/Ic";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E26606A31B
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 05:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gI7R3/Ic
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0229B1F000C1;
	Wed,  4 Nov 2026 05:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793770750;
	bh=mYlgO0UH5l8CTCHqhigTjlr+Kjgw+6etWKXSuirKey4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=gI7R3/IcpNbxgaKRpFFX7EqN0rMIzgt2Hv4TwR2trSXFUuWTQYTk+XaBzX9KxFCgH
	 7A9ok2Y3EEiD5frU+w6lH/5APxTvGEf3yIUZFOj4dVt4gngnuapSyCSpcugjkHF9SZ
	 I2D4lXRez6bsy7PxWJv2erf68U2h7mWN4sd6QNt5Cp6ZGAx9a1/oRz93ff/NAVTPmX
	 ogQ+mhTaK6NI1VIgMnXqnPwF+t72lWU/Qb3eHLmaIdHD2LAQnjzPFH8/BHR2AFwUgO
	 jP+lWguYZCUPWuHJUprvDREZIeZ3JweoYCgqufS6NvWgFKFyn9E34YxZ5u/YNNwjEE
	 0V2ThGaJLtEiQ==
Message-ID: <sashiko-outbox-196677@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 28/41] perf pmu: Add perf_pmu__probe() for basic
 open, counting, and sampling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261103234502.1008382-29-irogers@google.com>
References: <20261103234502.1008382-1-irogers@google.com>
 <20261103234502.1008382-29-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 05:39:09 +0000
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
- [Medium] perf pmu: collect_probe_candidate_cb() stops on unopenable ftrac=
e event
- [Medium] perf pmu: raw attr fallback in __perf_pmu__probe() clobbers open=
_err
--

commit 006ae863dd0267ee072ef7ac0650c59a05a689b6
Author: Ian Rogers <irogers@google.com>

perf pmu: Add perf_pmu__probe() for basic open, counting, and sampling

This commit adds struct perf_pmu::probed and perf_pmu__probe() to actively
probe a live PMU via perf_event_open() on a worker thread pinned to an
online CPU associated with the PMU. It selects a representative probe event
across PMU types and records whether opening, counting, and sampling are
supported.

> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index fecfe791bf8ae..9033bada9f472 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c

[ ... ]

> +static int collect_probe_candidate_cb(void *vstate, struct pmu_event_inf=
o *info)
> +{
> +	struct probe_candidates *cands =3D vstate;
> +	char buf[512];
> +
> +	if (info->deprecated)
> +		return 0;
> +	if (info->str && strstr(info->str, "=3D?"))
> +		return 0;
> +	if (!info->name)
> +		return 0;
> +
> +	if (info->pmu && info->pmu->type =3D=3D PERF_TYPE_TRACEPOINT) {
> +		probe_candidates__add(cands, info->name);
> +		return 1;
> +	} else if (strchr(info->name, '/')) {

[Severity: Medium]
When __perf_pmu__probe() cannot open any of the three hardcoded tracepoints
in fast_tps and falls back to perf_pmu__for_each_event(),
collect_probe_candidate_cb() adds only the very first enumerated tracepoint
and returns 1 to stop iteration.

Because the kernel registers __start_ftrace_events first in tracefs and
tp_pmu__for_each_tp_sys() reads /sys/kernel/tracing/events in directory
order, the first enumerated event is typically an internal ftrace:* event
(such as ftrace:bprint or ftrace:print) whose tp_event->class->reg is NULL,
which perf_trace_init() rejects with -EINVAL.

Should collect_probe_candidate_cb() skip internal ftrace:* events or collect
up to MAX_PROBE_CANDIDATES tracepoints before stopping, so the fallback does
not fail with EINVAL on the first ftrace event?

[ ... ]

> +static void __perf_pmu__probe(struct perf_pmu *pmu, int pmu_cpu)
> +{
> +	struct probe_candidates cands =3D { .nr =3D 0 };
> +	struct perf_event_attr base_attr;
> +	char uprobe_exe_path[PATH_MAX];
> +	__u64 uprobe_offset =3D 0;
> +	unsigned long flags =3D perf_event_open_cloexec_flag();
> +	int keepalive_fd =3D -1;
> +	pid_t pid =3D 0;
> +	int cpu =3D 0;
> +	int last_err =3D 0;
> +	bool found =3D false;
> +
> +	if (pmu->type =3D=3D PERF_TYPE_TRACEPOINT) {
> +		static const struct {
> +			const char *sys;
> +			const char *name;
> +		} fast_tps[] =3D {
> +			{ "sched", "sched_switch" },
> +			{ "raw_syscalls", "sys_enter" },
> +			{ "irq", "irq_handler_entry" },
> +		};
> +
> +		for (size_t i =3D 0; i < ARRAY_SIZE(fast_tps); i++) {
> +			int tp_id =3D tp_pmu__id(fast_tps[i].sys, fast_tps[i].name);
> +
> +			if (tp_id >=3D 0) {

[ ... ]

> +	if (!found && cands.nr =3D=3D 0) {
> +		memset(&base_attr, 0, sizeof(base_attr));
> +		base_attr.type =3D pmu->type;
> +		base_attr.size =3D sizeof(base_attr);
> +		if (pmu->perf_event_attr_init_default)
> +			pmu->perf_event_attr_init_default(pmu, &base_attr);
> +		if (try_open_attr_variants(&base_attr, pmu->is_uncore, pmu_cpu,
> +					   flags, &pid, &cpu, &last_err)) {
> +			char buf[256];
> +
> +			snprintf(buf, sizeof(buf), "%s//", pmu->name);
> +			pmu->probed.probe_event =3D strdup(buf);
> +			found =3D true;
> +		}
> +	}

[Severity: Medium]
When probing a tracepoint, kprobe, uprobe, or breakpoint PMU fails in
__perf_pmu__probe(), does falling through into this cands.nr =3D=3D 0 block
clobber pmu->probed.open_err with EINVAL?

The kprobe, uprobe, and PERF_TYPE_BREAKPOINT branches probe their targets
directly without populating cands, and the PERF_TYPE_TRACEPOINT branch
ignores negative error returns (such as -EACCES when tracefs is mode 0700)
from tp_pmu__id() and perf_pmu__for_each_event(), leaving cands.nr =3D=3D 0=
 and
last_err =3D=3D 0.

Because none of those PMUs defines perf_event_attr_init_default, the
cands.nr =3D=3D 0 fallback calls try_open_attr_variants() with a zeroed
base_attr (config =3D=3D 0, kprobe_func =3D=3D NULL, uprobe_path =3D=3D NUL=
L, or
bp_type =3D=3D HW_BREAKPOINT_EMPTY). The kernel rejects all 16 attempts with
-EINVAL, and try_open_attr_variants() overwrites *last_err whenever it is 0
or ENOENT, replacing the original failure reason with EINVAL.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103234502.1008=
382-1-irogers@google.com?part=3D28

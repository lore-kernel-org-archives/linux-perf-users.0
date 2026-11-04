Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793771993;
	b=VVHELY3ixSXjQzFbWOazPlhZVq9neSJ5azGbW/mXmT8AAcUGSwz1DWcaGNdRakGBRYfZ
	 jI3y6lid8vt9eJIGScTUMyLRvirPRUE6VRFJc2V2aRxE4ncKVBU9jdbx/799rQy4iHV42
	 62RpUJ/BnlnnxsX6RN9r29z1WLhRe2bWeKJ4qEqc5nPWZN160dbFMd4HyzJNnSVvq6x0S
	 kN1bwRPJoLqhHSBION6lxdUfLtOMxFHcL8fH8D6smyInfq/yQ4bGQzhf8bn/jcTlm1Ydl
	 pPtKz778DTko7smGl00G7xAHuNZMfm7DVdNZQ9xWf0DZdzVi6pefFa8Qlx8Bo7us9Gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793771993;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ivDGp+ImQuDMPMUZUnsoVb1K0Lu28olpZx3nir5yoQ4=;
	b=GdWkWWunO6XAjPTlzEq4HsFyY9AxDu8yG0z6BoL9SNCfJ6zjcUSzXPkEo0UJuHAxskaO
	 Gr66Z8v5wyZT6YEPFDqZWRVQOANXJjywEA4LMSwfN/1/hNLgr1y9Lkn3awBlQ3TyLZg0U
	 q0CNmq/wJNv6GaKNAzOzuBLNYbATreJKNkYDEMmIHF5RDuuziogVDxSgPFEMQ6UwVMdA3
	 /YZVTy4PBDJH5Qyk5Pii29NxE2OxoGdUslKpF8y4lL/WT8LxuBmOt4aIWUGEi8c9ZWJz4
	 wI2qf6Y/PscB2Z2uj3dlrWg/TVOOBtsquIgP981gNUOs44Zumxwxut2pT2lCA2fmKZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="LR/WdHak";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F929606A32C
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 05:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LR/WdHak
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622501F000C1;
	Wed,  4 Nov 2026 05:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793771992;
	bh=ivDGp+ImQuDMPMUZUnsoVb1K0Lu28olpZx3nir5yoQ4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=LR/WdHakiBcN2lVTn6j0zUKSo6Yta+86ypKO0/INfaqpgW1rj23Rduu6a0Q143WBF
	 KkKxuBDKG+/wg5kAWsD3sO5jqACUrKGurvcOwybw7TSEG7/j2aDmdyhaZM0oU6i7K5
	 0IoXJ5NUi82tzoFKZ3tj2dK+3SGt1F9219TqxMERyAQFGyRo8ee1ZXurchf6P082fH
	 hKguLjBSQxIGkrng+we2ENqceILyWKIYTjR+k2QpAmeJ36J6UXZSl4uDJuWKnOUBsH
	 mzP+AEgwXsqMpsQDk9n3hGoT/sObWXvTVDZBctEw/tGN+vOHNom7+lMsIYEXeOsFQD
	 M9aKgsA+B3E5w==
Message-ID: <sashiko-outbox-196711@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 30/41] perf pmu: Probe precise_ip levels
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261103234502.1008382-31-irogers@google.com>
References: <20261103234502.1008382-1-irogers@google.com>
 <20261103234502.1008382-31-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 05:59:49 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf pmu: false precise_ip levels for sampling-only PMUs in __pe=
rf_pmu__probe()
--

commit d1ce0d9ed1dbce5cef4c6ec1524e970638e08a49
Author: Ian Rogers <irogers@google.com>

perf pmu: Probe precise_ip levels

This commit extends perf_pmu__probe() to probe supported precise_ip
levels (1..3) and populate probed.precise_mask and probed.max_precise.
To avoid misreporting non-precise PMUs that silently ignore precise_ip,
it checks whether precise_ip =3D 1 succeeds on a counting event when
pmu->probed.can_count is true.

> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 164ed926184e2..1c55265be2469 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -3453,6 +3453,56 @@ static void __perf_pmu__probe(struct perf_pmu *pmu=
, int pmu_cpu)
>  	if (pmu->probed.can_sample)
>  		probe_sample_types(pmu, &base_attr, pid, cpu, flags);
> =20
> +	/*
> +	 * 3. Precise sampling support (:p, :pp, :ppp).
> +	 * PMUs that do not validate attr.precise_ip (such as software,
> +	 * breakpoint, or intel_pt) silently accept precise_ip > 0 even when
> +	 * sample_period =3D=3D 0. A PMU that genuinely implements precise_ip
> +	 * either rejects precise_ip > 0 on non-sampling events or is a
> +	 * sampling-only PMU (such as AMD ibs_op).
> +	 * Note: On AMD, core events like cycles:P are forwarded to IBS and
> +	 * support higher precision than advertised in sysfs caps/max_precise.
> +	 */
> +	if (pmu->probed.can_sample && !pmu->auxtrace) {
> +		bool ignores_precise_ip =3D false;
> +
> +		if (pmu->probed.can_count) {
> +			struct perf_event_attr c_attr =3D base_attr;
> +			int fd;
> +
> +			c_attr.sample_period =3D 0;
> +			c_attr.freq =3D 0;
> +			c_attr.sample_type =3D 0;
> +			c_attr.precise_ip =3D 1;
> +			fd =3D sys_perf_event_open(&c_attr, pid, cpu, -1, flags);
> +			if (fd >=3D 0) {
> +				close(fd);
> +				ignores_precise_ip =3D true;
> +			}
> +		}

[Severity: Medium]
Can guarding the ignores_precise_ip check with pmu->probed.can_count
cause __perf_pmu__probe() to misreport probed.max_precise =3D 3 and
probed.precise_mask =3D 0xe on sampling-only PMUs?

For AMD IBS, the kernel only checks event->attr.precise_ip when forwarding
a core PMU event via amd_pmu_hw_config() -> forward_event_to_ibs():

arch/x86/events/amd/ibs.c:forward_event_to_ibs() {
	if (!event->attr.precise_ip || event->attr.precise_ip > 2)
		return -EOPNOTSUPP;
	...
}

When ibs_op or ibs_fetch is opened directly via its own PMU type, the
event_init callback is perf_ibs_init(), which rejects sample_period =3D=3D 0
(so pmu->probed.can_count is false) and never checks event->attr.precise_ip.
As a result, probing ibs_op and ibs_fetch directly succeeds for levels 1, 2,
and 3 even though IBS only supports levels 1 and 2 (and core forwarding only
targets ibs_op).

Similarly, non-auxtrace sampling-only PMUs on other architectures reject
counting events while ignoring attr.precise_ip on sampling events, such as
PowerPC vpa_dtl and trace_imc:

arch/powerpc/perf/vpa-dtl.c:vpa_dtl_event_init() {
	/* Return if this is a counting event */
	if (!is_sampling_event(event))
		return -EOPNOTSUPP;
	...
}

arch/powerpc/perf/imc-pmu.c:trace_imc_event_init() {
	/* Return if this is a couting event */
	if (event->attr.sample_period =3D=3D 0)
		return -ENOENT;
	...
}

as well as s390 cpum_sf in __hw_perf_event_init() -> hw_perf_event_reset().
Because pmu->probed.can_count is false for these PMUs, ignores_precise_ip
remains false and all three precise_ip levels will be reported as supported.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103234502.1008=
382-1-irogers@google.com?part=3D30

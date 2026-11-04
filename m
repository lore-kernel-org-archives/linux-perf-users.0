Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793757951;
	b=u+atrGIBJNR9kCI3ik221xQpY5ukbWG6DtFTc8MnUfcMiyKQjC6xRarGSmqUqzfzzYIz
	 ni8gvgjAtfXFHrV15F6URwoFX4OUXZgHVgE7AiAM/nDidwJtQ5rWGFKtBcvgnr2RaPEZC
	 Nx/Y7qh8aGEugiKGVYWJwvwLxQeTRaYDp6NvlgunYYC2qfX70mVJmucOl6Awe4sreJzHK
	 kawebJ+nERX+mqK+lxi4Rb0XVstB5dU4PUKEZQxV5biOiqQYd4OiA7jbN/IOEbTFYMrj7
	 fvnMxoTfQyad8GUYwvsJ6iV0oG9tvGAbAJIaf9MvlnmOdjAZH8+QRkV1y8OVA+8HzoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793757951;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TopVRmD/ADtpyUDzbxdrUvTh1b1cafKOnv3FJy9nVaw=;
	b=PwqxqvNPlPljSmYzaZhocD9JFMQ5UGaDDPwDvIiI9Sm3D5eQb9lUd/ADZOQKMmLmExTr
	 N2a6R56YWWtNZ1PMp2JBxc6W6lVA1W/zp4v5/HEm5hUpTGoHDMf/qVyHE49oeLvj1ibSp
	 ea41PQAXLhFIA4wqyOc94oOFdW80kY7Wpvihf739tlON0vCy3OE63UM7Ee1aRdfW22QKz
	 aZxDa45GCvEJ7gzqluVFS3zz2M7AmM6xHBv74OxiTowaDzl6ft4D/CXnckmKDScudOG5P
	 eSJZOHt+tqKErTmoWIK6rDE3Af18oKNpUqHpgHfpyVy5CYcR9+J3hfQPoQ5TlaOikmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jgAa0lC9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025F7606A31B
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 02:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jgAa0lC9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B20D1F000C1;
	Wed,  4 Nov 2026 02:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793757950;
	bh=TopVRmD/ADtpyUDzbxdrUvTh1b1cafKOnv3FJy9nVaw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=jgAa0lC9GBIbQjbva8dw6u3tswS71Eh/WWLbr7Xnprorw9aCt/vWmycpZ8DEsar2l
	 IIiixwarnJR0bDf3B87nXemKZ4jQdqZYe9zEWDLgaq72V2M7ygECjp99YxrSoqIW2l
	 SsGjerE4MAj67CpzPM0ZKTswVrUFs9efEtP73bvUJK7owEDCIvcQnGqQqd8ksCiRjN
	 U3hCrtxoPawKJ+gLsriH0QCCPpavQ7TV/8lWR1/oUIdnJsedgpuvzBG6mSivU6gChm
	 ivV7HoKO41zvqrOJg37WIQ7oErNbTa6euoOE3ezm7HdGlbTfzssTgM2RqMGrTo+tJg
	 e/mP/rxva01MA==
Message-ID: <sashiko-outbox-196422@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 13/41] perf pmus: Add perf_pmus__read_from_env()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261103234502.1008382-14-irogers@google.com>
References: <20261103234502.1008382-1-irogers@google.com>
 <20261103234502.1008382-14-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 02:05:49 +0000
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
- [Medium] perf header: missing HEADER_E_MACHINE pmus reset in perf_event__=
process_feature()
--

commit 523e239f6cc1817fa333720299701f5ca84f8562
Author: Ian Rogers <irogers@google.com>

perf pmus: Add perf_pmus__read_from_env()

This commit adds perf_pmus__read_from_env() and perf_pmu__add_cap() to
reconstruct PMU lists and capabilities from perf.data header metadata and
lazily populate env->pmus in perf_env__pmus().

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index a442f2a904a9d..27fc21fa3a6a7 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -5765,6 +5765,28 @@ int perf_event__process_feature(const struct perf_=
tool *tool __maybe_unused,
>  		goto out;
>  	}
> =20
> +	switch (feat) {
> +	case HEADER_ARCH:
> +	case HEADER_CPUID:
> +	case HEADER_NRCPUS:
> +	case HEADER_PMU_MAPPINGS:
> +	case HEADER_CPU_PMU_CAPS:
> +	case HEADER_HYBRID_TOPOLOGY:
> +	case HEADER_PMU_CAPS:
> +		mutex_lock(&header->env.pmus.lock);
> +		if (session->evlist) {
> +			struct evsel *evsel;
> +
> +			evlist__for_each_entry(session->evlist, evsel)
> +				evsel->pmu =3D NULL;
> +		}
> +		perf_pmus__exit(&header->env.pmus);
> +		mutex_unlock(&header->env.pmus.lock);
> +		break;

[Severity: Medium]
Should HEADER_E_MACHINE also be included in this switch statement in
perf_event__process_feature()?

In tools/perf/util/pmus.c, perf_pmus__read_from_env() relies on
perf_env__e_machine(env, NULL) directly to look up core_table:

	if (env->cpuid)
		core_table =3D find_core_events_table(perf_env__e_machine(env, /*e_flags=
=3D*/NULL),
						    env->cpuid);

and indirectly via perf_env__arch(env) in env_is_pmu_core().

Since HEADER_E_MACHINE comes after all the PMU feature records in the
feature enum and sets env->e_machine in process_e_machine() (overriding
the env->arch or host uts_machine() fallback in perf_env__e_machine()),
if perf_env__pmus(&header->env) is evaluated in pipe mode before
HEADER_E_MACHINE arrives, won't header->env.pmus and cached evsel->pmu
pointers remain stale once HEADER_E_MACHINE is processed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103234502.1008=
382-1-irogers@google.com?part=3D13

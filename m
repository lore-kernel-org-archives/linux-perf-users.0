Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6800D3242BA
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 22:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786659097; cv=none; b=WNYU0PvEhhiDyCf2ra2ggodGqcjkcaAo+u0e2rYfseOp6cBuoN6REgGZua0Dv//3EjuIizSdCHHinYgOwUdA3lOh0mC9gySyR15V0DH4FNu8e9sOdm3NyP8byo/eNgpM3CgZEVx+kV+9gnwaxFa583nT3FIhdqmfdD421pIjml4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786659097; c=relaxed/simple;
	bh=L5fn9mgIDCiS/4uTW9z3HUMrsemnk88DRxGNUAoOvDY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FlK/2B35o4EIA4hc4CSe2+ms4XRG4mm3Li+LHy36AaDk7wAUFoeSsion3ZxL7F8SqOVCtQ2r8EX317DAyLwYluOfIclY5Pm7rKOpV0ptzWO635BICTOdJTrxM0zoHdoxkomroAkBuAr8J4Z/mCk/cPn91mPyh7GVsOQvs44bJkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbBrgZ2M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbBrgZ2M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F381F000E9;
	Thu, 13 Aug 2026 22:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786659096;
	bh=dZCYH/UJCMvkvT4ZyzQTE0fDyelvpn02psh1BM7o6Oc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nbBrgZ2MDt3uF8lBzqU1MxQhemvZhQQ45FToUs7e7/b6lNJ470kleiq2r6Kghnyut
	 gQrmuXcDz1uuP+WKpVriluy9yhPOTplvk+kxBbU2wXwLZd+ZlnfnV5C/+vKjtaECGv
	 tsJiRGchEhIaiItuNPcc1Boeh9f7AUUHMwYJzuPf+M+YJDkmR7TgM8J0wkULieTOl/
	 nWPrYfXyVZJsefKvM+tiVy4ozJS1G0XqZSXDCAxjDjCUnuPbAmUnR6Qd+XiZUShSfN
	 K8pO+SJ03c5nA5cSIwAB7CqkWpdAUyUothZZ3tMo1M8z1diiuzx1v4RN5rV9EzQi77
	 5GqDz7YMDa9kw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/25] perf sample: Add evsel to struct perf_sample
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260319232334.287517-4-irogers@google.com>
References: <20260319232334.287517-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 22:11:35 +0000
Message-Id: <20260813221135.E4F381F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Uninitialized memory usage for `sample.evsel` in `powerpc_vpadtl_s=
ample` leads to a fatal assertion or crash during trace delivery.
--

--- Patch [3]: [PATCH v2 03/25] perf sample: Add evsel to struct perf_sampl=
e ---
commit b98d97d18e2ec81b0bc54af759fddbd9c49c126f
Author: Ian Rogers <irogers@google.com>

perf sample: Add evsel to struct perf_sample

This commit adds evsel to struct perf_sample so that the sample can
carry its associated evsel. This avoids the need to pass evsel and
perf_sample as a pair through various functions.

> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index c48e840da7d48..3794d3a04afb3 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
[ ... ]
> @@ -1451,8 +1456,12 @@ static int machines__deliver_event(struct machines=
 *machines,
> =20
>  	dump_event(evlist, event, file_offset, sample, file_path);
> =20
> -	evsel =3D evlist__id2evsel(evlist, sample->id);
> +	if (!sample->evsel)
> +		sample->evsel =3D evlist__id2evsel(evlist, sample->id);
> +	else
> +		assert(sample->evsel =3D=3D evlist__id2evsel(evlist, sample->id));

[Severity: High]
Could this assert trigger a crash due to an uninitialized evsel field?

Looking at powerpc_vpadtl_sample() in tools/perf/util/powerpc-vpadtl.c, it
allocates struct perf_sample on the stack without zero-initializing it:

	struct perf_sample sample;
	union perf_event event;

	sample.ip =3D be64_to_cpu(record->srr0);
	sample.period =3D 1;
	sample.cpu =3D cpu;
	sample.id =3D vpa->sample_id;

Since it doesn't call perf_sample__init() or memset() on the sample, the
newly added evsel field will contain stack garbage.

When this sample is delivered via perf_session__deliver_synth_event(), it
eventually reaches machines__deliver_event(). Because the uninitialized
sample->evsel pointer is likely non-NULL, won't it take the else branch, fa=
il
the assertion, and crash the perf tool?

> +	evsel =3D sample->evsel;
>  	machine =3D machines__find_for_cpumode(machines, event, sample);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260319232334.2875=
17-1-irogers@google.com?part=3D3

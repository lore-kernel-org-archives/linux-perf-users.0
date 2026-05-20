Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A871A8F7B
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 20:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779307599; cv=none; b=MQFrxLbX0xhurVFE5x7fOPPceTZwSL6I+h8zef0+IchlE0C9jqxNFFofZJ2hkUOWt/z76D9/c2MWKYQmqQUEFxBfvoyTEhCI43alAkb/4h0idtyW6GokQK4IrqrQCbh6sCnWPLe6u4c3x4qvhujHbLXPjXRXbacw3Pi870dwFkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779307599; c=relaxed/simple;
	bh=GjC9Ixel4s8exsCw3D7fFM97xXqDU0CMjpxklFgq2U8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NeMd3kZXQaTZkX7uadkUbPg6o9nWpZzyehBs1Guj0hJvU4YOVRe2tzv5Pf4RNDiYcimFq3lxANj+Ljkk9YqM3pbohTxwBkfaEh/XWYN//PlCgU5nmX8XifGhMbUtyZKKUWnJU7M7jwatNZBRFmPaMwH7GUbCwJSQM/n2nMp0DvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5ZOqr3U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5ZOqr3U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF021F000E9;
	Wed, 20 May 2026 20:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779307598;
	bh=XaigeT5SuvG2IVW7t3TcAQYPpavdgXs+LEoTZbFdNUI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E5ZOqr3UQRbUDnM9f7JOvEjEQ1PiR93XH3D33HW3hfbFJWQqOCF1sDXsZNj2gL3BQ
	 cVuLlyENZfiBH7iSGk4k11ZgFDX/eKl2QHyGufeXCMFIVyuZWcLa6oLL9zubUy8KVE
	 o9cPmp+1ENHnqj2FxK2Lte5Ry3uue14DRTF5U/OO+Hin4l0l3xvyGARY8YWdULUawb
	 FHxJZLMf2B/o1a0TJalQAyydHY3pwMXxT938mi6i0ZnusEjXPFWBoHMYXMtFX7S1bn
	 BPaqD3D6ritz8mrHBjKK16PGQw2CmvcfMXAmYx3dMjQg1RAu7VSR0R3QdWZ2GBiMMd
	 /GpD2aJq6NLbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 29/32] perf timechart: Bounds check CPU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260520190538.142018-30-irogers@google.com>
References: <20260520190538.142018-30-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 20:06:37 +0000
Message-Id: <20260520200638.5BF021F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Returning -1 from tracepoint handlers causes full session abort in=
stead of just dropping the out-of-bounds sample.
--

commit 3886673c573a53ceabf60565604906fa2eeab45d
Author: Ian Rogers <irogers@google.com>

perf timechart: Bounds check CPU

Prevent out-of-bounds writes/reads in CPU state tracking arrays by enforcing
strict MAX_CPUS bounds checks in timechart's tracepoint handlers.

> diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechar=
t.c
> index d2e15d02304ea..630756bebe324 100644
> --- a/tools/perf/builtin-timechart.c
> +++ b/tools/perf/builtin-timechart.c
> @@ -605,6 +605,10 @@ process_sample_cpu_idle(struct timechart *tchart __m=
aybe_unused,
>  	u32 state  =3D perf_sample__intval(sample, "state");
>  	u32 cpu_id =3D perf_sample__intval(sample, "cpu_id");
> =20
> +	if (cpu_id >=3D MAX_CPUS) {
> +		pr_debug("Out-of-bounds cpu_id %u\n", cpu_id);
> +		return -1;
> +	}

[Severity: High]
Does returning -1 here cause the entire session processing to abort?

When tool->sample returns a negative value, it propagates up through
perf_session__deliver_event(), reader__read_event(), and
perf_session__process_events(), causing the entire processing loop to fail.

If a file contains a single corrupted event, or if it runs on a system with
more than 4096 CPUs, would this completely abort execution and fail to
generate an SVG?

Could we return 0 instead to gracefully skip the invalid sample?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520190538.1420=
18-1-irogers@google.com?part=3D29

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55516397E9A
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 02:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790648864; cv=none; b=dEp3YOwgIKkioLSi91WeyqAQjGECyD91RKD5TcBzYIaLRFpzlD4k/L5AkOazgOspBzekWn9QfV4pI8a37kvBqr3yjgGi+JQNj4FV23NS/a8tQxwXAmSZa6QupjfctRxHi2vfdVeVHrwxks+sPceK+dfa3iDPjLMbCkma2AK1tHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790648864; c=relaxed/simple;
	bh=0Dr5JXsGpYSRoUzAvGVWdA3eFvchQnl451hao06YVpk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ffy+ZOS1axaDBNk9ubMdAT/b1r4EA7fi7ucNJTSEEAgRnyLhc9NCriVyUCbyvWA+DWF7R3ESx+k3M2VskjIzf2Eh4+BC9k4rhE/M7ObBinzrHeK7/sUSDBUuYpZOcuCI+BV51xKDbTRW+fKcEBlNmUA/AyQi+ZF3SJB1baI0RN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H54MGhx3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H54MGhx3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E12EB1F000FF;
	Tue, 29 Sep 2026 02:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790648863;
	bh=A4vOzsUQBlmz686DXQi2r73HdykrtPe96ZDgf+EC5Ps=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H54MGhx3PwEmeKMCSsiplykzCm6/2pr7cXSZfWGiaePrO6Ux6Ykv5TwUVDxGRPbql
	 CQV3s+UQo/MRvp9g4Ah5AQzoxiuhWCOo1btSHIg9Jtcxizxq/6MJco6T0TJICDQodD
	 CfLMFzrTuCPJ7yCAytMcCQdqa9RTsfsRaHAJhcxgc3eSFof8WOhK2rgB2S0qwj3kr4
	 d5VrBVM4q83wAkvi2wh1Tw+Rj5HUZjp7FthE/ld19KMYD0TtCluEflagHMXHqax/la
	 D6HwpDTL4C1ypmGfx26bN8B/U0HE58iXcmzi1H/mep3jdfgPndcPyZZsghQi1PnGRj
	 8f0+962walN/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 9/9] perf pmu: Fix race with concurrent tracepoint
 creation and removal in perf list
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260929021913.56010-10-irogers@google.com>
References: <20260929021913.56010-1-irogers@google.com>
 <20260929021913.56010-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 02:27:42 +0000
Message-Id: <20260929022742.E12EB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] perf: missing explicit <stdlib.h> inclusion for realloc()
--

commit 156bff4d99dfcb5bfd8c7cc38a4671357c5113e3
Author: Ian Rogers <irogers@google.com>

perf pmu: Fix race with concurrent tracepoint creation and removal in perf =
list

This commit modifies the perf tool to handle concurrent addition and remova=
l of
tracepoint events by dynamically reallocating the aliases array and handling
-ENOENT gracefully.

> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> index e0a4cb2428ca4..137abad37c33b 100644
> --- a/tools/perf/util/pmus.c
> +++ b/tools/perf/util/pmus.c
[ ... ]
> @@ -597,8 +597,18 @@ static int perf_pmus__print_pmu_events__callback(voi=
d *vstate,
>  	struct sevent *s;
> =20
>  	if (state->index >=3D state->aliases_len) {
> -		pr_err("Unexpected event %s/%s/\n", info->pmu->name, info->name);
> -		return 1;
> +		size_t new_len =3D max_t(size_t, 16, state->aliases_len * 2);
> +		struct sevent *new_aliases;
> +
> +		new_aliases =3D realloc(state->aliases, new_len * sizeof(struct sevent=
));

[Severity: Low]
Does this code in perf_pmus__print_pmu_events__callback() rely on implicit
header inclusions for realloc()?

Since the perf tool can be built against musl libc, which strictly separates
declarations and does not implicitly include <stdlib.h> through other
headers, should <stdlib.h> be explicitly included at the top of
tools/perf/util/pmus.c to prevent compilation failures?

> +		if (!new_aliases) {
> +			pr_err("Unexpected event %s/%s/\n", info->pmu->name, info->name);
> +			return 1;
> +		}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929021913.5601=
0-1-irogers@google.com?part=3D9

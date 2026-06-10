Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C28F2550D5
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Jun 2026 17:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781111042; cv=none; b=HYaxvvqMWuidjeAqsgES2mQ7k6gXByNwGM/ZvHAgcQddQsLpfy7QzioJojhd0/tHu4Iu+vbKDDMMwnmvT9R6PGFdrZ6kTXMKR4aUNuQwQn/2642QpDLMEgNWeGN3l56lQWIg6v6JdlgpqhtK96+DcTiBY+uqi+PJhdPBCm81LQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781111042; c=relaxed/simple;
	bh=HQE3GjQn0MEhJefVi+PN2mC850+cjE5h+AUOpjGCvX8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lCPL9je4R/AKO0oukpZxoLJ7h4/hDsxDbjvwjfwTDi+PVJicrwEodrv7AJkOsJMR37ffyYNgejdBmd88/JiacA3qFNRn58NlTHzRfIMLIZLKUXT4rirwxHfcW9hJyLB7AXksjCCSHclytpoZ/R67tY7c5PiryPE2t8SbThaHSLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hRRjvHXa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hRRjvHXa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5091F00893;
	Wed, 10 Jun 2026 17:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781111041;
	bh=5cpolQJWb4sagyg/KZrNSCupNs4QsY0KsS+upL3Z77o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hRRjvHXaUC4nB6Aiy3DTQsXN0L60glsGAWORgsuZEncQyKudUswL7a6GdgY2cFVhI
	 sDITDsEUMvdfwostMvru2ve7ePxgcPaXmjnUNRTwFM8Lo//SPaUEyayontTPnLTJE4
	 f1czS6REAFGNo4/ACMG7hQFQ8PnenqroE8GgdYVLbLzB/7dFNKYTQGf0tyMfh7z3Vw
	 a8w/8L/HMpOlKjanauUQq3otcIt9TI69HMq/WF2BZaqcJZBx9QDNN82aTs8g4TTi+3
	 n1PH0AhOyfGsso+tL2N2B1heVDvEHhqgkRC+a/tBakBlYykDTijLnlTsGMltFAzy+d
	 C1kJbKUwzXcig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/11] perf sched: Bounds-check prio before test_bit()
 in timehist
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260610165207.2077258-6-acme@kernel.org>
References: <20260610165207.2077258-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 17:04:00 +0000
Message-Id: <20260610170401.1B5091F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch introduces a logic error that causes invalid negative pri=
orities (<-1) to bypass the `--prio` filter.
--

commit 3165982942697d89513b8b104d95d745a4412391
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf sched: Bounds-check prio before test_bit() in timehist

This commit adds a bounds check to timehist_skip_sample() to ensure that
priority values from untrusted tracepoint data do not exceed MAX_PRIO before
calling test_bit(). It also updates the sentinel check from !=3D -1 to >=3D=
 0.

> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 1ff01f03d2ad1..ded511d851880 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -2645,7 +2645,9 @@ static bool timehist_skip_sample(struct perf_sched =
*sched,
>  		else if (evsel__name_is(sample->evsel, "sched:sched_switch"))
>  			prio =3D perf_sample__intval(sample, "prev_prio");
> =20
> -		if (prio !=3D -1 && !test_bit(prio, sched->prio_bitmap)) {
> +		/* prio comes from untrusted tracepoint data =E2=80=94 bounds-check be=
fore test_bit */
> +		if (prio >=3D 0 &&
> +		    (prio >=3D MAX_PRIO || !test_bit(prio, sched->prio_bitmap))) {

[Severity: Low]
Does this logic inadvertently allow invalid negative priorities (less than =
-1)
to bypass the --prio filter?

By explicitly replacing the prio !=3D -1 sentinel check with prio >=3D 0, t=
he new
logic evaluates to false for any priority less than -1. This causes the blo=
ck
to be bypassed, meaning rc remains false and the invalid negative priority =
is
not skipped by the filter.

Should the check be restructured to ensure that invalid negative priorities
from crafted or corrupted perf.data files are also properly skipped?

>  			rc =3D true;
>  			sched->skipped_samples++;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610165207.2077=
258-1-acme@kernel.org?part=3D5

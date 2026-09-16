Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681F34DAFA2
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 20:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789591475; cv=none; b=gMErr8Gf2q4+JI7Y4R463XDXvg319TRsP7u3snuBgLuWiFycFpfbWIzOqXlanNW7LSZ2k1JNfhAon0/4d4ywnLJ+pzTDMr8KnB8kE3wcTv7SzN3Rk7RFct3TxU8TjPbiirDrccYSWXckm2d9eHv5POmifdFJU0sPWJgPzlNPfeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789591475; c=relaxed/simple;
	bh=nFH5rdHkV3CLtUgODU2ux0I2RTuqurC3yIh//LqT8RY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jkN7q9UPUnGdFvCCPfFaeiGDZy9SxmiSVgwzXIBHhxLpX+YBmu0pt/zzyEGew2tctOeZDLflU58ZsYRy+GykNCxRXOwkOrRPV2NKrNJi12hxg0IOrQ21xCJPqfsITon2rSB5sJHDzer/BEKloJILyVnldTHmvUWNbM0/zVuUcVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lE6MO/JZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lE6MO/JZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E761F000FF;
	Wed, 16 Sep 2026 20:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789591456;
	bh=JaSOixIxgKQItlAdH7kEMPGKFLMBDzIpHjEhylC8NEs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lE6MO/JZBGMVZ8DV4mYjgrOkpJwupGB8UtA5gLIuzwByioCLRq+cJYO/rp50ykk/u
	 Qidw5pj/zu3kOVvyzlWmerZyOCfZf8mxwu5Nuy7pocVFTBxhOhfBYsEa65O1Z0J6ub
	 lDPAE7wr92yyNNUpx2bPJ78FH0kJw3P5gih7XjRZZTHXRp5Tc3s8Wo4F9GNtZfSzFq
	 r+KoHO2hbqXfMC3SyLOSej+KsNt52U9h1VKbsek1R1tSFEtsQ2SZszX9wBJvZxGhlA
	 41Qih+JGbjNGm5iRjD9xbwWMIK4TKSgg83zXEUc0QcVPX5UHM5ZAxyi+NX+YdgwV4c
	 tDItZaaAbbYLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf topdown: Don't require config1==0 for a slots
 event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zide Chen" <zide.chen@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916202740.257376-1-zide.chen@intel.com>
References: <20260916202740.257376-1-zide.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 20:44:16 +0000
Message-Id: <20260916204416.80E761F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] perf: missing explicit <stdio.h> and <string.h> inclusions
--

commit 197eea3115a0d065dc53e6f96ad2fd38fdb9bc99
Author: Zide Chen <zide.chen@intel.com>

perf topdown: Don't require config1=3D=3D0 for a slots event

This commit modifies the topdown slots architecture check to no longer requ=
ire
config1 =3D=3D 0, fixing an issue where explicit slots events were duplicat=
ed in
scheduling. It also adds a new test to verify that an explicit metrics_clear
slots event doesn't trigger extra injections.

> diff --git a/tools/perf/arch/x86/tests/topdown.c b/tools/perf/arch/x86/te=
sts/topdown.c
> index 2b6f47ce49324..b1ce9f83db00e 100644
> --- a/tools/perf/arch/x86/tests/topdown.c
> +++ b/tools/perf/arch/x86/tests/topdown.c
[ ... ]
> @@ -229,10 +229,38 @@ static int test__x86_topdown_slots_injection(struct=
 test_suite *test __maybe_unu
>  	return TEST_OK;
>  }
> =20
> +/*
> + * An explicit "slots,metrics_clear=3D1" event is still the slots event =
and
> + * must not cause an extra slots event to be injected into the group.
> + */
> +static int test__x86_topdown_metrics_clear(struct test_suite *test __may=
be_unused,
> +					   int subtest __maybe_unused)
> +{
> +	struct perf_pmu *pmu;
> +	char event_str[128];
> +	int ret;
> +
> +	if (!topdown_sys_has_perf_metrics())
> +		return TEST_OK;
> +
> +	pmu =3D perf_pmus__find_by_type(PERF_TYPE_RAW);
> +	if (!pmu || !perf_pmu__has_format(pmu, "metrics_clear"))
> +		return TEST_OK;
> +
> +	snprintf(event_str, sizeof(event_str),
> +		 "{%s/slots,metrics_clear=3D1/,%s/topdown-retiring/}",
> +		 pmu->name, pmu->name);

[Severity: Low]
Does this new function test__x86_topdown_metrics_clear() need explicit head=
er
inclusions for musl compatibility?

This code relies on an implicit declaration of <stdio.h> for snprintf().
Missing POSIX headers can cause build failures when compiling the perf tool
with strict libc implementations like musl instead of glibc.

Should <stdio.h> (and potentially <string.h>) be explicitly included at the=
 top
of this file to prevent musl compilation failures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916202740.2573=
76-1-zide.chen@intel.com?part=3D1

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252A1341AC7
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 07:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780298388; cv=none; b=KY/xrBz34JfmzFsVAnBVWHhkpUgiQBt6+FDPhazkX5m0qqFz0QgrWdMJV87Z/+h6ly6jRDeuNdAUNZy+zHu9BHfM45ElomGQgpZnnxs7afugCHdVWgAn/UgzAXs79O7Y9cwBEcPtEVtf4s6hVvnM37wCr7p8AdytVFYzOKPW46s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780298388; c=relaxed/simple;
	bh=uZKzrUIMusbownsaW+woSVa4Epa4JraLibwFhEggdjc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qWhL8xFjbHm7FXc2LFmmDBSsie3PJ2HcNHAsBD528sLFZgpLss0u3cUG6pcAAQx8/alZ+MI8t/TK6/kdqUAJLdXF5dRfRek5CjMq3P0eynNUbbBo2Tec3l3ncTa/4n9//YwJG/c0X9xUMPPcuB/gJUcqWA1/7OE41vTz63cKNGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXAHimEA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXAHimEA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA281F00893;
	Mon,  1 Jun 2026 07:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780298386;
	bh=2QosgMDkmJygbVP6oW+mdzfbjiRcdGHgijQjAHyNuh0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IXAHimEAZGRY/FWQMWz8gqM7QWPOIJR29sR655BBetgNqPvYEEKClfVechdGWsgy/
	 25jXOXk/PeDNagKfsctd3xHh96o6mfPFNl7F4B3nZU0++wh7gLMvwwzl+ALEr3w1o0
	 1qdcpZAwUQMAzeJYLqgi7cH3Zz1iNc5wSU+HOvMoy6HRNAKjTqd8HAozU+ftkcbepR
	 P1O2j4Qvx9eokPl5QIOWfjSfrAKyVKI1fTDOtWKf7ngm/07v1PpYOHKfVeV2vgjIFU
	 hwYubvl/V930VCL1R2npI7jfBb5eVf5oYb6Xe5TNAurkPMlIovjYkvAitsSXNGBLnd
	 swISgkcx3+KSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 18/18] perf symbol: Lazily compute idle
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260601065407.1597927-19-irogers@google.com>
References: <20260601065407.1597927-19-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 07:19:46 +0000
Message-Id: <20260601071946.9AA281F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The fallback mechanism in `perf_env__os_release()` defeats the u=
npopulated guest trace safeguard, poisoning the guest environment with host=
 data and causing false negatives for s390 `psw_idle`.
- [Medium] The `e_machine` prioritization bypasses the accurate DSO archite=
cture, breaking cross-platform analysis for unpopulated traces.
--

commit 68dda82c5f091cdbfc3cd5e322eb9f9b77be4637
Author: Ian Rogers <irogers@google.com>

perf symbol: Lazily compute idle

This patch switches from an idle boolean to a helper symbol__is_idle functi=
on.
It lazily computes whether a symbol is an idle function by taking the kernel
version and architecture of the machine into consideration.

Link: https://lore.kernel.org/lkml/20260219113850.354271-1-tmricht@linux.ib=
m.com/

> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
[ ... ]
> +	e_machine =3D env ? perf_env__e_machine(env, NULL) :
> +		(dso ? dso__e_machine((struct dso *)dso, NULL, NULL) : EM_NONE);

[Severity: Medium]
When analyzing an unpopulated guest trace where the env is present but its
arch field is empty, does perf_env__e_machine() fall back to uname() and
return the host architecture?

Because the ternary operator prioritizes the environment, this short-circui=
ts
and bypasses the more accurate dso__e_machine() check which would read the
actual target ELF binary. Could this break cross-platform analysis by
evaluating a guest trace against the host's idle routines?

> +
> +	if (e_machine =3D=3D EM_386 || e_machine =3D=3D EM_X86_64) {
[ ... ]
> +	if (e_machine =3D=3D EM_S390 && strstarts(name, "psw_idle")) {
> +		int major =3D 0, minor =3D 0;
> +		const char *release =3D env ? perf_env__os_release(env) : NULL;
> +
> +		/*
> +		 * If we can't determine the release (e.g. unpopulated guest traces),
> +		 * default to idle.
> +		 */
> +		if (!release) {

[Severity: Medium]
If the env os_release is unpopulated, does perf_env__os_release() fall back=
 to
calling uname() to get the host's OS release and cache it in the guest's
environment?

If so, it appears the !release check becomes dead code for unpopulated guest
traces. An old s390 guest trace analyzed on a modern host might incorrectly
use the host's version, fail the version check below, and misclassify psw_i=
dle
as not idle. Can we prevent the host release from poisoning the guest
environment here?

> +			symbol__set_idle(sym, /*idle=3D*/true);
> +			return true;
> +		}
> +
> +		/* Before v6.10, s390 used psw_idle. */
> +		if (sscanf(release, "%d.%d", &major, &minor) =3D=3D 2 &&
> +		    (major < 6 || (major =3D=3D 6 && minor < 10))) {
> +			symbol__set_idle(sym, /*idle=3D*/true);
> +			return true;
> +		}
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601065407.1597=
927-1-irogers@google.com?part=3D18

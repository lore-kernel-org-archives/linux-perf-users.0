Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BAE39989D
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 06:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780382797; cv=none; b=tspTjZuHeme3OVew05Hkc735hSMYz/VT2YhuiTCj8ij6C2/xow+4YmAtJeQ/FI6LTrNsYWoWUQgnCWsn+ts3Gke9cTRIqQQc2LTvfy2itoQaqY8HYTBMHSJUMv0LnO/yaASlLZO2iFHwvp539BN6oCWQdC9MIc9ypFHyhGqV1hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780382797; c=relaxed/simple;
	bh=akSS/mUboGOO/dICr4er5JQqHBXmOhki4Az4Ty3a4bs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dzhLxhXVDRvxHtWguOx2acsgvl5iHPgCf69wQiwXb/aVudr6EkGVBojTknIDcltrYC8Z0hg734mZWO6bGMUi2JMvYvkH5ASr7HJsDREiiqkXT+tmCbycTasP1JeMZhedLbDJl9pcb5ttrxZRnXuY9Zji0x+clAyMtGsR8t33oFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWGl4w4O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWGl4w4O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C160C1F00893;
	Tue,  2 Jun 2026 06:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780382795;
	bh=jkyrrCzzEXoUup6AZ7/jUm6zXfX6P38mRZXHjLaFrj0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fWGl4w4OU1re4SorGRwfs5AKgwzOPVsBfcC8kwcYunme8Mt2KpFouyl/sskokhJ5L
	 A02DXPdwHdDLfKBpiRA/KooifKcu34u5z323bg5Q09TffDCMF7ZqggFgyoIiJ8+i1E
	 uroV00wBsls/Ob+vhAd6db8fUekDIXDGnuFvlw7V9FdV0235v3V+97K8SEPYhZUbX0
	 vA6z0wGYnb9OTUtUZps4ip5MmVLKtQEAFaBD0YAPriIbmb/xL6oLfmUPTWowwl9aML
	 DNkk0V3n2Kc8E6unM1AIAsmyf+r3KE0gwX9pR1Xal4nxDSRuX09TtEobgzsK09/7f6
	 ATUkSM2j5gGsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 05/19] perf print_insn: Use e_machine for fallback
 IP length check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260602062452.2583619-6-irogers@google.com>
References: <20260602062452.2583619-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 06:46:35 +0000
Message-Id: <20260602064635.C160C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] is64bitip() incorrectly falls back to the host architecture via =
uname() for guest machines, breaking instruction decoding bitness for 32-bi=
t guest analysis on x86_64 hosts.
--

commit 57b90f6c4edae48460ac4aff9f63c175178b0004
Author: Ian Rogers <irogers@google.com>

perf print_insn: Use e_machine for fallback IP length check

This patch avoids string comparisons with perf_env arch, switching to
using the more precise ELF machine. It also sorts header files and fixes
missing definitions.

> diff --git a/tools/perf/util/print_insn.c b/tools/perf/util/print_insn.c
> index 02e6fbb8ca04e..4068436f26ea4 100644
> --- a/tools/perf/util/print_insn.c
> +++ b/tools/perf/util/print_insn.c

[ ... ]

> @@ -33,13 +38,13 @@ size_t sample__fprintf_insn_raw(struct perf_sample *s=
ample, FILE *fp)
>  static bool is64bitip(struct machine *machine, struct addr_location *al)
>  {
>  	const struct dso *dso =3D al->map ? map__dso(al->map) : NULL;
> +	uint16_t e_machine;
> =20
>  	if (dso)
>  		return dso__is_64_bit(dso);
> =20
> -	return machine__is(machine, "x86_64") ||
> -		machine__normalized_is(machine, "arm64") ||
> -		machine__normalized_is(machine, "s390");
> +	e_machine =3D perf_env__e_machine(machine->env, /*e_flags=3D*/NULL);
> +	return e_machine =3D=3D EM_X86_64 || e_machine =3D=3D EM_AARCH64 || e_m=
achine =3D=3D EM_S390;

[Severity: Medium]
Does this change break instruction decoding bitness for guest machines?

For guest machines, machine->env is often NULL. The previous code
handled this gracefully because machine__is() checks perf_env__raw_arch(),
which returns "unknown" when the environment is NULL, safely returning
false for the 64-bit check on x86_64 hosts.

With the new logic, passing a NULL env to perf_env__e_machine() delegates
to perf_env__e_machine_nocache(), which calls uname() to retrieve the
local host architecture.

If analyzing a 32-bit guest trace on a 64-bit x86_64 host without a valid
DSO present, this fallback would return EM_X86_64. Could this cause
is64bitip() to return true, improperly decoding the 32-bit guest
instructions with 64-bit bitness?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602062452.2583=
619-1-irogers@google.com?part=3D5

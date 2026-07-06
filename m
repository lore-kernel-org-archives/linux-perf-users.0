Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CE6386C08
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Jul 2026 02:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783306768; cv=none; b=QPaaorog9L0AHx9N6WWaZVF+BwyKq1ZkZdaAZ7ZUvQ2WP6GI/Qup8sJAcK0ytCqYL6I93U3TjQTkbNZIYl/Hml4EdySb5Hw8MzRc4R4uchB23GSGqrqovtoxynM6wblmenUGfB1T+rWetbWeyH1Y+gwaAYqQeGzhA/lqzyjrBLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783306768; c=relaxed/simple;
	bh=uJfRhxqG7r1WMcz4kae7vLS2BpaQL5gL/hnKcbU0Wug=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KFbD/3h2pFqS84ssT+Uy7QqrrZAh0r4vnJVaJRSVs4sYDcDPOGYZJ+vuuZUmJxbnYJM/tQqHM+mxoPlPCLzY6+LwaFlo5G78Gly4oow9O0TqI8G9Y4KFXTDoEOrHd1QuKz1HAl/kofBXPE7gzOnDFez6QwyIlw6Ga94auWVU3RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RB3z0HkY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RB3z0HkY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA051F000E9;
	Mon,  6 Jul 2026 02:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783306766;
	bh=cmSC6wnbC47s78UFZTss0WgfCx4IRdceBr5EwIDm7No=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RB3z0HkY9h3+bTtjLXR6PZNYSAIy5dwTaa1LWqh/LR2aB2ACh+nZQQR0z2h+fqckW
	 3FMohpKxICHyROsrs2vkovMEIBQ2F4ydCzUi3hiTN1/9LQtWsacOc6M2hrZ98W6PKG
	 TUTHvl8gj9ncXuwqxMDbeCJzJqrnvRZTnfvUpy9ELCeopZxSfaTJsshfJ/ymckao1D
	 6hhtowW0pJwVW1IQulLvgyxfpjYU0MMWDr6d17c0QzizPDDKW4u8qeCjoKXMpy4wXF
	 kPxZK/Okx2EJP2nCqS0eKLxql9LOi6Fv9rt3LSplhTfR/i57JP/FLdNXDnWGYM8Dhr
	 xo35etGJR5U6A==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v9 05/10] perf regs: Support x86 eGPRs/SSP sampling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260706023444.3067660-6-dapeng1.mi@linux.intel.com>
References: <20260706023444.3067660-1-dapeng1.mi@linux.intel.com>
 <20260706023444.3067660-6-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 02:59:25 +0000
Message-Id: <20260706025926.3AA051F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Reclaiming XMM register space breaks explicit XMM register selec=
tion on SIMD-capable hosts.
--

commit 4a688e42468a5e89b85174c21cc87866b350369c
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf regs: Support x86 eGPRs/SSP sampling

This commit adds support for sampling x86 extended GP registers (R16-R31)
and the shadow stack pointer (SSP) by reclaiming the original XMM register
space. A new abi argument is introduced to distinguish the register layout,
defaulting to the new SIMD layout on supported platforms.

> diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse=
-regs-options.c
> --- a/tools/perf/util/parse-regs-options.c
> +++ b/tools/perf/util/parse-regs-options.c
[ ... ]
> @@ -87,14 +100,16 @@ __parse_regs(const struct option *opt, const char *s=
tr, int unset, bool intr)
>  			*p =3D '\0';
> =20
>  		if (!strcmp(s, "?")) {
> -			list_perf_regs(stderr, mask);
> +			list_perf_regs(stderr, mask, abi);
>  			goto error;
>  		}
> =20
> -		reg_mask =3D name_to_perf_reg_mask(s, mask);
> -		if (reg_mask =3D=3D 0) {
> -			ui__warning("Unknown register \"%s\", check man page or run \"perf re=
cord %s?\"\n",
> -				s, intr ? "-I" : "--user-regs=3D");
> +		reg_mask =3D name_to_perf_reg_mask(s, mask, abi);
> +		if (reg_mask) {
> +			if (abi & PERF_SAMPLE_REGS_ABI_SIMD)
> +				opts->sample_simd_regs_enabled =3D 1;
> +		} else {
> +			ui__warning(warn, s, intr ? "-I" : "--user-regs=3D");

[Severity: Medium]
Will this change break explicit XMM register selection on SIMD-capable host=
s?

Because PERF_SAMPLE_REGS_ABI_SIMD is set by default on platforms with SIMD
support, the reclaimed register space means name_to_perf_reg_mask will now =
map
to eGPRs instead of XMM registers.=20

If a user runs an existing script that explicitly requests individual XMM
registers, such as perf record -I xmm0, won't this branch fail to match the
string, return an Unknown register warning, and break backward compatibility
for those CLI options?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706023444.3067=
660-1-dapeng1.mi@linux.intel.com?part=3D5

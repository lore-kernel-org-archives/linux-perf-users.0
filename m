Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794365934;
	b=UFAvjfadErDPy15gqXT1cPwRPjBFE79LEcE4DNPm2y5CqCPPwvVjpiluAYDU5jOGGmpP
	 I488t1U/cNOpNMNk/wZN/Ytx92fzV4lozzL9BH/97IPGkw8OTiR3u+39hCRQiicDj+NaJ
	 iOhOFRIBDFxgcIhHGPKMP+RjjsXkeM2GSvlcUxKqzyfG2R7DMcsj5PQYhGLceF0BYYRIW
	 8c3IWYVjQbKz69n5FjPElcwg7Dl7d/qOtfo9Xl1zijMLOrahXan0Qn/6qLfnikXA/bl8U
	 xqj04n7T80vsL4n0bpAxzonKbZkCDYpZ/yTBIDfZUU4fV/S7MDWfnbGKH6Wn+r6wJ/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794365934;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=S5T9vhjlctgIImRr+N92w0piFczgO8gP2zP1kPw63WQ=;
	b=Fej4F1mW+WGgwy9wS1+9U0ixkONM+HNHl3y0F9ah/mLSTKCyEAzWrCpl1zN5FrfmMrjE
	 cfR/8+l+i9cLFAGTI9QupbB4g0uVVtF0NdRcO3Ns8KXh4hTZc23MQ4NxGqrBNgEKSG+dZ
	 n5hRER/OZweiCqG+okRAHL0XUYI7o3egTmv6bv1Plerjaht/HZpnpbGjYHgBFR/fV9X5u
	 DQkRQtdY85A6Tu5/5cQESXM2cqnLe1rMIJ0SK79zncj+If6w3PaCUywlHv34wFnz+Y8U/
	 1aHOyfhk94BCE0UMHmDfAYhb0BKA5W+UwieqdAvavhJfAntU6YcwqgWYqakQotQeh1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AonsGsai;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8A4606A31C
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 02:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AonsGsai
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8043A1F0089F;
	Wed, 11 Nov 2026 02:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794365933;
	bh=S5T9vhjlctgIImRr+N92w0piFczgO8gP2zP1kPw63WQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AonsGsai9ell+DB9Dy8TUV3UVkyTrC2sdFOqyZnDI8XJ8SaFswA4g2vADxiW77XTk
	 z5MUXV47LLOGAPiCw4jv/A4jAilMTvvGZXyDTkkYsme/EFqz78dJmJ6652ONpi7x9T
	 LOhtJCOb2XpkIVr6NmI4mD09HdngEqlN3xjJoBrjAxJQdgzlYv4yR3DYmPT8QT1neU
	 i7PYlcc49rHFBYAjQF84mwdCVTEZpsef9hC7p8L1KnrPR3ftrgHL6L2DdsHKolFdhU
	 ek0whdzjw4u7oVOkMwLL2qXO90fIcYce99SXa8X9zVUjUguMy4aVxR6pwg86H6UzoU
	 tRNXDk+XsUiVg==
Message-ID: <sashiko-outbox-208141@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf: arm_v7_pmu: suppress -Winitializer-overrides for
 perf maps
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261111023326.70922-1-rosenp@gmail.com>
References: <20261111023326.70922-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 02:58:53 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] perf: arm_v7_pmu: Clang-only -Winitializer-overrides breaks GCC
  builds
--

commit 56df4775a501226704b362f4cef9ce6d443becbf
Author: Rosen Penev <rosenp@gmail.com>

perf: arm_v7_pmu: suppress -Winitializer-overrides for perf maps

This commit wraps the perf_map and cache_map array definitions in
drivers/perf/arm_v7_pmu.c with __diag_push(), __diag_ignore_all(), and
__diag_pop() to suppress designated initializer override warnings.

> diff --git a/drivers/perf/arm_v7_pmu.c b/drivers/perf/arm_v7_pmu.c
> index a1e438101114a..9ac28c8adf801 100644
> --- a/drivers/perf/arm_v7_pmu.c
> +++ b/drivers/perf/arm_v7_pmu.c
> @@ -146,6 +146,15 @@
> =20
>  #define SCORPION_ITLB_MISS				0x12021
> =20
> +/*
> + * The perf_map and cache_map arrays use range initializers to fill all
> + * entries with HW_OP_UNSUPPORTED / CACHE_OP_UNSUPPORTED, then override
> + * specific entries with supported event codes. This is valid C99 but
> + * triggers Clang's -Winitializer-overrides.
> + */
> +__diag_push();
> +__diag_ignore_all("-Winitializer-overrides", "");

[Severity: High]
Does passing "-Winitializer-overrides" to __diag_ignore_all() break GCC
builds with CONFIG_WERROR=3Dy?

__diag_ignore_all() expands on both Clang and GCC, producing a
"#pragma GCC diagnostic ignored" directive on GCC.  Because
-Winitializer-overrides is a Clang-specific flag name, GCC rejects the
pragma with a -Wpragmas warning and leaves its own -Woverride-init warning
unsuppressed in W=3D1 builds.  Using "-Woverride-init" (with a non-empty
comment argument) works on both compilers since Clang supports it as an
alias for -Winitializer-overrides.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111023326.7092=
2-1-rosenp@gmail.com?part=3D1

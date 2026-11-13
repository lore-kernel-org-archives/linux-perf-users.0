Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794600185;
	b=H8D+2VUunEaFfN3ZYgWaBr6B8AL60o91Zt8FNWQx//niDL3/hZLJsy381mxzo2sR7bbN
	 H9RAw9mUVAdlASD6ldwaAx9NRsQ+NQ7IPjn2Axt/9MOU+eNKtYyg/5Rp1vCNwSx9j6qEH
	 7XwCwF3BlTo5jlQozzKEqaeeLH6w/WLfTIcs9OSK6eXbCOwzI2IBvUrMAtm9JD12oAmw9
	 v7CMeHDzUmw7C8elI+IIhEI0BB3MzFfPfQgpVEBWASXTi1u3DBHrs9XmqUz7mBbfwgPAR
	 giEcOuyT9VQOCaoo8fPvNdAJZ8rdnEwNME11E/RjpIB5h8xyau5h5gSPNIkM0nzA9FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794600185;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iwrmh0XOwMGei9E6gD8ltJtNsUvzTy79AbFyzt8BS4Q=;
	b=uEJ5MNJu2bSNASh1U4xXYYLnZt/UT19edMDQ6zM8b9AjB1HhCBzOqvtA7C5hvxFaDAGy
	 cqh59bmXriO+y89nBEvOzippUcHUGIXNkyNg4Uhi69Nf+Q/cJUV6m8/zs4BuH7QVzetlS
	 nVKBjXeT3g1Se/VNMDIy8v9Rx62ZKV1FHzo4ywhwwo221jzbtAVrOvULMi5wrwSM1MEba
	 gTHEs1+MUD/peC1PZLHsJyhBCJ6vGnE8e5wI8KPCoKfM8ZCclFWEeZWDBJOPtgfBDC1yt
	 D26WSPaPZDlFMC06QMErWp9gUPZj0XpxQjt9ZRfujcB0pFogx5YiOyAnb6psBxw9Vfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="l/aG4YBF";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8669606A32D
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 20:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l/aG4YBF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8DB1F000C5;
	Fri, 13 Nov 2026 20:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794600185;
	bh=iwrmh0XOwMGei9E6gD8ltJtNsUvzTy79AbFyzt8BS4Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l/aG4YBFf3pzYSZXN5evu5iZqrVBNYMTOunw+iHnZtpiwYXxnhhg+dkhTpqQEQOft
	 //4cknhVNUWtXVLNoqdoQMqQjXodhy1kahUpNbH5sy1zWlQtnjN4q+HUWfrbwVBqbO
	 qN4dQ9vvHVDlTCbnF1poJu1aCNFQqq5RBlHWyokV6htyq/dXuxSKSupbVHesYZ9UEg
	 xoLXEtcrVEUqxc1GSu1rJmHkTRqtki5FVFwSRcUYsq2BsGKP8jeItUyaa2k1+EtEAX
	 XV8QwWINcvmtn/5AuxUudA7iGrZBMGYqjapKFmPXR0FN8SvzHHlM5M99LYoVJBXsrO
	 AK3UViJhUL0gA==
Message-ID: <sashiko-outbox-213604@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 16/30] perf test: Add CPUID matching tests for other
 architectures
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113195335.2865725-17-irogers@google.com>
References: <20261113195335.2865725-1-irogers@google.com>
 <20261113195335.2865725-17-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 20:03:04 +0000
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
- [Low] perf test: two-hyphen RISC-V strings in
  test__cpuid_match_regex()
--

commit 119e605bf598b12e6b113f6de7ea78452df71ad9
Author: Ian Rogers <irogers@google.com>

perf test: Add CPUID matching tests for other architectures

This commit adds strcmp_cpuid_str() unit tests for exact matching, x86,
PowerPC, RISC-V, and s390 CPUID strings.

> diff --git a/tools/perf/tests/cpuid-match.c b/tools/perf/tests/cpuid-matc=
h.c
> index e3d4a349f393b..826380241a0f1 100644
> --- a/tools/perf/tests/cpuid-match.c
> +++ b/tools/perf/tests/cpuid-match.c
> @@ -36,8 +36,87 @@ static int test__cpuid_match_arm64(struct test_suite *=
test __maybe_unused,

[ ... ]

> +static int test__cpuid_match_regex(struct test_suite *test __maybe_unuse=
d,
> +				   int subtest __maybe_unused)
> +{
> +	/* Three hyphens in a RISC-V CPUID don't imply an x86 stepping. */
> +	TEST_ASSERT_VAL("riscv match",
> +			!strcmp_cpuid_str(EM_RISCV, "0x489-0x8000000000000007-0x[[:xdigit:]]+=
",
> +					  "0x489-0x8000000000000007-0x0000000000000001"));

[Severity: Low]
Does the RISC-V test here actually exercise the three-hyphen x86 stepping
case described in the comment?

is_full_x86_cpuid() checks for three '-' characters, whereas both RISC-V
mvendorid-marchid-mimpid strings above contain only two hyphens and would
still match even if routed through strcmp_x86_cpuid_str().  Using a
mapcpuid pattern with a character-range hyphen (for example,
"0x489-0x8000000000000[1-7]-0x[[:xdigit:]]+") would give mapcpuid three
hyphens while cpuid has two.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113195335.2865=
725-1-irogers@google.com?part=3D16

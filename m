Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315B9355F57
	for <linux-perf-users@vger.kernel.org>; Sat, 22 Aug 2026 21:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787435284; cv=none; b=orSjd+3DcbQAlWuycSUGGWLlIuMXY4XLHZoBkbMJzOF8dN8nFu9wgCQ6udcFdSqrqSNLVi5ZCM/1eNyt1DbZ+NnwXZ6Eb6sD1LDq3Quym2WYVyTmhLpkGQxWk4r5yD5HhLm+VRTPID4RY25NhT79RqYbhVeoUY53PCXGdPJM2dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787435284; c=relaxed/simple;
	bh=jkoGWuzjsyj8He5BEi/m9Q/UIMXmomp+2gA1F56NnNY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Sod2mme2V+pxtsA0CaCwDs+1HZvggwnjUpoN8bV8HNLEX4i6kEIIFScA2f+Q0X774hgpNvL6XqcFTt/WnPHwXH3GFPL11Y0PcEO4irac9BBHg0+YitkaBNtC3SsLq3yq9L87RELAEMGpIbokGc3lYZdVOrwrj5Wu9vhCuHnb4YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FinHYxUl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FinHYxUl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22261F000E9;
	Sat, 22 Aug 2026 21:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787435282;
	bh=Zek8F11y1z4tyi7XVcuAFLgSjUa28GCxznMok/hfaQA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FinHYxUlQTqTsYolCCTTBF/j1V4uSXlsH41M9BLsRwJw2qaSXUNI079Pl8LyTXLF4
	 SL/48kk/RXSYEb5AiW/itOJtJwPSYYQWFfvEpBQw045SzggAWOSo+OIROm9k1A2MbC
	 3QpB/bqf2HHWKNTM94B0qrzPbclIVk3HPmRJPBTQJydsb0brrBN2z9R2uLrJNucwft
	 oYScEsdQ85DMkIOiTWYrRuCL707JNjMg/Dv8js4KSsdX+zFK/MNtzLlL3Ghrdq67bq
	 YtnoJClpRIYbOtuJV6UYRQniKR6oVJnLfWcz+FTFcEtKgNk8e9FBfiprRBYHAifAtZ
	 E5P1hU3VadIpQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v5 4/4] perf tests: Add shell test for
 kernel symbol beautifier
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260822213558.704018-5-atomlin@atomlin.com>
References: <20260822213558.704018-1-atomlin@atomlin.com>
 <20260822213558.704018-5-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 21:48:02 +0000
Message-Id: <20260822214802.B22261F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The test script `trace_ksym_beautifier.sh` intends to verify BTF=
 type routing for function pointers using the `timer:hrtimer_start` tracepo=
int, but this tracepoint's `function` field is of type `void *`, which bypa=
sses the BTF function pointer routing logic. The test only passes due to a =
hardcoded fallback for arguments named 'function'.
--

--- Patch [4]: [PATCH perf-tools-next v5 4/4] perf tests: Add shell test fo=
r kernel symbol beautifier ---
commit e969790d116081081634b0e3ece5c71834b3fe8f
Author: Aaron Tomlin <atomlin@atomlin.com>

perf tests: Add shell test for kernel symbol beautifier

This commit introduces a shell test script to verify that perf trace proper=
ly
symbolizes kernel virtual addresses and function pointers. It checks both
the default kallsyms beautifier and BTF type routing.

> diff --git a/tools/perf/tests/shell/trace_ksym_beautifier.sh b/tools/perf=
/tests/shell/trace_ksym_beautifier.sh
> new file mode 100755
> index 0000000000000..45c803338d4ca
> --- /dev/null
> +++ b/tools/perf/tests/shell/trace_ksym_beautifier.sh

[ ... ]

> +test_ksym_btf() {
> +  echo "Testing perf trace kernel symbol beautifier (BTF)"
> +  if [ ! -f /sys/kernel/btf/vmlinux ]; then
> +    echo "Skipping BTF test due to missing vmlinux BTF"
> +    return
> +  fi
> +
> +  output=3D"$(perf trace -e timer:hrtimer_start --force-btf --max-events=
=3D1 -- sleep 0.01 2>&1)"

[Severity: Medium]
Does this test actually verify BTF type routing?

For the timer:hrtimer_start tracepoint, the function field is declared as
a void pointer in both BTF and tracefs. This means btf_is_func_ptr()
will evaluate to false, and trace__btf_scnprintf() will return 0.

The output is successfully symbolized here only because builtin-trace.c
contains a hardcoded fallback array, syscall_arg_fmts__by_name, that maps
any field named function to SCA_KSYM.

Could a different tracepoint be used here that has an actual function
pointer type in BTF, to ensure the BTF type routing logic is being properly
exercised instead of the hardcoded fallback?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822213558.7040=
18-1-atomlin@atomlin.com?part=3D4

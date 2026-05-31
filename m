Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC503264D8
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 06:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780210724; cv=none; b=QGLyuAGZxpW/1G/ZI7joAOGIzL63wJaH3gLsNop0veNiw1VQHC7lZUFsuN9mzXovoymavBLRK8gMStBiWVCwLECp18nJUhHC8KFX6SzLBurg9SVSPM2MGm/UyU4ldZ0YpMJN6BqjzboYwXZAHiSIYw7iTLY7Go5snOS1uLbWz4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780210724; c=relaxed/simple;
	bh=DDru+Ti/XxdvXeGyPqSoIja29HxIDbOgZVHAPY61ZyU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p6kmYdzL7Tu48IVUBfHq6bD6/ZL6yrkVPg0I6Znooy4/xbYRcJrEs/2ai4enJupzxqVW6P5XBhHRPHYOBs/Zoi7wYqN2yc30Xiizz7sRACacLogPsLSyG3hdm9SllbhDHP+c4k59pI/HFmUchZWHa+KY1lkFOBHYkz9pOMvhuy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5bTS5gl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5bTS5gl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8740C1F00898;
	Sun, 31 May 2026 06:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780210718;
	bh=ddYS+UWUvotFnkVI8/GlexvNgn8hObuzptqESGEjuQg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e5bTS5glu5mTn+J72nx5Yf+Lxo5KgVy0W10PzYHQwAOnIxkY5GXrCYNH7sVOYHc/0
	 GRt3J3avVB+KMkR1YGaylL6h2vgO2PMPKHTvtLhOFuLf9EApbsJkg6m4tu0YSvK/J7
	 SFGHRu+BRvOyt31fQHPHSEF/gqJ5b/RMl6iZs0knmI2z39bRTU70+iQWSW9952jVYY
	 QPGAtCEgHPmOLlO3pIwS+2ynKKX5l6ND9aJyyrZpv6PnwxwUsFE8nqLx3f0XiSL87n
	 PrACZp8RRELud5etXOHpF7uYkKspSwimGfQQ4RRWMt8nXF58t5WChzn8je6SVb+Xo1
	 QH07GD7DsDnPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 14/14] perf test: Remove /usr/bin/cc dependency from
 Intel PT shell test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260531063736.871777-15-irogers@google.com>
References: <20260531063736.871777-15-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2026 06:58:38 +0000
Message-Id: <20260531065838.8740C1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Instruction endianness mismatch on Big-Endian ARM (BE-8) and RIS=
C-V.
- [Low] Missing fallback for `gettid()` causes build failures on older libc=
 environments.
--

commit e870f7c92617a09a4540aabd6ac2cc0a65b00a09
Author: Ian Rogers <irogers@google.com>

perf test: Remove /usr/bin/cc dependency from Intel PT shell test

This commit removes the dependency on an external C compiler in the
test_intel_pt.sh shell test by introducing built-in thloop and jitdump
workloads. It also adds multi-architecture compatibility by dynamically
encoding opcodes across several architectures without requiring external
tools.

[ ... ]

> diff --git a/tools/perf/tests/workloads/jitdump.c b/tools/perf/tests/work=
loads/jitdump.c
> new file mode 100644
> index 0000000000000..225d3f3dc6e3b
> --- /dev/null
> +++ b/tools/perf/tests/workloads/jitdump.c
> @@ -0,0 +1,188 @@
> +// SPDX-License-Identifier: GPL-2.0

[ ... ]

> +static int write_jitdump(FILE *f, void *addr, const void *dat, size_t sz=
, uint64_t *idx)
> +{
> +	struct jr_code_load rec =3D {
> +		.p.id =3D JIT_CODE_LOAD,
> +		.p.total_size =3D sizeof(rec) + sz,
> +		.p.timestamp =3D get_timestamp(),
> +		.pid =3D getpid(),
> +		.tid =3D gettid(),

[Severity: Low]
Does this code build successfully on older libc environments?

Older distributions do not declare gettid(), and unlike other perf files
that use syscall(__NR_gettid) as a fallback, this file lacks a fallback
definition. Because tools/perf/ is built with -Werror, could this
implicit function declaration break the build on those systems?

> +		.vma =3D (unsigned long)addr,
> +		.code_addr =3D (unsigned long)addr,
> +		.code_size =3D sz,
> +		.code_index =3D ++*idx,
> +	};
> +
> +	if (fwrite(&rec, sizeof(rec), 1, f) !=3D 1 || fwrite(dat, sz, 1, f) !=
=3D 1)
> +		return -1;
> +	return 0;
> +}
> +
> +static void close_jitdump(FILE *f)
> +{
> +	fclose(f);
> +}
> +
> +static int jitdump(int argc __maybe_unused, const char **argv __maybe_un=
used)
> +{
> +#if defined(__x86_64__) || defined(__i386__)
> +	/* Code to execute: mov CHK_BYTE, %eax ; ret */
> +	uint8_t dat[] =3D { 0xb8, CHK_BYTE, 0x00, 0x00, 0x00, 0xc3 };
> +#elif defined(__aarch64__)
> +	/* Code to execute: mov w0, #CHK_BYTE ; ret */
> +	uint32_t dat[] =3D { 0x52800000 | (CHK_BYTE << 5), 0xd65f03c0 };

[Severity: Medium]
Will these uint32_t arrays cause an instruction endianness mismatch on
Big-Endian ARM (BE-8) and RISC-V hosts?

Since uint32_t arrays are laid out in memory according to the host data
endianness, and these architectures expect Little-Endian instruction
fetches even in Big-Endian data modes, running this test on a Big-Endian
ARM or RISC-V host might result in byte-swapped, invalid instructions and
trigger a SIGILL crash.

Should these instructions be encoded as uint8_t byte arrays instead,
similar to how it is handled for s390x, to remain agnostic to host data
endianness?

> +#elif defined(__riscv)
> +	/* Code to execute: li a0, CHK_BYTE ; ret */
> +	uint32_t dat[] =3D { ((CHK_BYTE & 0xfff) << 20) | 0x513, 0x00008067 };

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260531063736.8717=
77-1-irogers@google.com?part=3D14

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673DC37C939
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 07:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780386546; cv=none; b=kLboNaJAN5ZSwrk+01NvbCNHLIcAppw+PwyP+M7eXsGyFH/Ac8HTITYKadBdw0Tme/5M3gEhwRz8LTHPQE8rhm/NVW4eRZp4FR4yGm8nDF93l8cFWAZIDBT1tO2IEEOFqKTyt6h0v6cwRslRVMrd4RX0tBbJP3ep0mlWHJlwuUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780386546; c=relaxed/simple;
	bh=bV3g1jtdcjKPoRmMN2x2OlSXoVqDc7LKAOGws1RzDCs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YVqqHJGYayL6S88zWj/Mq/I119katUmBsAoDE8vX14bt+KVhJpRWVrn2iAKefHhEAZC3WdR5FI5Qa5Gl5urXPimkRdvwVNg/yJGjzXVJ4xNtC1z6TZijgyFR3WQPnNTMw3K/HeRh9R11tWkDQ40POwnEhNgATolTNjnJnOAC+es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1KQgMzA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1KQgMzA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDEC11F00893;
	Tue,  2 Jun 2026 07:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780386545;
	bh=XbEUsj/lS6XqhZnw6Jv+SIk0sMcdB1VISl1HN4v4y6k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R1KQgMzAoeAQgjKU74u51KGgAY5bCxMQqPAinIU7tov/Q53UfRunDUYYA9JSo/nQl
	 HSL4gVe25pB3T+Ym6PwpfKegBkV1jLMjcNYtGjCoKWJUTtP2TiP5eE4nOUOhnjwuV0
	 YUfqh6Q1LsJgM7LbFFnbpXffA3rTQPx1iZV5gnHlyQ/BH7FtiGVRScXZxZcopzeCEb
	 yN2ODERpOskKUzDnY5qmmguTSDAo0nxvRWbpRSmrAIrOfSTouyKWQ0+wx4EOM6GSh1
	 2qkChTcqpUjrS6MmCFSjKt1p1DuG8Bds1PtpPoo0JmHFZKMU0F+pjsMOCLs1SUDL2E
	 nZ6uT7UAq057A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7] perf test: Remove /usr/bin/cc dependency from Intel
 PT shell test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260602073132.2653307-17-irogers@google.com>
References: <20260602073132.2653307-17-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 07:49:04 +0000
Message-Id: <20260602074904.CDEC11F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Instruction encodings on AArch64 and RISC-V incorrectly assume t=
he host data byte order dictates instruction fetch byte order.
--

commit 24bba6efa576b6453f0f09427882a8cfb7205892
Author: Ian Rogers <irogers@google.com>

perf test: Remove /usr/bin/cc dependency from Intel PT shell test

This commit replaces the external C compiler dependency in the Intel PT she=
ll
test with a built-in jitdump workload. It dynamically encodes instructions
across multiple architectures to avoid requiring an external compiler at
runtime.

[ ... ]

> diff --git a/tools/perf/tests/workloads/jitdump.c b/tools/perf/tests/work=
loads/jitdump.c
> new file mode 100644
> index 0000000000000..6bbe703c84092
> --- /dev/null
> +++ b/tools/perf/tests/workloads/jitdump.c

[ ... ]

> +static int jitdump(int argc __maybe_unused, const char **argv __maybe_un=
used)
> +{
> +#if defined(__x86_64__) || defined(__i386__)
> +	/* Code to execute: mov CHK_BYTE, %eax ; ret */
> +	uint8_t dat[] =3D { 0xb8, CHK_BYTE, 0x00, 0x00, 0x00, 0xc3 };
> +#elif defined(__aarch64__)
> +	/* Code to execute: mov w0, #CHK_BYTE ; ret */
> +	uint32_t dat[] =3D { 0x52800000 | (CHK_BYTE << 5), 0xd65f03c0 };
> +#elif defined(__riscv)
> +	/* Code to execute: li a0, CHK_BYTE ; ret */
> +	uint32_t dat[] =3D { ((CHK_BYTE & 0xfff) << 20) | 0x513, 0x00008067 };

[Severity: Medium]
Will this execute invalid instructions on big-endian AArch64 and RISC-V sys=
tems?

The specifications for these architectures mandate that instructions are
always fetched in little-endian byte order, regardless of the data endianne=
ss
configuration of the cpu. By defining the dynamic instructions as a uint32_t
array, the code relies on the host compiler's data layout.

When compiled on a big-endian host, the compiler stores these uint32_t valu=
es
in big-endian byte order in memory. When the cpu subsequently fetches this
memory to execute, it reads the bytes as a little-endian instruction word,
effectively byte-swapping the instruction. This results in the execution of
invalid or unintended instructions and causes the perf test to fail.

Would it be safer to encode these architectures using byte arrays in
little-endian order to ensure correctness on big-endian hosts?

> +#elif defined(__powerpc__)
> +	/* Code to execute: li r3, CHK_BYTE ; blr */
> +	uint32_t dat[] =3D { 0x38600000 | (CHK_BYTE & 0xffff), 0x4e800020 };

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602073132.2653=
307-17-irogers@google.com?part=3D1

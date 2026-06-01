Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3401376BC2
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 06:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780295833; cv=none; b=MrZcTKVklLyBmmmbsOILiJfoqlcs88UTICMGZQiKsnHDuM2w7VhkAmAQfQ/qTcniw9UXi168Iv4BjwO2b4EGB58Ge+R/KCVxoPRUxySsQxWAFVXTQPsJhPVciCa5rPA55j3Y0xTWmwV51J0vsHXpc4iZdbLaHfi9zZNWyQhM/BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780295833; c=relaxed/simple;
	bh=m0n+0WkgbBf9w1AHqPbuq662JTBE4c7aj3taefbH0as=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cb5gCWlHLoe1cagbrdUebiuWvKe9DsTtNhl/Amfg/hmlI5UUUjCQetzhJ6FwMgNbwkJ7F3irg4YWeCV6Z1xsn2kNF5f81P4RiK5CP8EsXAroyvhjNnpM8mAeabaWo7NVkvOoBRAplZ3Gki27l1jnkuD+HOSLXoJOouaB+4wusm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLD/1S0p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLD/1S0p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F9F1F00893;
	Mon,  1 Jun 2026 06:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780295827;
	bh=TaQzyBkAY1wxi48WDGQJRiMpjYNkjOivkVFYLUE6VnM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WLD/1S0puR4D0zr2Kesc8jjB4sXww0e0hQ+53nCFAlLnZ4JVH6kMEpuoPktKR/4vy
	 X9Xktie1lwYrEirkLG2t0/qG64uxC6Ne+pRL/cfOssr6MfbGv+ixhD7e1+W7nGI92Y
	 fvR2xqSOdURnT5Ed+OW7HjV6n8+sTbrPtZlGzt3ir+70Zn/Yn/GckY/QQmsTbdx9YB
	 tY+pGLUTMkFchTnSYDnu/nhFbLGTvUYr3w8oqqlXqrjHpYSZT08UjkKIGzDV7WQB2H
	 C1OQSNLBWShH8vcgTkyD3CbEM0ObCKQXFJRa/ALrhQuawhWq+3Xg/RmpUlJvbjLaWR
	 0UkFfitWmtwjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 15/15] perf test: Remove /usr/bin/cc dependency from
 Intel PT shell test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260601061401.1541457-16-irogers@google.com>
References: <20260601061401.1541457-16-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 06:37:07 +0000
Message-Id: <20260601063707.89F9F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Malformed JIT_CODE_LOAD record omits the mandatory null-terminat=
ed symbol name, causing an out-of-bounds read in `perf inject --jit`.
- [Low] Implicit function declaration of `gettid()` causes build failures o=
n systems with older glibc.
- [Low] Missing file unlink on the mmap failure path in `open_jitdump` leav=
es a stale zero-byte file on disk.
--

commit 194465fc2be17e9ffc37efc2f97d81ed4142188b
Author: Ian Rogers <irogers@google.com>

perf test: Remove /usr/bin/cc dependency from Intel PT shell test

This commit converts the external C program workloads in the Intel PT shell
test into built-in workloads. It creates a built-in 'jitdump' workload and
adds multi-architecture compatibility to remove the external C compiler
dependency.

> diff --git a/tools/perf/tests/workloads/jitdump.c b/tools/perf/tests/work=
loads/jitdump.c
> new file mode 100644
> index 0000000000000..225d3f3dc6e3b
> --- /dev/null
> +++ b/tools/perf/tests/workloads/jitdump.c

[ ... ]

> +static FILE *open_jitdump(void)
> +{

[ ... ]

> +	/* Create an MMAP event for the jitdump file. That is how perf tool fin=
ds it. */
> +	m =3D mmap(0, getpagesize(), PROT_READ | PROT_EXEC, MAP_PRIVATE, fileno=
(f), 0);
> +	if (m =3D=3D MAP_FAILED) {
> +		pr_err("mmap failed: %s\n", strerror(errno));
> +		fclose(f);

[Severity: Low]
Does this leave a stale zero-byte file on disk if mmap fails?

The other error paths in open_jitdump() call unlink(filename) before
returning, but it seems to be omitted here.

> +		return NULL;
> +	}
> +	munmap(m, getpagesize());

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
Is there a missing feature guard or fallback for gettid() here?

On older systems with glibc < 2.30, gettid() is not natively declared in
<unistd.h>. Because the perf tool typically compiles with -Werror, this
implicit declaration can cause a build failure. The perf subsystem usually
provides syscall(__NR_gettid) as a fallback or uses a feature test.

> +		.vma =3D (unsigned long)addr,
> +		.code_addr =3D (unsigned long)addr,
> +		.code_size =3D sz,
> +		.code_index =3D ++*idx,
> +	};
> +
> +	if (fwrite(&rec, sizeof(rec), 1, f) !=3D 1 || fwrite(dat, sz, 1, f) !=
=3D 1)

[Severity: Medium]
Can this cause an out-of-bounds read in perf inject --jit?

It looks like write_jitdump() writes the record header and directly follows=
 it
with the raw instruction bytes, omitting the required null-terminated string
for the symbol name.

While the original shell script also omitted this, the original x86 payload
happened to contain null bytes that safely terminated strlen(). The newly
added non-x86 payloads (e.g., ARM64, RISC-V) contain no null bytes.

When perf inject calculates the symbol name pointer in jit_repipe_code_load=
()
and calls strlen(sym) in jit_write_elf(), could it read out of bounds into
subsequent records or unmapped memory?

> +		return -1;
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601061401.1541=
457-1-irogers@google.com?part=3D15

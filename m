Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F7E26299
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 05:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780206480; cv=none; b=GF/iXkhrHqsNhZoVTjX1kRbMAUZYdPimiGHzdAHZCTpbMjaG3tZhByBSXKCTncV6tiLfc1oUqhmvY/78zcEgVs4FTBNTCUodTxjXR5z9txLg48nI8zUxdP2I1/44RvQm1YyNJ4+1gKDZGxPeJ1GR7L9fihflIgsCqNo+s4Rw5Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780206480; c=relaxed/simple;
	bh=czIeJr17b0BGIcNFLMn1gQQRMMPs+mN0NouLXJSgr60=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WZDWbROzZr90HhEwLa+6pqDaaW2EwIKrF8KkAZY5VN9m5vS9i43a1mU8/uTHpSeGlWWGFnRnChJEPG2Xs3/o9J6SG+1oCZ2CHeoEXY4FgxxWmgITm0BdjMDHZcuGMkMt8VcGq2qu3n7fUup+q188j3ZF9zXe2Q057ayXZRDwuDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJM/3Igl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJM/3Igl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417981F00893;
	Sun, 31 May 2026 05:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780206475;
	bh=HazXOb38Q2w/jYok3pHgVMr2Ohuj+ewXt4FpT5lcsNg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VJM/3IglV/lXk0IuBZ0P4e0T41PYyIZ3GVc5/6qbeCs+ybRsOIrlC3KdkPYdWhkCx
	 L75cRGp/m9r4HBEPPImRpwlL7dFpdLB0czOGhpzm9YNN2/sR0dx7XxzL3khhNxo1Ax
	 EFflcFJd1I2DTiLy5pGARYjQv0ea378tr/cjHNEycwQe+T8UZNxorGtekNrWQOV/yk
	 WkS/gvYuYOAGosoYtcLGSi7gND9qHBk8YNbI2aGRKROFiqMDpQOw0tpkTf95s8MYWF
	 rZ0bFajr/2xjY2i7TG4dZbF1rVNLkR3uE4b33Up/10q7pJqCFqRignC2vZVjrFNPJl
	 tdYT1v+Fp9t3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 14/14] perf test: Remove /usr/bin/cc dependency from
 Intel PT shell test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260531052740.796087-15-irogers@google.com>
References: <20260531052740.796087-15-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2026 05:47:54 +0000
Message-Id: <20260531054755.417981F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Malformed JIT record payload causes an out-of-bounds heap read in =
`perf inject --jit` on non-x86 architectures.
- [Medium] Unconditional use of `gettid()` causes build failures on older g=
libc versions.
--

commit cf0e0be72561e89fdfe0a9f78c96ee5fbf656c9b
Author: Ian Rogers <irogers@google.com>

perf test: Remove /usr/bin/cc dependency from Intel PT shell test

This commit replaces the shell test dependency on an external C compiler in
test_intel_pt.sh by providing a built-in jitdump workload. The new workload
is implemented to support multiple architectures by dynamically encoding
instructions without relying on a compiler.

> diff --git a/tools/perf/tests/workloads/jitdump.c b/tools/perf/tests/work=
loads/jitdump.c
> new file mode 100644
> index 0000000000000..ff164158902e9
> --- /dev/null
> +++ b/tools/perf/tests/workloads/jitdump.c

[ ... ]

> +static int write_jitdump(FILE *f, void *addr, const void *dat, size_t sz=
, uint64_t *idx)
> +{
> +	struct jr_code_load rec =3D {
> +		.p.id =3D JIT_CODE_LOAD,
> +		.p.total_size =3D sizeof(rec) + sz,

[Severity: High]
Does this calculation need to include space for the mandatory null-terminat=
ed
symbol name string?

The JIT dump specification requires a JIT_CODE_LOAD record to contain a
null-terminated symbol name string immediately following the header, before
the native code payload.

> +		.p.timestamp =3D get_timestamp(),
> +		.pid =3D getpid(),
> +		.tid =3D gettid(),

[Severity: Medium]
Will this unconditional use of gettid() cause build failures on older glibc
versions?

While gettid() is provided by <unistd.h> in glibc 2.30 and later, it is abs=
ent
in older versions (such as glibc 2.27, which is still widely tested). Becau=
se
this file is now compiled unconditionally for all architectures, compiling =
perf
on systems with older standard libraries could fail with a
-Werror=3Dimplicit-function-declaration error.

> +		.vma =3D (unsigned long)addr,
> +		.code_addr =3D (unsigned long)addr,
> +		.code_size =3D sz,
> +		.code_index =3D ++*idx,
> +	};
> +
> +	if (fwrite(&rec, sizeof(rec), 1, f) !=3D 1 || fwrite(dat, sz, 1, f) !=
=3D 1)

[Severity: High]
Does this write omit the required symbol string before the machine code?

Because the symbol string is omitted, perf inject --jit will calculate both
the symbol pointer and the code pointer to point to the exact same location
(the start of the machine code) and call strlen() on it.

On non-x86 architectures where the instruction payload lacks null bytes, th=
is
could cause strlen() to read past the end of the heap-allocated record buff=
er,
crashing the perf inject tool or causing memory corruption.

> +		return -1;
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260531052740.7960=
87-1-irogers@google.com?part=3D14

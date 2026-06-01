Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C6078F4A
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 00:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780273406; cv=none; b=bzbJs0Rr6+P6zBMNhGZDnjqz4CAaZ4SsqDPHJ/0h7eYL3RP9hN+k0QJHTQrIitb/GuLUa3Nqbym/L0QKRmE4ShIi5dWAF22CaDwzF3JdYxSEAfE8XPnPsXHgOExrAEd+GxLivcvrnP7vobtLjzsfliRZnuqRBlymhEJtQSkCBv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780273406; c=relaxed/simple;
	bh=bcB28QWrP2xGluI9bFfv4xKvvP7YyVClv8SX2BPVUFo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aoIVDN32h+s/v1Iy5bwPF6UB5/NZFp54RJ2kX24YoEDHyQpEmDhe48+5aA14CPl4+2nrdDAmnCegFM1+JsOqowC7a+5OlJLyw0CkACloJhzGadFHH4WgHFKvDJoVrgZ0AAap2tsC5AkGoQ6f4Dttnn6BzRPUSydTqvm3Xo0zD/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjLlNi8N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjLlNi8N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 595C51F00893;
	Mon,  1 Jun 2026 00:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780273400;
	bh=7iBgiWrjrupNBHBRrkAzofoAnDFtUy683yq+KUjgaYY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JjLlNi8NeJAZvv/JWpf/YzedXXmR6eyNoRDPpOKd4ppRi5XnWTvvBPewp4Yle4SE6
	 PMCr2cxFq/YZLyC2C35xJePhqV8A6x1zqa0ANEa2F/FuZQDArGq7NwWzOIzCVWfdhF
	 RqViCKRAuUYRS8v58sJfBv2dVWkaZn/jgXEgTsj+tfnZHXMkp1mIkkh0G4lLXxtKIj
	 Qhzze9qXIwKtZrjtFp3B3euiDImicmvUFBcYNTxj3Y2Pe5YFSzs+jvqBSunJTvXMa/
	 blVLdmFRExBsKzsPfYlx+D51kegdmIlWZmtuT71lKQs+/gUj25pTgZQYkPXwrcNv8I
	 cppztyZDB4HYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 15/15] perf test: Remove /usr/bin/cc dependency from
 Intel PT shell test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260601000548.1195604-16-irogers@google.com>
References: <20260601000548.1195604-16-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 00:23:20 +0000
Message-Id: <20260601002320.595C51F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Use of `gettid()` without a fallback wrapper breaks the build on gl=
ibc versions older than 2.30.
--

commit 98762182c49447a0cdf85565efe77bfa5da71cf6
Author: Ian Rogers <irogers@google.com>

perf test: Remove /usr/bin/cc dependency from Intel PT shell test

This commit replaces runtime C compilation in the test_intel_pt.sh shell te=
st
with built-in workloads (thloop and jitdump) to prevent CI failures due to
missing external C compilers. It also adds multi-architecture compatibility
for the self-modifying code workload.

> diff --git a/tools/perf/tests/workloads/jitdump.c b/tools/perf/tests/work=
loads/jitdump.c
> new file mode 100644
> index 0000000000000..225d3f3dc6e3b
> --- /dev/null
> +++ b/tools/perf/tests/workloads/jitdump.c

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
Does this direct call to gettid() break the build on older glibc versions?

Because gettid() was only introduced in glibc 2.30, using it without a
fallback wrapper causes an implicit function declaration error on systems
with older glibc versions. Since the perf tool is compiled with -Werror,
this can result in a hard build failure.

Could this use syscall(__NR_gettid) or provide a local fallback wrapper
similar to how other code in tools/perf/ handles this?

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

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601000548.1195=
604-1-irogers@google.com?part=3D15

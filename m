Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875DB42AF9A
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 09:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789549231; cv=none; b=E0mP8Jm68XYCBx33OCYzk9BL3ZdldHHmniZeb5pDfAj+3k1kFSQGyqk6wGG6TOBj0HWsw8a33G3jxTpPUhLPaZ3n00EeKJyAgI8V1CSjLnEQ7L2Nj7b1DH7/yFgzA8rQytV5k/4gqWQsXgvR8KxYSVsmlU5+1Vv4TD4sFSoKl0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789549231; c=relaxed/simple;
	bh=KksKKf+xs7wuw6LcLyMTWugPYCRuLqL437ebxNdbO1U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QBE5BqZWql4J8+Znm9dEBw5R2XbTd8DBSqUZ3sghWebBfIV4irZ57LIhAAGq7J/PRGeDaY+zNw9oyw/rRVWCNhS//ghQ/yYrjIeIuR9KZpmTjiWpx4Wd41OjANlKjuTE0WjLQRRUz7Z5jW49MAsrePL/lvEcEnOuUBs1MeO/a4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLJk5bHT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLJk5bHT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3C01F000FF;
	Wed, 16 Sep 2026 09:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789549209;
	bh=9b2Jw1EsNQxpKdN5h/IbZe8Q5fdlV+jpFrjbkefkD1Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FLJk5bHTTUZPQ+RnW4BGrR20YP2JFfSJjN/Tric+6vcpWPU8OgshrItYimZ9gFV4K
	 smnhyCg3RMIEPUClvmiBmplCuoz7drTGz7RdDTdd0QiGOSgIuXLbmr4oORT7GXG1qG
	 967MktbJFSEic+zROcqg4b2zl5i6UbXmOQhuwslO0unZ4EA/QmKpw9yrdCr3VKiKZZ
	 EpK+VUuwjy1dgwrcY4LWZHHZlMN9IRfSs6ajT744TlQTfNSY8y/tAS0SSaLmGc2sgg
	 ul1Oz7JUHzqwB9r8U3vIrJaYFh7u5JcUrbOxe5FQilNaaA4GQh+/bPTe49tTNG9AD5
	 gIcHvvXRZXbng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] perf riscv: Add perf_regs_load and enable the dwarf
 unwind test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chen Pei" <cp0613@linux.alibaba.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916084626.1166-1-cp0613@linux.alibaba.com>
References: <20260916084626.1166-1-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 09:00:08 +0000
Message-Id: <20260916090009.6B3C01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf: NULL pointer dereference in test__arch_unwind_sample() on =
OOM
--

commit 5845b516a9f1970f694021ec56b60a02bd3f3b49
Author: Chen Pei <cp0613@linux.alibaba.com>

perf riscv: Add perf_regs_load and enable the dwarf unwind test

This commit adds perf_regs_load() and an architecture-specific unwind
sample helper for RISC-V. It also wires RISC-V into the test gates to
enable the DWARF unwind test on this architecture.

> diff --git a/tools/perf/arch/riscv/tests/dwarf-unwind.c b/tools/perf/arch=
/riscv/tests/dwarf-unwind.c
> new file mode 100644
> index 0000000000000..fe0c32ea0e05a
> --- /dev/null
> +++ b/tools/perf/arch/riscv/tests/dwarf-unwind.c

[ ... ]

> +int test__arch_unwind_sample(struct perf_sample *sample,
> +		struct thread *thread)
> +{
> +	struct regs_dump *regs =3D perf_sample__user_regs(sample);
> +	u64 *buf;
> +
> +	buf =3D calloc(PERF_REGS_MAX, sizeof(u64));
> +	if (!buf) {
> +		pr_debug("failed to allocate sample uregs data\n");
> +		return -1;
> +	}
> +
> +	perf_regs_load(buf);
> +	regs->abi  =3D PERF_SAMPLE_REGS_ABI;

[Severity: Medium]
Is it possible for perf_sample__user_regs() to return a NULL pointer?

If memory allocation fails during perf_sample__user_regs(), it returns NULL.
Since the subsequent calloc() for buf may still succeed, could this lead to=
 an
unconditional NULL pointer dereference when assigning regs->abi?

Would it be better to verify that regs is not NULL before attempting to=20
assign values to its fields?

> +	regs->regs =3D buf;
> +	regs->mask =3D PERF_REGS_MASK;
> +
> +	return sample_ustack(sample, thread, buf);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916084626.1166=
-1-cp0613@linux.alibaba.com?part=3D1

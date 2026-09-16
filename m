Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA4643BDB1
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 07:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789545141; cv=none; b=kNrfIiLn3oP5xtQqsT8q+RQPrwtncNzsaA6fJt+pQCcm92S9HZOI2Vbmc7VNpL89e0jCIfnH6s6/2YAQMsBciGp1mqTm3yI9JTTfprTfom7s4TwqQVcrr4TpW9JkSp4pliGmdqr5E2m+y8WtmJpc+IG0MkGn3WHW1+jit+Ve9q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789545141; c=relaxed/simple;
	bh=8aBu+R9hQKAjc1HD65OUc94TRfi4WC4YyySuNIEeTIw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=McCx7bWruQmkmCiouYbXSvRQG/FhFBMFlYf+cG0fZWj7H7xIk3MFeuQSK6t+VScMsM3EfPJCorSr+1aJ/kgCYxDiakEPAcTwgQdXZzAh3Wj8WKKvIoOf/Cxf2xfTx+Cqp43ZuUwDcGP7jgpWpU6q5y1EC2HrGtH+gnhJIIlJ7/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IhrD35nG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhrD35nG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA051F000FF;
	Wed, 16 Sep 2026 07:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789545131;
	bh=/H8GwAJfgjJpK4fIi0bOt73M0wQFnCnuDZzLO0j/Mgc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IhrD35nGi+CO7K/eor7m8nCxkar9Vn9ytNrgEWy7hA7Fi7uelrry8KVDRw8PQFvWa
	 1Za0eU0IqBtIHPM+yr5j8XAFZ7ZCiIaPI8KWpD9IAbcPBPf2v3bmZDBmtqQOgd0CRE
	 HYi808vBaXFOppO5O6ZXzBd6o19HXcFN1qe/MCa50IkICz3yHbSkNN2B6m8ByUNFgn
	 1iuWp7YN3BPSq9ckjEd4S6usds8h2HhkNoWmVyup8lCfNNwylUmhugtr33FV+XUiDS
	 ju6jX0brH/mco6Gc4sXcavoDIJoeuDeIIzRd4dbkR6N1qPgAjs+vD45lRisLSckohZ
	 cvPqxZxG/xj6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf riscv: Add perf_regs_load and enable the dwarf
 unwind test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chen Pei" <cp0613@linux.alibaba.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916073622.1045-1-cp0613@linux.alibaba.com>
References: <20260916073622.1045-1-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 07:52:10 +0000
Message-Id: <20260916075210.CBA051F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] perf riscv: unchecked return from perf_sample__user_regs() cause=
s crash on OOM
- [Low] perf riscv: missing explicit POSIX header inclusion for NULL in arc=
h-tests.c
- [Low] perf riscv: misleading error message for sample_ustack() allocation=
 failure
--

commit e16ea72472ccddd24553a422bc4e281ff9984621
Author: Chen Pei <cp0613@linux.alibaba.com>

perf riscv: Add perf_regs_load and enable the dwarf unwind test

This patch adds perf_regs_load() and the arch unwind sample helper for RISC=
-V,
wiring it into the gates. It also enables the generic dwarf unwind test dri=
ver
to support RISC-V.

> diff --git a/tools/perf/arch/riscv/tests/arch-tests.c b/tools/perf/arch/r=
iscv/tests/arch-tests.c
> new file mode 100644
> index 0000000000000..756706a09609e
> --- /dev/null
> +++ b/tools/perf/arch/riscv/tests/arch-tests.c
> @@ -0,0 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "tests/tests.h"
> +#include "arch-tests.h"
> +
> +struct test_suite *arch_tests[] =3D {
> +#ifdef HAVE_DWARF_UNWIND_SUPPORT
> +	&suite__dwarf_unwind,
> +#endif
> +	NULL,
        ^^^^

[Severity: Low]
Does this code need an explicit POSIX header inclusion for NULL?

The perf subsystem guidelines require explicit, direct header inclusions for
POSIX libc constants like NULL (e.g. <stddef.h>) to prevent compilation
failures on musl libc.

> +};

> diff --git a/tools/perf/arch/riscv/tests/dwarf-unwind.c b/tools/perf/arch=
/riscv/tests/dwarf-unwind.c
> new file mode 100644
> index 0000000000000..fe0c32ea0e05a
> --- /dev/null
> +++ b/tools/perf/arch/riscv/tests/dwarf-unwind.c
> @@ -0,0 +1,65 @@
[ ... ]
> +static int sample_ustack(struct perf_sample *sample,
> +		struct thread *thread, u64 *regs)
> +{
> +	struct stack_dump *stack =3D &sample->user_stack;
> +	struct map *map;
> +	unsigned long sp;
> +	u64 stack_size, *buf;
> +
> +	buf =3D malloc(STACK_SIZE);
> +	if (!buf) {
> +		pr_debug("failed to allocate sample uregs data\n");
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: Low]
Is this error message accurate?

Since the allocation in sample_ustack() is for the user stack (STACK_SIZE),
this appears to be a copy-paste error from test__arch_unwind_sample().

> +		return -1;
> +	}
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
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: Medium]
Could regs be a NULL pointer here?

If perf_sample__user_regs(sample) fails its internal allocation (zalloc())
on OOM, it returns NULL. This would result in an unconditional NULL pointer
dereference when setting regs->abi.

> +	regs->regs =3D buf;
> +	regs->mask =3D PERF_REGS_MASK;
> +
> +	return sample_ustack(sample, thread, buf);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916073622.1045=
-1-cp0613@linux.alibaba.com?part=3D1

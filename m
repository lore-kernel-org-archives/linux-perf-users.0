Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5334F46AED1
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 12:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789390696; cv=none; b=KxhFxPzTxsyU6fcRoW87CXfiMM/KQW/ssPcSwZGGgBOop45uqsqTb/J7go/DgazoJTq1rY9rNTUyaD7PwMw8y5ovSkL8+LlxWRsitsmPkBzmbgfHW/0B6sdBTtbDjTsGu2ArWujbklV32tYMAZHbG8l2cdnA2Qv/6M0JHExHp4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789390696; c=relaxed/simple;
	bh=0p41BbN9IdEWVoY9UQhIS026V4xhrekqOWw6V04wFDw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q5WJtPSQ5WjoHGiN0R55nKzYNWQfdLpk6+dvctbfZgDTDNhip4Ub0J4XXGPHFFl1EKWzq4iCxyZdOWupPA6O8qA1p037Tdn4nBHjuQ9tQGRk2JVyZoPBm0WWJCsxJl5kgdGBGbrFvAeNKs9wOGfmrkJ0enRefa6lYp1esYy9igU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hm+Yws4H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hm+Yws4H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C92251F000FF;
	Mon, 14 Sep 2026 12:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789390695;
	bh=msLdM1mcmLl8fwreNuVpyMSkZbMtqjaWQ8voivkqppw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hm+Yws4HBOQ80GJQKbVlrhmWLgoL7HkLgZpTBMTs6IJnCWnuMtncNEopeHiOHRlXw
	 oHgmZXGnlLnPyNStAuU81PmZdRibaZFaPvxPv8+nLpNUXSv8uS3+sswRrCdb40HvF3
	 vdrJhOpeIXCyCMW3g0/r83QFbSwRC+MkR/LUwnrYsvi1s3lfv7+F/4MypzAWdfRgXa
	 vX2X3gy7rdkpHCQskBg6SYbWqJ9YnA6y3mRt5WwpwyGWEV1SGE/rJWby8DYFpS89Ld
	 j3iwkSPgA1ZkG+vfj/cE9TmpcJ3G4gopVxRQoYgUN46KTkEgkvjThw9oUbRM8spRt8
	 vMkQ22yHFcs7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf riscv: Add perf_regs_load and enable the dwarf
 unwind test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chen Pei" <cp0613@linux.alibaba.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260914124145.1257-1-cp0613@linux.alibaba.com>
References: <20260914124145.1257-1-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 12:58:14 +0000
Message-Id: <20260914125814.C92251F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Unchecked dereference of `regs` when `perf_sample__user_regs()` =
fails to allocate.
- [Low] Missing explicit inclusion of <stdlib.h> for standard memory alloca=
tion functions, violating musl compatibility guidelines.
--

commit d76f4341bf568ee75224d45323c5c8e122fd3e66
Author: Chen Pei <cp0613@linux.alibaba.com>
Subject: perf riscv: Add perf_regs_load and enable the dwarf unwind test

This commit adds perf_regs_load and an architecture-specific unwind sample
helper for riscv. It also wires riscv into the dwarf unwind test gates so=20
that unwinding tests can be executed on riscv architectures.

> diff --git a/tools/perf/arch/riscv/tests/dwarf-unwind.c b/tools/perf/arch=
/riscv/tests/dwarf-unwind.c
> new file mode 100644
> index 0000000000000..e981b21f918d2
> --- /dev/null
> +++ b/tools/perf/arch/riscv/tests/dwarf-unwind.c
> @@ -0,0 +1,64 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <string.h>
> +#include "perf_regs.h"
> +#include "thread.h"
> +#include "map.h"
> +#include "maps.h"
> +#include "event.h"
> +#include "debug.h"
> +#include "tests/tests.h"
> +
> +#define STACK_SIZE 8192
> +
> +static int sample_ustack(struct perf_sample *sample,
> +		struct thread *thread, u64 *regs)
> +{
> +	struct stack_dump *stack =3D &sample->user_stack;
> +	struct map *map;
> +	unsigned long sp;
> +	u64 stack_size, *buf;
> +
> +	buf =3D malloc(STACK_SIZE);

[Severity: Low]
Does this file need to explicitly include <stdlib.h>? Since musl libc
enforces strict POSIX header inclusions, missing the declaration for
malloc could lead to a build failure regression on musl libc systems.

[ ... ]

> +int test__arch_unwind_sample(struct perf_sample *sample,
> +		struct thread *thread)
> +{
> +	struct regs_dump *regs =3D perf_sample__user_regs(sample);
> +	u64 *buf;
> +
> +	buf =3D calloc(PERF_REGS_MAX, sizeof(u64));

[Severity: Low]
Similarly, does this calloc require an explicit include of <stdlib.h> to
ensure compatibility with musl libc systems?

> +	if (!buf) {
> +		pr_debug("failed to allocate sample uregs data\n");
> +		return -1;
> +	}
> +
> +	perf_regs_load(buf);
> +	regs->abi  =3D PERF_SAMPLE_REGS_ABI;

[Severity: Medium]
Can perf_sample__user_regs() return NULL here?

If memory allocation fails within perf_sample__user_regs() (which uses=20
zalloc), the returned NULL pointer would be unconditionally dereferenced=20
on this line when setting regs->abi.

Could this regression cause a segmentation fault in the perf test tool=20
under memory constraints?

> +	regs->regs =3D buf;
> +	regs->mask =3D PERF_REGS_MASK;
> +
> +	return sample_ustack(sample, thread, buf);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914124145.1257=
-1-cp0613@linux.alibaba.com?part=3D1

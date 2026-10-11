Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADF923817E
	for <linux-perf-users@vger.kernel.org>; Sun, 11 Oct 2026 20:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791751362; cv=none; b=ZUE9Uy8DrcxeJzErj2j3kx8qRpH8tHm6RgTRTAzWEohx/moIeQHLGdaX0TEksLtBZ2kYznOqwOWBiGZb+BOgMSeg9Sb9S4RTycbjKzV0KK36ZLmDrQomkz9r8nJQHrgwAwq1mBoAFvcOSeUqvwbxSu6XLLcm8evB922v4y7uhac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791751362; c=relaxed/simple;
	bh=+ingS6BkRAqtDUGIopQ7ZiwSqt+Yuj+oiG10jcebILA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ixUwF1boiGNqmJH1/ZYqt9877la5asTTu+EbaQtEuNUYdvSzDehYpO4K6gtqMGWpNPhA24zrBER2htnHvqYjACJATORt88TRWh1df7W4xyVwv6BXCOAXQfjjZUp/WL4w9TUdhEfpRHeWB8fkApuJUl4TcVtDiVso3TfgLDlFpck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sw7CLS7M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sw7CLS7M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B81971F0089B;
	Sun, 11 Oct 2026 20:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791751361;
	bh=OspZWqQISDZfAlrrolXkBRXy/8CTESEBVmJzouGwGvw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Sw7CLS7MJSWSOIFqZZLe3xR/Z+zqg0irmflax8vJDTaRxoyHItBMeOcFu7bRJwo3u
	 md7Xj6WN9vFN2iuqMG5xPMV6QnazILrccGN0SezA/w7nJEuYMqq73HUnvjCaTa1Olo
	 TA5+hy91xM2hpvVIa0iE9MS9rL0x067HbX6wgUCwVHZ40i8GQC2naknT6o6wV0NXJu
	 /ITm5UwWTAuE8EaQPrjD0ea0AV2we1SNJe7hR80v5VxFWjRPWjiLKqm1mPWLQ7WXVc
	 wBan/KfV4Tsa3ruWL2Jp3aj6XVAa3AYmXg7xSmBsRws9jW0jmVC3/knsoBrWesR//y
	 IbT6r6kmTr4SQ==
Message-ID: <sashiko-outbox-167456@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf regs: Add alpha support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261011-alpha-perf-tools-regs-v1-1-2a5940e22548@gmail.com>
References: <20261011-alpha-perf-tools-regs-v1-1-2a5940e22548@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 20:42:41 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] perf: missing POSIX header inclusions in perf_regs_alpha.c
--

commit fd8853fd5c4e09ccccf58c76fbab7cdfcce13a97
Author: Matt Turner <mattst88@gmail.com>

perf regs: Add alpha support

Add the alpha perf register tables so that -I/--user-regs and
--call-graph dwarf work. r9-r15 cannot be sampled and are left out of the
mask.

> diff --git a/tools/perf/util/perf-regs-arch/perf_regs_alpha.c b/tools/per=
f/util/perf-regs-arch/perf_regs_alpha.c
> new file mode 100644
> index 0000000000000..cb9c8a1cd74b9
> --- /dev/null
> +++ b/tools/perf/util/perf-regs-arch/perf_regs_alpha.c
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "../perf_regs.h"
> +#include "../../arch/alpha/include/perf_regs.h"

[Severity: Low]
Does this file need explicit inclusions for stdint.h, stdbool.h, and stddef=
.h?

The code below relies on uint64_t, bool, and NULL. Relying on implicit head=
er
dependencies might cause build failures on systems using musl libc where th=
ese
headers are not automatically included by other subsystem headers.

> +
> +static const char * const alpha_reg_names[PERF_REG_ALPHA_MAX] =3D {
> +	"r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7",
> +	"r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15",
> +	"r16", "r17", "r18", "r19", "r20", "r21", "r22", "r23",
> +	"r24", "r25", "r26", "r27", "r28", "gp", "sp", "pc",
> +};
> +
> +uint64_t __perf_reg_mask_alpha(bool intr __maybe_unused)

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011-alpha-perf=
-tools-regs-v1-1-2a5940e22548@gmail.com?part=3D1

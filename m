Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41E347605C
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 09:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790154884; cv=none; b=Vj48STNM0NtlhGOnEaR3nHdLPSYO9WW/dYTqiItkziqT6rqPPZys0XfdtiZAr8ntWWyDqriIX2LytK+R8ffLTxGxpzJcTIJrb+TC03d4iusj29szni2ft+rQatqyMmukezF9S090SvgNoeKHnwja0nlRVgJII9qYvkPQYpAbSrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790154884; c=relaxed/simple;
	bh=dPaPzVLzOshsvSjCEMzu9Ycx5z115TJDN2osnGLg4Kw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Tg5yuKZuuWYkuBy3vjK7ZxD8nzrBkBQO1ssUMI+EJpT7xY3yJV2NkxscjqsPM8ym3bcKQsMDWliK9gUhd2Q7HEvF4CJ/XCTbaYCHMw/YoXASQEK1BvTOdIFftcEHzrbv9aFRxsBY6J1RXEpDSdr5vLIe3xZJISwI3a3/TW3wCm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAKDXxTo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAKDXxTo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7971F000FF;
	Wed, 23 Sep 2026 09:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790154883;
	bh=hf3RiSX4k5LC5QXIZIxPb49coAlE/kzDPp1eyjRLdSQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DAKDXxTo8TMZ0vkJoLSsa7qZ6OdTRspFKDStbp1ocbnKsxgBj96eZ0lbpID97/8/T
	 dD6NO3zTBDM2lmmftvdaZmPTsRh/Jok97qlmc5fRpOG4QvLPh4DypKEDZpR5/0bAto
	 Xvbdf22PABrD2fteNKsVYwXUV1EIzH4Jn3DCY95O6iX7ICCir0kY5kr54iaDryZUm7
	 0x2KXLs1G6bnneouzgLiQOlWwUf+FscZTYX1+J5SPptK5ERtiYOyeQ29Joe/YbLI5i
	 xBAO+chkuqF5ZKga6+sAjLu9x2i2Y5+dInoi5j4BQAiktppsgCc3XpV7wbWyV1WBJ2
	 Qqg42u3SlVj1w==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 3/3] perf tools: Support sparc user register
 samples and dwarf unwinding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stian Halseth" <stian@itx.no>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923090429.2026529-4-stian@itx.no>
References: <20260923090429.2026529-1-stian@itx.no>
 <20260923090429.2026529-4-stian@itx.no>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 09:14:42 +0000
Message-Id: <20260923091443.2C7971F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf/unwind: missing endian swap for sparc window registers
- [Low] perf/sparc: missing explicit stddef.h inclusion for NULL
--

commit 58ddb5306f26894ea36bdfc46ec5335a5abbcee6
Author: Stian Halseth <stian@itx.no>

perf tools: Support sparc user register samples and dwarf unwinding

Add the sparc perf_regs tables and the EM_SPARC/EM_SPARCV9 dispatch for
register names, masks, ip/sp and the perf-to-DWARF register mapping,
plus the uapi header copy.

> diff --git a/tools/perf/util/perf-regs-arch/perf_regs_sparc.c b/tools/per=
f/util/perf-regs-arch/perf_regs_sparc.c
> new file mode 100644
> index 0000000000000..9ee8e496ab8cc
> --- /dev/null
> +++ b/tools/perf/util/perf-regs-arch/perf_regs_sparc.c
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "../perf_regs.h"
> +#include "../../arch/sparc/include/perf_regs.h"
> +
> +uint64_t __perf_reg_mask_sparc(bool intr __maybe_unused)
> +{
> +	return PERF_REGS_MASK;
> +}
> +
> +const char *__perf_reg_name_sparc(int id)
> +{
> +	switch (id) {

[ ... ]

> +	case PERF_REG_SPARC_Y:
> +		return "y";
> +	default:
> +		return NULL;
> +	}
> +
> +	return NULL;

[Severity: Low]
Does this rely on implicit header inclusion for NULL?

The NULL macro is used here, but neither <stddef.h> nor <stdlib.h> is
explicitly included in this file. It appears to rely on the implicit inclus=
ion
of <stdlib.h> via the ../../arch/sparc/include/perf_regs.h header.

Should this explicitly include <stddef.h> or <stdlib.h>?

> +}

[ ... ]

> diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libd=
w.c
> index 63a5c2253174f..d2adf7f2d8bb3 100644
> --- a/tools/perf/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw.c

[ ... ]

> +/*
> + * The sampled window's %l and %i registers (DWARF 16-31) are not in the
> + * sample; the kernel flushed them to the register save area at the start
> + * of the dumped stack.
> + */
> +static void libdw_set_sparc_window_registers(struct unwind_info *ui,
> +					     struct regs_dump *user_regs,
> +					     Dwarf_Word *dwarf_regs)
> +{
> +	struct stack_dump *stack =3D &ui->sample->user_stack;
> +	u64 sp;
> +
> +	if (perf_reg_value(&sp, user_regs, perf_arch_reg_sp(ui->e_machine)))
> +		return;
> +	if (!(sp & 1) || 16 * sizeof(u64) > stack->size)
> +		return;
> +
> +	memcpy(&dwarf_regs[16], stack->data, 16 * sizeof(u64));

[Severity: Medium]
When analyzing a SPARC perf.data file on a little-endian host, will this
memcpy() write raw big-endian bytes into the little-endian host variables?

The dwarf_regs array is composed of Dwarf_Word (uint64_t) elements and expe=
cts
values in host endianness, while the stack dump (stack->data) retains the
target's original memory layout and endianness (SPARC is strictly big-endia=
n).

This can cause the 64-bit integer values read by libdw to be byte-swapped,
breaking cross-architecture DWARF unwinding for SPARC as the stack unwinder
relies on %i6 and %i7 (DWARF registers 30 and 31) to find the caller's fram=
e.

Should this code perform conditional byte-swapping when copying from the st=
ack
dump?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923090429.2026=
529-1-stian@itx.no?part=3D3

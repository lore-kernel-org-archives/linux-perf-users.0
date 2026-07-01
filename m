Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B33B3905E0
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 04:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782878817; cv=none; b=e17VK/Lp2JjPs8vT40jF8pgXKB9Jl22SSf7F/Au6NJCR27MM9U7sb7P7C7KMi8z2BivN8wMFefyuAxdyjtXiyCQImHyJQFo1D2kzy64rRffdY+hEAwbRZyibI/CLAvibQayumjniQMAkYM+UBfxjCFwdPAyitl9V0JTUhR9loh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782878817; c=relaxed/simple;
	bh=spIVhgN7lqYTOTRRpTFmLQX65lrxRoH1jyKRQ1KsZjk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RX1AIONipiSov013ZjRj7d+z3idRhDd+a4Zzu6uZ6xUZ3vnMsVakaSMk/laheTczdOjIj8/6KA4CXSPlK7ZXU/osNoMMjzlTMsMd+MS+ACyswvjn19wS54XEz3I2WZuKB0zwuj3zULtD4/fNjU0fq2Ag1mx+MAaq2MjJ6Bmli2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzmDCMY/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzmDCMY/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23771F00A3A;
	Wed,  1 Jul 2026 04:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782878807;
	bh=JaeHvTG/Pz13pMgcSe9yKSb2axLVO7KYWS9ZpKMJ2Ug=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jzmDCMY/qowUI6zLUA85OPep+MI5TbQfhimVOcGySX5fz314CGMCebwQ4OD3GtDw8
	 osEzdLRuTMeU0Y7v2nJcsLaNoOgJ1JB2bYE/KcLEkJnt5lY8uKYv/vLHy2sYS2TyqW
	 JhvVlLQGu9rfynx/9tuEDLT8XgtFdz5Lgn12v5ogmr0OZMHR3t8skcQTX67q2Sisvr
	 uU5fJSZH2193Y4vLRB1YpFFxp1oPxADAViIycUa+jqdRLNWsWnu/hmNUcTWJ9I3xrK
	 NTsnnuQlddmFV5gu5k8mbTuqgERMX7fbvopG9wndyh0ErovI4aYCqMfpEQpzVJghCw
	 g2KUNz0C6N8MQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/21] perf annotate: Introduce extract_op_location
 callback for arch-specific parsing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260701035355.752944-9-wutengda@huaweicloud.com>
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
 <20260701035355.752944-9-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 04:06:47 +0000
Message-Id: <20260701040647.A23771F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Refactoring changes the error propagation behavior for memory op=
erands with unrecognized registers, causing valid instructions to be incorr=
ectly marked as bad.
- [Low] Missing explicit inclusion of `<stdlib.h>` for the POSIX libc funct=
ion `strtol()`, breaking musl compatibility.
--

commit a79e03a1004b442317df26b7478d0a1daed1e563
Author: Tengda Wu <wutengda@huaweicloud.com>

perf annotate: Introduce extract_op_location callback for arch-specific par=
sing

This patch refactors operand parsing by moving it from the central
annotate_get_insn_location() into architecture-specific callbacks. By
introducing extract_op_location callbacks for PowerPC and x86, it aims to
simplify the core logic and improve maintainability without making function=
al
changes.

> diff --git a/tools/perf/util/annotate-arch/annotate-x86.c b/tools/perf/ut=
il/annotate-arch/annotate-x86.c
> index 7e61365363938..6a4b4bdcd7a7c 100644
> --- a/tools/perf/util/annotate-arch/annotate-x86.c
> +++ b/tools/perf/util/annotate-arch/annotate-x86.c
> @@ -2,6 +2,7 @@
>  #include <string.h>
>  #include <linux/compiler.h>
>  #include <linux/zalloc.h>
> +#include <linux/ctype.h>
>  #include <assert.h>
>  #include <inttypes.h>
>  #include "../annotate-data.h"

[Severity: Low]
Does this file need an explicit include of <stdlib.h> for musl libc
compatibility?

It appears strtol() is used later in extract_op_location_x86() without
the required <stdlib.h> header being directly included here, which might
lead to implicit function declaration errors on musl-based systems.

[ ... ]

> @@ -809,6 +810,86 @@ static void update_insn_state_x86(struct type_state =
*state,
>  }
>  #endif
> =20
> +/*
> + * Get register number and access offset from the given instruction.
> + * It assumes AT&T x86 asm format like OFFSET(REG).  Maybe it needs
> + * to revisit the format when it handles different architecture.
> + * Fills @reg and @offset when return 0.
> + */
> +static int extract_reg_offset(const struct arch *arch, const char *str,
> +			      struct annotated_op_loc *op_loc)
> +{

[ ... ]

> +static int extract_op_location_x86(const struct arch *arch,
> +				   struct disasm_line *dl __maybe_unused,
> +				   const char *op_str, int op_idx __maybe_unused,
> +				   struct annotated_op_loc *op_loc)
> +{
> +	const char *s =3D op_str;
> +	char *p =3D NULL;
> +
> +	if (op_str =3D=3D NULL)
> +		return 0;
> +
> +	if (strchr(op_str, arch->objdump.memory_ref_char)) {
> +		op_loc->mem_ref =3D true;
> +		return extract_reg_offset(arch, op_str, op_loc);

[Severity: Medium]
Does returning the result of extract_reg_offset() here alter the error
propagation behavior?

In the previous annotate_get_insn_location() logic, the return value of
extract_reg_offset() was safely ignored:

        } else if (strchr(insn_str, arch->objdump.memory_ref_char)) {
                op_loc->mem_ref =3D true;
                op_loc->multi_regs =3D multi_regs;
                extract_reg_offset(arch, insn_str, op_loc);
        } else {

By returning it here, extract_op_location_x86() might return -1 if the
register is unrecognized. This regression is now propagated back to the
caller in annotate_get_insn_location():

        if (arch->extract_op_location) {
                ret =3D arch->extract_op_location(arch, dl, insn_str, i, op=
_loc);
                if (ret)
                        return ret;
        }

Could this cause valid instructions to be completely skipped and
incorrectly marked as bad?

> +	}
> +
> +	/* FIXME: Handle other segment registers */
> +	if (!strncmp(op_str, "%gs:", 4)) {
> +		op_loc->segment =3D INSN_SEG_X86_GS;
> +		op_loc->offset =3D strtol(op_str + 4,
> +					&p, 0);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701035355.7529=
44-1-wutengda@huaweicloud.com?part=3D8

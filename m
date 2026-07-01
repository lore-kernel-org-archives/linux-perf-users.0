Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0378378826
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 04:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782878851; cv=none; b=I+O0D3LDQrtDZuv2WQnH2fbs6/BcZCAKiQgzI2KQPbPIheb4irqAFyAzt3FLfYZOQS0QdRgt6/AcUAc+ZD3zFqj9JJZf6OkJIw0SxjC4F/69DXbciRf4emLzF/sOJxeNSvcCdCBfzA1E0TGmt5nX8b8joLjBRCgXt7gxS7J7A60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782878851; c=relaxed/simple;
	bh=2QK9ls35XNhwqNRIldGgpF1sbZX4hLc2ecMl4DxmnwM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YJVQ8FHzQ4ldBfAdohzotHqE0yWDN/CrWMrpNc0q+kZwnBbkRCMMnWM93U1RkMafnaeZJc6+xwCrMaJma95xj68N38XZOEE65eff2usrVumw14dnLY1NtkOFkwhutap9Q5xfhNUjv6oEFyWYsFpQ7du6nkH2YuC7R94Fgk3f3jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hexO64OM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hexO64OM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C4F1F000E9;
	Wed,  1 Jul 2026 04:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782878843;
	bh=JWoEUcv60YRv1deSGz/Nxve0qG0cMOyRtlrkrHPTNgc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hexO64OMiEnY3X8UfgL9MdlcFXdeVSU04FpbsxwAsmad3lU1GBl78nE7hcDLPZYr6
	 CH5TG5bRB6RS+Rf7DLj5VlD7RIVVrV9QDKcTZgXf0h3GxVFLJZ70JZLBErrFkHTmYh
	 uwOXvfTObHQGUOc7w9JBO7zhAWMrN+uagkIqy9VBOETfZNMZiqXseyAlYs81sSc95T
	 zJ3dzO0PTwkGnBkKhYYGPe7Gi0LbkmXAA+lAT6JvgKTJKO9kKNFiUDPc4r0LS2X5RO
	 7hVxHlxWlTlu3iYQkp7cKAZZgFc+o2oQE42o9Ods+ondesAqe82jWhxehNcy+wAulw
	 Bwc2D7dAJ1Jkw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/21] perf dwarf-regs: Adapt get_dwarf_regnum() for
 arm64
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260701035355.752944-7-wutengda@huaweicloud.com>
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
 <20260701035355.752944-7-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 04:07:23 +0000
Message-Id: <20260701040723.B7C4F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The zero registers ('wzr' and 'xzr') are incorrectly mapped to D=
WARF register 31.
- [Medium] The link register ('lr') alias is no longer recognized and will =
unexpectedly return -ENOENT.
- [Low] The functions strcmp and strtol are used without explicitly includi=
ng <string.h> and <stdlib.h>.
--

commit cf10eca9678152514cc1354dc6997be3eec9f436
Author: Tengda Wu <wutengda@huaweicloud.com>

perf dwarf-regs: Adapt get_dwarf_regnum() for arm64

This commit replaces the static string table lookup for arm64 DWARF registe=
rs
with a programmatic implementation in __get_dwarf_regnum_arm64(). This allo=
ws
resolving register names directly into their corresponding DWARF numbers
during annotation.

> diff --git a/tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c b/tools/p=
erf/util/dwarf-regs-arch/dwarf-regs-arm64.c
> index 593ca7d4fccca..be55fc2a4f385 100644
> --- a/tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c
> +++ b/tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <errno.h>
> +#include <ctype.h>

[Severity: Low]
Does omitting the explicit includes for <string.h> and <stdlib.h> break the
build on musl libc?=20

This file now uses strcmp() and strtol() below, and musl strictly separates
declarations without relying on implicit inclusions.

>  #include <dwarf-regs.h>
>  #include "../../../arch/arm64/include/uapi/asm/perf_regs.h"

[ ... ]

> +int __get_dwarf_regnum_arm64(const char *name)
> +{
> +	int reg;
> +
> +	if (!strcmp(name, "sp") || !strcmp(name, "wzr") || !strcmp(name, "xzr"))
> +		return 31;

[Severity: Medium]
Does this incorrectly map the zero registers (wzr and xzr) to DWARF
register 31?

The AArch64 DWARF ABI assigns register 31 strictly to the stack pointer (sp=
),
and zero registers have no valid DWARF mapping.

Mapping wzr and xzr to 31 might cause perf annotate to conflate operations =
on
the zero register with stack pointer operations, leading to incorrect stack
variable tracking and type profiling statistics.

> +
> +	if (*name !=3D 'x' && *name !=3D 'w')
> +		return -ENOENT;

[Severity: Medium]
Will this strict prefix check reject the link register alias lr?

The previous static table lookup correctly mapped lr to register 30.
Because lr does not start with x or w, it appears this will now return
-ENOENT, which might break data type tracking for instructions that operate
on the link register.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701035355.7529=
44-1-wutengda@huaweicloud.com?part=3D6

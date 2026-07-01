Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA86735E1A6
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 19:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782935999; cv=none; b=RG0b0wn96YvYKWIViBFphzPe3rkRQzl5b1+CzsibXhkWqgkfs/M6aISQl4RjdCUp553zJDOld3S8Zi85IbZm9dYvq2gqO4nBKevznlnv/LpsmaCzq3IuqoJM7bbE2ANmysa7CWh2w04UgiZTi3+4lF2l6MFQ0PzGi/wRjbq2Vso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782935999; c=relaxed/simple;
	bh=C/Wtj+2k/EpdMPU1rra5d5mYuonogAQvunhKHCDbjHA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PpSuPnTg/8Dz/edrozzGT+XgG2F3Nox6XEGRECzq4RwWVgcetLVZWpQrf9MNtYGGvyC/T6CL6KFnDPVzhFbzG6YvHjqqAkpF92f9+tpbaOnMgbhGqNuPXkjIIgWo2PuWmDO6fxofkWnOLzdDUdlCtRSbo8y+GXitnJlGePMPqqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVLnBAB/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVLnBAB/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147871F00A3D;
	Wed,  1 Jul 2026 19:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782935998;
	bh=wRsAR5+842uqjidIUVfHiiYPdKeO8pmR1RVcHI16hN8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LVLnBAB/pXgggP6hl2dMabS5+xmyaagytGGix1A3zJT9X1zxqrUipul5YS/rC1MYG
	 94gvP+qaiqC4xvc1H73wrqxMcCZSYsEC2bBoWAOEsSMFbwi8LiMpXeZ7mQUUZbyykh
	 CSHtQ6n9reGoTK2l6ct5OcB6R79LKHY+91wwFYieqcO7AaPpx23qJlOQmmJZJ7NOTI
	 qtasZJlIb4UlnwYIDcopXNHGBVT0Acghs0PMYGIz6zeD1+StBWI55qleiROYW64cvw
	 S+8g2bLgJIepBx746RRAwulQjw7FxUcnPaQ3Qz6r5tUqZuzpDCot10mbJ8iv/WS16E
	 5b0QAWsluHt5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/6] perf kvm: Factor out
 kvm_need_default_arch_event()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260701194153.401218-2-namhyung@kernel.org>
References: <20260701194153.401218-1-namhyung@kernel.org>
 <20260701194153.401218-2-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 19:59:57 +0000
Message-Id: <20260701195958.147871F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The file tools/perf/util/kvm-stat.c introduces usage of calloc and =
free but fails to explicitly include <stdlib.h>, violating POSIX/musl compa=
tibility guidelines.
--

commit 706198153306324cdd16cca21dab43f87d56e722
Author: Namhyung Kim <namhyung@kernel.org>

perf kvm: Factor out kvm_need_default_arch_event()

This commit extracts the common logic for checking if an event command line
option exists into a new generic function kvm_need_default_arch_event().
This avoids duplicating the checking logic in each architecture's
kvm_add_default_arch_event() function.

> diff --git a/tools/perf/util/kvm-stat.c b/tools/perf/util/kvm-stat.c
> index 755ab659a05c3..c571d2ed711a8 100644
> --- a/tools/perf/util/kvm-stat.c
> +++ b/tools/perf/util/kvm-stat.c
> @@ -1,8 +1,10 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include "debug.h"
> +#include "env.h"
>  #include "evsel.h"
>  #include "kvm-stat.h"
>  #include <dwarf-regs.h>
> +#include <subcmd/parse-options.h>
> =20
>  bool kvm_exit_event(struct evsel *evsel)
>  {

[ ... ]

> @@ -268,3 +270,42 @@ int kvm_add_default_arch_event(uint16_t e_machine, i=
nt *argc, const char **argv)
>  		return 0;
>  	}
>  }
> +
> +bool kvm_need_default_arch_event(uint16_t e_machine, int argc, const cha=
r **argv)
> +{
> +	const char **tmp_argv;
> +	bool event =3D false;
> +	int i;
> +
> +	const struct option event_options[] =3D {
> +		OPT_BOOLEAN('e', "event", &event, NULL),
> +		OPT_BOOLEAN(0, "pfm-events", &event, NULL),
> +		OPT_END()
> +	};
> +
> +	switch (e_machine) {
> +	case EM_PPC:
> +	case EM_PPC64:
> +		break;
> +	case EM_X86_64:
> +	case EM_386:
> +		if (!x86__is_intel_cpu())
> +			return false;
> +		break;
> +	default:
> +		return false;
> +	}
> +
> +	/* parse_options() may change the argv, let's make a copy */
> +	tmp_argv =3D calloc(argc + 1, sizeof(char *));

[Severity: Low]
Does this file need an explicit include of <stdlib.h>?

It looks like calloc() and free() are used here, but <stdlib.h> is not dire=
ctly=20
included in tools/perf/util/kvm-stat.c. Relying on implicit includes could =
cause=20
build failures under musl libc where headers are strictly separated.

> +	if (!tmp_argv)
> +		return false;
> +
> +	for (i =3D 0; i < argc; i++)
> +		tmp_argv[i] =3D argv[i];
> +
> +	parse_options(argc, tmp_argv, event_options, NULL, PARSE_OPT_KEEP_UNKNO=
WN);
> +	free(tmp_argv);
> +
> +	return !event;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701194153.4012=
18-1-namhyung@kernel.org?part=3D1

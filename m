Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9620E1F91D6
	for <linux-perf-users@vger.kernel.org>; Sat,  2 May 2026 07:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777708519; cv=none; b=CTwN6Doxy5fUb4dxbwRLQqramBsMhStBsxRu+aAWLnvsVnxNBcM99rkYTHR/gfmKsAVKkTHiwTvjtrsT+AWuqOBYHR3RCz0Y4Y7gB5Kvj1omJ8n/m/MMzIPnubj85SggA3txVpx64aX+8Ok5IYssBm6US1Z2rRGaYMo/VHTjKsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777708519; c=relaxed/simple;
	bh=VVoEs28uU0biA/Btw5qMjB03hZc+vRvf6xJHTgoY6rE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iSTTa2TWwzMttSOCm7D6L0QflGtorznFuldjo4Voq++Fc3Alj17Uzl/ALqPseLiyFjM8pe3Rej8KO0KikbuEFGbLYxPXh+x3qUhNcf0qpcgl5IM7IVtad/Qt3ni5EZlDOw6mB4u8Zo/yduwQ9uiiFxh5KlX3a8pycYK9XMG+tmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCMZtkfg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCMZtkfg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05E2C19425;
	Sat,  2 May 2026 07:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777708519;
	bh=VVoEs28uU0biA/Btw5qMjB03hZc+vRvf6xJHTgoY6rE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=aCMZtkfg9HN2HFkxR9ntj6Wrg6H70eTbfWFJzLDUFndrZ10i/Ht+mZyWKFWUhdvPQ
	 +QPq1dnHj1oeabfWBvfi5jD2DFr24GUeQ7DXDmxHe7KFRMAdSIhiNG2Vj3gBdXVBXo
	 ZPS2x6rlgpAXCRKOhKbR03W8ER6CVJiRkJOl5BLJXeeuoGzmiB5jPAp8aAM19fR7XY
	 x7lQY98EARQNQMAUnSzlNaDui4bessGNVvna88bSsJ6bta75z+04yyraHUboTJ4WVC
	 5CCyV5+/v5OiQEUHXszSpFqkAW/OwmN3BVQPH0epJrWSDb6N+F61ZekuB3PEFQ8MU6
	 7gG88tiuWdL1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 04/17] perf print_insn: Use e_machine for fallback IP
 length check
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260502065935.291960-5-irogers@google.com>
References: <20260502065935.291960-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 02 May 2026 07:55:18 +0000
Message-Id: <20260502075518.F05E2C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Incorrect fallback to host architecture for guest machines break=
s cross-architecture disassembly.
- [Low] Missing `#ifndef` fallback for `EM_AARCH64` will cause compilation =
failures on systems with older glibc.
--

commit 3c6ce70c4a5c93a1c064a25ccf73aca73925cf03
Author: Ian Rogers <irogers@google.com>

perf print_insn: Use e_machine for fallback IP length check

This commit updates the instruction printer to use the ELF machine type
instead of string comparisons on the perf_env architecture. This aims to
provide a more precise fallback check for instruction pointer length.

> --- a/tools/perf/util/print_insn.c
> +++ b/tools/perf/util/print_insn.c
> @@ -17,6 +18,7 @@
>  #include "dump-insn.h"
>  #include "map.h"
>  #include "dso.h"
> +#include <elf.h>

This isn't a bug, but could compiling on older systems fail here? Other
files in the perf codebase, such as tools/perf/util/symbol-elf.c,
provide an explicit fallback definition for EM_AARCH64 since older
system headers might not include it.

[ ... ]

> @@ -33,13 +35,13 @@ size_t sample__fprintf_insn_raw(struct perf_sample *s=
ample, FILE *fp)
>  static bool is64bitip(struct machine *machine, struct addr_location *al)
>  {
>  	const struct dso *dso =3D al->map ? map__dso(al->map) : NULL;
> +	uint16_t e_machine;
> =20
>  	if (dso)
>  		return dso__is_64_bit(dso);
> =20
> -	return machine__is(machine, "x86_64") ||
> -		machine__normalized_is(machine, "arm64") ||
> -		machine__normalized_is(machine, "s390");
> +	e_machine =3D perf_env__e_machine(machine->env, /*e_flags=3D*/NULL);

When processing traces from guest machines, machine->env is initialized
as NULL. If env is NULL, perf_env__e_machine_nocache() defaults to
returning EM_HOST, the compile-time ELF architecture of the perf tool.

If a 64-bit host analyzes a trace from a 32-bit guest, would e_machine
evaluate to EM_X86_64 (or similar) instead of the guest's actual
architecture?

The previous string comparison logic safely returned false when env was
NULL.

> +	return e_machine =3D=3D EM_X86_64 || e_machine =3D=3D EM_AARCH64 || e_m=
achine =3D=3D EM_S390;

Will this regression cause Capstone to disassemble 32-bit guest
instructions using the 64-bit decoder and yield garbage output for
those guests?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260502065935.2919=
60-1-irogers@google.com?part=3D4

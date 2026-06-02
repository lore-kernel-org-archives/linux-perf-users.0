Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999663EF647
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 14:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780411771; cv=none; b=Hsupsh69EhmPHxkk4Y0As1YXo4bXBFsTd++Rs4bMLTCH30E8pDaTDO8skMiSP29nDO6ssifJJdffKS+dT922ucmzmakzV/yKtO2CpnhemfZHLceKuieAS9Khzb/Zm0AuG6D1D1GAqAjviuIX8iRBZK/PT400uuZyN2hc8HWvihs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780411771; c=relaxed/simple;
	bh=Hx3UOBQhY5P5Jq9tRx11mnnJ7aiXVBe3n4no2Pq+oyo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JOa0Rz78A4/qu6rTZLNQAC2YGI9l/eVcjf+IwoCQ9InvcuEJlHoL/KZSWCRFU2vuiBRPtykFsnspP/oxvamUrzBavYlwJmrVdsmKePRnxTL8gIx7kgDi8b1vTJN6k7qtJY/YleVx2tcG/F3l5kF7zcdIlQHcJZ70H22XD9g//1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCDErtG+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCDErtG+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEDC61F00893;
	Tue,  2 Jun 2026 14:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780411770;
	bh=ZFJK/DNlCM19Zf43VSe1hVvCC+kiPKIc+QitUbv47o0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iCDErtG+GQwlJULGmAg0ZYcoFc+3u+fYhP/rXCzPgGUd667tPZgzBP2XsdIOMuim8
	 hJT4NqgPbnrJsCv/4kriRy8Lid5nyJCEYs40PrUk6ekY/8fbLwJvmeBteg4Rxz0vVk
	 OFC+ICdKq7sCJ0q9JPL5z2PLEFnRloBIYLBuKM7PNPL1DlKYQIzjL5serCGQhVJbnK
	 MYLFqQ8D/qfC+06yiFsWD0cpYGT7KWbNsh4rP3MfQnR0n72S8+xBU4wbRs0d64vkfl
	 qAOzGjcjCcQXlGijRn8mkCRR7ws/HMsljBqMxR/5BMJz1cDSdx+7hNlySxpo7BeKcQ
	 cH/9lODDvoU5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/18] perf test: Add deterministic workload
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260602-james-cs-context-tracking-fix-v2-5-85b5ce6f55c6@linaro.org>
References: <20260602-james-cs-context-tracking-fix-v2-5-85b5ce6f55c6@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 14:49:29 +0000
Message-Id: <20260602144929.DEDC61F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] Signed integer overflow in dt_work causes Undefined Behavior
- [Medium] Workload state leakage breaks data determinism on consecutive ru=
ns
- [Low] Build failure due to missing `-U_FORTIFY_SOURCE` with `-O0`
- [Low] Global namespace pollution from non-static `dt_work`
--

commit cdb1ed35f7dbaf322c0b18289b38a7da8d21039e
Author: James Clark <james.clark@linaro.org>

perf test: Add deterministic workload

This commit adds a new workload for testing CPU trace decoding. It introduc=
es
a deterministic sequence of multiplications and function calls that can be=
=20
used to verify expected behavior across test runs.

[ ... ]

> diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workload=
s/Build
> index 3bda6da04a350..599a37c87878f 100644
> --- a/tools/perf/tests/workloads/Build
> +++ b/tools/perf/tests/workloads/Build

[ ... ]

> @@ -22,3 +23,4 @@ CFLAGS_brstack.o          =3D -g -O0 -fno-inline -U_FOR=
TIFY_SOURCE
>  CFLAGS_datasym.o          =3D -g -O0 -fno-inline -U_FORTIFY_SOURCE
>  CFLAGS_traploop.o         =3D -g -O0 -fno-inline -U_FORTIFY_SOURCE
>  CFLAGS_inlineloop.o       =3D -g -O2
> +CFLAGS_deterministic.o    =3D -g -O0

[Severity: Low]
Does this code introduce a build regression on systems with glibc?

Since the perf build system globally defines _FORTIFY_SOURCE=3D2 and enables
-Werror by default, compiling with -O0 without also passing -U_FORTIFY_SOUR=
CE
can trigger a warning from <features.h> ("_FORTIFY_SOURCE requires compiling
with optimization (-O)"), which is then escalated to an error.

> diff --git a/tools/perf/tests/workloads/deterministic.c b/tools/perf/test=
s/workloads/deterministic.c
> new file mode 100644
> index 0000000000000..3caea8564043c
> --- /dev/null
> +++ b/tools/perf/tests/workloads/deterministic.c
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/compiler.h>
> +#include "../tests.h"
> +
> +int dt_work =3D 1234;

[Severity: Low]
Should dt_work be declared static?

It is currently declared at global scope without a unique prefix, which exp=
oses
it to the entire perf tool binary.

[Severity: Medium]
Will dt_work experience undefined behavior due to signed integer overflow?

The variable is initialized to 1234 and is unconditionally multiplied by 7
twelve times during the execution of deterministic(). The 8th multiplication
results in 7,113,764,434, which exceeds the maximum value of a 32-bit signed
integer.

Could this cause crashes if the perf tool is built with undefined behavior
sanitizer? Perhaps dt_work could be unsigned int or unsigned long long
instead.

> +
> +static noinline void function1(void)
> +{
> +	dt_work *=3D 7;

[ ... ]

> +static int deterministic(int argc __maybe_unused,
> +			 const char **argv __maybe_unused)
> +{

[Severity: Medium]
Does this code break data determinism on consecutive test runs?

If the workload is executed multiple times within the same process (for exa=
mple,
using perf test -w deterministic -r N), dt_work will start from the final
overflowed value of the previous run rather than being reset to 1234.

> +	dt_work *=3D 7;
> +	dt_work *=3D 7;
> +	dt_work *=3D 7;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602-james-cs-c=
ontext-tracking-fix-v2-0-85b5ce6f55c6@linaro.org?part=3D5

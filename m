Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D6358039D
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Sep 2026 16:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788970633; cv=none; b=Jlfq95g48CYoKVD59v4hsQSanveyzjn2FuDVlv7MsAQlSkTdD3HKqXqe2dApV8/oMx9hzJom8gLAmibAKNm5iq1qtJmNdu76+u21hBFHKT90S0rLPxN1XyZStaW2wWvnbrEKweNUEOWAFNiX/OQZW8Te9SjUNzUIc96MPkMpdL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788970633; c=relaxed/simple;
	bh=M440NycW2GYoAE4JsBSa92RcA6fj3ApiwvyIhxP1J3g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d8sHQ2I6TzE2biFohUHVbQlV7C6pYMIp3uuihdU/S0o0OOc6AIMQxYWR/O60zBeH0caU2l9XLKX4prpRiRbQj584oUkU/X2NwrR/W2tlIMgdFynEdZdF+PVRpSANoXpILhxf5Jd96qTTfQ9mdoUBGNK2GnyQYfzmU9Z9yMxg1RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHBjOp7W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHBjOp7W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA981F000FF;
	Wed,  9 Sep 2026 16:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788970632;
	bh=RfDADJz1F18jq65dzrAGl3izIIFfHCzejvqomqtYe1U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SHBjOp7WcqiUlUTsmof/eAV54zv49rcjIYtNh9sVO3o7wB0OtGtHsDRhIGr/3vIGw
	 7yuEkiGQqXd6LFx+ikWgjlvtPbSfwad2EbKUiL3JpFm9bQ/cwc/NcpNHhdhv8nnna/
	 F8aKp6tKCivs2IVaFilDjx6Io6SzduZHOpv2DpG1IjIWA9l6tucZE19i44NMq+fmvW
	 +dnG5T+XkmMwUiMwQ1EOwFKDdw7WEQ6FIIJBSubYwWLttE+iIhGBl3hBQwlFi6Ddqu
	 tDPKJnFvTc43jsYhNlxg1vE88q5x2Tw30K/mNkzOQFQmylPLwPgZQSNdrJUWRFVLlf
	 3CF4OJX0Qx78g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 5/6] perf tools: Show memory region in perf-script
 subcommand
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260909160218.174928-6-thomas.falcon@intel.com>
References: <20260909160218.174928-1-thomas.falcon@intel.com>
 <20260909160218.174928-6-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 16:17:11 +0000
Message-Id: <20260909161711.DFA981F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Integer underflow leading to stack buffer overflow if the accumu=
lated string length reaches the buffer size in `perf_mem__region_scnprintf`.
- [Low] Unnecessary full header inclusion of "session.h" in mem-events.h in=
stead of using a forward declaration.
--

commit f7491b8d4beca72ae600f38adac9d0669b182411
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf tools: Show memory region in perf-script subcommand

Show the memory region in perf-script subcommand. Memory region is found
in the mem_region field of the memory information data source.

Link: https://lore.kernel.org/all/20260114011750.350569-1-dapeng1.mi@linux.=
intel.com/

> diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
> index daa22748f9fea..4ebb8109fc3c4 100644
> --- a/tools/perf/util/mem-events.h
> +++ b/tools/perf/util/mem-events.h
> @@ -4,6 +4,7 @@
> =20
>  #include <stdbool.h>
>  #include <linux/types.h>
> +#include "session.h"

[Severity: Low]
Does this code introduce unnecessary namespace pollution and risk musl=20
compilation failures? The subsystem guidelines recommend using a forward=20
declaration for struct perf_session instead of a full header inclusion=20
when only structure pointer handles are referenced.

[ ... ]

> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index 4fd48fd200552..8ce4996cad8d3 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
[ ... ]
> +static int perf_mem__region_scnprintf(char *out, size_t sz, const struct=
 mem_info *mem_info)
>  {
> +	size_t l =3D 0;
> +	u64 mem =3D PERF_MEM_REGION_NA;
> +
> +	sz -=3D 1; /* -1 for null termination */
> +	out[0] =3D '\0';

[Severity: Medium]
Can this lead to an integer underflow and a stack buffer overflow?

In perf_script__meminfo_scnprintf, the characters written are accumulated=20
in i. If i grows larger than or equal to the initial buffer size (e.g. 200)=
=20
due to previous print operations, sz - i passed to=20
perf_mem__region_scnprintf evaluates to 0.=20

When sz is 0 in perf_mem__region_scnprintf, sz -=3D 1 underflows to the=20
maximum unsigned size. The subsequent out[0] assignment writes=20
out-of-bounds, and scnprintf receives the maximum size as its limit, which=
=20
can cause a massive buffer overflow when parsing a complex perf.data file.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909160218.1749=
28-1-thomas.falcon@intel.com?part=3D5

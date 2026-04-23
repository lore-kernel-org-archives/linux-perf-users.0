Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EDF33B97F
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 04:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776917429; cv=none; b=frQuyBNUbtGRXSrjA+yzLrPrFwmmYRbCbFxQTPmhVXsUi2pKPK3A6sFrVYfN5BeNqwMiZUPJlWrrXMQvwdKG+GlWzO/rqWspTa6zGzL2zP5YJI6tk9prVD7xOEnoVh7yNXxpRCa5R3rsx9FT/nNCy455nhq25er4GR2RT5F3UlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776917429; c=relaxed/simple;
	bh=iNBxAUd+zo/WMIZHvio9/LMXzPHoRBVOsI8FxAWUnq0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KTd77y75XlVStYyQ7f89qgfrnVS5CZTepzM9nzLEBTEQcKDppTeuUnYivbvsQUenJlSxxGSf/aIOcL+0ZAQrfvSZ+qqijbi8yoBQB1n/0HOlSguqbiIRY/puXeupRLLYfmPgRExnaPTu2wqNG2PGOJdfk7hPIOfNdAEGNRVO3ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ucwh9Csk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ucwh9Csk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B7CC2BCB4;
	Thu, 23 Apr 2026 04:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776917428;
	bh=iNBxAUd+zo/WMIZHvio9/LMXzPHoRBVOsI8FxAWUnq0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Ucwh9CsknAFGC5gS80PjLE9U3oFgqvBrIfRpavzh1l9K/xcEPKJJ0xlmJFybF0trB
	 3DrId7T1XDfOfypQXcL2UUwfw7+yixrKom6j0u/alpUUKYyLb3SPpzDdL6RH/yhkPI
	 BS2SdLpK8McuWKt5e8ZMh/0uJESycXxjDHn1AFLWLn0Hmg+QjFx/8d5aGgpT9uyNZg
	 +RxrB2ZtgtK6FGd2KJMwQj4oSj0V6209v8V4g+rCbsP8+fk0Kyq3UQ11C774Uzx29r
	 nTJOAup49TXr4g8TpbmvigumlIu7A3gAlhsY9AbI6YBZ7tBBrIAzG4uQ0ZayfEBx+5
	 Ux9Das1VI/lgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 26/58] perf mem-phys-addr: Port mem-phys-addr to use
 python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260423035526.1537178-27-irogers@google.com>
References: <20260423035526.1537178-27-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 04:10:27 +0000
Message-Id: <20260423041028.81B7CC2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [High] Excessive error logging in `find_memory_type` can cause console sp=
am and severe performance degradation.
- [Medium] Python API compatibility breakage due to Python 3.10+ specific f=
eatures.
- [Medium] Logic error in binary search result handling leads to unintended=
 negative indexing.
--

commit cd8c15e87c970c83acdb9decf2e94c2d6f8dbf59
Author: Ian Rogers <irogers@google.com>

perf mem-phys-addr: Port mem-phys-addr to use python module

This commit provides an example of using the perf python session API to
load a perf.data file and resolve physical address samples using
/proc/iomem.

> diff --git a/tools/perf/python/mem-phys-addr.py b/tools/perf/python/mem-p=
hys-addr.py
> new file mode 100755
> index 0000000000000..ba874d7a2011c
> --- /dev/null
> +++ b/tools/perf/python/mem-phys-addr.py
> @@ -0,0 +1,117 @@

[ ... ]

> +import collections
> +from dataclasses import dataclass
> +import re
> +from typing import (Dict, Optional)
> +
> +import perf
> +
> +@dataclass(frozen=3DTrue)
> +class IomemEntry:
> +    """Read from a line in /proc/iomem"""
> +    begin: int
> +    end: int
> +    indent: int
> +    label: str
> +
> +# Physical memory layout from /proc/iomem. Key is the indent and then
> +# a list of ranges.
> +iomem: Dict[int, list[IomemEntry]] =3D collections.defaultdict(list)

Will this break compatibility on older Python versions?=20

Generic built-in collections for type hinting like list[IomemEntry] were
added in Python 3.9. Running this on enterprise distributions that ship with
Python 3.6 to 3.8 might result in an immediate TypeError crash.

[ ... ]

> +def find_memory_type(phys_addr) -> Optional[IomemEntry]:
> +    """Search iomem for the range containing phys_addr with the maximum =
indent"""
> +    for i in range(max_indent, -1, -1):
> +        if i not in iomem:
> +            continue
> +        position =3D bisect.bisect_right(iomem[i], phys_addr,
> +                                       key=3Dlambda entry: entry.begin)

The key parameter for bisect.bisect_right was introduced in Python 3.10. Co=
uld
this cause similar compatibility issues on older setups?

> +        if position is None:
> +            continue
> +        iomem_entry =3D iomem[i][position-1]

Does this handle cases where phys_addr is smaller than the first element
correctly?

bisect.bisect_right always returns an integer, not None. If it returns 0,
position-1 becomes -1, which will wrap around and unintentionally access the
last element in the iomem[i] list.

> +        if  iomem_entry.begin <=3D phys_addr <=3D iomem_entry.end:
> +            return iomem_entry
> +    print(f"Didn't find {phys_addr}")

Can this cause console spam and slow down execution?

Since find_memory_type() is called for every sample event, printing to stdo=
ut
whenever an address cannot be mapped could flood the console. If there are
millions of unresolved addresses (for example, if addresses aren't recorded
or are missing from an unprivileged user's /proc/iomem), this might complet=
ely
bottleneck execution time.

> +    return None

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423035526.1537=
178-1-irogers@google.com?part=3D26

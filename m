Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE363175A81
	for <linux-perf-users@vger.kernel.org>; Sat, 13 Jun 2026 05:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781329854; cv=none; b=mbtJfHPyz3jXGj78yncUZZqWYJW4+oWT8150lWawwrJkwqsLY9/OFKOpvGPMeL6po79Pb4sn7jJJJcTyk2OMCqkULYZnayNeT6Sb97BaBdFRCAltGAk/YVF4/h7NM2Z4RHFstJKqmOdZPm2qmhYTZWntEJkHXnXxHbZeBCF8zCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781329854; c=relaxed/simple;
	bh=Vz+aYehF0NIj7F++HGx5Sl7hs4ulumOIfprx++iNl08=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L1WwRyJCKfm6EuvGlSN1yIuHS0/bawAPzfgogfNJ3nROxjif4NcSVNY8a8tXQB3sGWLrHOa5NULQXXli5EU2qiu/CL4IlVfUVL22vb2ivriZrmAIyxhwjEoDSJFtDvY3YOZK2STuys+v8MqgiN/6lzXiVw0Wq79+NKDOBfTpvCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLVmULB2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLVmULB2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 902281F000E9;
	Sat, 13 Jun 2026 05:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781329853;
	bh=Vz+aYehF0NIj7F++HGx5Sl7hs4ulumOIfprx++iNl08=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oLVmULB2xQ50wl6bVNjwwoBJ+DtBw2oNOyoETM9IiLmvPzPsIjUZIsX9xdrNy7Woz
	 tFdtQDA1zkDHT0P72eh9tHG7JZIF4pPdvBoaYpouqmpaIj2ItHWW8rZsBJLBtE/pRK
	 Ul1Ds5gS8qo3yM8ZQPeLnbVC61P7CI7NPNPImT+OOmTRjlvQjUnIuiQ13E1oiBFE9f
	 IISHU4Dy77wpyJRe2+UIAZrfM2jihYophJCIKkYffk031zTLTMWzXpVL/OOmSXqdKy
	 R9fVdvLEZsQ2QT2UDiE06s8CiWc9ctvUnCKiRie4yxlRAILQjs9f2SJFor580JSXgB
	 8MbUdEmADFzMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 20/20] perf python: Add LiveSession helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260613052722.1424093-21-irogers@google.com>
References: <20260613052722.1424093-21-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 05:50:53 +0000
Message-Id: <20260613055053.902281F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The 'errno' module is imported but never used.
--

commit 3ee61514ccd781a03eca72622f807583b23c9f22
Author: Ian Rogers <irogers@google.com>

perf python: Add LiveSession helper

Add LiveSession class in tools/perf/python/perf_live.py to support
live event collection using perf.evlist and perf.parse_events,
avoiding the need to fork a separate perf record process.

> diff --git a/tools/perf/python/perf_live.py b/tools/perf/python/perf_live=
.py
> new file mode 100755
> index 0000000000000..fd049933a052e
> --- /dev/null
> +++ b/tools/perf/python/perf_live.py
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: GPL-2.0
> +"""
> +Live event session helper using perf.evlist.
> +
> +This module provides a LiveSession class that allows running a callback
> +for each event collected live from the system, similar to perf.session
> +but without requiring a perf.data file.
> +"""
> +
> +import errno

[Severity: Low]
This isn't a bug, but it looks like the 'errno' module is imported here but=
=20
never used anywhere else in the file. Could this import be removed?

> +import perf
> +
> +
> +class LiveSession:

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613052722.1424=
093-1-irogers@google.com?part=3D20
